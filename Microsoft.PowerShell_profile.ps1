# Omogoci izvajanje skript
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force

# Alias za Sublime Text
Set-Alias -Name sublime -Value "C:\Program Files\Sublime Text\sublime_text.exe"

# Naloži PSReadLine
Import-Module PSReadLine

# Nastavitve PSReadLine
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -PredictionSource History      # inline predlogi (autosuggest)
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# Syntax highlighting barve (Kali zsh-style)
Set-PSReadLineOption -Colors @{
    "Command"            = "Green"
    "Parameter"          = "Cyan"
    "String"             = "Yellow"
    "Operator"           = "White"
    "Variable"           = "Magenta"
    "Comment"            = "DarkGray"
    "Number"             = "Blue"
    "InlinePrediction"   = "DarkGray"
    "ContinuationPrompt" = "DarkYellow"
    "Emphasis"           = "White"
}

# Tipkovne bližnjice
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord "Ctrl+Enter" -Function PossibleCompletions

# Prompt
Clear-Host
$ESC = [char]27
function prompt {
    $skull  = [char]0x2620
    $mm = [char]0x24C2
    $minus  = [char]0x2500
    $top    = [char]0x250C + "$minus$minus"
    $bottom = [char]0x2514 + "$minus"

    # preveri ali je uporabnik admin
    $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    # dinamicna barva uporabnika
    if ($isAdmin) {
        $userColor = "31m"   # rdeca = admin
	$logo = $skull
    } else {
        $userColor = "0m"   # zelena = obicajen user
	$logo = $mm
    }

    # sestavi prompt
    "$($ESC)[32m`r`n$($top) PS($($ESC)[$userColor$env:UserName@$env:COMPUTERNAME$($ESC)[32m)$logo [$($ESC)[$userColor$(Get-Location)$($ESC)[32m]`r`n$($bottom) $($ESC)[94m$ $($ESC)[0m"
}
