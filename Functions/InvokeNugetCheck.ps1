function Invoke-NugetCheck {
  param([Parameter(Mandatory, Position = 0)][string]$Id)

  $url = "https://api.nuget.org/v3-flatcontainer/$($Id.ToLower())/index.json"
  $res = Invoke-WebRequest -Uri $url -SkipHttpErrorCheck

  switch ($res.StatusCode) {
    200 {
      $body = if ($res.Content -is [byte[]]) { [Text.Encoding]::UTF8.GetString($res.Content) } else { $res.Content }
      $versions = ($body | ConvertFrom-Json).versions -join ', '
      "$Id → 200 (있음: $versions)"
    }
    404 { "$Id → 404 (비어 있음)" }
    default { "$Id → $($res.StatusCode)" }
  }
}

Set-Alias -Name nugetcheck -Value Invoke-NugetCheck
