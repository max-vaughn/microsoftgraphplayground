#
# Remove token before you push changes to cloud
# Need a new token every day from Graph Explorer to use on Corp network.
#
$GraphExplorerToken = ""
$SecTok = ConvertTo-SecureString $GraphExplorerToken -AsPlainText -Force
Connect-MgGraph -AccessToken $SecTok