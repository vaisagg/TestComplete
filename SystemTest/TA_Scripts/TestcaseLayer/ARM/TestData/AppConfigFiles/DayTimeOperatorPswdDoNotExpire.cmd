@echo off
WMIC USERACCOUNT WHERE Name='DayTimeOperator' SET PasswordExpires=FALSE