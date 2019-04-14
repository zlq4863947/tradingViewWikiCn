#交易主机

---

![](/images/trading.png)此页面上的所有内容仅适用于[交易终端](Trading-Terminal.md)。

交易主机是[经纪商API](Broker-API.md)与图表交易子系统之间交互的API。其主要目的是用您的交易适配器与图表之间交换信息。 就`JS`而言，它是一个具有一组函数的`object`。 以下是交易主机的 **方法** 列表。

## 指令

### showOrderDialog(order, focus): Promise
1. `order` 下单或修改
2. `focus` - [焦点常量](Trading-Objects-and-Constants.md#focusoptions).

显示标准订单对话框以创建或修改订单，并在按下买/卖/修改时执行处理程序。

### showCancelOrderDialog(orderId, handler): Promise
1. `orderId` 要取消订单id
2. `handler` 处理取消的方法。它应该返回 `Promise`

显示一个确认对话框，并在按下`YES/OK`时，执行处理程序。

### showCancelMultipleOrdersDialog(symbol, side, qty, handler): Promise
1. `symbol` 取消订单的商品
2. `side` - 取消订单的方向
3. `qty` - 取消订单的数量
4. `handler` 处理取消的方法。它应该返回 `Promise`。

显示一个确认对话框，并在按下`YES/OK`时，执行处理程序。

### showClosePositionDialog([positionId](Trading-Objects-and-Constants.md#position), handler): Promise
1. `positionId` 要平仓的仓位id
2. `handler` 处理平仓的方法。它应该返回 `Promise`。

显示一个确认对话框，并在按下`YES/OK`时，执行处理程序。

### showReversePositionDialog([position](Trading-Objects-and-Constants.md#position), handler): Promise
1. `position` 反转仓位
2. `handler` 处理反转仓位的方法。它应该返回 `Promise`。

显示一个确认对话框，并在按下`YES/OK`时，执行处理程序。

### showPositionBracketsDialog([position](Trading-Objects-and-Constants.md#position), [brackets](Trading-Objects-and-Constants.md#brackets), focus): Promise
1. `position` 修改仓位
2. `brackets` (可选) 新的[包围单](Trading-Objects-and-Constants.md#Brackets)
3. `focus` - [焦点常量](Trading-Objects-and-Constants.md#focusoptions)

显示默认的编辑包围单对话框，并在按下MODIFY时执行处理程序。

### activateBottomWidget: Promise
打开底部面板并切换到交易标签页上。

### showTradingProperties()
显示属性对话框，切换当前标签页到交易标签页。

### showNotification(title, text, type)
显示通知。类型可以是 `1` - 成功 或 `0` - 错误。

### triggerShowActiveOrders()
触发显示活动订单。

### numericFormatter(decimalPlaces)
返回具有指定小数位的[Formatter](Trading-Objects-and-Constants.md#focusoptions)。
 
### defaultFormatter(symbol: string, alignToMinMove?: boolean = true)

返回指定合约的默认[Formatter](Trading-Objects-and-Constants.md#formatter)。此formatter基于[SymbolInfo](Symbology.md#symbolinfo-structure)创建。

默认情况下，formatter将价格舍入到最低价格，但有时您可能希望禁用此舍入。例如，仓位的平均价格不应四舍五入到最低价格。让我们假设我们将一笔交易价格在`100.25`，另一笔交易价格在`100.50`。该持仓的平均价格将是`100.375`。 如果你使用`defaultFormatter(symbol)`获得formatter，那么这个formatter会将这个价格舍入为`100.38`，但是如果你将第二个参数设置为`false`，那么价格将四舍五入为`100.50`。

### factory
`factory` 是一个对象属性。 其成员如下所述。

### factory.createDelegate
创建一个[Delegate](Delegate.md)对象。

### factory.createWatchedValue
创建一个[WatchedValue](WatchedValue.md)对象。

### factory.createPriceFormatter(priceScale, minMove, fractional, minMove2)

创建价格[Formatter](Trading-Objects-and-Constants.md#formatter)。此函数的参数在[另一个文章](Symbology.md#minmov-pricescale-minmove2-fractional)中描述。

### symbolSnapshot(symbol): Promise
返回商品报价。

## Getters and Setters

### floatingTradingPanelVisibility: [WatchedValue](WatchedValue.md)
返回浮动交易面板是否可见。

### domVisibility: [WatchedValue](WatchedValue.md)
返回DOM面板是否可见。

### orderPanelVisibility: [WatchedValue](WatchedValue.md)
返回订单面板是否可见。

#### showPricesWithZeroVolume: [WatchedValue](WatchedValue.md)
返回是否折叠0成交量（最小和最大成交量级别）的级别。

### silentOrdersPlacement: [WatchedValue](WatchedValue.md)
返回是否可以在不显示订单窗口的情况下将订单发送给经纪商。

### suggestedQty(): Object
返回的对象属性：
1. value - 获取当前值。 它返回Promise.
2. setValue - 设置新值
3. changed : [Subscription](Subscription.md)

在浮动交易面板和对话框中同步数量。

### setButtonDropdownActions(actions)
底部交易面板有一个带有下拉列表项目的按钮。此方法可用于替换现有项目。
1. `actions` [ActionMetainfo](Trading-Objects-and-Constants.md#actionmetainfo)的数组, 每个对象都代表一个下拉项。

### defaultContextMenuActions()
提供默认的买/卖，显示属性操作作为默认值[chartContextMenuItems](Trading-Controller.md#chartcontextmenuitemse)返回。

### defaultDropdownMenuActions(options)
提供操作的默认下拉列表。您可以在[setButtonDropdownActions](#setButtonDropdownActionsactions)中使用默认操作。
您可以使用  `options` 从结果中添加/删除默认操作:
1. `showFloatingToolbar`: boolean;
1. `tradingProperties`: boolean;
1. `selectAnotherBroker`: boolean;
1. `disconnect`: boolean;
1. `showDOM`: boolean;
1. `showOrderPanel`: boolean;

## 数据更新
使用这些方法来通知图表它需要更新的信息。

### orderUpdate([order](Trading-Objects-and-Constants.md#order))
在添加或更改订单时调用此方法。

### orderPartialUpdate([order](Trading-Objects-and-Constants.md#order))
当订单未更改时调用此方法，但您添加到在账户管理器中显示的订单对象的字段已更改。
仅当您要在[账户管理器](Account-Manager.md)中显示自定义字段时才应使用它。

### positionUpdate ([position](Trading-Objects-and-Constants.md#position))
在添加或更改持仓时调用此方法。

### positionPartialUpdate ([position](Trading-Objects-and-Constants.md#position))
当持仓未更改时调用此方法，但您添加到在账户管理器中显示的持仓对象的字段已更改。
仅当您要在[账户管理器](Account-Manager.md)中显示自定义字段时才应使用它。

### executionUpdate([[execution](Trading-Objects-and-Constants.md#execution))
添加执行时调用此方法。

### fullUpdate()
所有数据都已更改时调用此方法。例如，用户帐户已更改。

### plUpdate(positionId, pl)
当经纪商连接收到PL更新时调用此方法。当`configFlags`中设置`supportPLUpdate`标志时，应使用此方法。

### equityUpdate(equity)
当经纪商连接收到equity时调用此方法。标准订单对话框需要此方法来计算风险。

### marginAvailableUpdate(marginAvailable)

当经纪商连接收到可用保证金更新时，请调用此方法。标准订单对话框需要此方法来显示可用保证金。 当在`configFlags`中设置`supportMargin`标志时，应该使用此方法。交易终端使用[subscribeMarginAvailable](Broker-API.md#subscribemarginavailable)，订阅保证金可用更新。

### tradeUpdate([trade](Trading-Objects-and-Constants.md#trade))

在添加或更改交易时调用此方法。

### tradePartialUpdate ([trade](Trading-Objects-and-Constants.md#trade))

交易未更改时调用此方法，但您添加到交易对象中以显示在客户经理中的字段将更改。

### tradePLUpdate(tradeId, pl)

当经纪商连接收到交易PL更新时，请调用此方法。

### pipValueUpdate(symbol, pipValues)

当经纪商连接具有`pipValue`更新时，请调用此方法。图表库使用[subscribePipValue](Broker-API.md#subscribepipvalue)订阅`pipValue`更新。

`pipValues`是一个包含以下字段的对象:

1. `buipPipValue`  - 如果你买入`symbol`，值为1点
1. `sellPipValue` - 如果卖出`symbol`，值为1点
