using System;
using System.Management.Automation;
namespace PwshModule;

[Cmdlet(VerbsDiagnostic.Resolve, "VivCmdlet")]
public class ResolveVivCmdletCommand : PSCmdlet
{
    [Parameter(Position=0)]
    public Object? InputObject { get;set;}
    
    protected override void EndProcessing() 
    {
        this.WriteObject(this.InputObject);
        base.EndProcessing();
    }
}
