#!/bin/bash

# Automatisierte Sicherung der Keepass-Datenbanken...
# Skript, das in /sbin/ gespeichert sein muss (ohne Datei-Endung .sh).
# Aktiviert durch einen Cron job im root crontab.
#   0 12 * * * /sbin/k33pa55 &> /dev/null
#   Jeden Tag um 12 Uhr mittags

KeepassDir=/mnt/Daten/Nextcloud/Documents/K33PA55/
BackupDir=/mnt/Daten/Nextcloud/Documents/K33PA55/k33pa55_backups/
KeepassFile=k33pa55
Endung=kdbx

# Wenn noch keine Datei vorhanden ist, die jünger als 15 Tage ist , dann erstelle eine Kopie.
exists=$(find "$BackupDir" -type f -name "*${KeepassFile}*" -mtime -15)
if [ -z "$exists" ];then
    # Die aktuelle Datenbank-Datei wird im BackupDir gesichert.
    cp $KeepassDir$KeepassFile.$Endung $BackupDir$(date +%Y-%m-%d_)$KeepassFile.$Endung
fi

# Dateien, die älter als 6 Monate (=185 Tage) sind, werden gelöscht
find "$BackupDir" -type f -name "*${KeepassFile}*" -mtime +185 -delete
