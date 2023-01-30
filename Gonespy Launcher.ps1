Clear-Host

$title = "Gonespy Single Launcher"
$host.UI.RawUI.WindowTitle = $title

Write-Host $title
Write-Host "`n"
Write-Host "======================================================="
Write-Host "Runs MaraDNS, Deadwood, And Gonespy From A Single File."
Write-Host "======================================================="
Write-Host "`n"

# Version 1.00

# Main menu, allowing user selection
function Show-Menu {
    Write-Host "================================= $title ================================="
    Write-Host "1: Press '1' To Update IP Address Of Gonespy Server (Opens Default Text Editor)."
    Write-Host "2: Press '2' To Update Deadwood IP Address For Gonespy Server (Opens Default Text Editor)."
    Write-Host "3: Press '3' To Start MaraDNS."
    Write-Host "4: Press '4' To Install/Start Deadwood Service."
    Write-Host "5: Press '5' To Start Gonespy."
    Write-Host "6: Press '6' To Stop/Uninstall Deadwood Service."
    Write-Host "A: Press 'A' To Start All."
    Write-Host "Q: Press 'Q' To Quit."
    Write-Host "`n"
}

function updateMaraDNSIP {
    Write-Host "Opening In Default Text Editor."
    Write-Host "`n"
    explorer "maradns-2-0-15-win32\gamespydns.txt"
}

function updateDeadwoodIP {
    Write-Host "Opening In Default Text Editor."
    Write-Host "`n"
    explorer "Deadwood-3-2-11-win32\dwood3rc.txt"
}

function startMaraDNS {
    Write-Host "Launching MaraDNS."
    Write-Host "`n"
    Start-Process ./"maradns-2-0-15-win32/mkSecretTxt.exe" -WorkingDirectory ./"maradns-2-0-15-win32"
    Start-Process -FilePath ./"maradns-2-0-15-win32\maradns.exe" -ArgumentList "-f mararc.txt" -WorkingDirectory ./"maradns-2-0-15-win32"
}

function startDeadwood {
    Write-Host "Launching Deadwood."
    Write-Host "`n"
    Start-Process "cmd.exe" -ArgumentList ("/k cd {0}\Deadwood-3-2-11-win32 && install.bat" -f (Get-Location).path) -Verb RunAs
}

function startGonespy {
    Write-Host "Launching Gonespy."
    Write-Host "`n"
    Start-Process -FilePath "cmd.exe" -ArgumentList "/k java -jar bstormps3-0.2.jar" -WorkingDirectory ./"bstormps3-0.2" -PassThru
}

function uninstallDeadwood {
    Write-Host "Uninstalling Deadwood."
    Write-Host "`n"
    Start-Process "cmd.exe" -ArgumentList ("/k cd {0}\Deadwood-3-2-11-win32 && uninstall.bat" -f (Get-Location).path) -Verb RunAs
}

function startAll {
    startMaraDNS
    startDeadwood
    startGonespy
}

#Main menu loop
do {
    Show-Menu
    $userInput = Read-Host "Please make a selection"
    Write-Host "`n"
    switch ($userInput) {
         '1' {
            updateMaraDNSIP
        } '2' {
            updateDeadwoodIP
        } '3' {
            startMaraDNS
        } '4' {
            startDeadwood
        } '5' {
            startGonespy
        } '6' {
            uninstallDeadwood
        } 'a' {
            startAll
        } 'q' {
            stop-process -Id $PID
        }
    }
    pause
    Write-Host "`n"
}
until ($userInput -eq 'q')