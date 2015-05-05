
Local Const $ADVENTURE_BUTTON_POS[2] = [680, 148]
Local Const $BLACKSMITH_BUTTON_POS[2] = [331, 278]
Local Const $INVENTORY_BUTTON_POS[2] = [60, 435]
Local Const $PVP_BUTTON_POS[2] = [594, 365]
Local Const $RAID_BUTTON_POS[2] = [435, 125]
Local COnst $GUILD_BUTTON_POS[2] = [680, 324]
Local Const $STAMINA_POTION_BUTTON_POS[2] = [189, 116]
Local Const $STAMINA_POTION_USE_OK_BUTTON_POS[2] = [474, 366]
Local Const $MAIN_QUEST_COSE_BUTTON_POS[2] = [720, 442]

Local Const $MAIN_SCREEN_CHECK_REGION = [404, 380, 532, 468]
Local Const $RAID_POPUP_CLOSE_BUTTON_REGION = [209, 206, 572, 376]
Local Const $ARCHIEVEMENT_POPUP_CLOSE_BUTTON_REGION = [631, 378, 761, 474]




Func waitMainScreen() ;Waits for main screen to popup
   SetLog("Waiting for Main Screen", $COLOR_ORANGE)
   _log("waitMainScreen begin" )
   For $i = 0 To $RetryWaitCount
	  Local $x, $y
	  Local $bmpPath = @ScriptDir & "\images\screen_main.bmp"

	  _log("waitMainScreen capture" )
	  _CaptureRegion()

	  _log("waitMainScreen image checking" )
	  If ImageSearchArea($bmpPath, 0, $MAIN_SCREEN_CHECK_REGION, $x, $y, 30) Then
		 _log("waitMainScreen OK" )
		 SetLog("Main Screen Located", $COLOR_BLUE)
		 Return True
	  Else
		 _log("waitMainScreen Fail" )
		 closeAllPopupOnMainScreen()
 		 If _Sleep($SleepWaitMSec) Then Return False
	  EndIf

   Next

   ; Now, not used...
   If 0 Then
	  SetLog("Unable to load Raven, Restarting...", $COLOR_RED)
	  Local $RestartApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "Restart")
	  Run($RestartApp & " Android")
	  If _Sleep(10000) Then Return False

	  Do
		 If _Sleep(5000) Then Return False
	  Until ControlGetHandle($Title, "", "BlueStacksApp1") <> 0
   EndIf

   Return False

EndFunc   ;==>waitMainScreen

Func checkStamina()
   Local $x, $y
   Local $needStamina = getStaminaCount($setting_stage_major)
   Local $lack = False
   While 1
	  If _Sleep(100) Then Return

	  _CaptureRegion()

	  $lack = False

	  For $i = $needStamina - 1 To 0 Step -1
		 Local $bmpPath = @ScriptDir & "\images\stamina_lack_text_" & $i & ".bmp"
		 _log("Stamina lack checking : " & $bmpPath )

		 If _ImageSearchArea($bmpPath, 0, 68, 10, 155, 34, $x, $y, $DefaultTolerance) Then
			SetLog("Lack of stamina detected", $COLOR_RED)

			; Use stamia potion
			;Click($x, $y)
			Click(112, 24)
			_Sleep(1500)

			_CaptureRegion()

			If ClickButtonImage(@ScriptDir & "\images\stamina_use_text.bmp") Then
			   ClickButtonImage(@ScriptDir & "\images\button_ok.bmp")
			EndIf
			$lack = True
			ExitLoop
		 EndIf
	  Next

	  If $lack = False Then
		 ExitLoop
	  EndIf

   WEnd
EndFunc	;==>checkStamina


Func checkActiveAdventureStatus()

   Local $bmpPath = @ScriptDir & "\images\todo_on_icon.bmp"

   If _ImageSearchArea($bmpPath, 0, 651, 163, 665, 179, $x, $y, $DefaultTolerance) Then
	  SetLog("Active Adventure ON", $COLOR_RED)
	  Return True
   EndIf
   Return False
EndFunc	;==>checkActiveAdventureStatus


Func checkActivePvpStatus()

   Local $bmpPath = @ScriptDir & "\images\todo_on_icon.bmp"

   If _ImageSearchArea($bmpPath, 0, 561, 414, 576, 429, $x, $y, $DefaultTolerance) Then
	  SetLog("Active PvP ON", $COLOR_RED)
	  Return True
   EndIf
   Return False
EndFunc	;==>checkActiveRaidStatus


