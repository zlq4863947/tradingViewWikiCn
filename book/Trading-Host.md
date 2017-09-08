#交易主机

---

![](/images/trading.png)此页面上的所有内容仅适用于\[\[交易终端\]\]。

交易主机是[[交易控制器]]与图表交易子系统之间的交互API。 其主要目的是用您的交易逻辑与图表之间交换信息。 就`JS`而言，它是一个具有一组函数的`object`。 以下是主机的 **方法** 列表。

## 命令

#### showOrderDialog(order, handler, focus) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `order` 被放置或修改
2. `handler` 是一个处理买/卖/修改的功能。 它应该返回[Deferred](https://api.jquery.com/category/deferred-object/)
3. `focus` - [[Focus constant|Trading-Objects-and-Constants#focusoptions]].

显示标准订单对话框以创建或修改订单，并执行处理程序（如果以下达买/卖/修改指令）。

#### showCancelOrderDialog(orderId, handler) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `orderId` 待取消订单的编号
2. `handler` 处理取消的功能。它返回 [Deferred](https://api.jquery.com/category/deferred-object/)

显示一个确认对话框，并按下YES/OK，执行处理程序。

#### showCancelMultipleOrdersDialog(symbol, side, qty, handler) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `symbol` 取消订单商品
2. `side` - 取消订单方向
3. `qty` - 取消订单数量
4. `handler` 处理取消的功能。它返回 [Deferred](https://api.jquery.com/category/deferred-object/)

显示一个确认对话框，并按下YES/OK，执行处理程序。

#### showClosePositionDialog([[positionId|Trading-Objects-and-Constants#position]], handler) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `positionId` 要平仓的头寸id
2. `handler` 处理平仓的功能。它返回 [Deferred](https://api.jquery.com/category/deferred-object/)

显示一个确认对话框，并按下YES/OK，执行处理程序。

#### showReversePositionDialog([[position|Trading-Objects-and-Constants#position]], handler) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `position` 进行反转
2. `handler` 处理头寸反转的功能。它返回 [Deferred](https://api.jquery.com/category/deferred-object/)

显示一个确认对话框，并按下YES/OK，执行处理程序。

#### showPositionBracketsDialog([[position|Trading-Objects-and-Constants#position]], [[brackets|Trading-Objects-and-Constants#brackets]], focus, handler) : [Deferred](https://api.jquery.com/category/deferred-object/)
1. `position` 进行修改
2. `brackets` (可选) new [brackets|Trading-Objects-and-Constants#Brackets]
2. `focus` - [[Focus constant|Trading-Objects-and-Constants#focusoptions]].
3. `handler` is a function to process modification of brackets. It should return [Deferred](https://api.jquery.com/category/deferred-object/)

显示默认的编辑括号对话框，并在按下修改时执行处理程序。

#### activateBottomWidget : [Deferred](https://api.jquery.com/category/deferred-object/)
打开底部面板和开关选项卡到交易。

#### showTradingProperties()
显示属性对话框，切换当前标签到交易。

#### showNotification(title, text, type)
显示通知。类型可以是 `1` - 成功 或 `0` - 错误。

#### triggerShowActiveOrders()
触发器显示活动订单。

#### numericFormatter(decimalPlaces)
以指定的小数位数返回一个[[Formatter|Trading-Objects-and-Constants#focusoptions]]。
 
#### defaultFormatter(symbol)
Returns a default [[Formatter|Trading-Objects-and-Constants#focusoptions]] formatter for the specified instrument. This formatter is created based on [[SymbolInfo|Symbology#symbolinfo-structure].
返回指定仪器的默认值[[Formatter|Trading-Objects-and-Constants#focusoptions]]以格式化程序。这个格式化器是基于[[SymbolInfo|Symbology#symbolinfo-structure]创建的。

#### factory
`factory` 是一个对象属性。 其成员如下所述。

#### factory.createDelegate
创建一个[[Delegate]]对象。

#### factory.createWatchedValue
创建一个[[WatchedValue]]对象。

#### symbolSnapshot(symbol) : Promise
返回商品报价。

## Getters and Setters

#### floatingTradingPanelVisibility: [[WatchedValue]]
返回floatingTradingPanel是否可见。

#### showPricesWithZeroVolume: [[WatchedValue]]
返回是否折叠0成交量（最小和最大成交量级别）的级别。

#### suggestedQty() : Object
返回的对象属性：
1. value - 获取当前值。 它返回Promise.
2. setValue - 设置新值
3. changed : [[Subscription]]
它是在交易浮动面板和对话框中同步数量。

#### setButtonDropdownActions(actions)
底部交易面板有一个带有下拉列表项目的按钮。 此方法可用于替换现有项目。
1. `actions` [[ActionMetainfo|Trading-Objects-and-Constants#actionmetainfo]]的数组, 每个对象都代表一个下拉项。

#### defaultContextMenuActions()
提供默认的买/卖，显示属性操作作为默认值由[chartContextMenuItems](Trading-Controller#chartcontextmenuitemse)返回。

#### defaultDropdownMenuActions(options)
提供操作的默认下拉列表。 您可以在[[setButtonDropdownActions](Trading-Host#setButtonDropdownActionsactions)中使用默认操作。
您可以使用  `options` 从结果中添加/删除默认操作:
1. `showFloatingToolbar`: boolean;
2. `tradingProperties`: boolean;
3. `selectAnotherBroker`: boolean;
4. `disconnect`: boolean;

## 数据更新
需要使用这些方法来通知图表需要更新信息。

#### orderUpdate([[order|Trading-Objects-and-Constants#order]])
在添加或更改订单时调用此方法。

#### orderPartialUpdate([[order|Trading-Objects-and-Constants#order]])
当订单未更改时调用此方法，但您添加到在账户管理器中显示的订单对象的字段已更改。
仅当您要在[[Account Manager]]中显示自定义字段时才应使用它。

#### positionUpdate ([[position|Trading-Objects-and-Constants#position]])
在添加或更改头寸时调用此方法。

#### positionPartialUpdate ([[position|Trading-Objects-and-Constants#position]])
当头寸未更改时调用此方法，但您添加到在账户管理器中显示的头寸对象的字段已更改。
仅当您要在[[Account Manager]]中显示自定义字段时才应使用它。


#### executionUpdate([[execution|Trading-Objects-and-Constants#execution]])
添加执行时调用此方法。

#### fullUpdate()
当数据无效时调用此方法。 例如，用户帐户已被更改。

#### plUpdate(positionId, pl)
Call this method when a broker connection has received a PL update. This method should be used when `supportPLUpdate` flag is set in `configFlags`.
当代理商连接收到PL更新时调用此方法。 当`configFlags`中设置`supportPLUpdate`标志时，应使用此方法。

#### equityUpdate(equity)
当代理商连接收到股权更新时调用此方法。 标准订单对话框需要此方法。
