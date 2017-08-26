:chart: All content on this page is relevant for [[Trading Terminal]] only.

Trading Controller is a thing which will make your trading live. Its main purpose is to connect our charts with your trading logic. In terms of `JS`, it is an `object` which is expected to expose the specific interface. Here is a list of Controller's **methods** which Terminal will expect to have.

## Required Methods

#### setHost(host)
This methods is called on initialization to pass a [[Trading Host]] to the controller.

#### configFlags()
Implement this method to provide configuration flags object. The result is an object with the following keys, that can be `true`/`false`:

* supportReversePosition

    Broker supports reverse of a position.
    If it is not supported by broker, Chart will have the reverse button, but it will place a reverse order.

* supportClosePosition

    Broker supports close of a position.
    If it is not supported by broker, Chart will have the close button, but it will place a close order.

* supportReducePosition

    Broker supports changing of a position without orders.

* supportPLUpdate

    Broker provides PL for a position. If the broker calculates profit/loss by itself it should call [[plUpdate|Trading-Host#plupdatepositionid-pl]] as soon as PL is changed. Otherwise Chart will calculate PL as a difference between current trade and an average price of the position.

* supportBrackets

    Broker supports brackets (take profit and stop loss orders). If this flag is `true` the Chart will display an Edit button for positions and add `Edit position...` to the context menu of a position.

* supportMultiposition

    Supporting multiposition prevents creating default implementation for reverse position.

* supportCustomBottomWidget

    This flag can be used to change default account manager widget with a custom one.

* showQuantityInsteadOfAmount

	This flag can be used to change "Amount" to "Quantity" in the order dialog

* supportDOM

    This flag enables DOM widget. If `supportLevel2Data` is `false` only `last price` and orders will be shown.

* supportLevel2Data

    Level2 data is used for DOM widget. `subscribeDepth` and `unsubscribeDepth` should be implemented.

* supportStopLimitOrders

    This flag adds stop-limit orders type to the order dialog.
    
* supportMarketBrackets
	Using this flag you can disable brackets for market orders. By default it is enabled.
	
* supportEditAmount
    This flag can help you to disable amount control when editing existing orders.
    
#### durations(): array of objects
List of expiration options of orders. It is optional. Do not implement it if you don't want the durations to be displayed in the order ticket.
The objects have two kes: `{ name, value }`.

Example:

```
return [{ name: 'DAY', value: 'DAY' }, { name: 'GTC', value: 'GTC' }];
```

#### positions : [Deferred](https://api.jquery.com/category/deferred-object/)
#### orders : [Deferred](https://api.jquery.com/category/deferred-object/)
#### executions(symbol) : [Deferred](https://api.jquery.com/category/deferred-object/)
These methods are called by the Chart to request positions/orders/executions and display them on a chart.
You should return the appropriate lists of [[positions|Trading-Objects-and-Constants#position]], [[orders|Trading-Objects-and-Constants#order]] or [[executions|Trading-Objects-and-Constants#execution]]

#### supportFloatingPanel()
Function should return `true` for Floating Trading Panel to be displayed.

#### supportBottomWidget()
Function should return `true` for Bottom Trading Panel to be displayed.

#### chartContextMenuItems(e)
Chart can have a sub-menu `Trading` in the context menu. Return the list of items for a sub-menu. Format is the same as for `buttonDropdownItems`.

`e` is a context object passed by a broswer

#### bottomContextMenuItems()
Bottom Trading Panel can have a context menu. Return a list of items for this menu. Format is the same as for `buttonDropdownItems`.

#### isTradable(symbol)
This function is required for the Floating Trading Panel. Ability to trade via the panel depends on the result of this function: `true` or `false`. You don't need to imlement this method if all the symbols can be traded.

#### createBottomWidget(container)
This function is called when it is needed to create a Bottom Trading Panel. You should create DOM object and append it to the `container`. The container shows a vertical scroll bar when it is needed.

#### accountManagerInfo()
This function is called when supportCustomBottomWidget is false. It should return information that will be used to build an account manager.
See [[Account Manager]] for more information.

#### showOrderDialog([[order|Trading-Objects-and-Constants#order]])
This function is invoked by the chart when user requests to create or modify an order.

So we give you the ability to use your own dialog and it's 100% up to you how to manage it.

#### placeOrder([[order|Trading-Objects-and-Constants#order]], silently)

Method is invoked when a user want to place an order. Order is pre-filled with partial or full information.
If `silently` is `true` no order dialog show be shown.

#### modifyOrder([[order|Trading-Objects-and-Constants#order]], silently, focus)
1. `order` is an order object to modify
2. `silently` - if it is `true` no order dialog show be shown
3. `focus` - [[Focus constant|Trading-Objects-and-Constants#focusoptions]]. It can be already initialized by the chart.

Method is invoked when a user want to modify an existing order.

#### cancelOrder(orderId, silently)
This method is invoked to cancel single order with given `id`.
If `silently` is `true` no dialogs show be shown.

#### cancelOrders(symbol, side, ordersIds, silently)
1. `symbol` - symbol string
2. `side`: `"sell"` or `"buy"`
3. `ordersIds` - ids already collected by `symbol` and `side`
If `silently` is `true` no dialogs show be shown.

This method is invoked to cancel multiple orders for a `symbol` and `side`.

#### editPositionBrackets(positionId, focus)
This method is invoked if `supportBrackets` configuration flag is on to display a dialog for editing of take profit and stop loss.
1. `positionId` is ID of existing position to be modified
2. `focus` - [[Focus constant|Trading-Objects-and-Constants#focusoptions]].

#### closePosition(positionId, silently)
This method is invoked if `supportClosePosition` configuration flag is on to close the position by id.
If `silently` is `true` no dialogs show be shown.

#### reversePosition(positionId, silently)
This method is invoked if `supportReversePosition` configuration flag is on to reverse the position by id.
If `silently` is `true` no dialogs show be shown.

#### symbolInfo(symbol) : Deferred (or Promise)
1. `symbol` - symbol string

This method is invoked by the internal Order Dialog, DOM panel and floating trading panel to get symbol information.
Result is an object with the following data:
- `qty` - object with fields `min`, `max` and `step` that specifies Quantity field step and boundaries.
- `pipSize` - size of 1 pip (e.g., 0.0001 for EURUSD)
- `pipValue` - values of 1 pip in account currency (e.g., 1 for EURUSD for an account in USD)
- `minTick` - minimal price change (e.g., 0.00001 for EURUSD). It is used for price fields.
- `description` - a description to be displayed in the dialog
- `type` - instrument type, only `forex` matters - it enables negative pips check in the order dialog

#### accountInfo() : Deferred (or Promise)

This method is invoked by the internal Order Dialog to get account information.
It should return only one field for now:
1. currencySign: string - which is a sign of acccount currency

#### subscribePL(positionId)

Method should be implemented if `supportPLUpdate` config flag is `true`.
Since this method is called the broker should provide profit/loss via [[plUpdate|Trading-Host#plupdatepositionid-pl]] method.

#### unsubscribePL(positionId)

Method should be implemented if `supportPLUpdate` config flag is `true`.
Since this method is called the broker should stop providing profit/loss.

#### subscribeEquity()

Method should be implemented if you use standard order dialog and support stop loss.
Since this method is called the broker should provide equity updates via [[equityUpdate|Trading-Host#equityupdateequity]] method.

#### unsubscribeEquity()

Method should be implemented if you use standard order dialog and support stop loss.
Since this method is called the broker should stop providing equity updates.

And this is it !

# See Also
  * [[How to connect|Widget-Constructor#chart-trading_controller]] your trading controller to the chart
  * [[Trading Host]]
