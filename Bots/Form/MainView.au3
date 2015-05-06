Global $Initiate = 0

Local $tabX = 10
Local $tabY = 10
Local $contentPaneX = $tabX + 10
Local $contentPaneY = $tabY + 30

Local $gap = 10
Local $generalRightHeight = 240
Local $generalBottomHeight = 70
Local $logViewWidth = 260
Local $logViewHeight = 300
Local $frameWidth = $contentPaneX + $logViewWidth + $gap + $generalRightHeight + $tabX
Local $frameHeight = $contentPaneY + $logViewHeight + $gap + $generalBottomHeight + $tabY

Local $tabHeight = $frameHeight - $tabY - $tabY
Local $contentPaneWidth = $frameWidth - $contentPaneX * 2
Local $contentPaneHeight = $tabHeight - 30
Local $x
Local $y
Local $h = 20
Local $w

; Main GUI Settings
$mainView = GUICreate($sBotTitle, $frameWidth, $frameHeight, -1, -1)

$idTab = GUICtrlCreateTab($tabX, $tabY, $frameWidth - $tabX * 2, $tabHeight)



;-----------------------------------------------------------
; Tab : General
;-----------------------------------------------------------
Local $generalRightX = $frameWidth - $tabX - $generalRightHeight
Local $generalBottomY = $frameHeight - $tabY - $generalBottomHeight

GUICtrlCreateTabItem("General")

$x = $generalRightX
$y = $contentPaneY + 5
GUICtrlCreateLabel("Sell Item Max Level", $x, $y)
$comboSellItemLevel = GUICtrlCreateCombo("", $x + 120, $y - 5, 100, $h)

$y += 30
$checkPvpEnabled = GUICtrlCreateCheckbox("PvP Enabled", $x, $y, $w, 25)
$y += 30
$checkRaidEnabled = GUICtrlCreateCheckbox("Raid Enabled", $x, $y, $w, 25)
$y += 30
$checkGuildEnabled = GUICtrlCreateCheckbox("Guild Enabled", $x, $y, $w, 25)
$y += 30
$checkDailyEnabled = GUICtrlCreateCheckbox("Daily Enabled", $x, $y, $w, 25)

; The Bot Status Screen
$txtLog = _GUICtrlRichEdit_Create($mainView, "", $contentPaneX, $contentPaneY, $logViewWidth, $logViewHeight, BitOR($ES_MULTILINE, $ES_READONLY, $WS_VSCROLL, 8912))

; Start/Stop Button
$x = $contentPaneX
Local $btnWidth = 90
$btnStart = GUICtrlCreateButton("Start Bot", $x, $generalBottomY, $btnWidth, 50)
$btnStop = GUICtrlCreateButton("Stop Bot", $x, $generalBottomY, $btnWidth, 50)

$x += $btnWidth
$x += $gap
$btnScreenShot = GUICtrlCreateButton("Screen Shot", $x, $generalBottomY, $btnWidth, 50)


; Statistics
$x = $generalRightX
$y += 50
$txtStats = GUICtrlCreateLabel("", $x, $y, 200, 150);, BitOR($GUI_SS_DEFAULT_LABEL,$SS_GRAYFRAME))




;-----------------------------------------------------------
; Tab : Adventure
;-----------------------------------------------------------
GUICtrlCreateTabItem("Adventure")

$x = $contentPaneX
$y = $contentPaneY

$comboStageMajor = GUICtrlCreateCombo("", $x, $y, 100, 20)
$comboStageMinor = GUICtrlCreateCombo("", $x + 110, $y, 50, 20)

; Battle Buff Items
$x = $contentPaneX
$y = $contentPaneY + 30
$h = 20
$w = 120

Global $checkBuffAttack[$MaxBattleTypeCount];
Global $checkBuffDefence[$MaxBattleTypeCount];
Global $checkBuffHealth[$MaxBattleTypeCount];
Global $checkBuffAutoSkill[$MaxBattleTypeCount];
Global $checkBattleEatPotion[$MaxBattleTypeCount];

$checkBuffAttack[$Id_Adventure] = GUICtrlCreateCheckbox("Buff Attack", $x, $y, $w, 25)
$y += $h
$checkBuffDefence[$Id_Adventure] = GUICtrlCreateCheckbox("Buff Defence", $x, $y, $w, 25)
$y += $h
$checkBuffHealth[$Id_Adventure] = GUICtrlCreateCheckbox("Buff Health", $x, $y, $w, 25)
$y += $h
$checkBuffAutoSkill[$Id_Adventure] = GUICtrlCreateCheckbox("Buff AutoSkill", $x, $y, $w, 25)
$y += $h
$checkBattleEatPotion[$Id_Adventure] = GUICtrlCreateCheckbox("Eat health potion", $x, $y, 120, 25)



