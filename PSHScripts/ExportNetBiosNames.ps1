param (
     [string] $InputPaths,
     [string] $InputData = "D:\\data\\Folder Links.txt",
     [string]$searchPath = "",
     [string] $targetFile = "",
     [string] $targetFolder = ""
)
$List = Build-ImageList -ListPath $InputData
$file = Get-ChildItem -Path $searchPath -Name $targetFile
$file