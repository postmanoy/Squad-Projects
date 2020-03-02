<powershell>

#functions
function Show-Menu
{
     param (
           [string]$Title = 'Deep Security Agent Pre-Check Tool'
     )
     cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' for DSaaS pre-check."
     Write-Host "2: Press '2' for Deep Security AMI pre-check."
     Write-Host "3: Press '3' for Deep Security On-Premise pre-check."
     Write-Host "4: Press '4' to Check specific IP/URL and port connectivity"
     Write-Host "Q: Press 'q' to quit."
}

function Test-Port($ip)
{
    $t = New-Object System.Net.Sockets.TcpClient
    try{
    $t.Connect($ip, 443)
    if ($t.Connected) {
    echo "Successfully connected to $ip via port 443"
        }
    }
    catch {
        echo "Failed to connect to $ip via port 443"
    }
}

function Test-Port80($ip)
{
    $t = New-Object System.Net.Sockets.TcpClient
    try{
    $t.Connect($ip, 80)
    if ($t.Connected) {
    echo "Successfully connected to $ip via port 80"
        }
    }
    catch {
        echo "Failed to connect to $ip via port 80"
    }
}


function Test-PortRaw($ip)
{
    $ip1, $port1 = $ip.split(' ')
    $t = New-Object System.Net.Sockets.TcpClient
    try{
    $t.Connect($ip1, $port1)
    if ($t.Connected) {
        Write-Host "Successfully connected to $ip1 via port $port1"
    }
   }
   catch{
        Write-Host "Failed to connect to $ip1 via port $port1"
    }
}


function Test-Port4118($ip)
{
    $port = 4118
    $tm = New-Object System.Net.Sockets.TcpClient
    try{
    $tm.Connect($ip, $port)
    if ($tm.Connected) {
    echo "Successfully connected to $ip via port $port"
        }
    }
    catch {
        echo "Failed to connect to $ip via port $port"
    }
}


function Test-Port4119($ip)
{
    $port = 4119
    $tm = New-Object System.Net.Sockets.TcpClient
    try{
    $tm.Connect($ip, $port)
    if ($tm.Connected) {
    echo "Successfully connected to $ip via port $port"
        }
    }
    catch {
        echo "Failed to connect to $ip via port $port"
    }
}


function Test-Port4120($ip)
{
    $port = 4120
    $tm = New-Object System.Net.Sockets.TcpClient
    try{
    $tm.Connect($ip, $port)
    if ($tm.Connected) {
    echo "Successfully connected to $ip via port $port"
        }
    }
    catch {
        echo "Failed to connect to $ip via port $port"
    }
}


function Test-Port4122($ip)
{
    $port = 4122
    $tm = New-Object System.Net.Sockets.TcpClient
    try{
    $tm.Connect($ip, $port)
    if ($tm.Connected) {
    echo "Successfully connected to $ip via port $port"
        }
    }
    catch {
        echo "Failed to connect to $ip via port $port"
    }
}



