#交易主机

---

![](/images/trading.png)此页面上的所有内容仅适用于\[\[交易终端\]\]。

## Order

描述一个订单。

* id : String
* symbol : String
* brokerSymbol : String. 如果经纪商商品代码与TV商品代码相同，则可以为空。
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

描述一个头寸。

* id: String. 通常id应等于brokerSymbol
* symbol : String
* brokerSymbol : String. 如果经纪商商品代码与TV商品代码相同，则可以为空。
* qty : Double positive
* side: [[Side|Trading-Objects-and-Constants#side]]
* avg_price : Double

## Execution

Describes a single execution.

* symbol : String
* brokerSymbol : String. 如果经纪商商品代码与TV商品代码相同，则可以为空。
* price : double
* time: time_t
* side : [[Side|Trading-Objects-and-Constants#side]]
* qty : double


## ActionMetainfo

描述将其放入下拉菜单或上下文菜单中的单个操作。它是一个结构。

* text : String
* checkable : Boolean. 如果需要复选框，将其设置为true。
* checked : Boolean
* 复选框的值。
* enabled: Boolean
* action: function. 当用户单击该项目时执行操作。 它有一个参数 - 复选框的值（如果存在）。

## OrderType

用于描述订单状态的字符串常量。

* market
* limit
* stop
* stoplimit

## Side

用于描述订单/交易执行的字符串常量。

* buy
* Sell


## ParentType

String constants to describe a bracket owner.

* ORDER_PARENT
* POSITION_PARENT


## OrderStatus

用于描述订单状态的字符串常量。

| 状态    | 描述 |
|-----------|-------------|
| pending 	| 订单还未在经纪商一方创建 |
| inactive 	| bracket order is created but waiting for a base order to be filled |
| working	| 订单被创建还未执行成功 |
| rejected	| 订单因某些原因被拒绝 |
| filled	| 订单已成交 |
| canceled	| 订单被取消 |

## DOMEObject

描述单个DOME响应的对象。

* `snapshot`: Boolean
正值意味着以前的数据应该被清理

* `asks`: 根据价格升序排列的DOM价格水平数组
* `bids`: 根据价格升序排列的DOM等级数组

## DOMELevel

单个DOME价格水平对象。

* `price`: double
* `volume`: double


## FocusOptions

打开标准订单对话框或头寸对话框时设置焦点的字符串常量。

* STOP_PRICE_FIELD     focus stop price for StopLimit orders
* TAKE_PROFIT_FIELD    focus take profit control
* STOP_LOSS_FIELD      focus stop loss control

## Brackets

# `stopLoss`: double
# `takeProfit`: double

## Formatter

具有`format`方法的对象可用于将数字格式化为字符串。