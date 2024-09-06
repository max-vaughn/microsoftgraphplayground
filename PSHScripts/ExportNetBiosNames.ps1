param (
     [string] $InputData = "D:\\data\\engineer_mapping_data.txt",
     [string] $DomainCache =""
)
$Aliases = Import-Csv -Path $InputData
$NetBiosDomain = @{}
$ExportList = @()
ForEach ( $Item in $Aliases ) {
     $upn = $Item.Alias + "@microsoft.com"
     $User = Get-MgBetaUser -UserId $upn
     $domain = $NetBiosDomain[$User.OnPremisesDomainName]
     if( $domain -eq $null ){
          $ldp = "LDAP://" + $User.OnPremisesDomainName
          $domain = ([ADSI]$ldp).DC 
          $NetBiosDomain.Add($User.OnPremisesDomainName, $domain)
     }
     $UserNetBiosName = [string]::Format("{0}\{1}", $domain[0], $Item.Alias)
     $uObj = new-object PSObject
     $uObj | Add-Member -Name "Account" -Type NoteProperty -Value $UserNetBiosName
     $uObj | Add-Member -Name "Role" -Type NoteProperty -Value "member"
     $ExportList = $ExportList + $uObj
}
$outPath = "D:\\data\domain_cache.csv"
$importPath = "D:\\data\bulk_import.csv"
$NetBiosDonmain | export-csv -Path $outPath -Force
$ExportList | export-csv -Path $importPath -NoTypeInformation -Force