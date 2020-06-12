@echo off
net accounts /MaxPWAge:unlimited
WMIC USERACCOUNT WHERE Name='LabManager' SET PasswordExpires=FALSE
