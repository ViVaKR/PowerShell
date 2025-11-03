param (

    [Parameter(Mandatory=$false)]
    [AllowNull()]
    [string]$Path,

    [Parameter(Mandatory=$false)]
    [AllowNull()]
    [string]$Definition,
)

$copyArgs = @ {
    Path = $Path
    Destination = $Definition
}
