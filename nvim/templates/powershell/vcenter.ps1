try {
  Connect-Viserver txvctp01.ttiinc.com
}
catch {
  Write-Host "Unable to connect to TX vCenter"
  exit
}
try {
  Connect-Viserver covctp01.ttiinc.com
}
catch {
  Write-Host "Unable to connect to CO vCenter"
  exit
}

{{_cursor_}}

Disconnect-VIServer txvctp01.ttiinc.com
Disconnect-VIServer covctp01.ttiinc.com
