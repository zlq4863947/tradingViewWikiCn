# 经纪商API

![](/images/trading.png) 此页面上的所有内容仅与交易终端相关。

经纪商API是一种能让你在线交易的接口。它的主要目的是将我们的图表与您的交易逻辑连接起来。就`JS`而言，它是一个预期暴露特定接口的`对象`。下面是一个API的***方法**，终端将有这样一个列表。

## 必要的方法

#### constructor(host)
经纪商API的构造函数通常需要[交易主机](/book/Trading-Host.md)。

#### positions : Promise
交易终端调用这种方法来请求仓位。你应该返回[仓位](/book/Trading-Objects-and-Constants.md#position)对象。

#### orders : Promise
交易终端调用这种方法来请求订单。你应该返回[订单](/book/Trading-Objects-and-Constants.md#order)对象。

#### executions(symbol) : Promise
交易终端调用这种方法来请求执行。你应该返回[执行](/book/Trading-Objects-and-Constants.md#execution)对象。

#### trades : Promise
交易终端调用这种方法来请求交易（个别仓位）。 你应该返回一个[交易对象](/book/Trading-Objects-and-Constants.md#trade)的数组。

#### chartContextMenuActions(e)
图表可以在上下文菜单中有一个子菜单“交易”。 返回子菜单的项目列表。 格式与`buttonDropdownItems`相同。

`e` 是浏览器传递的上下文对象

#### connectionStatus()
通常你不需要返回'1`以外的值，因为当你创建widget时经纪商已经连接。 如果要在加载数据时在底部面板中显示微调框，则可以使用它。
可能的返回值是：

```
ConnectionStatus.Connected = 1
ConnectionStatus.Connecting = 2
ConnectionStatus.Disconnected = 3
ConnectionStatus.Error = 4
```

#### isTradable(symbol)
该功能是浮动交易面板所必需的。 通过面板进行交易的能力取决于这个函数的结果：`true`还是`false`。 如果所有符号都可以交易，则不需要实现这个方法。

#### accountManagerInfo()
此功能用于返回账户管理器的信息。请参阅[账户管理器](/book/Account-Manager.md)了解更多信息。

#### showOrderDialog([order](/book/Trading-Objects-and-Constants.md#order))
当用户请求创建或修改订单时，此功能由图表调用。

所以我们给您使用您自己的对话框的能力。

#### placeOrder([order](/book/Trading-Objects-and-Constants.md#order), silently)

方法在用户想要下订单时调用。 订单预先填写了部分或全部信息。
如果`silently`是`true`，则不显示任何对话框。

#### modifyOrder([order](/book/Trading-Objects-and-Constants.md#order), silently, focus)
1. `order` 是要修改的订单对象
2. `silently` - 如果是 `true` ，则不应显示任何订单对话框
3. `focus` - [OrderTicketFocusControl constants](/book/Trading-Objects-and-Constants.md#orderticketfocuscontrol)。它可以已经由图表初始化。

方法在用户想要修改现有订单时被调用。

#### cancelOrder(orderId, silently)
这个方法被调用来取消给定`id`的单个订单。
如果`silently`是`true`，则不显示任何对话框。

#### cancelOrders(symbol, side, ordersIds, silently)
1. `symbol` - symbol string
2. `side`: [Side](/book/Trading-Objects-and-Constants.md#side) or `undefined`
3. `ordersIds` - 已经通过商品和side收集的ids
如果`silently`是`true`，则不显示任何对话框。

这个方法被调用来取消一个`symbol`和`side`的多个订单。

#### editPositionBrackets(positionId, focus)
如果`supportPositionBrackets`配置标志打开，将显示一个用于编辑止盈和止损的对话框，此方法将被调用。
1.`positionId`要修改的现有仓位ID
2.`focus` - [Focus constant](/book/Trading-Objects-and-Constants.md#focusoptions])。

#### closePosition(positionId, silently)
如果`supportClosePosition`配置标志打开，通过仓位id平仓时，此方法将被调用。
如果`silently`是`true`，则不显示任何对话框。

#### reversePosition(positionId, silently)
如果`supportReversePosition`配置标志打开，通过仓位id反转时，此方法将被调用。
如果`silently`是`true`，则不显示任何对话框。

#### editTradeBrackets(tradeId, focus)
如果`supportTradeBrackets`配置标志打开，将显示一个用于编辑止盈和止损的对话框。
1.`tradeId`是要修改的现有交易ID
2.`focus` - [Focus constant](/book/Trading-Objects-and-Constants.md#focusoptions])。

#### closeTrade(tradeId, silently)
如果`supportCloseTrade`配置标志打开以通过交易id关闭交易，则调用此方法。
如果`silently`是`true`，则不显示任何对话框。

#### symbolInfo(symbol) : Deferred (or Promise)
1. `symbol` - symbol string

这个方法由内部的Order Dialog，DOM面板和浮动交易面板调用，以获取商品信息。
结果是具有以下数据的对象：

- `qty` - object with fields `min`, `max` and `step` that specifies Quantity field step and boundaries.
- `pipSize` - size of 1 pip (e.g., 0.0001 for EURUSD)
- `pipValue` - values of 1 pip in account currency (e.g., 1 for EURUSD for an account in USD)
- `minTick` - minimal price change (e.g., 0.00001 for EURUSD). It is used for price fields.
- `description` - a description to be displayed in the dialog
- `type` - instrument type, only `forex` matters - it enables negative pips check in the order dialog
- `domVolumePrecision` - number of decimal places of DOM asks/bids volume (optional, 0 by default)

#### accountInfo() : Deferred (or Promise)

这个方法被内部的Order Dialog调用来获取帐户信息。
现在应该只返回一个字段：
1. currencySign：字符串 - 这是一个计数货币的标志

由于这种方法被调用，经纪人应该停止提供利润/损失。

#### subscribeEquity()

如果您使用标准订单对话框并支持止损，则应实施方法。
由于这种方法被调用，经纪商应该通过[equityUpdate](/book/Trading-Host.md#equityupdateequity)方法提供股票更新。

#### unsubscribeEquity()
如果您使用标准订单对话框并支持止损，则应实施方法。
由于这种方法被调用，经纪商应该停止提供股票更新。

这就是它！

# See Also
  * [[How to connect|Widget-Constructor#chart-trading_controller]] your trading controller to the chart
  * [[Trading Host]]
