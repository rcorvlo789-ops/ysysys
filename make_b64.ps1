$glbPath = "C:\Users\ds1_20\Downloads\dp_12주차 실습\model.glb"
$outPath = "C:\Users\ds1_20\Downloads\dp_12주차 실습\model_b64.txt"
$bytes = [System.IO.File]::ReadAllBytes($glbPath)
$b64 = [Convert]::ToBase64String($bytes)
[System.IO.File]::WriteAllText($outPath, $b64)
Write-Host "Done! Length: $($b64.Length)"
