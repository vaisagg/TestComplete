
--step 2, import

delete TAB_Export_Sequence where Subject_Area ='Reagent'
insert into TAB_Export_Sequence (Subject_Area,Table_name,Tree_level, Disable_temp_FK)
SELECT DISTINCT 'Reagent', CHILD_TABLE, max(Tree_level)	LEVEL, 1 as Disable_temp_FK
FROM [VIW_TABLES_TREE] 
WHERE CHILD_TABLE in (
	'Reagent', 
	'Reagent_Lot', 
	'Reagent_Pack',
	'Reagent_Pack_Well'
)	
GROUP BY CHILD_TABLE

update TAB_Export_Sequence 
	set MapColumns = [dbo].[FNC_fk_ref_cols]('LOC_Messages',Table_name)
FROM TAB_Export_Sequence es INNER JOIN sys.foreign_keys k on OBJECT_NAME(k.parent_object_id) = es.Table_name
where es.Subject_Area = 'Reagent' AND OBJECT_NAME(k.referenced_object_id) = 'LOC_Messages'

exec PRC_DBM_Import @full_path_filename = 'F:\SystemTest\TA_Scripts\TestcaseLayer\ARM\TestData\AppConfigFiles\ReagentLoadQuery\ExportedReagentData.txt', @Subject_Area ='Reagent'

update Reagent_Pack
set FirstLoadedDatetime = GETDATE();