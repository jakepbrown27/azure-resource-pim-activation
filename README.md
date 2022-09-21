# **azure-resource-pim-activation**
For all API calls, this script uses the Azure CLI and the az rest command. The justification for using az rest for all calls is simply because it automatically handles all authentcation for us so we do not need to manage any authorization headers or tokens.

# **Assumptions**
1) The Azure CLI is installed on the machine you're working on. If not, please reference the Microsoft documentation provided below for installation.
2) You're already logged into the Azure CLI and have set your preferred subscription via az az account set --name [subscription]. Refer to documentation below if necessary.

# **To-do**
- [ ] Format the JSON body in a better method
- [ ] Streamline JSON body and conversion returned by the various api calls.
- [ ] Figure out a better way to exlude unnecessary users\roles from returned api calls. 

# **References:**

https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

https://learn.microsoft.com/en-us/cli/azure/account?view=azure-cli-latest#az-account-set

https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest

https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest#az-rest

Please note that unless the documentation has been updated in the reference below, the API call references roleAssignmentScheduleRequests which is incrrect and should instead be RoleAssignmentScheduleRequests. MSFT knows this and has comitted to updating the documentation at some point.

https://learn.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-resource-roles-activate-your-roles#activate-a-role-with-arm-api