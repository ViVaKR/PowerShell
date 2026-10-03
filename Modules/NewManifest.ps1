$manifest = @{
  Path              = "./$module/$module.psd1"
  Author            = 'Kim Bum Jun'
  NestedModules     = @('./$module/Output/$module.dll')
  RootModule        = "$module.psm1"
  FunctionsToExport = @('Resolve-MyCmdlet')
}
New-ModuleManifest @manifest
