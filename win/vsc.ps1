$type=$args[0]
$mypath=$args[1]
. "$PSScriptRoot\..\scripts\getremote.ps1"
$ret=getremote($mypath)
$code_path=(Split-Path -Parent $(cmd /c where code.cmd))+"\..\Code.exe"
if ($null -ne $ret) {
    Start-Process -Filepath $code_path -ArgumentList "--$type-uri", ('"vscode-remote://ssh-remote+'+$ret[0]+$ret[1].Replace('#', '%23').Replace('"', '\"')+'"')
}else{
    Start-Process -Filepath $code_path -ArgumentList ('"'+$mypath+'"')
}
