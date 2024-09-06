param (
     [string] $InputData = "D:\\data\\dump.csv",
     [string] $DomainCache =""
)
$Aliases = Import-Csv -Path $InputData
$i=0
$group = Get-MGBetaGroup -Filter "MailNickname eq 'scimiddev'"
ForEach ( $Item in $Aliases ) {
     $upn = ($Item.'Target Account'.Split('\'))[1] + "@microsoft.com"
     $usr = Get-MgBetaUser -UserId $upn
     $nw = New-MgBetaGroupMember -GroupId $group.id -DirectoryObjectId $usr.Id
     $i++
}
