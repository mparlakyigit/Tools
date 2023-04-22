clear

Write-Host "Mehmet PATLAKYIGIT | Office Apps & Services MVP" -ForegroundColor blue
Write-Host "https://www.parlakyigit.net/" -ForegroundColor blue
Write-Host "Twitter:@mparlakyigit" -ForegroundColor blue
Write-Host "- Microsoft 365 DKIM DMARC SPF Lookup (M365DDSLookup) -" -ForegroundColor red

$domain = Read-Host -Prompt "Domain Name (contoso.com)"

# SPF kaydı için sorgulama yapma
$spf = (Resolve-DnsName -Name "$domain" -Type TXT).Strings | Where-Object {$_ -clike "v=spf1*"}
if ($spf) {
    Write-Host "SPF kaydı mevcut:"
    $spfTable = $spf | Select-Object @{Name="Tipi"; Expression={"SPF"}}, @{Name="Değer"; Expression={$_}}
    $spfTable | Format-Table -AutoSize -Wrap | Out-String -Stream | ForEach-Object { Write-Host $_ }
    Write-Host ("+" * 50)
} else {
    Write-Host "SPF kaydı bulunamadı."
}

# DKIM kaydı için sorgulama yapma
$dkim = (Resolve-DnsName -Name "selector1._domainkey.$domain" -Type TXT).Strings | Where-Object {$_ -clike "v=DKIM1*"}
if ($dkim) {
    Write-Host "DKIM kaydı mevcut:"
    $dkimTable = $dkim | Select-Object @{Name="Tipi"; Expression={"DKIM"}}, @{Name="Değer"; Expression={$_}}
    $dkimTable | Format-Table -AutoSize -Wrap | Out-String -Stream | ForEach-Object { Write-Host $_ }
    Write-Host ("+" * 50)
} else {
    Write-Host "DKIM kaydı bulunamadı."
}

# DMARC kaydı için sorgulama yapma
$dmarc = (Resolve-DnsName -Name "_dmarc.$domain" -Type TXT).Strings | Where-Object {$_ -clike "v=DMARC1*"}
if ($dmarc) {
    Write-Host "DMARC kaydı mevcut:"
    $dmarcTable = $dmarc | Select-Object @{Name="Tipi"; Expression={"DMARC"}}, @{Name="Değer"; Expression={$_}}
    $dmarcTable | Format-Table -AutoSize -Wrap | Out-String -Stream | ForEach-Object { Write-Host $_ }
    Write-Host ("+" * 50)
} else {
    Write-Host "DMARC kaydı bulunamadı."
}
