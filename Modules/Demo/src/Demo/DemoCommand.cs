using System.Management.Automation;

namespace Demo;

[Cmdlet(VerbsDiagnostic.Test, "Demo")]
public class DemoCommand : PSCmdlet
{
    [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
    public object? InputObject { get; set; }

    protected override void ProcessRecord() => WriteObject(InputObject);
}
