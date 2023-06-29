using System.Management.Automation;
using System.Collections.ObjectModel;

namespace PsProj;
public class Pwsh
{
	public static void Run()
	{
		PowerShell ps = PowerShell.Create();
		ps.AddCommand("Get-PSDrive");
		Collection<PSObject> rs = ps.Invoke();

		foreach (var item in rs)
		{
			Console.WriteLine($"{item}");
		}
		
		// ps.Runspace.SessionStateProxy.SetVariable("a", new int[] { 1, 2, 3 });
		// ps.AddScript("$a");
		// ps.AddCommand("foreach-object");
		// ps.AddParameter("process", ScriptBlock.Create("$_ * 2"));
		// Collection<PSObject> results = ps.Invoke();
		// foreach (PSObject result in results)
		// {
		// 	Console.WriteLine(result);
		// }
	}
}
