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
