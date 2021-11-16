$gs_name = "RebuildClosedIndustries"
$gs_pack_name = $gs_name.replace(" ", "-")
$VersionFile = Get-Content  version.nut  


$Version = -1
$VersionLine = ($VersionFile | Select-String -Pattern "SELF_VERSION\s+<-\s+([0-9]+)")
if ($null -ne $VersionLine){
    $VersionLineString = $VersionLine.ToString()
    $Version = $VersionLineString.split()[2].replace(";","")
}else{
    exit 1
}

$DirectoryName = $gs_pack_name + "-v" + $Version
$ArchiveName = $DirectoryName + ".tar"
if (Test-Path -path $DirectoryName){
    Write-Warning "Directory Path Already Exists. Removing"
    Remove-Item $DirectoryName -Recurse
}
New-Item $DirectoryName -ItemType Directory
Copy-Item .\*.nut, .\readme.txt, .\license.txt, .\changelog.txt, .\lang -Destination $DirectoryName -PassThru -Recurse
tar.exe -cf $ArchiveName $DirectoryName
Remove-Item $DirectoryName -Recurse