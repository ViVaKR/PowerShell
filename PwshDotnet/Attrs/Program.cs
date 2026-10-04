
try
{
    int j = 0;
    Console.WriteLine(1 / j);
}
catch (Exception ex)
{
    Console.WriteLine($"Help Link:\t{ex.HelpLink}");
    Console.WriteLine($"HResult:\t{ex.HResult}");
    Console.WriteLine($"Message:\t{ex.Message}");
    Console.WriteLine($"Source:\t\t{ex.Source}");
    Console.WriteLine($"Stack Trace:\t{ex.StackTrace}");
    Console.WriteLine($"Target Site:\t{ex.TargetSite}");
}

int i = 10;
string s = "Hello, World";
var anony1 = new { int_val = i, string_val = s };
var anony2 = new { i, s };
var anony3 = new { anony1, anony2 };
Console.WriteLine(anony3.anony1.int_val);
Console.WriteLine(anony3.anony2.s);
