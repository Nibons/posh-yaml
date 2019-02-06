# Install Dependencies
# install nuget if its not a source
$package_source = Get-PackageSource | Where-object {$_.IsTrusted} | Where-Object Location -eq 'https://nuget.org/api/v2'
$temp_source = if (!$package_source) {
    $package_source = Register-PackageSource -name 'temp_package_source' -Location 'https://nuget.org/api/v2' -Trusted -providerName 'NuGet'
    $true
}
else {$false}

# install YamlDotNet
Find-Package -source $package_source.name -Name 'YamlDotNet' -MinimumVersion 5.3.0 |
    Install-Package -Destination .\posh-yaml\bin -Force

if ($temp_source) {$package_source | Unregister-PackageSource -Force}