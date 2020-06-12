set scriptFolderPath=%~dp0

sqlcmd -S %computername% -d MM -E -i %~dp0Supplies_RoundTrip_query.sql
