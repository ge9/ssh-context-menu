$mypath=$args[0]
. "$PSScriptRoot\..\scripts\getremote.ps1"
$ret=getremote($mypath)
if ($null -ne $ret) {
    $OutputEncoding = [System.Text.Encoding]::UTF8
    $splitPath=escape_path($ret[1])
    $res = (new-object -comobject wscript.shell).popup("Removing '$($ret[1])', OK?",0,"Delete in Remote", 1+256);
    if ($res -eq 2) {exit;}
    ssh $ret[0] "rm -rf $($splitPath)"
    exit
}
