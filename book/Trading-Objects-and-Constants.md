:chart: All content on this page is relevant for [[Trading Terminal]] only.

## Order

Describes a single order.

* id : String
* symbol : String
* brokerSymbol : String. Can be empty if broker symbol is the same as TV symbol.
* type : [[OrderType|Trading-Objects-and-Constants#ordertype]]
* side : [[Side|Trading-Objects-and-Constants#side]]
* qty : Double
* status : [[OrderStatus|Trading-Objects-and-Constants#orderstatus]]
* limitPrice : double
* stopPrice : double
* avg_price : double
* filledQty : double
* parentId : String. If order is a bracket parentOrderId should contain base order/position id.
* parentType: [[ParentType|Trading-Objects-and-Constants#parenttype]]

## Position

Describes a single position.

* id: String. Usually id should be equal to brokerSymbol
* symbol : String
* brokerSymbol : String. Can be empty if broker symbol is the same as TV symbol.
* qty : Double positive
* side: [[Side|Trading-Objects-and-Constants#side]]
* avg_price : Double

## Execution

Describes a single execution.

* symbol : String
* brokerSymbol : String. Can be empty if broker symbol is the same as TV symbol.
* price : double
* time: time_t
* side : [[Side|Trading-Objects-and-Constants#side]]
* qty : double


## ActionMetainfo

Describes a single action to put it into a dropdown or a context menu. It is a structure.

* text : String
* checkable : Boolean. Set it to true if you need a checkbox.
* checked : Boolean
* Value of the checkbox.
* enabled: Boolean
* action: function. Action is executed when user clicks the item. It has 1 argument - value of the checkbox if exists.

## OrderType

String constants to describe an order status.

* market
* limit
* stop
* stoplimit

## Side

String constants to describe an order/execution side.

* buy
* Sell


## ParentType

String constants to describe a bracket owner.

* ORDER_PARENT
* POSITION_PARENT


## OrderStatus

String constants to describe an order status.

| Status    | Description |
|-----------|-------------|
| pending 	| order is not created on a broker side yet |
| inactive 	| bracket order is created but waiting for a base order to be filled |
| working	| order is created but not executed yet |
| rejected	| order is rejected for some reason |
| filled	| order is fully executed |
| canceled	| order is canceled |

## DOMEObject

An object that describes a single DOME response.

* `snapshot`: Boolean
Positive value means that previous data should be cleaned

* `asks`: array of DOMELevel sorted by price ascendingly
* `bids`: array of DOMELevel sorted by price ascendingly

## DOMELevel

Single DOME price level object.

* `price`: double
* `volume`: double


## FocusOptions

String constants to set focus when you open standard Order dialog or Position dialog.

* STOP_PRICE_FIELD     focus stop price for StopLimit orders
* TAKE_PROFIT_FIELD    focus take profit control
* STOP_LOSS_FIELD      focus stop loss control

## Brackets

# `stopLoss`: double
# `takeProfit`: double

## Formatter

An object with `format` method that can be used to format number to string.