using System.Management.Automation;
using System.Collections.ObjectModel;

namespace PsProj;

public class Pwsh
{


	public static void Get_PSDrive(string command)
	{
		var ps = PowerShell.Create();
		ps.AddCommand(command);
		Print(ps.Invoke());
	}


	public static void Foreach_Object(string command)
	{
		var ps = PowerShell.Create();
		ps.Runspace.SessionStateProxy.SetVariable("a", new int[] { 1, 2, 3 });
		ps.AddScript("$a");
		ps.AddCommand(command);
		ps.AddParameter("process", ScriptBlock.Create("$_ * 2"));
		Print(ps.Invoke());
	}

	public static void Test_Net()
	{
		try
		{
			PowerShell ps = PowerShell.Create().AddCommand("Get-Process");
			IAsyncResult asyncpl = ps.BeginInvoke();
			foreach (PSObject result in ps.EndInvoke(asyncpl))
			{
				Console.WriteLine("{0,-20}{1}",
						result.Members["ProcessName"].Value,
						result.Members["Id"].Value);
			}
			Console.WriteLine("Hit any key to exit.");
			Console.ReadKey();
		}
		catch (Exception ex)
		{
			Console.WriteLine(ex.Message);
		}
	}



	/// <summary>
	/// Print
	/// </summary>
	/// <param name="pso"></param>
	public static void Print(Collection<PSObject> pso)
	{
		Console.WriteLine();
		foreach (var item in pso)
		{
			Console.WriteLine($"{item}");
		}
	}
}