function Test-ServerSSLSupport {
[CmdletBinding()]
param(
[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
[ValidateNotNullOrEmpty()]
[string]$HostName,
[UInt16]$Port = 443
)
process {
$RetValue = New-Object psobject -Property @{
Host = $HostName
Port = $Port
SSLv2 = $false
SSLv3 = $false
TLSv1_0 = $false
TLSv1_1 = $false
TLSv1_2 = $false
KeyExhange = $null
HashAlgorithm = $null
}
“ssl2”, “ssl3”, “tls”, “tls11”, “tls12” | %{
$TcpClient = New-Object Net.Sockets.TcpClient
$TcpClient.Connect($RetValue.Host, $RetValue.Port)
$SslStream = New-Object Net.Security.SslStream $TcpClient.GetStream()
$SslStream.ReadTimeout = 15000
$SslStream.WriteTimeout = 15000
try {
$SslStream.AuthenticateAsClient($RetValue.Host,$null,$_,$false)
$RetValue.KeyExhange = $SslStream.KeyExchangeAlgorithm
$RetValue.HashAlgorithm = $SslStream.HashAlgorithm
$status = $true
} catch {
$status = $false
}
switch ($_) {
“ssl2” {$RetValue.SSLv2 = $status}
“ssl3” {$RetValue.SSLv3 = $status}
“tls” {$RetValue.TLSv1_0 = $status}
“tls11” {$RetValue.TLSv1_1 = $status}
“tls12” {$RetValue.TLSv1_2 = $status}
}

}
$RetValue
“From “+ $TcpClient.client.LocalEndPoint.address.IPAddressToString +” to $hostname “+ $TcpClient.client.RemoteEndPoint.address.IPAddressToString +’:’+$TcpClient.client.RemoteEndPoint.port + " Success!"

}
}

function Test-ServerSSLSupportRaw {
[CmdletBinding()]
param(
[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
[ValidateNotNullOrEmpty()]
[string]$HostName,
[UInt16]$Port
)
process {
$RetValue = New-Object psobject -Property @{
Host = $HostName
Port = $Port
SSLv2 = $false
SSLv3 = $false
TLSv1_0 = $false
TLSv1_1 = $false
TLSv1_2 = $false
KeyExhange = $null
HashAlgorithm = $null
}
“ssl2”, “ssl3”, “tls”, “tls11”, “tls12” | %{
$TcpClient = New-Object Net.Sockets.TcpClient
$TcpClient.Connect($RetValue.Host, $RetValue.Port)
$SslStream = New-Object Net.Security.SslStream $TcpClient.GetStream()
$SslStream.ReadTimeout = 15000
$SslStream.WriteTimeout = 15000
try {
$SslStream.AuthenticateAsClient($RetValue.Host,$null,$_,$false)
$RetValue.KeyExhange = $SslStream.KeyExchangeAlgorithm
$RetValue.HashAlgorithm = $SslStream.HashAlgorithm
$status = $true
} catch {
$status = $false
}
switch ($_) {
“ssl2” {$RetValue.SSLv2 = $status}
“ssl3” {$RetValue.SSLv3 = $status}
“tls” {$RetValue.TLSv1_0 = $status}
“tls11” {$RetValue.TLSv1_1 = $status}
“tls12” {$RetValue.TLSv1_2 = $status}
}

}
$RetValue
“From “+ $TcpClient.client.LocalEndPoint.address.IPAddressToString +” to $hostname “+ $TcpClient.client.RemoteEndPoint.address.IPAddressToString +’:’+$TcpClient.client.RemoteEndPoint.port + " Success!"

}
}

function Test-ServerSSLSupport4118 {
[CmdletBinding()]
param(
[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
[ValidateNotNullOrEmpty()]
[string]$HostName,
[UInt16]$Port = 4118
)
process {
$RetValue = New-Object psobject -Property @{
Host = $HostName
Port = $Port
SSLv2 = $false
SSLv3 = $false
TLSv1_0 = $false
TLSv1_1 = $false
TLSv1_2 = $false
KeyExhange = $null
HashAlgorithm = $null
}
“ssl2”, “ssl3”, “tls”, “tls11”, “tls12” | %{
$TcpClient = New-Object Net.Sockets.TcpClient
$TcpClient.Connect($RetValue.Host, $RetValue.Port)
$SslStream = New-Object Net.Security.SslStream $TcpClient.GetStream()
$SslStream.ReadTimeout = 15000
$SslStream.WriteTimeout = 15000
try {
$SslStream.AuthenticateAsClient($RetValue.Host,$null,$_,$false)
$RetValue.KeyExhange = $SslStream.KeyExchangeAlgorithm
$RetValue.HashAlgorithm = $SslStream.HashAlgorithm
$status = $true
} catch {
$status = $false
}
switch ($_) {
“ssl2” {$RetValue.SSLv2 = $status}
“ssl3” {$RetValue.SSLv3 = $status}
“tls” {$RetValue.TLSv1_0 = $status}
“tls11” {$RetValue.TLSv1_1 = $status}
“tls12” {$RetValue.TLSv1_2 = $status}
}

}
$RetValue
“From “+ $TcpClient.client.LocalEndPoint.address.IPAddressToString +” to $hostname “+ $TcpClient.client.RemoteEndPoint.address.IPAddressToString +’:’+$TcpClient.client.RemoteEndPoint.port + " Success!"

}
}

function Test-ServerSSLSupport4119 {
[CmdletBinding()]
param(
[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
[ValidateNotNullOrEmpty()]
[string]$HostName,
[UInt16]$Port = 4119
)
process {
$RetValue = New-Object psobject -Property @{
Host = $HostName
Port = $Port
SSLv2 = $false
SSLv3 = $false
TLSv1_0 = $false
TLSv1_1 = $false
TLSv1_2 = $false
KeyExhange = $null
HashAlgorithm = $null
}
“ssl2”, “ssl3”, “tls”, “tls11”, “tls12” | %{
$TcpClient = New-Object Net.Sockets.TcpClient
$TcpClient.Connect($RetValue.Host, $RetValue.Port)
$SslStream = New-Object Net.Security.SslStream $TcpClient.GetStream()
$SslStream.ReadTimeout = 15000
$SslStream.WriteTimeout = 15000
try {
$SslStream.AuthenticateAsClient($RetValue.Host,$null,$_,$false)
$RetValue.KeyExhange = $SslStream.KeyExchangeAlgorithm
$RetValue.HashAlgorithm = $SslStream.HashAlgorithm
$status = $true
} catch {
$status = $false
}
switch ($_) {
“ssl2” {$RetValue.SSLv2 = $status}
“ssl3” {$RetValue.SSLv3 = $status}
“tls” {$RetValue.TLSv1_0 = $status}
“tls11” {$RetValue.TLSv1_1 = $status}
“tls12” {$RetValue.TLSv1_2 = $status}
}

}
$RetValue
“From “+ $TcpClient.client.LocalEndPoint.address.IPAddressToString +” to $hostname “+ $TcpClient.client.RemoteEndPoint.address.IPAddressToString +’:’+$TcpClient.client.RemoteEndPoint.port + " Success!"

}
}

function Test-ServerSSLSupport4120 {
[CmdletBinding()]
param(
[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
[ValidateNotNullOrEmpty()]
[string]$HostName,
[UInt16]$Port = 4120
)
process {
$RetValue = New-Object psobject -Property @{
Host = $HostName
Port = $Port
SSLv2 = $false
SSLv3 = $false
TLSv1_0 = $false
TLSv1_1 = $false
TLSv1_2 = $false
KeyExhange = $null
HashAlgorithm = $null
}
“ssl2”, “ssl3”, “tls”, “tls11”, “tls12” | %{
$TcpClient = New-Object Net.Sockets.TcpClient
$TcpClient.Connect($RetValue.Host, $RetValue.Port)
$SslStream = New-Object Net.Security.SslStream $TcpClient.GetStream()
$SslStream.ReadTimeout = 15000
$SslStream.WriteTimeout = 15000
try {
$SslStream.AuthenticateAsClient($RetValue.Host,$null,$_,$false)
$RetValue.KeyExhange = $SslStream.KeyExchangeAlgorithm
$RetValue.HashAlgorithm = $SslStream.HashAlgorithm
$status = $true
} catch {
$status = $false
}
switch ($_) {
“ssl2” {$RetValue.SSLv2 = $status}
“ssl3” {$RetValue.SSLv3 = $status}
“tls” {$RetValue.TLSv1_0 = $status}
“tls11” {$RetValue.TLSv1_1 = $status}
“tls12” {$RetValue.TLSv1_2 = $status}
}

}
$RetValue
“From “+ $TcpClient.client.LocalEndPoint.address.IPAddressToString +” to $hostname “+ $TcpClient.client.RemoteEndPoint.address.IPAddressToString +’:’+$TcpClient.client.RemoteEndPoint.port + " Success!"

}
}

function Test-ServerSSLSupport4122 {
[CmdletBinding()]
param(
[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
[ValidateNotNullOrEmpty()]
[string]$HostName,
[UInt16]$Port = 4122
)
process {
$RetValue = New-Object psobject -Property @{
Host = $HostName
Port = $Port
SSLv2 = $false
SSLv3 = $false
TLSv1_0 = $false
TLSv1_1 = $false
TLSv1_2 = $false
KeyExhange = $null
HashAlgorithm = $null
}
“ssl2”, “ssl3”, “tls”, “tls11”, “tls12” | %{
$TcpClient = New-Object Net.Sockets.TcpClient
$TcpClient.Connect($RetValue.Host, $RetValue.Port)
$SslStream = New-Object Net.Security.SslStream $TcpClient.GetStream()
$SslStream.ReadTimeout = 15000
$SslStream.WriteTimeout = 15000
try {
$SslStream.AuthenticateAsClient($RetValue.Host,$null,$_,$false)
$RetValue.KeyExhange = $SslStream.KeyExchangeAlgorithm
$RetValue.HashAlgorithm = $SslStream.HashAlgorithm
$status = $true
} catch {
$status = $false
}
switch ($_) {
“ssl2” {$RetValue.SSLv2 = $status}
“ssl3” {$RetValue.SSLv3 = $status}
“tls” {$RetValue.TLSv1_0 = $status}
“tls11” {$RetValue.TLSv1_1 = $status}
“tls12” {$RetValue.TLSv1_2 = $status}
}

}
$RetValue
“From “+ $TcpClient.client.LocalEndPoint.address.IPAddressToString +” to $hostname “+ $TcpClient.client.RemoteEndPoint.address.IPAddressToString +’:’+$TcpClient.client.RemoteEndPoint.port + " Success!"

}
}


# DSaaS URLs
$DSaaSURLs = "files.trendmicro.com", "gacl.trendmicro.com", "grid-global.trendmicro.com", "grid.trendmicro.com", "dsaas1100-en-census.trendmicro.com", "deepsecaas11-en.gfrbridge.trendmicro.com", 
"ds120-en.fbs25.trendmicro.com", "ds120-jp.fbs25.trendmicro.com", "deepsecurity1100-en.fbs25.trendmicro.com", "deepsecurity1100-jp.fbs25.trendmicro.com", "deepsecurity1000-en.fbs20.trendmicro.com",
"deepsecurity1000-jp.fbs20.trendmicro.com", "deepsecurity1000-sc.fbs20.trendmicro.com", "dsaas.icrc.trendmicro.com", "dsaas-en-f.trx.trendmicro.com", "dsaas-en-b.trx.trendmicro.com", "dsaas.url.trendmicro.com",
"sitesafety.trendmicro.com", "jp.sitesafety.trendmicro.com", "iaus.activeupdate.trendmicro.com", "iaus.trendmicro.com", "ipv6-iaus.trendmicro.com", "ipv6-iaus.activeupdate.trendmicro.com"

# DS AMI and On-Premise URLs
$DSAMIandONPURLs = "files.trendmicro.com", "ds1200-en-census.trendmicro.com", "ds1200-jp-census.trendmicro.com", "ds1100-en-census.trendmicro.com", "ds1100-jp-census.trendmicro.com", "ds1020-en-census.trendmicro.com",
"ds1020-jp-census.trendmicro.com", "ds1020-sc-census.trendmicro.com", "ds1000-en.census.trendmicro.com", "ds1000-jp.census.trendmicro.com", "ds1000-sc.census.trendmicro.com", "ds1000-tc.census.trendmicro.com",
"deepsec12-en.gfrbridge.trendmicro.com", "deepsec12-jp.gfrbridge.trendmicro.com", "deepsec11-en.gfrbridge.trendmicro.com", "deepsec11-jp.gfrbridge.trendmicro.com", "deepsec102-en.gfrbridge.trendmicro.com",
"deepsec102-jp.gfrbridge.trendmicro.com", "deepsec10-en.grid-gfr.trendmicro.com", "deepsec10-jp.grid-gfr.trendmicro.com", "deepsec10-cn.grid-gfr.trendmicro.com", "ds120.icrc.trendmicro.com", "ds120-jp.icrc.trendmicro.com",
"ds110.icrc.trendmicro.com", "ds110-jp.icrc.trendmicro.com", "ds102.icrc.trendmicro.com", "ds102-jp.icrc.trendmicro.com", "ds102-sc.icrc.trendmicro.com.cn", "ds10.icrc.trendmicro.com", "ds10-jp.icrc.trendmicro.com",
"ds10-sc.icrc.trendmicro.com", "iaufdbk.trendmicro.com", "ds96.icrc.trendmicro.com", "ds96-jp.icrc.trendmicro.com", "ds96-sc.icrc.trendmicro.com.cn", "ds95.icrc.trendmicro.com", "ds95-jp.icrc.trendmicro.com",
"ds95-sc.icrc.trendmicro.com.cn", "ds120-en-b.trx.trendmicro.com", "ds120-jp-b.trx.trendmicro.com", "ds120-en-f.trx.trendmicro.com", "ds120-jp-f.trx.trendmicro.com", "ds110-en-b.trx.trendmicro.com",
"ds110-jp-b.trx.trendmicro.com", "ds110-en-f.trx.trendmicro.com", "ds110-jp-f.trx.trendmicro.com", "ds102-en-f.trx.trendmicro.com", "ds102-jp-f.trx.trendmicro.com", "ds102-sc-f.trx.trendmicro.com",
"ds12-0-en.url.trendmicro.com", "ds12-0-jp.url.trendmicro.com", "ds11-0-en.url.trendmicro.com", "ds11-0-jp.url.trendmicro.com", "ds10-2-en.url.trendmicro.com", "ds10-2-sc.url.trendmicro.com.cn",
"ds10-2-jp.url.trendmicro.com", "ds100-en.url.trendmicro.com", "ds100-sc.url.trendmicro.com", "ds100-jp.url.trendmicro.com", "ds96-en.url.trendmicro.com", "ds96-jp.url.trendmicro.com",
"ds95-en.url.trendmicro.com", "ds95-jp.url.trendmicro.com", "sitesafety.trendmicro.com", "jp.sitesafety.trendmicro.com", "iaus.activeupdate.trendmicro.com", "iaus.trendmicro.com", "ipv6-iaus.trendmicro.com",
"ipv6-iaus.activeupdate.trendmicro.com"



function Powershell4upDSaaS {
                    $Global:ProgressPreference = 'SilentlyContinue'
                    $Test1 = Test-NetConnection agents.deepsecurity.trendmicro.com -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on agents.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on agents.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection app.deepsecurity.trendmicro.com -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on app.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on app.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection relay.deepsecurity.trendmicro.com -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on relay.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on relay.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection dsmim.deepsecurity.trendmicro.com -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on dsmim.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on dsmim.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    ForEach ($DSaaSURL in $DSaaSURLs){
                    $Test1 = Test-NetConnection $DSaaSURL -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on $DSaaSURL" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on $DSaaSURL" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    }

                    ForEach ($DSaaSURL in $DSaaSURLs){
                    $Test1 = Test-NetConnection $DSaaSURL -Port 80 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 80 on $DSaaSURL" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 80 on $DSaaSURL" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    }
                    Write-Host "Checking SSL/TLS Connection to the URLs..."
                try{
                    Test-ServerSSLSupport agents.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to agents.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport app.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to app.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport relay.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to relay.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport dsmim.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to dsmim.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }

                    Write-Host "Checking Listening and Established Ports..."
                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt

}

function Powershell4upDSaaS-2 {
                    $Global:ProgressPreference = 'SilentlyContinue'
                    $Test1 = Test-NetConnection agents.deepsecurity.trendmicro.com -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on agents.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on agents.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection app.deepsecurity.trendmicro.com -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on app.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on app.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection relay.deepsecurity.trendmicro.com -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on relay.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on relay.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection dsmim.deepsecurity.trendmicro.com -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on dsmim.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on dsmim.deepsecurity.trendmicro.com" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    ForEach ($DSaaSURL in $DSaaSURLs){
                    $Test1 = Test-NetConnection $DSaaSURL -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on $DSaaSURL" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on $DSaaSURL" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    }
                    ForEach ($DSaaSURL in $DSaaSURLs){
                    $Test1 = Test-NetConnection $DSaaSURL -Port 80 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 80 on $DSaaSURL" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 80 on $DSaaSURL" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }
                    }
                    Write-Host "Checking SSL/TLS Connection to the URLs..."
                try{
                    Test-ServerSSLSupport agents.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to agents.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport app.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to app.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport relay.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to relay.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport dsmim.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to dsmim.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }

                    Write-Host "Checking Listening and Established Ports..."
                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt

}


function Powershell4downDSaaS {
                Test-Port('agents.deepsecurity.trendmicro.com') >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                Test-Port('relay.deepsecurity.trendmicro.com') >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                Test-Port('app.deepsecurity.trendmicro.com') >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                Test-Port('dsmim.deepsecurity.trendmicro.com') >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                ForEach ($DSaaSURL in $DSaaSURLs){
                    Test-Port($DSaaSURL) >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                ForEach ($DSaaSURL in $DSaaSURLs){
                    Test-Port80($DSaaSURL) >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                Write-Host "Checking SSL/TLS Connection to the URLs..."
                try{
                    Test-ServerSSLSupport agents.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to agents.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport app.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to app.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport relay.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to relay.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport dsmim.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to dsmim.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }

                    Write-Host "Checking Listening and Established Ports..."
                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
}

function Powershell4downDSaaS-2 {
                Test-Port('agents.deepsecurity.trendmicro.com') >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                Test-Port('relay.deepsecurity.trendmicro.com') >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                Test-Port('app.deepsecurity.trendmicro.com') >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                Test-Port('dsmim.deepsecurity.trendmicro.com') >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                ForEach ($DSaaSURL in $DSaaSURLs){
                    Test-Port($DSaaSURL) >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                ForEach ($DSaaSURL in $DSaaSURLs){
                    Test-Port80($DSaaSURL) >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                Write-Host "Checking SSL/TLS Connection to the URLs..."
                try{
                    Test-ServerSSLSupport agents.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to agents.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport app.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to app.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport relay.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to relay.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport dsmim.deepsecurity.trendmicro.com >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to dsmim.deepsecurity.trendmicro.com on port 443" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }

                    Write-Host "Checking Listening and Established Ports..."
                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
}


function Powershell4upDSAMI {
                    $Global:ProgressPreference = 'SilentlyContinue'
                    $Test1 = Test-NetConnection $inputadd -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection $inputadd -Port 4120 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 4120 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 4120 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection $inputadd -Port 4122 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 4122 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 4122 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    $Test1 = Test-NetConnection $DSAMIONP -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on $DSAMIONP" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on $DSAMIONP" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                    }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    $Test1 = Test-NetConnection $DSAMIONP -Port 80 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 80 on $DSAMIONP" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 80 on $DSAMIONP" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                    }
                    Write-Host "Checking SSL/TLS Connection to the URLs..."
                    try{
                    Test-ServerSSLSupport $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 443" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4118 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4118" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4120 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4120" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4122 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4122" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }

                    Write-Host "Checking Listening and Established Ports..."
                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
}

function Powershell4upDSAMI-2 {
                    $Global:ProgressPreference = 'SilentlyContinue'
                    $Test1 = Test-NetConnection $inputadd -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection $inputadd -Port 4120 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 4120 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 4120 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection $inputadd -Port 4122 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 4122 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 4122 on $inputadd" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    $Test1 = Test-NetConnection $DSAMIONP -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on $DSAMIONP" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on $DSAMIONP" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                    }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    $Test1 = Test-NetConnection $DSAMIONP -Port 80 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 80 on $DSAMIONP" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 80 on $DSAMIONP" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }
                    }
                    Write-Host "Checking SSL/TLS Connection to the URLs..."
                    try{
                    Test-ServerSSLSupport $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 443" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4118 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4118" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4120 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4120" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4122 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4122" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }

                    Write-Host "Checking Listening and Established Ports..."
                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
}

function Powershell4downDSAMI {
                    Test-Port($inputadd) >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Test-Port4120($inputadd) >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Test-Port4122($inputadd) >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    Test-Port($DSAMIONP) >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    Test-Port80($DSAMIONP) >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    Write-Host "Checking SSL/TLS Connection to the URLs..."
                    try{
                    Test-ServerSSLSupport $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 443" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4118 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4118" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4120 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4120" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4122 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4122" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }

                    Write-Host "Checking Listening and Established Ports..."
                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
}

function Powershell4downDSAMI-2 {
                    Test-Port($inputadd) >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Test-Port4120($inputadd) >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Test-Port4122($inputadd) >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    Test-Port($DSAMIONP) >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    Test-Port80($DSAMIONP) >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    Write-Host "Checking SSL/TLS Connection to the URLs..."
                    try{
                    Test-ServerSSLSupport $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 443" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4118 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4118" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4120 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4120" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4122 $inputadd >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4122" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }

                    Write-Host "Checking Listening and Established Ports..."
                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt

}

function Powershell4upDSONP {
                    $Global:ProgressPreference = 'SilentlyContinue'
                    $Test1 = Test-NetConnection $inputadd -Port 4119 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 4119 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 4119 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection $inputadd -Port 4120 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 4120 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 4120 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection $inputadd -Port 4122 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 4122 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 4122 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    $Test1 = Test-NetConnection $DSAMIONP -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on $DSAMIONP" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on $DSAMIONP" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                    }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    $Test1 = Test-NetConnection $DSAMIONP -Port 80 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 80 on $DSAMIONP" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 80 on $DSAMIONP" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                    }
                    Write-Host "Checking SSL/TLS Connection to the URLs..."
                    try{
                    Test-ServerSSLSupport4118 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4118" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4119 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4119" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4120 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4120" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4122 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4122" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }

                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
}

function Powershell4upDSONP-2 {
                    $Global:ProgressPreference = 'SilentlyContinue'
                    $Test1 = Test-NetConnection $inputadd -Port 4119 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 4119 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 4119 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection $inputadd -Port 4120 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 4120 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 4120 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                    $Test1 = Test-NetConnection $inputadd -Port 4122 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 4122 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 4122 on $inputadd" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    $Test1 = Test-NetConnection $DSAMIONP -Port 443 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 443 on $DSAMIONP" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 443 on $DSAMIONP" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                    }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    $Test1 = Test-NetConnection $DSAMIONP -Port 80 -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                        if($Test1 -eq 'True'){
                            echo "Successfully connected to port 80 on $DSAMIONP" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                        else{
                            echo "Failed to connect to port 80 on $DSAMIONP" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }
                    }
                    Write-Host "Checking SSL/TLS Connection to the URLs..."
                    try{
                    Test-ServerSSLSupport4118 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4118" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4119 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4119" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4120 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4120" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4122 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4122" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }

                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
}

function Powershell4downDSONP {
                    Test-Port4119($inputadd) >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Test-Port4120($inputadd) >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Test-Port4122($inputadd) >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    Test-Port($inputadd) >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    Test-Port80($inputadd) >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    Write-Host "Checking SSL/TLS Connection to the URLs..."
                    try{
                    Test-ServerSSLSupport4118 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4118" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4119 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4119" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4120 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4120" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4122 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4122" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }

                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
}


function Powershell4downDSONP-2 {
                    Test-Port4119($inputadd) >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Test-Port4120($inputadd) >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Test-Port4122($inputadd) >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    Test-Port($inputadd) >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    ForEach ($DSAMIONP in $DSAMIandONPURLs){
                    Test-Port80($inputadd) >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    Write-Host "Checking SSL/TLS Connection to the URLs..."
                    try{
                    Test-ServerSSLSupport4118 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4118" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4119 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4119" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4120 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4120" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    try{
                    Test-ServerSSLSupport4122 $inputadd >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    catch{
                        echo "Failed to connect via SSL/TLS to $inputadd on port 4122" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }

                    echo "Checking Listening and Established Ports..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    netstat -an | findstr "LISTENING ESTABLISHED" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
}


#Main Program Execution
do
{
     Show-Menu
     $input = Read-Host "Enter Choice"
     switch ($input)
     {
           '1' {
                cls
                New-Item -Path "$env:USERPROFILE" -Name "DSaaS_Pre-check" -ItemType "directory" -Force | Out-Null
                Write-Host "Please wait..."
                $versionPS = $PSVersionTable.PSVersion.Major
                if ($versionPS -gt 3){
                    Write-Host "You are using Powershell version 4 and up."
                    Write-Host "Checking the system if it has proxy enabled..."
                    $p = Get-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
                    if ($p.ProxyEnable -eq 1){
                    $server = $p.ProxyServer
                    Write-Host "This machine has a proxy enabled."
                    echo "This machine has a proxy enabled : $server" > $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                     }
                    else{
                        Write-Host "This machine has no proxy enabled."
                        echo "This machine has no proxy enabled." > $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    Write-Host "Checking connection to the URLs of Deep Security As A Service..."
                    Powershell4upDSaaS
                    Write-Host "Done. See connection.txt inside the zip file that will be created later for more information."
                    Write-Host "Send Heartbeat to the Manager..."
                    try{
                    & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -m >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    do{1
                    $diagopt = Read-Host "Enable agent debugging?(y/n)"
                    if ($diagopt -eq 'y'){
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\sendCommand" --get Trace?trace=* >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        Write-Host "Enabled Debugging. Trace set to *."
                        Write-Host "Rechecking Connection to URLs. Please wait..."
                        Powershell4upDSaaS-2
                        Write-Host "Rechecking Connection Done."
                        $diagstop = Read-Host "Replicate the issue. Type y and press enter when done"
                        if ($diagstop -eq 'y'){
                            try{
                            Write-Host "Restarting ds_agent..."
                            Restart-Service -Name ds_agent -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                            Write-Host "Service has been restarted successfully."
                            }
                            catch{
                            Write-Host "Service failed to restart."
                            }
                            Write-Host "Creating Diagnostic Package..."
                            Start-Sleep -s 2
                            try{
                            & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                            }catch{
                            echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                            echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                            Write-Host "Failed. Check if Deep Security Agent is installed properly."
                            }
                            Start-Sleep -s 5
                            do{
                            Start-Sleep -s 5
                            }
                            until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                            Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSaaS_Pre-check" -Force
                         }
                    }elseif ($diagopt -eq 'n'){
                        Write-Host "Creating Diagnostic Package..."
                        Start-Sleep -s 2
                        try{
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }catch{
                        echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        Write-Host "Failed. Check if Deep Security Agent is installed properly."
                        }
                        Start-Sleep -s 5
                        do{
                        Start-Sleep -s 5
                        }
                        until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                        Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSaaS_Pre-check" -Force
                    }
                    }until(($diagopt -eq 'y') -or ($diagopt -eq 'n'))
                    }catch{
                    echo "Send Heartbeat to the Manager..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    Write-Host "Failed. Check if Deep Security Agent is installed properly."

                    Write-Host "Getting System Information..."
                    echo "Getting System Information..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    Start-Process -WindowStyle Hidden msinfo32 -ArgumentList "/nfo $env:USERPROFILE\DSaaS_Pre-check\msinfo.nfo"
                    $p = Get-Process -Name msinfo32
                    Wait-Process -id $p.Id
                    echo "Getting System Information...Done" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    Write-Host "Getting System Information...Done"

                    }
                    Write-Host "Getting all running task..."
                    tasklist >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    Write-Host "Getting all running task...Done"


                    $source = "$env:USERPROFILE\DSaaS_Pre-check"
                    $archive = "$env:USERPROFILE\Desktop\Pre-check DSaaS Package.zip"

                    Add-Type -assembly "system.io.compression.filesystem"
                    [io.compression.zipfile]::CreateFromDirectory($source, $archive)
                    Get-ChildItem $env:USERPROFILE"\DSaaS_Pre-check" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\Desktop" -Force
                    Start-Sleep -s 3
                    Remove-Item $env:USERPROFILE\DSaaS_Pre-check -Force -Recurse
                    Write-Host "Done. See zip file created in Desktop."
                    
                    }

                else {
                Write-Host "You are using Powershell version 4 lower"
                Write-Host "Checking connection to the URLs of Deep Security As A Service..."
                Write-Host "Checking the system if it has proxy enabled..."
                $p = Get-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
                if ($p.ProxyEnable -eq 1){
                $server = $p.ProxyServer
                Write-Host "This machine has a proxy enabled."
                echo "This machine has a proxy enabled : $server" > $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                }
                else{
                Write-Host "This machine has no proxy enabled."
                echo "This machine has no proxy enabled." > $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                }
                Powershell4downDSaaS
                Write-Host "Done. See connection.txt inside the zip file that will be created later for more information."
                Write-Host "Send Heartbeat to the Manager..."
                try{
                    & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -m >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    do{
                    $diagopt = Read-Host "Enable agent debugging?(y/n)"
                    if ($diagopt -eq 'y'){
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\sendCommand" --get Trace?trace=* >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        Write-Host "Enabled Debugging. Trace set to *."
                        Write-Host "Rechecking Connection to URLs. Please wait..."
                        Powershell4downDSaaS-2
                        Write-Host "Rechecking Connection Done."
                        $diagstop = Read-Host "Replicate the issue. Type y and press enter when done"
                        if ($diagstop -eq 'y'){
                            try{
                            Write-Host "Restarting ds_agent..."
                            Restart-Service -Name ds_agent -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                            Write-Host "Service has been restarted successfully."
                            }
                            catch{
                            Write-Host "Service failed to restart."
                            }
                            Write-Host "Creating Diagnostic Package..."
                            Start-Sleep -s 2
                            try{
                            & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                            }catch{
                            echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                            echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                            Write-Host "Failed. Check if Deep Security Agent is installed properly."
                            }
                            Start-Sleep -s 5
                            do{
                            Start-Sleep -s 5
                            }
                            until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                            Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSaaS_Pre-check" -Force
                         }
                    }elseif ($diagopt -eq 'n'){
                        Write-Host "Creating Diagnostic Package..."
                        Start-Sleep -s 2
                        try{
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        }catch{
                        echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                        Write-Host "Failed. Check if Deep Security Agent is installed properly."
                        }
                        Start-Sleep -s 5
                        do{
                        Start-Sleep -s 5
                        }
                        until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                        Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSaaS_Pre-check" -Force
                    }
                    }until(($diagopt -eq 'y') -or ($diagopt -eq 'n'))
                    }catch{
                    echo "Send Heartbeat to the Manager..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    Write-Host "Failed. Check if Deep Security Agent is installed properly."

                    Write-Host "Getting System Information..."
                    echo "Getting System Information..." >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    Start-Process -WindowStyle Hidden msinfo32 -ArgumentList "/nfo $env:USERPROFILE\DSaaS_Pre-check\msinfo.nfo"
                    $p = Get-Process -Name msinfo32
                    Wait-Process -id $p.Id
                    echo "Getting System Information...Done" >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    Write-Host "Getting System Information...Done"

                    }
                    Write-Host "Getting all running task..."
                    tasklist >> $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    Write-Host "Getting all running task...Done"
                    
                $source = "$env:USERPROFILE\DSaaS_Pre-check"
                $archive = "$env:USERPROFILE\Desktop\Pre-check DSaaS Package.zip"

                Add-Type -assembly "system.io.compression.filesystem"
                [io.compression.zipfile]::CreateFromDirectory($source, $archive)
                Get-ChildItem $env:USERPROFILE"\DSaaS_Pre-check" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\Desktop" -Force
                Start-Sleep -s 3
                Remove-Item $env:USERPROFILE\DSaaS_Pre-check -Force -Recurse
                Write-Host "Done. See zip file created in Desktop."
                
                }

           } '2' {
                cls
                New-Item -Path "$env:USERPROFILE" -Name "DSAMI_Pre-check" -ItemType "directory" -Force | Out-Null
                Write-Host "Please wait..."
                $inputadd = Read-Host "Enter IP address or FQDN (without https)"
                $versionPS = $PSVersionTable.PSVersion.Major
                if ($versionPS -gt 3){
                    Write-Host "You are using Powershell version 4 and up."
                    Write-Host "Checking the system if it has proxy enabled..."
                    $p = Get-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
                    if ($p.ProxyEnable -eq 1){
                    $server = $p.ProxyServer
                    Write-Host "This machine has a proxy enabled."
                    echo "This machine has a proxy enabled : $server" > $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    else{
                    Write-Host "This machine has no proxy enabled."
                    echo "This machine has no proxy enabled." > $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    Write-Host "Checking connection to the URLs of Deep Security AMI..."
                    Powershell4upDSAMI
                    Write-Host "Done. See connection.txt inside the zip file that will be created later for more information."
                    Write-Host "Send Heartbeat to the Manager..."
                     try{
                    & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -m >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    do{
                    $diagopt = Read-Host "Enable agent debugging?(y/n)"
                    if ($diagopt -eq 'y'){
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\sendCommand" --get Trace?trace=* >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        Write-Host "Enabled Debugging. Trace set to *."
                        Write-Host "Rechecking Connection to URLs. Please wait..."
                        Powershell4upDSAMI-2
                        Write-Host "Rechecking Connection Done."
                        $diagstop = Read-Host "Replicate the issue. Type y and press enter when done"
                        if ($diagstop -eq 'y'){
                            try{
                            Write-Host "Restarting ds_agent..."
                            Restart-Service -Name ds_agent -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                            Write-Host "Service has been restarted successfully."
                            }
                            catch{
                            Write-Host "Service failed to restart."
                            }
                            Write-Host "Creating Diagnostic Package..."
                            Start-Sleep -s 2
                            try{
                            & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                            }catch{
                            echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                            echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                            Write-Host "Failed. Check if Deep Security Agent is installed properly."
                            }
                            Start-Sleep -s 5
                            do{
                            Start-Sleep -s 5
                            }
                            until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                            Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSAMI_Pre-check" -Force
                         }
                    }elseif ($diagopt -eq 'n'){
                        Write-Host "Creating Diagnostic Package..."
                        Start-Sleep -s 2
                        try{
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }catch{
                        echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        Write-Host "Failed. Check if Deep Security Agent is installed properly."
                        }
                        Start-Sleep -s 5
                        do{
                        Start-Sleep -s 5
                        }
                        until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                        Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSAMI_Pre-check" -Force
                    }
                    }until(($diagopt -eq 'y') -or ($diagopt -eq 'n'))
                    }catch{
                    echo "Send Heartbeat to the Manager..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Write-Host "Failed. Check if Deep Security Agent is installed properly."

                    Write-Host "Getting System Information..."
                    echo "Getting System Information..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Start-Process -WindowStyle Hidden msinfo32 -ArgumentList "/nfo $env:USERPROFILE\DSAMI_Pre-check\msinfo.nfo"
                    $p = Get-Process -Name msinfo32
                    Wait-Process -id $p.Id
                    echo "Getting System Information...Done" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Write-Host "Getting System Information...Done"

                    }
                    Write-Host "Getting all running task..."
                    tasklist >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Write-Host "Getting all running task...Done"

                    $source = "$env:USERPROFILE\DSAMI_Pre-check"
                    $archive = "$env:USERPROFILE\Desktop\Pre-check DSAMI Package.zip"

                    Add-Type -assembly "system.io.compression.filesystem"
                    [io.compression.zipfile]::CreateFromDirectory($source, $archive)
                    Get-ChildItem $env:USERPROFILE"\DSAMI_Pre-check" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\Desktop" -Force
                    Start-Sleep -s 3
                    Remove-Item $env:USERPROFILE\DSAMI_Pre-check -Force -Recurse
                    Write-Host "Done. See zip file created in Desktop."
                    
                    }

                    else{
                    Write-Host "You are using Powershell version 3 and lower."
                    Write-Host "Checking the system if it has proxy enabled..."
                    $p = Get-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
                    if ($p.ProxyEnable -eq 1){
                    $server = $p.ProxyServer
                    Write-Host "This machine has a proxy enabled."
                    echo "This machine has a proxy enabled : $server" > $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    else{
                    Write-Host "This machine has no proxy enabled."
                    echo "This machine has no proxy enabled." > $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    }
                    Write-Host "Checking connection to the URLs of Deep Security AMI..."
                    Powershell4downDSAMI
                    Write-Host "Done. See connection.txt inside the zip file that will be created later for more information."
                    Write-Host "Send Heartbeat to the Manager..."
                     try{
                    & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -m >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    do{
                    $diagopt = Read-Host "Enable agent debugging?(y/n)"
                    if ($diagopt -eq 'y'){
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\sendCommand" --get Trace?trace=* >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        Write-Host "Enabled Debugging. Trace set to *."
                        Write-Host "Rechecking Connection to URLs. Please wait..."
                        Powershell4downDSAMI-2
                        Write-Host "Rechecking Connection Done."
                        $diagstop = Read-Host "Replicate the issue. Type y and press enter when done"
                        if ($diagstop -eq 'y'){
                            try{
                            Write-Host "Restarting ds_agent..."
                            Restart-Service -Name ds_agent -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                            Write-Host "Service has been restarted successfully."
                            }
                            catch{
                            Write-Host "Service failed to restart."
                            }
                            Write-Host "Creating Diagnostic Package..."
                            Start-Sleep -s 2
                            try{
                            & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                            }catch{
                            echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                            echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                            Write-Host "Failed. Check if Deep Security Agent is installed properly."
                            }
                            Start-Sleep -s 5
                            do{
                            Start-Sleep -s 5
                            }
                            until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                            Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSAMI_Pre-check" -Force
                         }
                    }elseif ($diagopt -eq 'n'){
                        Write-Host "Creating Diagnostic Package..."
                        Start-Sleep -s 2
                        try{
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        }catch{
                        echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                        Write-Host "Failed. Check if Deep Security Agent is installed properly."
                        }
                        Start-Sleep -s 5
                        do{
                        Start-Sleep -s 5
                        }
                        until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                        Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSAMI_Pre-check" -Force
                    }
                    }until(($diagopt -eq 'y') -or ($diagopt -eq 'n'))
                    }catch{
                    echo "Send Heartbeat to the Manager..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Write-Host "Failed. Check if Deep Security Agent is installed properly."

                    Write-Host "Getting System Information..."
                    echo "Getting System Information..." >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Start-Process -WindowStyle Hidden msinfo32 -ArgumentList "/nfo $env:USERPROFILE\DSAMI_Pre-check\msinfo.nfo"
                    $p = Get-Process -Name msinfo32
                    Wait-Process -id $p.Id
                    echo "Getting System Information...Done" >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Write-Host "Getting System Information...Done"

                    }

                    Write-Host "Getting all running task..."
                    tasklist >> $env:USERPROFILE\DSAMI_Pre-check\connection.txt
                    Write-Host "Getting all running task...Done"

                    $source = "$env:USERPROFILE\DSAMI_Pre-check"
                    $archive = "$env:USERPROFILE\Desktop\Pre-check DSAMI Package.zip"

                    Add-Type -assembly "system.io.compression.filesystem"
                    [io.compression.zipfile]::CreateFromDirectory($source, $archive)
                    Get-ChildItem $env:USERPROFILE"\DSAMI_Pre-check" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\Desktop" -Force
                    Start-Sleep -s 3
                    Remove-Item $env:USERPROFILE\DSAMI_Pre-check -Force -Recurse
                    Write-Host "Done. See zip file created in Desktop."
                    
                    }

           } '3' {
                cls
                New-Item -Path "$env:USERPROFILE" -Name "DSONP_Pre-check" -ItemType "directory" -Force | Out-Null
                Write-Host "Please wait..."
                $inputadd = Read-Host "Enter IP address or FQDN (without https)"
                $versionPS = $PSVersionTable.PSVersion.Major
                if ($versionPS -gt 3){
                    Write-Host "You are using Powershell version 4 and up."
                    Write-Host "Checking the system if it has proxy enabled..."
                    $p = Get-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
                    if ($p.ProxyEnable -eq 1){
                    $server = $p.ProxyServer
                    Write-Host "This machine has a proxy enabled."
                    echo "This machine has a proxy enabled : $server" > $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    else{
                    Write-Host "This machine has no proxy enabled."
                    echo "This machine has no proxy enabled." > $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    Write-Host "Checking connection to the URLs of Deep Security On-premise..."
                    Powershell4upDSONP
                    Write-Host "Done. See connection.txt inside the zip file that will be created later for more information."
                    Write-Host "Send Heartbeat to the Manager..."
                    try{
                    & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -m >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    do{
                    $diagopt = Read-Host "Enable agent debugging?(y/n)"
                    if ($diagopt -eq 'y'){
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\sendCommand" --get Trace?trace=* >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        Write-Host "Enabled Debugging. Trace set to *."
                        Write-Host "Rechecking Connection to URLs. Please wait..."
                        Powershell4upDSONP-2
                        Write-Host "Rechecking Connection Done."
                        $diagstop = Read-Host "Replicate the issue. Type y and press enter when done"
                        if ($diagstop -eq 'y'){
                            try{
                            Write-Host "Restarting ds_agent..."
                            Restart-Service -Name ds_agent -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                            Write-Host "Service has been restarted successfully."
                            }
                            catch{
                            Write-Host "Service failed to restart."
                            }
                            Write-Host "Creating Diagnostic Package..."
                            Start-Sleep -s 2
                            try{
                            & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                            }catch{
                            echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                            echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                            Write-Host "Failed. Check if Deep Security Agent is installed properly."
                            }
                            Start-Sleep -s 5
                            do{
                            Start-Sleep -s 5
                            }
                            until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                            Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSONP_Pre-check" -Force
                         }
                    }elseif ($diagopt -eq 'n'){
                        Write-Host "Creating Diagnostic Package..."
                        Start-Sleep -s 2
                        try{
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }catch{
                        echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        Write-Host "Failed. Check if Deep Security Agent is installed properly."
                        }
                        Start-Sleep -s 5
                        do{
                        Start-Sleep -s 5
                        }
                        until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                        Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSONP_Pre-check" -Force
                    }
                    }until(($diagopt -eq 'y') -or ($diagopt -eq 'n'))
                    }catch{
                    echo "Send Heartbeat to the Manager..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Write-Host "Failed. Check if Deep Security Agent is installed properly."

                    Write-Host "Getting System Information..."
                    echo "Getting System Information..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Start-Process -WindowStyle Hidden msinfo32 -ArgumentList "/nfo $env:USERPROFILE\DSONP_Pre-check\msinfo.nfo"
                    $p = Get-Process -Name msinfo32
                    Wait-Process -id $p.Id
                    echo "Getting System Information...Done" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Write-Host "Getting System Information...Done"

                    }
                    Write-Host "Getting all running task..."
                    tasklist >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Write-Host "Getting all running task...Done"
                    
                    $source = "$env:USERPROFILE\DSONP_Pre-check"
                    $archive = "$env:USERPROFILE\Desktop\Pre-check DSONP Package.zip"

                    Add-Type -assembly "system.io.compression.filesystem"
                    [io.compression.zipfile]::CreateFromDirectory($source, $archive)
                    Get-ChildItem $env:USERPROFILE"\DSONP_Pre-check" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\Desktop" -Force
                    Start-Sleep -s 3
                    Remove-Item $env:USERPROFILE\DSONP_Pre-check -Force -Recurse
                    Write-Host "Done. See zip file created in Desktop."
                    
                    }

                    else{
                    Write-Host "You are using Powershell version 3 and lower."
                    Write-Host "Checking the system if it has proxy enabled..."
                    $p = Get-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
                    if ($p.ProxyEnable -eq 1){
                    $server = $p.ProxyServer
                    Write-Host "This machine has a proxy enabled."
                    echo "This machine has a proxy enabled : $server" > $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    }
                    else{
                    Write-Host "This machine has no proxy enabled."
                    echo "This machine has no proxy enabled." > $env:USERPROFILE\DSaaS_Pre-check\connection.txt
                    }
                    Write-Host "Checking connection to the URLs of Deep Security On-premise..."
                    Powershell4downDSONP
                    Write-Host "Done. See connection.txt inside the zip file that will be created later for more information."
                    Write-Host "Send Heartbeat to the Manager..."
                    try{
                    & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -m >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    do{
                    $diagopt = Read-Host "Enable agent debugging?(y/n)"
                    if ($diagopt -eq 'y'){
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\sendCommand" --get Trace?trace=* >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        Write-Host "Enabled Debugging. Trace set to *."
                        Write-Host "Rechecking Connection to URLs. Please wait..."
                        Powershell4downDSONP-2
                        Write-Host "Rechecking Connection Done."
                        $diagstop = Read-Host "Replicate the issue. Type y and press enter when done"
                        if ($diagstop -eq 'y'){
                            try{
                            Write-Host "Restarting ds_agent..."
                            Restart-Service -Name ds_agent -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                            Write-Host "Service has been restarted successfully."
                            }
                            catch{
                            Write-Host "Service failed to restart."
                            }
                            Write-Host "Creating Diagnostic Package..."
                            Start-Sleep -s 2
                            try{
                            & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                            }catch{
                            echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                            echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                            Write-Host "Failed. Check if Deep Security Agent is installed properly."
                            }
                            Start-Sleep -s 5
                            do{
                            Start-Sleep -s 5
                            }
                            until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                            Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSONP_Pre-check" -Force
                         }
                    }elseif ($diagopt -eq 'n'){
                        Write-Host "Creating Diagnostic Package..."
                        Start-Sleep -s 2
                        try{
                        & $Env:ProgramFiles"\Trend Micro\Deep Security Agent\dsa_control" -d >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        }catch{
                        echo "Creating Diagnostic Package..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                        Write-Host "Failed. Check if Deep Security Agent is installed properly."
                        }
                        Start-Sleep -s 5
                        do{
                        Start-Sleep -s 5
                        }
                        until(!(Test-Path $env:ProgramData"\Trend Micro\Deep Security Agent\diag\*.tmp"))
                        Get-ChildItem $env:ProgramData"\Trend Micro\Deep Security Agent\diag" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\DSONP_Pre-check" -Force
                    }
                    }until(($diagopt -eq 'y') -or ($diagopt -eq 'n'))
                    }catch{
                    echo "Send Heartbeat to the Manager..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    echo "Failed. Check if Deep Security Agent is installed properly." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Write-Host "Failed. Check if Deep Security Agent is installed properly."

                    Write-Host "Getting System Information..."
                    echo "Getting System Information..." >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Start-Process -WindowStyle Hidden msinfo32 -ArgumentList "/nfo $env:USERPROFILE\DSONP_Pre-check\msinfo.nfo"
                    $p = Get-Process -Name msinfo32
                    Wait-Process -id $p.Id
                    echo "Getting System Information...Done" >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Write-Host "Getting System Information...Done"

                    }
                    Write-Host "Getting all running task..."
                    tasklist >> $env:USERPROFILE\DSONP_Pre-check\connection.txt
                    Write-Host "Getting all running task...Done"

                    $source = "$env:USERPROFILE\DSONP_Pre-check"
                    $archive = "$env:USERPROFILE\Desktop\Pre-check DSONP Package.zip"

                    Add-Type -assembly "system.io.compression.filesystem"
                    [io.compression.zipfile]::CreateFromDirectory($source, $archive)
                    Get-ChildItem $env:USERPROFILE"\DSONP_Pre-check" -File -ErrorAction SilentlyContinue | Where-Object { $_.Extension -eq ".zip" -and $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and $_.LastWriteTime -gt (Get-Date).AddMinutes(-1)} | Copy-Item -Destination $env:USERPROFILE"\Desktop" -Force
                    Start-Sleep -s 3
                    Remove-Item $env:USERPROFILE\DSONP_Pre-check -Force -Recurse
                    Write-Host "Done. See zip file created in Desktop."
                    }

           } '4' {
                    Write-Host "Please wait..."
                    $versionPS = $PSVersionTable.PSVersion.Major
                    $inputadd = Read-Host "Enter IP/URL and Port (e.g. 192.168.1.1 443 or trendmicro.com 443)"
                    $ipadd, $portadd = $inputadd.split(' ')
                    if ($versionPS -gt 3){
                        Write-Host "You are using Powershell version 4 and up."
                        $Global:ProgressPreference = 'SilentlyContinue'
                        $Test1 = Test-NetConnection $ipadd -Port $portadd -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                            if($Test1 -eq 'True'){
                                Write-Host "Successfully connected to port $portadd on $ipadd"
                            }
                            else{
                                Write-Host "Failed to connect to port $portadd on $ipadd"
                            }
                    try{
                    Test-ServerSSLSupportRaw $ipadd $portadd | Out-Null
                    Write-Host "Successfully connected to $ipadd via SSL/TLS on port $portadd"
                    }
                    catch{
                        Write-Host "Failed to connect via SSL/TLS to $ipadd on port $portadd"
                    }
                    }else{
                    Write-Host "You are using Powershell version 3 and lower."
                    Test-PortRaw($inputadd)
                    try{
                    Test-ServerSSLSupportRaw $ipadd $portadd | Out-Null
                    Write-Host "Successfully connected to $ipadd via SSL/TLS on port $portadd"
                    }
                    catch{
                        Write-Host "Failed to connect via SSL/TLS to $ipadd on port $portadd"
                    }
                }
                    
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')
</powershell>