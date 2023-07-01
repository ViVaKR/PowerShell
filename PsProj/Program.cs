//! 사전설치 패키지 
//! dotnet add package Microsoft.PowerShell.SDK

using PsProj;

Dictionary<int, string> Commands = new()
{
	{ 1, "Get-PSDrive"},
	{ 2, "Foreach-Object"},
	{ 3, "Test Network"},
};

foreach (var item in Commands)
{
	Console.WriteLine($"{item.Key} - {item.Value}");
}
Console.WriteLine();

Console.Write("실행할 명령 (번호선택) >> ");

var command = Convert.ToInt32(Console.ReadLine());

switch (command)
{
	case 1: Pwsh.Get_PSDrive(Commands[command]); break;
	case 2: Pwsh.Foreach_Object(Commands[command]);break;
	case 3: Pwsh.Test_Net(); break;
	default: break;
}


