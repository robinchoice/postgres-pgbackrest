# postgres-pgbackrest

## Zweck & Links

PostgreSQL 16 mit pgBackRest für WAL-Archivierung. Keine Zugangsdaten oder produktiven Daten im Repository. Die Stanza heißt `app`; Repository und Zugangsdaten kommen über `PGBACKREST_*`-Laufzeitvariablen.

## Checks

`docker build -t wal-pilot-local:16-alpine . && bash test-local`

Der Test prüft einen zeitpunktgenauen Restore mit künstlichen Daten in Containern ohne Netzwerk und entfernt seine Container und Volumes danach.

## Deploy

GitHub Actions baut und prüft nativ für amd64 und arm64. Erst nach beiden PITR-Tests veröffentlicht die CI das gemeinsame Manifest nach GHCR. Produktive Datenbanken verwenden den geprüften Image-Digest. Ihre Konfiguration und Neustarts laufen über Coolify.

## Fallen

- Keine PostgreSQL-Hauptversion ändern. Die offizielle Entrypoint und deren Datenpfad bleiben erhalten.
- Die Konfiguration muss für den Nutzer `postgres` lesbar sein.
- Sieben Vollbackups bleiben erhalten; abgelaufene Backups und zugehörige WAL-Segmente entfernt pgBackRest nach erfolgreichen Backups. Der tägliche Backup-Aufruf und dessen Überwachung gehören zum Betrieb, nicht zum Image.
- Der synthetische Test ersetzt keinen Restore-Test des produktiven S3-Archivs.
