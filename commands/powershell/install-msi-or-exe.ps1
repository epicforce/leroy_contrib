# Make sure we're in the right directory
# Requires 2 variables be set in the environment: INSTALL_DIR and INSTALL_FILE
# INSTALL_DIR: The folder that contains the INSTALL_FILE
# INSTALL_FILE: An .msi or .exe that you want automatically installed

CD $ENV:INSTALL_DIR

#-------------------------------------------------------------------------------------
# Functions
#-------------------------------------------------------------------------------------

function InstallApplication([string]${ApplicationName}, [int]${Silent})
{
    Write-Host "Installing ${ApplicationName}" -BackgroundColor Red;
        if (${Silent} -eq 1)    {
                Start-Process ${ApplicationName} -ArgumentList /S -wait;
        }
        if (${Silent} -eq 2)    {
                 Start-Process ${ApplicationName} -ArgumentList /Passive -wait;
        }
        else    {
    Start-Process ${ApplicationName} -ArgumentList /Passive, /norestart -wait;
        }
}

InstallApplication "$ENV:INSTALL_FILE" 0;
