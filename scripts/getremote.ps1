function getremote($mypath){
    $myHash = @{}
    Get-Content "$PSScriptRoot\..\config\remote-paths.txt" | ConvertFrom-Csv | ForEach-Object {$myHash[$_.Key] = $_.Value}
    foreach ($key in $myHash.Keys) {
        if ($mypath.StartsWith($key)) {
            $newpath = ($myHash[$key]+$mypath.SubString($key.length).Replace('\','/'))
            $myIndex = $newpath.IndexOf(':')
            return $newpath.Substring(0, $myIndex),$newpath.Substring($myIndex+1)
        }
    }
    return $null
}
# similar to printf %q
function escape_path($mypath){
    return $mypath -replace '(["$@&\''()^\|\[\]{}*?<>\`\\ ])','\$1'
}