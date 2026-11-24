$html = [System.IO.File]::ReadAllText('C:\Users\ds1_20\Downloads\dp_12주차 실습\index.html')
if ($html -match 'data:model/gltf-binary;base64,') {
    Write-Host "OK: base64 embedded"
} else {
    Write-Host "FAIL: base64 not found"
}
$sizeMB = [math]::Round($html.Length / 1MB, 1)
Write-Host "File size: $sizeMB MB"
if ($html -match 'scale="([^"]+)"') {
    Write-Host "Scale value: $($Matches[1])"
}
