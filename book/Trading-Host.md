:chart: All content on this page is relevant for [[Trading Terminal]] only.

Trading Host is API for interaction between [[Trading Controller]] and the Chart Trading Subsystem. Its main purpose is to exchange information between our charts with your trading logic. In terms of `JS`, it is an `object` with a set of functions. Here is a list of Hosts's **methods**.

## Commands

#### showOrderDialog(order, handler, focus) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `order` to be placed or modified
2. `handler` is a function to process buy/sell/modify. It should return [Deferred](https://api.jquery.com/category/deferred-object/)
3. `focus` - [[Focus constant|Trading-Objects-and-Constants#focusoptions]].

Shows standard order dialog to create or modify an order and executes handler if Buy/Sell/Modify is pressed.

#### showCancelOrderDialog(orderId, handler) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `orderId` ID of an order to be cancelled
2. `handler` is a function to process cancellation. It should return [Deferred](https://api.jquery.com/category/deferred-object/)

Shows a confirmation dialog and executes handler if YES/OK is pressed.

#### showCancelMultipleOrdersDialog(symbol, side, qty, handler) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `symbol` of orders to be cancelled
2. `side` - side of orders to be cancelled
3. `qty` - amount of orders to be cancelled
4. `handler` is a function to process cancellation. It should return [Deferred](https://api.jquery.com/category/deferred-object/)

Shows a confirmation dialog and executes handler if YES/OK is pressed.

#### showClosePositionDialog([[positionId|Trading-Objects-and-Constants#position]], handler) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `positionId` identifier of a position to be closed
2. `handler` is a function to process position close. It should return [Deferred](https://api.jquery.com/category/deferred-object/)

Shows a confirmation dialog and executes handler if YES/OK is pressed.

#### showReversePositionDialog([[position|Trading-Objects-and-Constants#position]], handler) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `position` to be reversed
2. `handler` is a function to process position reverse. It should return [Deferred](https://api.jquery.com/category/deferred-object/)

Shows a confirmation dialog and executes handler if YES/OK is pressed.

#### showPositionBracketsDialog([[position|Trading-Objects-and-Constants#position]], [[brackets|Trading-Objects-and-Constants#brackets]], focus, handler) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `position` to be modified
2. `brackets` (optional) new [brackets|Trading-Objects-and-Constants#Brackets]
2. `focus` - [[Focus constant|Trading-Objects-and-Constants#focusoptions]].
3. `handler` is a function to process modification of brackets. It should return [Deferred](https://api.jquery.com/category/deferred-object/)

Shows a default edit brackets dialog and executes handler if MODIFY is pressed.

#### activateBottomWidget : [Deferred](https://api.jquery.com/category/deferred-object/)
Opens bottom panel and switches tab to Trading.

#### showTradingProperties()
Shows the properties dialog, switches current tab to Trading.

#### showNotification(title, text, type)
Displays a notification. Type can be `1` - success or `0` - error.

#### triggerShowActiveOrders()
Triggers show active orders.

#### numericFormatter(decimalPlaces)
Returns a [[Formatter|Trading-Objects-and-Constants#focusoptions]] with the specified number of decimal places.
 
#### defaultFormatter(symbol)
Returns a default [[Formatter|Trading-Objects-and-Constants#focusoptions]] formatter for the specified instrument. This formatter is created based on [[SymbolInfo|Symbology#symbolinfo-structure].

#### factory
`factory` is an object property. Its members are described below.

#### factory.createDelegate
Creates a [[Delegate]] object.

#### factory.createWatchedValue
Creates a [[WatchedValue]] object.

#### symbolSnapshot(symbol) : Promise
Returns quotes of a symbol.

## Getters and Setters

#### floatingTradingPanelVisibility: [[WatchedValue]]
Returns whether floatingTradingPanel is visible or not.

#### showPricesWithZeroVolume: [[WatchedValue]]
Returns whether levels with empty volume (between min and max volume levels) are collapsed or not.

#### suggestedQty() : Object
Returned object properties:
1. value - use it to get current value. It returns Promise.
2. setValue - use it to set new value
3. changed : [[Subscription]]
It is to synchronize quantity in Trading Floating Panel and in the dialogs.

#### setButtonDropdownActions(actions)
Bottom Trading Panel has a button with a list of dropdown items. This method can be used to replace existing items. 
1. `actions` is an array of [[ActionMetainfo|Trading-Objects-and-Constants#actionmetainfo]], each of them representing one dropdown item.

#### defaultContextMenuActions()
Provides default buy/sell, show properties actions to be returned as a default by [chartContextMenuItems](Trading-Controller#chartcontextmenuitemse).

#### defaultDropdownMenuActions(options)
Provides default dropdown list of actions. You can use default actions in [setButtonDropdownActions](Trading-Host#setButtonDropdownActionsactions).
You can add/remove default action from the result using `options`:
1. `showFloatingToolbar`: boolean;
2. `tradingProperties`: boolean;
3. `selectAnotherBroker`: boolean;
4. `disconnect`: boolean;

## Data Updates
Using of these methods is required to notify the chart that it needs to update information.

#### orderUpdate([[order|Trading-Objects-and-Constants#order]])
Call this method when an order is added or changed.

#### orderPartialUpdate([[order|Trading-Objects-and-Constants#order]])
Call this method when an order is not changed, but fields that you added to the order object to display in the Account Manager are changed.
It should be used only if you want to display custom fields in the [[Account Manager]].

#### positionUpdate ([[position|Trading-Objects-and-Constants#position]])
Call this method when a position is added or changed.

#### positionPartialUpdate ([[position|Trading-Objects-and-Constants#position]])
Call this method when a position is not changed, but fields that you added to the position object to display in the Account Manager are changed.
It should be used only if you want to display custom fields in the [[Account Manager]].


#### executionUpdate([[execution|Trading-Objects-and-Constants#execution]])
Call this method when an execution is added.

#### fullUpdate()
Call this method when an data is invalidated. For example, user account has been changed.

#### plUpdate(positionId, pl)
Call this method when a broker connection has received a PL update. This method should be used when `supportPLUpdate` flag is set in `configFlags`.

#### equityUpdate(equity)
Call this method when a broker connection has received an equity update. This method is required by the standard order dialog.