Func checkActiveRaidStatus()

   Local $bmpPath = @ScriptDir & "\images\todo_on_icon.bmp"

   If _ImageSearchArea($bmpPath, 0, 394, 152, 416, 172, $x, $y, $DefaultTolerance) Then
	  SetLog("Active Raid ON", $COLOR_RED)
	  Return True
   EndIf
   Return False
EndFunc	;==>checkActiveRaidStatus


Func checkActiveGuildStatus()

   Local $bmpPath = @ScriptDir & "\images\todo_on_icon.bmp"

   If _ImageSearchArea($bmpPath, 0, 656, 344, 674, 358, $x, $y, $DefaultTolerance) Then
	  SetLog("Active Guild ON", $COLOR_RED)
	  Return True
   EndIf
   Return False
EndFunc	;==>checkActiveRaidStatus


Func clickAdventureButton()
   ClickPos($ADVENTURE_BUTTON_POS, 100, 2)	; twice click for some mistakes of mouse event
EndFunc	;==>clickAdventureButton


Func clickInventoryButton()
   ClickPos($INVENTORY_BUTTON_POS, 100, 2)	; twice click for some mistakes of mouse event
EndFunc	;==>clickAdventureButton


Func clickBlackSmithButton()
   ClickPos($BLACKSMITH_BUTTON_POS, 100, 2)	; twice click for some mistakes of mouse event
EndFunc	;==>clickAdventureButton


Func clickPvpButton()
   ClickPos($PVP_BUTTON_POS, 100, 1)	; twice click for some mistakes of mouse event
EndFunc	;==>clickAdventureButton


Func clickRaidButton()
   ClickPos($RAID_BUTTON_POS, 100, 1)	; twice click for some mistakes of mouse event
EndFunc	;==>clickRaidButton


Func clickGuildButton()
   ClickPos($GUILD_BUTTON_POS, 100, 1)	; twice click for some mistakes of mouse event
EndFunc	;==>clickGuildButton


Func closeAllPopupOnMainScreen()

   Local $color = $COLOR_PINK
   If ClickButtonImageArea(String(@ScriptDir & "\images\button_back.bmp"), $BACK_BUTTON_REGION) Then
	  SetLog("Back button clicked.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\screen_start.bmp"), $GAME_START_REGION) Then
	  SetLog("Game Start Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\screen_attendance.bmp"), $SCREEN_NAME_REGION) Then
	  SetLog("Attendance book Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_ad_close.bmp"), $AD_POPUP_CLOSE_BUTTON_REGION) Then
	  SetLog("AD Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_notice_close.bmp"), $NOTICE_POPUP_CLOSE_BUTTON_REGION) Then
	  SetLog("Notice Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_raid_close.bmp"), $RAID_POPUP_CLOSE_BUTTON_REGION) Then
	  SetLog("Raid Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_achievement_close.bmp"), $ARCHIEVEMENT_POPUP_CLOSE_BUTTON_REGION) Then
	  SetLog("Achievement Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_popup_close.bmp"), $NORMAL_CLOSE_BUTTON_REGION) Then
	  SetLog("Popup Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_main_screen.bmp"), $BOTTOM_MAINSCREEN_BUTTON_REGION) Then
	  SetLog("Main button Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_retry.bmp"), $POPUP_BUTTON_REGION) Then
	  SetLog("Retry button Detected.", $color)
	  Return
   EndIf

   ; Ok button checking.. without [cancel] [ok]
   If ClickButtonImageArea(String(@ScriptDir & "\images\button_cancel_red.bmp"), $POPUP_BUTTON_REGION) Then
	  SetLog("Cancel Button Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_close.bmp"), $POPUP_BUTTON_REGION) Then
	  SetLog("Close Button Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_big_ok.bmp"), $RESULT_PVP_BUTTON_REGION) Then
	  SetLog("PVP Ok button Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_yellow_ok.bmp"), $BOTTOM_CENTER_OK_BUTTON_REGION) Then
	  SetLog("Yellow Ok button Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_ok.bmp"), $BOTTOM_OK_BUTTON_REGION) Then
	  SetLog("Bottom ok button Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_ok.bmp"), $BOTTOM_CENTER_OK_BUTTON_REGION) Then
	  SetLog("Center ok button Detected.", $color)
	  Return
   EndIf

   If ClickButtonImageArea(String(@ScriptDir & "\images\button_package_close.bmp"), $NOTICE_POPUP_CLOSE_BUTTON_REGION) Then
	  SetLog("Package Product Detected.", $color)

	  _Sleep(2000)
	  If ClickButtonImageArea(String(@ScriptDir & "\images\button_ok.bmp"), $POPUP_BUTTON_REGION) Then
		 SetLog("package product canceled.", $color)
	  EndIf
   EndIf

EndFunc	;==>closeAllPopupOnMainScreen