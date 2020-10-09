/*
 * ExileClient_gui_safeXDialog_event_onClaimButtonClick
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
 
private ["_dialog", "_rewardsLB", "_claim", "_dropdown", "_selectedInventoryLBIndex", "_itemClassName", "_selected", "_currentContainerType", "_containerNetID"];
disableSerialization;

_dialog = uiNameSpace getVariable ["RscExileBarterDialog", displayNull];

_barterClear = _dialog displayCtrl 2019;
_inventoryClear = _dialog displayCtrl 2017;
_tradeButton = _dialog displayCtrl 2020;

_barterClear ctrlEnable false;
_inventoryClear ctrlEnable false;
_tradeButton ctrlEnable false;
_barterClear ctrlCommit 0;
_inventoryClear ctrlCommit 0;
_tradeButton ctrlCommit 0;

if (count ExileClientPlayerBarterOfferItems > 0) then
{
	if (count ExileClientPlayerInventoryOfferItems > 0) then
	{
		if !(ExileClientIsWaitingForServerTradeResponse) then
		{	
			if ((progressPosition (_dialog displayCtrl 2015)) >= (progressPosition (_dialog displayCtrl 2012))) then
			{
				_playerGear = (player call ExileClient_util_playerCargo_list);
				_hasItems = true;
				{
					_itemClassName = (_x select 0);
					_count = {_x == _itemClassName} count _playerGear;
					if ((_x select 1) > _count) then
					{
						_hasItems = false;
					};
				} forEach ExileClientPlayerInventoryOfferItems;
				if (_hasItems) then
				{
					{
						for "_i" from 1 to (_x select 1) do 
						{
							[player, (_x select 0)] call ExileClient_util_playerCargo_remove;
						};
					} forEach ExileClientPlayerInventoryOfferItems;
					ExileClientIsWaitingForServerTradeResponse = true;
					["tradeItemsRequest", [ExileClientPlayerBarterItems,ExileClientPlayerBarterOfferItems,ExileClientPlayerInventoryItems,ExileClientPlayerInventoryOfferItems,ExileClientPlayerBarterNumber]] call ExileClient_system_network_send;
				};
			};
		};
	};
};
true