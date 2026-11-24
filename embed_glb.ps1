# index.html 의 현재 내용을 읽고, GLB를 base64로 내장한 새 HTML 생성
$htmlPath = "C:\Users\ds1_20\Downloads\dp_12주차 실습\index.html"
$b64Path  = "C:\Users\ds1_20\Downloads\dp_12주차 실습\model_b64.txt"

$html = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)
$b64  = [System.IO.File]::ReadAllText($b64Path, [System.Text.Encoding]::ASCII)

$dataUrl = "data:model/gltf-binary;base64," + $b64

# a-asset-item src 교체
$newHtml = $html -replace 'src="model\.glb"', "src=`"$dataUrl`""

[System.IO.File]::WriteAllText($htmlPath, $newHtml, [System.Text.Encoding]::UTF8)
Write-Host "Done! HTML size: $([math]::Round($newHtml.Length / 1MB, 1)) MB"