;-----------------------------------------------------------
; Tab : PvP
;-----------------------------------------------------------

GUICtrlCreateTabItem("PvP")

; Battle Buff Items
$x = $contentPaneX
$y = $contentPaneY
$h = 20
$w = 120

$checkBuffAttack[$Id_Pvp] = GUICtrlCreateCheckbox("Buff Attack", $x, $y, $w, 25)
$y += $h
$checkBuffDefence[$Id_Pvp] = GUICtrlCreateCheckbox("Buff Defence", $x, $y, $w, 25)
$y += $h
$checkBuffHealth[$Id_Pvp] = GUICtrlCreateCheckbox("Buff Health", $x, $y, $w, 25)
$y += $h
$checkBuffAutoSkill[$Id_Pvp] = GUICtrlCreateCheckbox("Buff AutoSkill", $x, $y, $w, 25)
$y += $h
$checkBattleEatPotion[$Id_Pvp] = GUICtrlCreateCheckbox("Eat health potion", $x, $y, 120, 25)

GUICtrlSetState($checkBuffAutoSkill[$Id_Pvp], $GUI_CHECKED)
ControlDisable($mainView, "", $checkBuffAutoSkill[$Id_Pvp] )


;-----------------------------------------------------------
; Tab : Raid
;-----------------------------------------------------------

GUICtrlCreateTabItem("Raid")

; Battle Buff Items
$x = $contentPaneX
$y = $contentPaneY
$h = 20
$w = 120

$checkBuffAttack[$Id_Raid] = GUICtrlCreateCheckbox("Buff Attack", $x, $y, $w, 25)
$y += $h
$checkBuffDefence[$Id_Raid] = GUICtrlCreateCheckbox("Buff Defence", $x, $y, $w, 25)
$y += $h
$checkBuffHealth[$Id_Raid] = GUICtrlCreateCheckbox("Buff Health", $x, $y, $w, 25)
$y += $h
$checkBuffAutoSkill[$Id_Raid] = GUICtrlCreateCheckbox("Buff AutoSkill", $x, $y, $w, 25)
$y += $h
$checkBattleEatPotion[$Id_Raid] = GUICtrlCreateCheckbox("Eat health potion", $x, $y, 120, 25)

GUICtrlSetState($checkBuffAutoSkill[$Id_Raid], $GUI_CHECKED)
ControlDisable($mainView, "", $checkBuffAutoSkill[$Id_Raid] )


;-----------------------------------------------------------
; Tab : Guild
;-----------------------------------------------------------

GUICtrlCreateTabItem("Guild")

; Battle Buff Items
$x = $contentPaneX
$y = $contentPaneY
$h = 20
$w = 120

$checkBuffAttack[$Id_Guild] = GUICtrlCreateCheckbox("Buff Attack", $x, $y, $w, 25)
$y += $h
$checkBuffDefence[$Id_Guild] = GUICtrlCreateCheckbox("Buff Defence", $x, $y, $w, 25)
$y += $h
$checkBuffHealth[$Id_Guild] = GUICtrlCreateCheckbox("Buff Health", $x, $y, $w, 25)


;-----------------------------------------------------------
; Tab : Day Battle
;-----------------------------------------------------------

GUICtrlCreateTabItem("Daily")



;==================================
; Control Initial setting
;==================================

For $i = 1 To $MaxStageNumber
   GUICtrlSetData($comboStageMajor, "Stage-" & $i)
Next

GUICtrlSetData($comboSellItemLevel, "None")
For $i = 1 To 6
   GUICtrlSetData($comboSellItemLevel, "Level " & $i)
Next

GUICtrlSetOnEvent($btnScreenShot, "btnScreenShot")
GUICtrlSetOnEvent($btnStart, "btnStart")
GUICtrlSetOnEvent($btnStop, "btnStop")
GUICtrlSetOnEvent($idTab, "tabChanged")

GUICtrlSetState($btnStart, $GUI_SHOW)
GUICtrlSetState($btnStop, $GUI_HIDE)

GUISetState(@SW_SHOW, $mainView)


;==================================
; Control Callback
;==================================

Func tabChanged()
   If _GUICtrlTab_GetCurSel($idTab) = 0 Then
	  ControlShow($mainView, "", $txtLog)
   Else
	  ControlHide($mainView, "", $txtLog)
   EndIf
EndFunc


Func btnScreenShot()
   _CaptureRegion()
   SaveImageToFile("screenshot")

   ; For Test
   Local $x, $y
   _CaptureRegion()
   Local $bmpPath = String(@ScriptDir & "\images\stage_13.bmp")
   If _ImageSearch($bmpPath, 0, $x, $y,  $DefaultTolerance / 3) Then
	  _log("OK! :" & $x & "x" & $y)
   EndIf

   $RunState = True
   $PauseBot = False
   runBot()

