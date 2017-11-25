# Obtem o ID principal para correr o crack
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent();
$myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID);

# Obtem a segurança principal para Admin
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator;

# Verifica se tudo está correndo em Admin
if ($myWindowsPrincipal.IsInRole($adminRole))
{
    # Running as an administrator, so change the title and background colour to indicate this
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)";
    $Host.UI.RawUI.BackgroundColor = "DarkBlue";
    Clear-Host;
}
else {
    # Not Running as Admin.
    # Cria um novo processo que inicia o PWShell
    $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";

    # Specify the current script path and name as a parameter with added scope and support for scripts with spaces in it's path
    $newProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"

    # Indica que o processo deve ser elevado
    $newProcess.Verb = "runas";

    # Começa um novo processo
    [System.Diagnostics.Process]::Start($newProcess);

    # Termina o processo atual
    Exit;
}

$url = "https://raw.githubusercontent.com/anesthetiize/SpotifyHosts/master/hosts"
curl $url -OutFile C:\hosts.txt
$h = gc C:\hosts.txt
$h > C:\Windows\System32\Drivers\etc\hosts
cd $env:USERPROFILE\AppData\Roaming\Spotify\Apps
Rename-Item ad.spa adX.spa

Write-Host -NoNewLine "Pronto! pressione qualquer tecla para fechar [Por: Nyx Lean]";
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown");
