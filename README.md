# azure-resource-pim-activation
This script makes the following assumptions
1) The Azure CLI is installed on the machine you're working on. If you do not, please reference the Microsoft documentation provided below for installation.
2) You're already logged into the Azure CLI and have set your preferred subscription via az az account set --name [subscription]. Refer to documentation below if necessary.



References:
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

https://learn.microsoft.com/en-us/cli/azure/account?view=azure-cli-latest#az-account-set

https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest

Please note that unless the documentation has been updated in the reference below, the API call references roleAssignmentScheduleRequests which is incrrect and should instead be RoleAssignmentScheduleRequests. MSFT knows this and has comitted to updating the documentation at some point.

https://learn.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-resource-roles-activate-your-roles#activate-a-role-with-arm-api