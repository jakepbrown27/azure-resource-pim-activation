#This variable is used to gather the UPN to later use as a filter when looking at avaialble PIM roles.
$upnToFilter = az account show | ConvertFrom-Json

#This is done because az account show only provides a display name, and not a UPN, however the API call returns display names and not UPNs so we need a way to match them up.
$adDisplayName = az ad user show --id $upnToFilter.user.name | ConvertFrom-Json

#isolates the current subscription it set by az account set -s [subscriptionName]
$isolatedSubId = $upnToFilter.id

#API call using az rest and the isolated subscription ID
$subscriptionRoles = az rest --method get --url "https://management.azure.com/subscriptions/$isolatedSubId/providers/Microsoft.Authorization/roleEligibilityScheduleInstances?api-version=2020-10-01"
$subRolesJSONConvert = $subscriptionRoles | ConvertFrom-Json

#initialize an array to add custom objects to.
$initArray = @()

#loop to iterate the returned eligible roles, and filter only the ones applicable to the current user.
foreach($role in $subRolesJSONConvert.value){

    if($role.properties.expandedProperties.principal.displayName -eq $adDisplayName.displayName){

        $roleObject = [PSCustomObject]@{
                        displayName        = $role.properties.expandedProperties.principal.displayName
                        roleName           = $role.properties.expandedProperties.roleDefinition.displayName
                        principalID        = $role.properties.principalId
                        scope              = $role.properties.scope
                        roleDefinitionId   = $role.properties.expandedProperties.roleDefinition.id
                                          
                    }
                $initArray += $roleObject
    }
}

#provide the user with a list of their eligible roles, select which role that should be activated
$roleDef = $initArray | Select-Object displayName, roleName, scope, principalId, roleDefinitionId  | Out-GridView -PassThru

#This is part of the JSON body, it is required as part of the activation time.
$datetime = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")

#This is the role definition ID that is returned as part of the initial API call
$roleDefnitionId = $roleDef.roleDefinitionId

#principal ID (object ID) used in the JSON body, this is required.
$principalId = $roleDef.principalID

#Generate a random Guid as part of the request, this is required.
$randomGuid = (New-Guid).Guid

#Scope in which the API call should be applied to, this is required. 
$scope = $roleDef.scope

#Constructed URI used in the api call, includes the scope and the generated random guid.
$requestURI = "https://management.azure.com/"+"$scope"+"/providers/Microsoft.Authorization/RoleAssignmentScheduleRequests/"+"$randomGuid"+"?api-version=2022-04-01-preview"

#Api call using az rest. This included the headers, and JSON body;$datetime, $roleDefnitionId, $principalId
az rest --method PUT --headers Content-Type="application/json" --url $requestURI --body "{\`"properties\`": {\`"principalId\`": \`"$principalId\`",\`"roleDefinitionId\`": \`"$roleDefnitionId\`",\`"requestType\`": \`"SelfActivate\`",\`"Justification\`" : \`"Activation for work\`",\`"scheduleInfo\`": {\`"startDateTime\`": \`"$datetime\`",\`"expiration\`": {\`"type\`": \`"AfterDuration\`",\`"endDateTime\`": \`"null\`",\`"duration\`": \`"PT8H\`"}}}}"
