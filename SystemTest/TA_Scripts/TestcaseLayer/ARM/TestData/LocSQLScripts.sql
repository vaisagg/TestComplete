Use Bus_DM
Go
IF OBJECT_ID ('dbo.TA_PRC_LOC_GetMessageString') IS NOT NULL
	DROP PROCEDURE dbo.TA_PRC_LOC_GetMessageString
Go
Create PROCEDURE dbo.TA_PRC_LOC_GetMessageString @MessageCode varchar(150), @LanguageID varchar(50)
As
Begin
	select t2.message_text, t1.Message_Code , t3.Language_ID from UIW_TAB_LOC_Message_Translation t2 left join 
	dbo.UIW_TAB_LOC_Messages t1 on t1.Message_ID = t2.Message_ID
	left join UIW_TAB_LOC_Languages t3 on t2.Language_ID = t3.Language_ID
	where t1.Message_Code = @MessageCode and  t3.Language_ID= @LanguageID
END

Go
Use Event_Log

Go
IF OBJECT_ID ('dbo.TA_PRC_EL_LOC_GetMessageString') IS NOT NULL
	DROP PROCEDURE dbo.TA_PRC_EL_LOC_GetMessageString
Go
Create PROCEDURE dbo.TA_PRC_EL_LOC_GetMessageString @MessageCode varchar(150), @LanguageID varchar(50)
As
Begin
	select t2.message_text, t1.Message_Code , t3.Language_ID from UIW_EL_LOC_Message_Translation t2 left join 
	dbo.UIW_EL_LOC_Messages t1 on t1.Message_ID = t2.Message_ID
	left join UIW_EL_LOC_Languages t3 on t2.Language_ID = t3.Language_ID
	where t1.Message_Code = @MessageCode and  t3.Language_ID= @LanguageID
END

