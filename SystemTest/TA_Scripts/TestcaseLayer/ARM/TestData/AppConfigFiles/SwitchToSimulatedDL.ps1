# load XML file into local variable and cast as XML type.
$Path = "F:\InstrumentOutput\TriProcesses.xml"
$XPath = "/Root"
[xml]$Types = Get-Content $Path

#Delete node - DL 2.0
$DeleteNames = "DLARMWindowsService"
($Types.Root.ChildNodes |Where-Object { "DLARMWindowsService" -contains $_.Name }) | ForEach-Object {
    # Remove each node from its parent
    [void]$_.ParentNode.RemoveChild($_)
}

#Delete node - DL DML 2.0
$DeleteNames = "DLDMLIoTLauncher.exe"
($Types.Root.ChildNodes |Where-Object { "DLDMLIoTLauncher.exe" -contains $_.Name }) | ForEach-Object {
    # Remove each node from its parent
    [void]$_.ParentNode.RemoveChild($_)
}

#Add DL ModuleManager
$newEl = $Types.CreateElement('WindowsService')
$newEl.SetAttribute('Name','DL Module Manager')
$newEl.SetAttribute('DEPENDSON','EventMgr')
$newEl.SetAttribute('HEARTBEAT','DL')
$newNode = $Types.ImportNode($newEl,$true)
$IndexSMM =  [array]::IndexOf($Types.Root.TrinidadProcess.Name,"SampleMoverMediator.exe")

#Insert After Index of SMM
$Types.root.InsertAfter($newNode,$Types.Root.TrinidadProcess[$IndexSMM])

#save
$Types.Save($Path)

