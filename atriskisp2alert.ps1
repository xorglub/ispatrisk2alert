<#  Short PowerShell Script to get ATRISK nodes                                    
    Note:  Operates on a single server environment #>


add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    
    public class IDontCarePolicy : ICertificatePolicy {
        public IDontCarePolicy() {}
        public bool CheckValidationResult(
            ServicePoint sPoint, X509Certificate cert,
            WebRequest wRequest, int certProb) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = new-object IDontCarePolicy 

$admin = "view"
$secPw = ConvertTo-SecureString "iiWiphahjiezu6f" -AsPlainText -Force
$cred = New-Object PSCredential -ArgumentList $admin,$secPw
$headers = @{}
$headers.Add( "OC-API-Version", "1.0" )
$headers.Add( "Accept" , "application/json" )

<# Call the Rest API to get the list of current clients
   Note that if you have an unsigned certificate, you must add code to ignore it #>

$nodelist = Invoke-RestMethod -uri "https://10.220.1.5:11090/oc/api/clients" -Credential $cred -Headers $headers -Method GET

$nodelist.clients

<#
$riskcheck = $nodelist.clients

<# Check it the node is atrisk #>
<# $restcommand = "https://10.220.1.5:11090/oc/api/servers/"+ ($riskcheck.SERVER) +"/clients/"+ $riskcheck.Name +"/atrisk"
$risk
$restcommand
$atrisk = Invoke-RestMethod -uri $restcommand -Credential $cred -Headers $headers -Method GET
$atrisk
}

<# Build the command to lock the node and pass it to the rest API#>
# $restcommand = "https://localhost:11090/oc/api/servers/" + ($locknode.SERVER) + "/clients/" + $locknode.Name + "/lock"
# (Invoke-RestMethod -uri $restcommand -Credential $cred -Headers $headers -Method Put).Message.Messagefordev

