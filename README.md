# **Azure Resource PIM Activation**
The goal of this script is to be able to activate a PIM role without first having to go through the portal. This is particularly useful for administrators who do significant work in CLI, PowerShell or VSCode environments. For all API calls, this script uses the Azure CLI and the az rest command. The justification for using az rest for all calls is simply because it automatically handles all authentcation for us so we do not need to manage any authorization headers or tokens.

At the time of writing this, I've provided only one option using the Out-GridView method for user selection. I will modify this soon to include a CLI based menu option.

# **Assumptions**
1) The Azure CLI is installed on the machine you're working on. If not, please reference the Microsoft documentation provided below for installation.
2) You're already logged into the Azure CLI and have set your preferred subscription via az az account set --name [subscription]. Refer to documentation below if necessary.

# **To-do**
- [ ] Provide an alternative with a CLI "menu" option.
- [ ] Format the JSON body in a better method
- [ ] Streamline JSON body and conversion returned by the various api calls.
- [ ] Figure out a better way to exlude unnecessary users\roles from returned api calls. 

# **References:**

https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

https://learn.microsoft.com/en-us/cli/azure/account?view=azure-cli-latest#az-account-set

https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest

https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest#az-rest

https://learn.microsoft.com/en-us/azure/active-directory/privileged-identity-management/pim-resource-roles-activate-your-roles#activate-a-role-with-arm-api