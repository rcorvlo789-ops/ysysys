# 간단한 로컬 HTTP 서버 (PowerShell)
$port = 8080
$folder = Split-Path -Parent $MyInvocation.MyCommand.Path

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()

Write-Host "============================================"
Write-Host "  서버가 시작되었습니다!"
Write-Host "  브라우저에서 아래 주소를 열어주세요:"
Write-Host "  http://localhost:$port/index.html"
Write-Host "  종료하려면 이 창을 닫으세요."
Write-Host "============================================"

# 브라우저 자동 열기
Start-Process "http://localhost:$port/index.html"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response

    $localPath = $request.Url.LocalPath.TrimStart('/')
    if ($localPath -eq '') { $localPath = 'index.html' }

    $filePath = Join-Path $folder $localPath

    if (Test-Path $filePath -PathType Leaf) {
        $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
        $mimeTypes = @{
            '.html' = 'text/html; charset=utf-8'
            '.js'   = 'application/javascript'
            '.css'  = 'text/css'
            '.glb'  = 'model/gltf-binary'
            '.gltf' = 'model/gltf+json'
            '.png'  = 'image/png'
            '.jpg'  = 'image/jpeg'
            '.jpeg' = 'image/jpeg'
        }
        $contentType = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { 'application/octet-stream' }
        $bytes = [System.IO.File]::ReadAllBytes($filePath)
        $response.ContentType = $contentType
        $response.ContentLength64 = $bytes.Length
        $response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
        $response.StatusCode = 404
    }

    $response.OutputStream.Close()
}
