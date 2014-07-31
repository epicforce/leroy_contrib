# Script to start services.
#
# Takes as many arguments as you like -- each one a service name to start.

# PowerShell has a scope issue that requires this step
$argTemp = $args

if ($argTemp.Length -lt 1) {
    Write-Host "Required parameter(s): service(s) to start"
    exit(1)
}

$services = @()
for($i = 0; $i -lt $argTemp.Length; $i++) {
    $services += $argTemp[$i]
}
 

# wait for services to complete action
$svcActionWaitSeconds = 30
 
#Script timer
$StartDTM = (Get-Date)
 
#region Functions
function IsNullOrEmpty($str) {if ($str) {return $false} else {return $true}}
function Get-ObjectCount($Obj) {
    if (IsNullOrEmpty $Obj) { return 0 }
    elseif (IsNullOrEmpty $Obj.count) { return 1 }
    else { return $Obj.count }
}
 
function svc-Start ($ServiceName) {
# $svcActionWaitSeconds will need to be defined outside function
    try {
        $i=0
        #Check Current Status
        $CurrentStatus = (Get-Service -Name $ServiceName).Status
        if ($CurrentStatus -eq "Stopped") {
            (Get-Service -Name $ServiceName).start()
            write-host " ==> Starting Service $serviceName " -NoNewline
            while ($CurrentStatus -ne "Running") {
                $CurrentStatus = (Get-Service -Name $ServiceName).Status
                Write-Host "." -NoNewline
                if ($i -gt $svcActionWaitSeconds) {write-host " action timeout " -NoNewline -BackgroundColor yellow -ForegroundColor black ; break }
                $i++; sleep 1
            }
            write-host " ==> $CurrentStatus"
        } elseif ($currentStatus -eq "Running") {
            write-host " ==>  already running service: $ServiceName"
        } else {
            write-host " ==> Service status is $CurrentStatus"
        }
    } catch { $CurrentStatus = "ERROR" }
    return $CurrentStatus
}
  
function svc-Status ($ServiceName) {
    $CurrentStatus = (Get-Service -Name $ServiceName).Status
    write-host " ==> status " -NoNewline
    write-host $CurrentStatus -BackgroundColor Green -ForegroundColor Black -NoNewline;
    write-host " for service: $($ServiceName) "
    return $CurrentStatus
}
#endregion
 
# Loop through all server entries in the csv file and start each of the above listed services.
# Then store the results in an object for later reporting.
foreach ($service in $services) {
    if((svc-start $service) -ne "Running") {
        Write-Host "Aborting because ${service} did not start."
        exit(1)
    }
}

Write-Host "All services started."
exit(0)
