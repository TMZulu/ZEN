#include "script_component.hpp"
/*
 * Author: mharis001
 * Enables or disables the list buttons based on currently selected item.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_updateButtons
 *
 * Public: No
 */

params ["_display"];

// Get mass of currently selected item
private _ctrlList = _display displayCtrl IDC_LIST;
private _currentRow = lnbCurSelRow _ctrlList;
private _item = _ctrlList lnbData [_currentRow, 0];
private _mass = [_item] call FUNC(getItemMass);

// Get current and max load for object
private _maxLoad = _display getVariable QGVAR(maxLoad);
private _currentLoad = _display getVariable QGVAR(currentLoad);

// Enable add button if object has enough space
private _ctrlButtonAdd = _display displayCtrl IDC_BTN_ADD;
_ctrlButtonAdd ctrlEnable (_maxLoad - _currentLoad >= _mass);

// Enable remove button if item count is not zero
private _ctrlButtonRemove = _display displayCtrl IDC_BTN_REMOVE;
_ctrlButtonRemove ctrlEnable (_ctrlList lnbText [_currentRow, 2] != "0");
