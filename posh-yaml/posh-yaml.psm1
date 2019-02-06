# Load DLL
$yaml_dot_net_file = "$PSScriptRoot\bin\lib\netstandard1.3\YamlDotNet.dll"
if (test-path $yaml_dot_net_file) {
    [System.Reflection.Assembly]::LoadFile($yaml_dot_net_file)
}
else {
    throw 'Please run Install.ps1'
}

# load Public/private functions
$Public = @( Get-ChildItem -Path $PSScriptRoot\public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\private\*.ps1 -ErrorAction SilentlyContinue )
foreach ($import in @($Public + $Private)) {
    try {
        . $import.fullname
    }
    catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename -Alias *