EndFunc


Func btnStart()

   If $RunState = True Then Return

   _log("START BUTTON CLICKED" )

   _GUICtrlEdit_SetText($txtLog, "")
   _WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; Reduce BlueStacks Memory Usage

   GUICtrlSetState($btnStart, $GUI_HIDE)
   GUICtrlSetState($btnStop, $GUI_SHOW)

   $RunState = True
   $PauseBot = False

   saveConfig()

   Initiate()

EndFunc

Func btnStop()
   _log("STOP BUTTON CLICKED" )

   GUICtrlSetState($btnStart, $GUI_SHOW)
   GUICtrlSetState($btnStop, $GUI_HIDE)

   If $RunState Then
	  SetLog("Bot has stopped", $COLOR_ORANGE)
   EndIf

   $Restart = False
   $RunState = False
   $PauseBot = True
EndFunc

; System callback
Func mainViewClose()
   saveConfig()
   _GDIPlus_Shutdown()
   _GUICtrlRichEdit_Destroy($txtLog)
   Exit
EndFunc


;==================================
; Methods
;==================================

Func Initiate()
   If IsArray(ControlGetPos($Title, "_ctl.Window", $WindowClass)) Then
	  Local $BSsize = [ControlGetPos($Title, "_ctl.Window", $WindowClass)[2], ControlGetPos($Title, "_ctl.Window", $WindowClass)[3]]
	  Local $fullScreenRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "FullScreen")
	  Local $guestHeightRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "GuestHeight")
	  Local $guestWidthRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "GuestWidth")
	  Local $windowHeightRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "WindowHeight")
	  Local $windowWidthRegistryData = RegRead($REGISTRY_KEY_DIRECTORY, "WindowWidth")

	  Local $BSx = ($BSsize[0] > $BSsize[1]) ? $BSsize[0] : $BSsize[1]
	  Local $BSy = ($BSsize[0] > $BSsize[1]) ? $BSsize[1] : $BSsize[0]

	  If $BSx <> $DEFAULT_WIDTH Or $BSy <> $DEFAULT_HEIGHT Then
		 RegWrite($REGISTRY_KEY_DIRECTORY, "FullScreen", "REG_DWORD", "0")
		 RegWrite($REGISTRY_KEY_DIRECTORY, "GuestHeight", "REG_DWORD", $DEFAULT_HEIGHT)
		 RegWrite($REGISTRY_KEY_DIRECTORY, "GuestWidth", "REG_DWORD", $DEFAULT_WIDTH)
		 RegWrite($REGISTRY_KEY_DIRECTORY, "WindowHeight", "REG_DWORD", $DEFAULT_HEIGHT)
		 RegWrite($REGISTRY_KEY_DIRECTORY, "WindowWidth", "REG_DWORD", $DEFAULT_WIDTH)
		 SetLog("Please restart your computer for the applied changes to take effect.", $COLOR_ORANGE)
		 _Sleep(3000)

		 $MsgRet = MsgBox(BitOR($MB_OKCANCEL, $MB_SYSTEMMODAL), "Restart Computer", "Restart your computer for the applied changes to take effect." & @CRLF & "If your BlueStacks is the correct size  (" & $DEFAULT_WIDTH & " x " & $DEFAULT_HEIGHT & "), click OK.", 10)
		 If $MsgRet <> $IDOK Then
			btnStop()
			Return
		 EndIf
		 Exit
	  EndIf

	  WinActivate($Title)

	  SetLog("Welcome to " & $sBotTitle, $COLOR_PURPLE)
	  SetLog($Compiled & " running on " & @OSArch & " OS", $COLOR_GREEN)
	  SetLog("Bot is starting...", $COLOR_ORANGE)

	  runBot()
   Else
	  btnStop()
   EndIf
EndFunc


Func clearStats()
   $loopCount = 0
   $lastElapsed = "--:--:--"
   $raidAttackCount = 0
   $pvpAttackCount = 0
   $guildAttackCount = 0
   $dailyAttackCount = 0
   $itemSoldCount = 0
EndFunc


Func updateStats()

   Local $text = "Loop : " & $loopCount & @CRLF & "Elapsed : " & $lastElapsed & @CRLF & "PvP : " & $pvpAttackCount & @CRLF & "Raid : " & $raidAttackCount & @CRLF   & "Guild : " & $guildAttackCount & @CRLF & "Daily : " & $dailyAttackCount & @CRLF & "Item sold : " & $itemSoldCount & @CRLF

   GUICtrlSetData($txtStats, $text)
EndFunc