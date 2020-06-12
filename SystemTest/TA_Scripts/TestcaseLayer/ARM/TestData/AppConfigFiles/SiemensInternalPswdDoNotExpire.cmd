@echo off
net accounts /MaxPWAge:unlimited
WMIC USERACCOUNT WHERE Name='SiemensInternal' SET PasswordExpires=FALSE