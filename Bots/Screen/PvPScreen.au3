
Local Const $PVP_READY_BUTTON_POS[2] = [555, 421]

Local Const $PVP_BATTLE_PAUSE_REGION[4] = [684, 22, 750, 84]
Local Const $RESULT_PVP_BUTTON_REGION[4] = [520, 385, 702, 467]

Local Const $PVP_BATTLE_BAD_HEALTH_COLOR[4] = [225, 53, 0x111111, 10]

Func waitPvpScreen()
   SetLog("Waiting for PvP Screen", $COLOR_ORANGE)
   For $i = 0 To $RetryWaitCount
	  _CaptureRegion()

	  Local $x, $y
	  Local $bmpPath = @ScriptDir & "\images\pvp_text.bmp"
	  If ImageSearchArea($bmpPath, 0, $LEFT_TOP_SCREEN_NAME_REGION, $x, $y, 30) = False Then
		 If _Sleep($SleepWaitMSec) Then Return False

		 ; Checking RAID
		 If ClickButtonImage(String(@ScriptDir & "\images\button_raid_close.bmp")) Then
			SetLog("Raid Detected.", $COLOR_PINK)
		 EndIf

		 ; In this Pvp screen, this server disconnected popup can show up often. So just close the popup and try reconnect
		 If ClickButtonImageArea(String(@ScriptDir & "\images\button_retry.bmp"), $POPUP_BUTTON_REGION) Then
			SetLog("Retry button Detected.", $COLOR_PINK)
		 EndIf

		 ; Re-click adventure button on MainScreen
		 clickPvpButton()
		 If _Sleep($SleepWaitMSec) Then ExitLoop
	  Else
		 SetLog("PvP Screen Located", $COLOR_BLUE)
		 Return True
	  EndIf
   Next
   SetLog("PvP Screen Timeout", $COLOR_RED)
   Return False
EndFunc	;==>waitPvpScreen


Func checkPvpStamina()

   Local $bmpPath = @ScriptDir & "\images\pvp_lack_text_0.bmp"
   _log("PVP Stamina lack checking : " & $bmpPath )

   If _ImageSearchArea($bmpPath, 0, 264, 12, 312, 39, $x, $y, $DefaultTolerance) Then
	  SetLog("Lack of PvP stamina detected", $COLOR_RED)
	  Return False
   EndIf
   Return True
EndFunc


Func clickPvpReadyButton()
   ClickPos($PVP_READY_BUTTON_POS)
EndFunc	;==>clickPvpReadyButton


Func startPvpBattle()
   SetLog("Waiting for PvP Battle Ready Screen", $COLOR_ORANGE)
   For $i = 0 To $RetryWaitCount

	  If waitBattleReadyScreen(True) Then
		 SetLog("PvP Battle Ready Screen Located", $COLOR_BLUE)
		 Return True
	  EndIf

	  clickPvpReadyButton()

	  If _Sleep($SleepWaitMSec) Then Return False
   Next
   Return False
EndFunc	;==>startPvpBattle


Func doPvpBattleScreen()

   _waitPvpBattleScreen()

   _selectAutoPvpBattle()

   Local $hTimer = TimerInit()
   While 1
	  If Int(TimerDiff($hTimer)) > 300000 Then
		 SetLog("Unexpected battle detected...", $COLOR_RED)
		 SaveImageToFile("pvp_error");
		 $RunState = True
		 Return
	  EndIf

	  Local $battleEnd = WaitScreenImage(String(@ScriptDir & "\images\button_big_ok.bmp"), $RESULT_PVP_BUTTON_REGION, True);

	  If ClickButtonImageArea(String(@ScriptDir & "\images\button_ok.bmp"), $POPUP_BUTTON_REGION) Then
		 SetLog("Disconnect Detected.", $COLOR_BLUE)
		 ExitLoop
	  EndIf

	  If $battleEnd Then
		 SetLog("Finished PvP Battle!", $COLOR_RED)
		 ExitLoop
	  EndIf

	  ; To remove 3 continuous reward text
	  Click(186, 352)

	  If _Sleep(2000) Then Return

	  ClickPos($BATTLE_DODGE_BUTTON_POS, 500, 2)

	 _checkHealthAndEatPotionForPvP()
   WEnd

   ; Click OK Button
   ClickButtonImageArea(String(@ScriptDir & "\images\button_big_ok.bmp"), $RESULT_PVP_BUTTON_REGION)

EndFunc	;==>doPvpBattleScreen


Func _waitPvpBattleScreen()
   SetLog("Waiting for PvP Battle Screen", $COLOR_ORANGE)

   For $i = 0 To $RetryWaitCount
	  _CaptureRegion()

	  Local $x, $y
	  Local $bmpPath = @ScriptDir & "\images\battle_mark.bmp"
	  If ImageSearchArea($bmpPath, 0, $PVP_BATTLE_PAUSE_REGION, $x, $y, 30) = False Then
		 If _Sleep($SleepWaitMSec) Then Return False

		 Click(400, 200)	; Click anywhere to start
		 _Sleep(1500)
	  Else
		 SetLog("PvP Battle Screen Located", $COLOR_BLUE)
		 Return True
	  EndIf
   Next

   Return False
EndFunc	;==>_waitPvpBattleScreen


Func _selectAutoPvpBattle()
   Local $bmpPath = @ScriptDir & "\images\battle_auto_mark.bmp"
   Local $x, $y
   _CaptureRegion()

   If _ImageSearchArea($bmpPath, 0, 318, 398, 405, 474, $x, $y, $DefaultTolerance) Then
	  ClickPos($BATTLE_AUTO_BUTTON_POS)
	  SetLog("Auto Battle Clicked", $COLOR_DARKGREY)
   EndIf

EndFunc	;==>_selectAutoBattle


Func _checkHealthAndEatPotionForPvP()
   If CheckPixel($PVP_BATTLE_BAD_HEALTH_COLOR) Then
	  SetLog("Eat Potion", $COLOR_RED)
	  ClickPos($BATTLE_POTION_BUTTON_POS)
	  _Sleep(1500)
   EndIf

EndFunc	;==> _checkHealthAndEatPotionForPvP
