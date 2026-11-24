# GLB를 base64로 변환해서 index.html에 직접 삽입
$glbPath  = "C:\Users\ds1_20\Downloads\dp_12주차 실습\model.glb"
$htmlTpl  = "C:\Users\ds1_20\Downloads\dp_12주차 실습\index.html"
$outPath  = "C:\Users\ds1_20\Downloads\dp_12주차 실습\index.html"

Write-Host "GLB 파일 읽는 중..."
$bytes  = [System.IO.File]::ReadAllBytes($glbPath)
$b64    = [Convert]::ToBase64String($bytes)
$dataUrl = "data:model/gltf-binary;base64," + $b64
Write-Host "변환 완료. base64 길이: $($b64.Length)"

$html = @"
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>A-Frame Space Planets</title>
    <script src="https://aframe.io/releases/1.6.0/aframe.min.js"></script>
    <script>
      AFRAME.registerComponent("starfield", {
        init: function () {
          var group = document.createElement("a-entity");
          for (var i = 0; i < 500; i += 1) {
            var star = document.createElement("a-sphere");
            var radius = 70;
            var phi = Math.random() * Math.PI * 2;
            var costheta = Math.random() * 2 - 1;
            var theta = Math.acos(costheta);
            var x = radius * Math.sin(theta) * Math.cos(phi);
            var y = radius * Math.sin(theta) * Math.sin(phi);
            var z = radius * Math.cos(theta);
            star.setAttribute("position", x + " " + y + " " + z);
            star.setAttribute("radius", 0.06 + Math.random() * 0.06);
            star.setAttribute("color", "#fffbde");
            star.setAttribute("material", "shader: flat; emissive: #ffffff; emissiveIntensity: 1;");
            group.appendChild(star);
          }
          this.el.appendChild(group);
        },
      });
    </script>
    <style>
      html, body { margin: 0; width: 100%; height: 100%; overflow: hidden; background: #020617; }
    </style>
  </head>
  <body>
    <a-scene background="color: #020617">
      <a-entity starfield></a-entity>
      <a-entity light="type: ambient; color: #ffffff; intensity: 1.5"></a-entity>
      <a-entity light="type: point; color: #ffffff; intensity: 2.0; distance: 90" position="0 6 6"></a-entity>

      <a-entity id="camera-rig" position="0 1.6 0">
        <a-camera position="0 0 0"></a-camera>

        <a-entity animation="property: rotation; to: 0 360 0; loop: true; dur: 4500; easing: linear;">
          <a-sphere position="2.8 0.2 0" radius="0.80" color="#fadcf0"
            material="metalness: 0.15; roughness: 0.65;"
            animation="property: rotation; to: 360 0 0; loop: true; dur: 2200; easing: linear;">
          </a-sphere>
        </a-entity>

        <a-entity rotation="14 0 0" animation="property: rotation; to: 0 360 0; loop: true; dur: 7000; easing: linear;">
          <a-sphere position="4.2 -0.1 0" radius="0.52" color="#84e3d8"
            material="metalness: 0.2; roughness: 0.55;"
            animation="property: rotation; to: 0 360 0; loop: true; dur: 3000; easing: linear;">
          </a-sphere>
        </a-entity>

        <a-entity rotation="-10 0 0" animation="property: rotation; to: 0 360 0; loop: true; dur: 10200; easing: linear;">
          <a-gltf-model
            src="DATAURL_PLACEHOLDER"
            position="5.6 0 0"
            scale="0.6 0.6 0.6"
            animation="property: rotation; to: 0 360 0; loop: true; dur: 3800; easing: linear;">
          </a-gltf-model>
        </a-entity>
      </a-entity>
    </a-scene>
  </body>
</html>
"@

$html = $html.Replace("DATAURL_PLACEHOLDER", $dataUrl)
[System.IO.File]::WriteAllText($outPath, $html, [System.Text.Encoding]::UTF8)
Write-Host "완료! 파일 크기: $([math]::Round((Get-Item $outPath).Length / 1MB, 1)) MB"
