# base html
$html = @"
<style>
:root {
    --card-width: 63mm;
    --card-height: 88mm;
    --margin: 3.175mm;
    --imargin: calc(var(--margin) * -1);
    --corrected-card-width: calc(var(--card-width) + (var(--margin) * 2));
    --corrected-card-height: calc(var(--card-height) + (var(--margin) * 2));
  }
  
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  
  body {
    display: grid;
    grid-template-columns: var(--card-width) var(--card-width) var(--card-width);
    grid-auto-rows: var(--card-height);
    /* uncomment for cutting lines */
    /* gap: 1px; */
  }
  
  .card {
    width: var(--card-width);
    height: var(--card-height);
    overflow: hidden;
  }
  
  img {
    width: var(--corrected-card-width);
    height: var(--corrected-card-height);
    position: relative;
    top: var(--imargin);
    left: var(--imargin);
  }  
</style>

"@

# Filename
$file = '.\index.html'

# Make index.html if it doesn't exist
if (-Not (Test-Path -Path $file)) {
    New-Item -Path $file -ItemType File
}

# Generate image html
Get-ChildItem -Path ".\images\*" -File -Include ('*.png', '*.jpg') | ForEach-Object {
    $html = $html + @"
<div class="card">
<img src="./images/$($_.Name)"/>
</div>
"@
}

# Write file contents
Get-ChildItem -File -Path $file | Set-Content -Value $html 
