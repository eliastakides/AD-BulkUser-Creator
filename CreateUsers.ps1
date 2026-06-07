# CreateUsers.ps1
# Automatisierung für Active Directory - Neue Mitarbeiter importieren
# Erstellt von Ilias Takidis

Import-Module ActiveDirectory

# Pfad zur CSV-Datei definieren
$csvPath = "C:\IT-Daten\neue_mitarbeiter.csv"

# Prüfen ob die Datei überhaupt da ist
if (-not (Test-Path $csvPath)) {
    Write-Host "❌ Fehler: CSV-Datei unter $csvPath nicht gefunden!" -ForegroundColor Red
    exit
}

Write-Host "--- Starte AD-User Import ---" -ForegroundColor Yellow
$users = Import-Csv -Path $csvPath -Delimiter ","

foreach ($user in $users) {
    # Variablen aus CSV auslesen
    $firstname = $user.Vorname
    $lastname = $user.Nachname
    $ou = $user.Abteilung # Verwenden wir als OU Name
    
    # SamAccountName bauen (z.B. itakidis)
    $username = ($firstname.Substring(0,1) + $lastname).ToLower()
    $displayName = "$firstname $lastname"
    
    # Ziel-OU im AD festlegen (Pfad muss im echten System angepasst werden)
    $targetOU = "OU=$ou,DC=firma,DC=local"
    
    # Prüfen ob der User schon existiert
    $checkUser = Get-ADUser -Filter "SamAccountName -eq '$username'"
    
    if ($checkUser) {
        Write-Host "⚠️ User $username existiert bereits im AD. Überspringe..." -ForegroundColor Orange
    } else {
        # Passwort generieren (Standardpasswort für den ersten Login)
        $password = ConvertTo-SecureString "Start1234!" -AsPlainText -Force
        
        # Neuen User anlegen
        New-ADUser -Name $displayName `
                   -SamAccountName $username `
                   -GivenName $firstname `
                   -Surname $lastname `
                   -DisplayName $displayName `
                   -Path $targetOU `
                   -AccountPassword $password `
                   -ChangePasswordAtLogon $true `
                   -Enabled $true
                   
        Write-Host "✅ User $displayName ($username) erfolgreich in OU '$ou' angelegt." -ForegroundColor Green
    }
}

Write-Host "--- Import abgeschlossen ---" -ForegroundColor Yellow
