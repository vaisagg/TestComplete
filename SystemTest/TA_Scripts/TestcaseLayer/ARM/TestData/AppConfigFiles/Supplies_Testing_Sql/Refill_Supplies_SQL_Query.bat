set scriptFolderPath=%~dp0

sqlcmd -S %computername% -d MM -E -i %~dp0Refill_Supplies_SQL_Query.sql
