# Functions.ps1
function Set-Cursor { Write-Host "`[5 q" }

function Set-GitWorkspace {
	$path =  "~/GitWorkspace"
	if (Test-Path $path -PathType Container) {
		Set-Location -Path $path
	}
}

function Set-Temp {
	$path =  "~/Temp"
	if (Test-Path $path -PathType Container) {
		Set-Location -Path $path
	}
}

function Set-WebProjects {
	$path =  "~/WebProjects"
	if (Test-Path $path -PathType Container) {
		Set-Location -Path $path
	}
}

function Set-Projects {
	$path =  "~/Projects"
	if (Test-Path $path -PathType Container) {
		Set-Location -Path $path
	}
}

# eza
function lss {
    eza -ablghmuUF --git --git-repos --group-directories-first --color=always --icons --time-style long-iso
}

# ls: 기본 eza (아이콘, 디렉토리 우선) - 가장 자주 사용
function ls {
    eza --icons --group-directories-first @args
}

# ld: 디렉토리만 표시 (파일 제외)
function lld {
    eza -lD --icons --group-directories-first --time-style long-iso @args
}

# ll: 긴 형식 (사용자/그룹/권한 포함, Git, 아이콘, 디렉토리 우선) - 상세 정보
function ll {
    eza -l --icons --no-user --group-directories-first --time-style long-iso @args
}

# la: 모든 파일 (숨김 파일 포함), 긴 형식 (Git 포함)
function la {
    eza -algh --git --show-symlinks --icons `
    	--group-directories-first --time-style long-iso @args
}

# l: 숨김 파일 포함, 간략 형식 (Git 포함)
function l {
    eza -alF --icons --group-directories-first --time-style long-iso
}
# lt: 트리 뷰 - 기본 깊이 2 (추가 인자로 깊이 지정 가능)
# 예: lt, lt -L=3 (깊이 3), lt .git (특정 디렉토리 트리)
function lt {
    # -L이 명시되지 않았다면 기본 깊이 2 사용
    if ($args -notcontains "-L" -and $args -notcontains "--level") {
        eza -T -L=2 --icons --group-directories-first --time-style long-iso @args
    }
    else {
        eza -T --icons --group-directories-first --time-style long-iso @args
    }
}

# lf: 파일만 표시 (디렉토리 제외) - ls -F | grep '/' 와 유사
function llf {
    eza -l --only-files --icons @args # --only-files 옵션이 eza에 있다면 사용 (현재 eza는 --only-dirs만 있음)
}

# lsf: 파일만 표시 (숨김 파일 포함)
function lsf {
    eza -alfF --color=always --icons --time-style long-iso @args
}

# lsd: 디렉토리만 표시 (숨김 디렉토리 포함), 접근 시간 기준 정렬
function lsd {
    eza -alhuUDF --total-size --sort=accessed --color=always --icons --time-style long-iso @args
}

# l2: 트리 형식 (깊이 2)
function l2 {
    eza -l -T -L=2 --icons --no-user --group-directories-first --time-style long-iso
}

# l3: 트리 형식 (깊이 3)
function l3 {
    eza -l -T -L=3 --icons --no-user --group-directories-first --time-style long-iso
}

