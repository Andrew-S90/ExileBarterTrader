/**
 * ExileServer_world_loadAllClans
 *
 * Exile Mod
 * www.exilemod.com
 * © 2015 Exile Mod Team
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private["_continueLoading", "_page", "_pageSize", "_clanIDs", "_numberOfClans", "_i"];
"Loading Barter lists..." call ExileServer_util_log;

BarterMasterList = [];
"Clearing saved trader info..." call ExileServer_util_log;
format["clearSavedBarterInfo"] call ExileServer_system_database_query_fireAndForget;


_traderTypes = (missionConfigfile >> "CfgBarter" >> "Barters") call BIS_fnc_returnChildren;
diag_log format["_traderTypes %1",_traderTypes];
for "_i" from 0 to ((count _traderTypes) - 1) do 
{
	_traderItems = (_traderTypes select _i) call BIS_fnc_returnChildren;
	_traderArray = [];
	_traderClassnames = [];
	{
		_chance = getNumber (_x >> "chance");
		_min = getNumber (_x >> "min");
		_max = getNumber (_x >> "max");
		_blockItem = getText (_x >> "block_item");
		if((floor (random 100)) < _chance) then
		{
			_quantity = round ((random (_max-_min)) + _min);
			if !(_blockItem in _traderClassnames) then
			{
				_traderArray pushBack [configName _x,_quantity];
				_traderClassnames pushBack (configName _x);
			};
		};
	} forEach _traderItems; 
	BarterMasterList pushBack _traderArray;
};
ExileClientPlayerBarterMasterList = BarterMasterList;
publicVariable "ExileClientPlayerBarterMasterList";

"Done loading Barter lists!" call ExileServer_util_log;
true