

; -----------------------------
; Settings Variable
; -----------------------------

Global $setting_stage_major = 7
Global $setting_stage_minor = 2
Global $setting_use_buff_items[$MaxBattleTypeCount][4] = [[False, False, False, False], [True, True, True, True], [False, False, False, True], [False, False, False, True], [False, False, False, True]]
Global $setting_eat_potion[$MaxBattleTypeCount] = [True, True, True, True, True]
Global $setting_item_sell = True
Global $setting_item_sell_maximum_level = 1
Global $setting_pvp_enabled = False
Global $setting_raid_enabled = True
Global $setting_guild_enabled = True
Global $setting_daily_enabled = False
; ------------------------------


Local $setting_common_group = "Raven"

Func loadConfig()
   If FileExists($config) Then
	  $setting_pvp_enabled = IniRead($config, $setting_common_group, "enabled_pvp", "False") == "True" ? True : False
	  $setting_raid_enabled = IniRead($config, $setting_common_group, "enabled_raid", "False") == "True" ? True : False
	  $setting_guild_enabled = IniRead($config, $setting_common_group, "enabled_guild", "False") == "True" ? True : False
	  $setting_daily_enabled = IniRead($config, $setting_common_group, "enabled_daily", "False") == "True" ? True : False

	  $setting_stage_major = Int(IniRead($config, $setting_common_group, "stage_major", "7"))
	  $setting_stage_minor = Int(IniRead($config, $setting_common_group, "stage_minor", "2"))
	  For $i = 0 To $MaxBattleTypeCount - 1
		 $setting_use_buff_items[$i][0] = IniRead($config, $setting_common_group, "use_buff_" & $i & "_1", "False") == "True" ? True : False
		 $setting_use_buff_items[$i][1] = IniRead($config, $setting_common_group, "use_buff_" & $i & "_2", "False") == "True" ? True : False
		 $setting_use_buff_items[$i][2] = IniRead($config, $setting_common_group, "use_buff_" & $i & "_3", "False") == "True" ? True : False
		 $setting_use_buff_items[$i][3] = IniRead($config, $setting_common_group, "use_buff_" & $i & "_4", "False") == "True" ? True : False
		 $setting_eat_potion[$i] = IniRead($config, $setting_common_group, "eat_potion_" & $i, "False") == "True" ? True : False
	  Next
	  $setting_item_sell_maximum_level = Int(IniRead($config, $setting_common_group, "sell_item_level", "1"))
   EndIf
EndFunc	;==>loadConfig

Func applyConfig()

   For $i = 0 To $MaxBattleTypeCount - 1
	  If $setting_use_buff_items[$i][0] = 1 Then
		 GUICtrlSetState($checkBuffAttack[$i], $GUI_CHECKED)
	  Else
		 GUICtrlSetState($checkBuffAttack[$i], $GUI_UNCHECKED)
	  EndIf

	  If $setting_use_buff_items[$i][1] = 1 Then
		 GUICtrlSetState($checkBuffDefence[$i], $GUI_CHECKED)
	  Else
		 GUICtrlSetState($checkBuffDefence[$i], $GUI_UNCHECKED)
	  EndIf

	  If $setting_use_buff_items[$i][2] = 1 Then
		 GUICtrlSetState($checkBuffHealth[$i], $GUI_CHECKED)
	  Else
		 GUICtrlSetState($checkBuffHealth[$i], $GUI_UNCHECKED)
	  EndIf

	  If $setting_use_buff_items[$i][3] = 1 Then
		 GUICtrlSetState($checkBuffAutoSkill[$i], $GUI_CHECKED)
	  Else
		 GUICtrlSetState($checkBuffAutoSkill[$i], $GUI_UNCHECKED)
	  EndIf

	  If $setting_eat_potion[$i] = 1 Then
		 GUICtrlSetState($checkBattleEatPotion[$i], $GUI_CHECKED)
	  Else
		 GUICtrlSetState($checkBattleEatPotion[$i], $GUI_UNCHECKED)
	  EndIf
   Next

   If $setting_pvp_enabled = 1 Then
	  GUICtrlSetState($checkPvpEnabled, $GUI_CHECKED)
   Else
	  GUICtrlSetState($checkPvpEnabled, $GUI_UNCHECKED)
   EndIf

   If $setting_raid_enabled = 1 Then
	  GUICtrlSetState($checkRaidEnabled, $GUI_CHECKED)
   Else
	  GUICtrlSetState($checkRaidEnabled, $GUI_UNCHECKED)
   EndIf

   If $setting_daily_enabled = 1 Then
	  GUICtrlSetState($checkDailyEnabled, $GUI_CHECKED)
   Else
	  GUICtrlSetState($checkDailyEnabled, $GUI_UNCHECKED)
   EndIf

   If $setting_guild_enabled = 1 Then
	  GUICtrlSetState($checkGuildEnabled, $GUI_CHECKED)
   Else
	  GUICtrlSetState($checkGuildEnabled, $GUI_UNCHECKED)
   EndIf

   _GUICtrlComboBox_SetCurSel($comboStageMajor, Int($setting_stage_major) - 1)
   loadStageMinorCombo($setting_stage_major)
   _GUICtrlComboBox_SetCurSel($comboStageMinor, Int($setting_stage_minor) - 1)

   _GUICtrlComboBox_SetCurSel($comboSellItemLevel, Int($setting_item_sell_maximum_level))
EndFunc	;==>applyConfig


Func saveConfig()
   IniWrite($config, $setting_common_group, "enabled_pvp", _IsChecked($checkPvpEnabled))
   IniWrite($config, $setting_common_group, "enabled_raid", _IsChecked($checkRaidEnabled))
   IniWrite($config, $setting_common_group, "enabled_guild", _IsChecked($checkGuildEnabled))
   IniWrite($config, $setting_common_group, "enabled_daily", _IsChecked($checkDailyEnabled))

   For $i = 0 To $MaxBattleTypeCount - 1
	  IniWrite($config, $setting_common_group, "use_buff_" & $i & "_1", _IsChecked($checkBuffAttack[$i]))
	  IniWrite($config, $setting_common_group, "use_buff_" & $i & "_2", _IsChecked($checkBuffDefence[$i]))
	  IniWrite($config, $setting_common_group, "use_buff_" & $i & "_3", _IsChecked($checkBuffHealth[$i]))
	  IniWrite($config, $setting_common_group, "use_buff_" & $i & "_4", _IsChecked($checkBuffAutoSkill[$i]))
	  IniWrite($config, $setting_common_group, "eat_potion_" & $i, _IsChecked($checkBattleEatPotion[$i]))
   Next
   IniWrite($config, $setting_common_group, "stage_major", _GUICtrlComboBox_GetCurSel($comboStageMajor) + 1)
   IniWrite($config, $setting_common_group, "stage_minor", _GUICtrlComboBox_GetCurSel($comboStageMinor) + 1)
   IniWrite($config, $setting_common_group, "sell_item_level", _GUICtrlComboBox_GetCurSel($comboSellItemLevel))
EndFunc	;==>saveConfig

Func _IsChecked($idControlID)
    Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

