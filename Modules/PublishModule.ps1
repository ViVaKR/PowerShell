function Publish-MyModule {
  [CmdletBinding(SupportsShouldProcess)]
  param([Parameter(Mandatory)][string]$Path, [string]$Repository = 'PSGallery')

  if ($PSCmdlet.ShouldProcess($Path, "Publish to $Repository")) {
    Publish-PSResource -Path $Path -Repository $Repository `
      -ApiKey (Get-Secret -Name "ViVaKRKey" -AsPlainText)
  }
}
