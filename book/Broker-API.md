# 经纪商API

![](/images/trading.png) 此页面上的所有内容仅与交易终端相关。

经纪商API是一种能让你在线交易的接口。它的主要目的是将我们的图表与您的交易逻辑连接起来。就`JS`而言，它是一个预期暴露特定接口的`对象`。下面是一个API的***方法**，终端将有这样一个列表。

## 必要的方法

#### constructor(host)
经纪商API的构造函数通常需要[交易主机](/book/Trading-Host.md)。

#### positions : Promise
交易终端调用这种方法来请求仓位。你应该返回[仓位](/book/Trading-Objects-and-Constants.md#position)数组。

#### orders : Promise
交易终端调用这种方法来请求订单。你应该返回[订单](/book/Trading-Objects-and-Constants.md#order)数组。

#### executions(symbol) : Promise
交易终端调用这种方法来请求执行。你应该返回[执行](/book/Trading-Objects-and-Constants.md#execution)数组。

#### trades : Promise
交易终端调用这种方法来请求交易（个别仓位）。 你应该返回[交易对象](/book/Trading-Objects-and-Constants.md#trade)数组。

#### chartContextMenuActions(e)
图表可以在菜单中拥有一个子菜单`交易`。 返回子菜单的项目列表。 格式与`buttonDropdownItems`相同。

`e` 是浏览器传递的上下文对象

#### connectionStatus()
通常你不需要返回`1`以外的值，因为当你创建widget时经纪商已经连接。 如果要在加载数据时在底部面板中显示一个spinner，则可以使用它。
可能的返回值是：

```javascript
ConnectionStatus.Connected = 1
ConnectionStatus.Connecting = 2
ConnectionStatus.Disconnected = 3
ConnectionStatus.Error = 4
```

#### isTradable(symbol)
该功能是浮动交易面板所必需的。通过面板进行交易的能力取决于这个函数的结果：`true`还是`false`。 如果所有商品都可以交易，则不需要实现这个方法。

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
3. `focus` - [OrderTicketFocusControl constants](/book/Trading-Objects-and-Constants.md#orderticketfocuscontrol)。它可以通过图表初始化。

方法在用户想要修改现有订单时被调用。

#### cancelOrder(orderId, silently)
这个方法被调用来取消给定`id`的单个订单。
如果`silently`是`true`，则不显示任何对话框。

#### cancelOrders(symbol, side, ordersIds, silently)
1. `symbol` - symbol string
2. `side`: [Side](/book/Trading-Objects-and-Constants.md#side) or `undefined`
3. `ordersIds` - `symbol`和`side`收集的ids。如果`silently`是`true`，则不显示任何对话框。

这个方法被调用来取消`symbol`和`side`的多个订单。

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
1.`tradeId`是要修改的交易id
2.`focus` - [Focus constant](/book/Trading-Objects-and-Constants.md#focusoptions])。

#### closeTrade(tradeId, silently)
如果`supportCloseTrade`配置标志打开以通过交易id关闭交易，则调用此方法。
如果`silently`是`true`，则不显示任何对话框。

#### symbolInfo(symbol) : Deferred (or Promise)
1. `symbol` - symbol string

这个方法由内部的Order Dialog，DOM面板和浮动交易面板调用，以获取商品信息。
结果是具有以下数据的对象：

- `qty` - 对象拥有这3个属性：`min`、`max`、`step`，用于指定数量的`step`和边界。
- `pipSize` - 点数的大小（例如，EURUSD为0.0001）
- `pipValue` - 账户币种的点数值（例如，对于以美元为账户的EURUSD为1）
- `minTick` - 最低的价格变动（例如，EURUSD为0.00001）。 它用于价格字段。
- `description` - 要在对话框中显示的描述
- `type` - 商品类型, 只要 `forex` 比较特殊 - 它允许在订单对话框中检查负的点数。
- `domVolumePrecision` - DOM 卖出/买入量的小数位数（可选，默认为0）

#### accountInfo() : Deferred (或 Promise)

这个方法被内部的Order Dialog调用来获取帐户信息。
现在应该只返回一个字段：
1. currencySign：字符串 - 这是一个计数货币的标志

由于这种方法被调用，经纪商应该停止提供利润/损失。

#### subscribeEquity()

如果您使用标准订单对话框并支持止损，则应实现这个方法。
由于这种方法被调用，经纪商应该通过[equityUpdate](/book/Trading-Host.md#equityupdateequity)方法提供净资产更新。

#### unsubscribeEquity()
如果您使用标准订单对话框并支持止损，则应实现这个方法。
由于这种方法被调用，经纪商应该停止提供净资产更新。

这就是它！

# 也可以看看

- [如何连接](/book/Widget-Constructor.md#brokerfactory)你的交易控制器到图表
- [交易主机](/book/Trading-Host.md)
