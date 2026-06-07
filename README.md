# Active Directory Bulk User Creator

Dieses Skript automatisiert das Anlegen von neuen Benutzern im Active Directory mithilfe einer CSV-Datei. Perfekt für das Onboarding von mehreren Mitarbeitern gleichzeitig.

## 🚀 Funktionen
* Liest Mitarbeiterdaten (Vorname, Nachname, Abteilung) aus einer CSV-Datei.
* Erstellt automatisch einen standardisierten Benutzernamen (z.B. `mmustermann`).
* Überprüft vor dem Anlegen, ob der Benutzer bereits existiert (Duplikatschutz).
* Setzt ein temporäres Passwort und zwingt den User, es beim ersten Login zu ändern (`ChangePasswordAtLogon`).
* Sortiert die Benutzer automatisch in die richtige Organisationseinheit (OU) ein.

## 🛠️ Voraussetzungen
* Windows Server mit Active Directory Rolle
* ActiveDirectory PowerShell-Modul
