#RequireAdmin

#pragma compile(FileDescription, Raven Bot)
#pragma compile(ProductName, Raven Bot)
#pragma compile(ProductVersion, 0.9)
#pragma compile(FileVersion, 0.9)
#pragma compile(LegalCopyright, ?The Bytecode Club)

$sBotName = "Raven Bot"
$sBotVersion = "0.9"
$sBotTitle = "AutoIt " & $sBotName & " v" & $sBotVersion

If _Singleton($sBotTitle, 1) = 0 Then
   MsgBox(0, "", "Bot is already running.")
   Exit
EndIf

#include <Bots/GlobalVariables.au3>
#include <Bots/AutoFlow.au3>
#include <Bots/Form/MainView.au3>
#include <Bots/Screen/MainScreen.au3>
#include <Bots/Screen/AdventureScreen.au3>
#include <Bots/Screen/CommonBattleScreen.au3>
#include <Bots/Screen/CommonReadyScreen.au3>
#include <Bots/Screen/RaidScreen.au3>
#include <Bots/Screen/InventoryScreen.au3>
#include <Bots/Screen/BlackSmithScreen.au3>
#include <Bots/Screen/PvPScreen.au3>
#include <Bots/Screen/GuildScreen.au3>
#include <Bots/Screen/DailyScreen.au3>
#include <Bots/Screen/AdventureStageScreen.au3>
#include <Bots/Util/SetLog.au3>
#include <Bots/Util/Config.au3>
#include <Bots/Util/Time.au3>
#include <Bots/Util/CreateLogFile.au3>
#include <Bots/Util/_Sleep.au3>
#include <Bots/Util/Click.au3>
#include <Bots/Util/getBSPos.au3>
#include <Bots/Util/FindPos.au3>
#include <Bots/Util/WaitScreen.au3>
#include <Bots/Util/Wheel.au3>
#include <Bots/Util/SaveImageToFile.au3>
#include <Bots/Util/Image Search/ImageSearch.au3>
#include <Bots/Util/Pixels/_CaptureRegion.au3>
#include <Bots/Util/Pixels/_ColorCheck.au3>
#include <Bots/Util/Pixels/_GetPixelColor.au3>
#include <Bots/Util/Pixels/_MultiPixelSearch.au3>
#include <Bots/Util/Pixels/_PixelSearch.au3>
#include <Bots/Util/Pixels/_WaitForPixel.au3>
#include <Bots/Util/Pixels/boolPixelSearch.au3>
#include-once

Opt("MouseCoordMode", 2)
Opt("GUICoordMode", 2)
Opt("GUIResizeMode", 1)
Opt("GUIOnEventMode", 1)

GUISetOnEvent($GUI_EVENT_CLOSE, "mainViewClose", $mainView)
GUIRegisterMsg($WM_COMMAND, "GUIControl")
GUIRegisterMsg($WM_SYSCOMMAND, "GUIControl")

; Initialize
DirCreate($dirLogs)
DirCreate($dirCapture)
_GDIPlus_Startup()
CreateLogFile()

loadConfig()
applyConfig()

clearStats()
updateStats()

; Just idle around
While 1
   Sleep(10)
WEnd

_log("Bye!")

Func GUIControl($hWind, $iMsg, $wParam, $lParam)
	Local $nNotifyCode = BitShift($wParam, 16)
	Local $nID = BitAND($wParam, 0x0000FFFF)
	Local $hCtrl = $lParam
	#forceref $hWind, $iMsg, $wParam, $lParam
	Switch $iMsg
	  Case 273
		Switch $nID
			Case $GUI_EVENT_CLOSE
			   mainViewClose();
			Case $btnStop
			   btnStop()
			EndSwitch
		Case 274
			Switch $wParam
			   Case 0xf060
				  mainViewClose();
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIControl

; Main Auto Flow
Func runBot()
   _log("START" )

   $loopCount = 0
   Local $iSec, $iMin, $iHour
   clearStats()
   updateStats()

   Local $errorCount = 0

   While $RunState
	  Local $hTimer = TimerInit()

	  $Restart = False

	  ; Config re-apply
      saveConfig()
      loadConfig()
	  applyConfig()

	  if $loopCount > 0 Then
		 _GUICtrlEdit_SetText($txtLog, "")
	  EndIf

	  SetLog("Start Loop : " & $loopCount + 1, $COLOR_PURPLE)

	  Local $res = AutoFlow()

	  If $res = False OR $RunState = False Then
		 SetLog("Error occurred..", $COLOR_RED)
		 $errorCount = $errorCount + 1

		 If $errorCount = 1 Then
			; only saved screen shot at first error
			SaveImageToFile()
		 EndIf
	  Else
		 $errorCount = 0
		 $loopCount = $loopCount + 1

		 Local $time = _TicksToTime(Int(TimerDiff($hTimer)), $iHour, $iMin, $iSec)

		 $lastElapsed = StringFormat("%02i:%02i:%02i", $iHour, $iMin, $iSec)

		 updateStats()
	  EndIf

	  ;ExitLoop ; for one loop test
   WEnd

   _log("Bye" )
   btnStop()
EndFunc


