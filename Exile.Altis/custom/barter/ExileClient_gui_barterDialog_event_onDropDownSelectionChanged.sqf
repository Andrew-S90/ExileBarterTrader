/*
 * ExileClient_gui_safeXDialog_event_onDropDownSelectionChanged
 *
 * Rewards Client - Made by Andrew_S90
 *
 * Derived from ExileMod Code
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private ["_listBox", "_index", "_dialog", "_withdrawListBox"];
disableSerialization;

_listBox = _this select 0;
_index = _this select 1;
_dialog = uiNameSpace getVariable ["RscExileBarterDialog", displayNull];
_withdrawListBox = _dialog displayCtrl 5002;
_withdrawListBox lbSetCurSel -1;
true