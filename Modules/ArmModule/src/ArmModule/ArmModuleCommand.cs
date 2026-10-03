using System.Management.Automation;

namespace ArmModule;

[Cmdlet(VerbsDiagnostic.Test, "ArmModule")]
public class ArmModuleCommand : PSCmdlet
{
    [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
    public object? InputObject { get; set; }

    protected override void ProcessRecord() => WriteObject(InputObject);
}
