# Disclaimer
## Please Read Carefully

The code provided in this repository is offered "as is," with no warranties or guarantees of any kind. By using this code, you acknowledge and accept the following terms:

**No Warranties:** The code is provided without any express or implied warranties, including but not limited to implied warranties of merchantability or fitness for a particular purpose. The authors and contributors make no guarantees regarding the performance, reliability, or suitability of the code.

**Use at Your Own Risk:** You are solely responsible for any consequences resulting from the use of this code. This includes but is not limited to any errors, issues, or damages that may arise. It is recommended to thoroughly test the code in your own environment before using it in a production setting.

**No Liability:** The authors and contributors of this repository will not be liable for any direct, indirect, incidental, or consequential damages arising from the use or inability to use this code.

By continuing to use or interact with this repository, you agree to these terms. If you do not agree with these terms, you should not use this code.

# Descriptions
## TeamsAddIn

Customers have been reporting an issue whereby after Microsoft Teams (New) is centrally deployed to Azure Virtual Desktop/AVD environments, the Teams Outlook Scheduling Plug-In fails to successfully install. This is due to the fact that the Outlook plug-in attempts to install in the user context which is typically blocked in Remote/Virtual Desktop environments (MsiInstaller error 1625 appears in the Application Event Log). Microsoft have acknowledged this issue and have provided a workaround script which must be run as Administrator on each machine [here](https://learn.microsoft.com/en-us/microsoftteams/new-teams-vdi-requirements-deploy#new-teams-and-outlook-integration). These are modified versions of this script for use with the InTune Remediation capability to initially determine if the correct version of the Plug-In is installed, and if not, proceed to install it as Administrator to All Users. This *should* be resilient to updates to the Teams package which would otherwise require the script to be re-run reactively.
