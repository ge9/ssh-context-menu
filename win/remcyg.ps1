$mypath=$args[0]
. "$PSScriptRoot\..\scripts\getremote.ps1"
$ret=getremote($mypath)
if ($null -ne $ret) {
    $escaped_path = escape_path($ret[1]).Replace('%','==%').Replace(';','\;')
    wt ssh -t $ret[0] "IFS=\; cd `$`(echo $escaped_path | sed s/==%/%/g`) \;exec `$SHELL -l"
}else{
    wt cyg sh "--login" "-c" '"IFS=\;cd $(echo $*|/bin/sed ''s/==%/%/g\;s/\\\\?/\\\\\\\\?/\;s/^\\\"//\;s/\\\"$//''|/bin/cygpath -f -)\;exec bash"' -- $($mypath.Replace('%','==%').Replace(';','\;'))
#     Start-Process -Filepath cyg -ArgumentList 'sh',"--login","-c",@'
# "IFS=;cd $(echo $*|/bin/sed 's/\\\\?/\\\\\\\\?/;s/^\"//;s/\"$//'|/bin/cygpath -f -);exec bash"
# '@, '--',"`"$mypath`""
}
