Get-ChildItem *.ps1 -File |
Format-List Fullname,
@{
	name = "Modified"
	expression={$_.LastWriteTime}
	formatstring='0'
},
@{
	name='Size'
	expression={$_.Length/1KB}
	formatstring='N2'
}
