# 经纪商 API

![](/images/trading.png) 此页面上的所有内容仅与交易终端相关。

经纪商 API 是支持实时交易的关键组件。其主要目的是将图表库与您的交易逻辑联系起来。
对`JS`而言，它是一个预期暴露特定接口的`对象`。下面是经纪商 API 的**方法**列表。

## 必要的方法

### constructor(host)

经纪商 API 的构造函数通常需要[交易主机](Trading-Host.md)。

### positions: `Promise<Position[]>`

交易终端调用此方法来请求[仓位](Trading-Objects-and-Constants.md#position)。

### orders: `Promise<Order[]>`

交易终端调用此方法来请求[订单](Trading-Objects-and-Constants.md#order)。

### executions(symbol): `Promise<Execution[]>`

交易终端调用此方法来请求[执行](Trading-Objects-and-Constants.md#execution)。

### trades: `Promise<Trade[]>`

交易终端调用此方法来请求[交易](Trading-Objects-and-Constants.md#trade)（个别仓位）。

### chartContextMenuActions(e)

`e` 是浏览器传递的上下文对象

图表可以在菜单中拥有`交易`子菜单。 此方法应返回一组 [ActionMetaInfo](Trading-Objects-and-Constants.md#actionmetainfo) 元素，每个元素代表一个上下文菜单项。

### connectionStatus()

通常你不需要返回`1`以外的值，因为当你创建 widget 时经纪商已经连接。如果要在加载数据时在底部面板中显示一个微调控制器(spinner)，则可以使用它。
可能的返回值是：

```javascript
ConnectionStatus.Connected = 1;
ConnectionStatus.Connecting = 2;
ConnectionStatus.Disconnected = 3;
ConnectionStatus.Error = 4;
```

### isTradable(symbol): `Promise<boolean | IsTradableResult>`

该方法是浮动交易面板所必需的。通过面板进行交易的能力取决于这个方法的返回值是：`true`还是`false`。 如果所有商品都可以交易，则不需要实现这个方法。

如果要显示自定义消息显示无法交易商品的原因，则可以返回对象`IsTradableResult`。 它只有两个键：tradable（`true`或`false`）、solutions（`TradableSolutions`）、reason（`string`）和shortReason（`string`）。 Reason 显示在 Order 对话框中，而 shortReason 显示在图例中。

### accountManagerInfo()

此方法用于返回账户管理器的信息。请参阅[账户管理器](Account-Manager.md)了解更多信息。

### placeOrder([order](Trading-Objects-and-Constants.md#order), confirmId)

方法在用户想要下订单时调用。订单预先填写了部分或全部信息。

如果 `supportPlaceOrderPreview` 配置标志打开，则传递 `confirmId`。

### previewOrder([order](Trading-Objects-and-Constants.md#order))

返回订单的估计佣金、费用、保证金和其他信息，而无需实际下订单。 如果 `supportPlaceOrderPreview` 配置标志打开，则调用该方法。
结果将是一个具有以下字段的对象：

`OrderPreviewResult` - 描述订单预览的结果。

- `sections`：订单预览部分数组，[OrderPreviewSection](Trading-Objects-and-Constants.md#OrderPreviewSection)[]。
- `confirmId` : 应该传递给 `placeOrder` 方法的唯一标识符
- `warnings` : 可选的文本警告数组
- `errors` : 可选的文本错误数组

### modifyOrder([order](Trading-Objects-and-Constants.md#order), confirmId)

1. `order` 是要修改的订单对象

方法在用户想要修改现有订单时被调用。

如果 `supportModifyOrderPreview` 配置标志打开，则传递 `confirmId`。

### cancelOrder(orderId, silently)

调用这个方法来取消`id`的订单。

如果`silently`是`true`，则不显示任何对话框。

### cancelOrders(symbol, side, ordersIds, silently)

1. `symbol` - symbol string
2. `side`: [Side](Trading-Objects-and-Constants.md#side) 或 `undefined`
3. `ordersIds` - `symbol`和`side`收集的 ids。如果`silently`是`true`，则不显示任何对话框。

这个方法被调用来取消`symbol`和`side`的多个订单。

如果`silently`是`true`，则不显示任何对话框。

### editPositionBrackets(positionId, [brackets](Trading-Objects-and-Constants#brackets.md))

1. `positionId` 要修改的现有仓位 ID
1. `brackets` - 新的[包围单](Trading-Objects-and-Constants.md#brackets) (可选).

如果启用了`supportPositionBrackets`配置标志，则请求此方法，可显示一个用于编辑止盈和止损的对话框。

### closePosition(positionId)

如果启用了`supportClosePosition`配置标志，则请求此方法，可通过仓位 id 平仓。

### reversePosition(positionId)

如果启用了`supportReversePosition`配置标志，则请求此方法，可通过仓位 id 反转仓位。

### editTradeBrackets(tradeId, [brackets](Trading-Objects-and-Constants#brackets))

1. `tradeId`是要修改的交易 id
1. `brackets` - 新的[包围单](Trading-Objects-and-Constants.md#brackets) (可选).

如果启用了`supportTradeBrackets`配置标志，则请求此方法，应显示一个用于编辑止盈和止损的对话框。

### closeTrade(tradeId)

如果启用了`supportCloseTrade`配置标志，则请求此方法，可通过交易 id 关闭交易。

### symbolInfo(symbol): Deferred (或 Promise)

1. `symbol` - symbol string

此方法通过内部订单对话框调用。DOM 面板和浮动交易面板请求此方法，以获取商品信息。

返回值是具有以下属性的对象:

- `qty` - 对象拥有这 3 个属性：`min`、`max`、`step`，用于指定数量、`step`和边界。
- `pipSize` - 点的大小（例如，EURUSD 为`0.0001`）
- `pipValue` - 对于合约账户币种的每`1pip`的值
- `minTick` - 最小价格变动（例如，EURUSD 为`0.00001`）。用于价格字段。
- `description` - 要在对话框中显示的描述
- `type` - 合约类型, 只有 `forex` 比较特殊 - 它允许在订单对话框中实现负的点数。
- `domVolumePrecision` - DOM `卖出/买入` 数量的小数位数（可选，默认为 0）
- `marginRate` - 合约的保证金要求。`3%`的保证金率应表示为`0.03`
- `stopPriceStep` - 止损和止损限价订单的止损价格字段的最小价格变化。如果设置，它将覆盖 minTick 值。
- `limitPriceStep` - 限价和止损限价订单的限价字段的最小价格变化。如果设置，它将覆盖 minTick 值。
- `allowedDurations` - 具有有效持续时间值的字符串数组。 您可以在订单对话框中进行检查。
- `currency` - 在订单对话框中显示的工具货币
- `baseCurrency` - 货币对中报价的第一种货币。 仅用于加密货币。
- `quoteCurrency` - 货币对中报价的第二种货币。 仅用于加密货币。

### accountInfo(): Deferred (或 Promise)

此方法通过内部订单对话框调用，以获取账户信息。

只返回一个字段：

1. currencySign：字符串 - 这是账户货币的标志

一旦调用此方法，经纪商应停止提供盈利/亏损。

### subscribeEquity()

如果您使用标准订单对话框并支持止损，则应实现这个方法。`Equity` 用于计算风险百分比。

一旦调用此方法，经纪商应通过[equityUpdate](Trading-Host.md#equityupdateequity)方法，提供 `equity(余额+P/L)` 的更新订阅。

### unsubscribeEquity()

如果您使用标准订单对话框并支持止损，则应实现这个方法。

一旦调用此方法，经纪商应停止提供 `Equity` 的更新。

### subscribeMarginAvailable()

如果您使用标准订单对话框并想要显示可用保证金，则应实现这个方法。

一旦调用此方法，经纪商应通过[marginAvailableUpdate](Trading-Host.md#marginavailableupdatemarginavailable)方法，提供可用保证金的更新。

### unsubscribeMarginAvailable()

如果您使用标准订单对话框并想要显示可用保证金，则应实现这个方法。

一旦调用此方法，经纪商应停止提供可用保证金的更新。

### subscribePipValue()

如果您使用标准订单对话框，则应实现这个方法。`pipValues`显示在订单信息中，用于计算交易价值和风险。
如果没有实现这个方法，则在订单面板/对话框中使用`symbolInfo`中的`pipValue`。

一旦调用此方法，经纪商应通过[pipValueUpdate](Trading-Host.md#pipvalueupdatesymbol-pipValues)方法，提供`pipValue`的更新。

### unsubscribePipValue()

如果使用标准订单对话框并实现`subscribePipValue`，则应实现该方法。

调用此方法后，经纪商应停止提供`pipValue`的更新。

## 可选方法

### getOrderDialogOptions(symbol): Promise\<OrderDialogOptions |未定义>

1. `symbol` - 商品字符串。

如果您使用标准订单对话框并希望对其进行自定义，则可以实现该方法。

使用 `symbol` 参数返回特定商品的自定义选项。

结果是一个带有 Order 对话框选项的对象：

- `showTotal`：布尔值

  使用此标志，您可以在“订单”对话框的“订单信息”部分将“交易价值”更改为“总计”。

- `customFields`: (TextWithCheckboxFieldMetaInfo | CustomComboBoxMetaInfo)[];

  使用customFields`，您可以向“订单”对话框添加其他输入字段。

例子：

```javascript
customFields: [
    {
        inputType: 'TextWithCheckBox',
        id: '2410',
        title: 'Digital Signature',
        placeHolder: 'Enter your personal digital signature',
        value: {
            text: '',
            checked: false,
        },
        customInfo: {
            asterix: true,
            checkboxTitle: 'Save',
        },
    }
]
```

### getPositionDialogOptions(): PositionDialogOptions

如果要自定义位置对话框，可以实现该方法。

结果是一个带有位置对话框选项的对象。

- `customFields`: (TextWithCheckboxFieldMetaInfo | CustomComboBoxMetaInfo)[];

    使用 `customFields` ，您可以向位置对话框添加额外的输入字段。
    
# 也可以看看

- [如何连接](Widget-Constructor.md#brokerfactory)你的交易控制器到图表
- [交易主机](Trading-Host.md)
