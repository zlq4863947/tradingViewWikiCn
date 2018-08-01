#交易控制器(已废弃)

---

![](/images/trading.png)此页面上的所有内容仅适用于\[\[交易终端\]\]。

交易控制器是一种能使您在线交易的东西。其主要目的是将我们的图表与您的交易逻辑连接起来。就`JS`而言,它是一个 `object` 以便公开特定的接口。 下面是一个终端控制器的 **方法** 。

## 必需的方法

#### setHost\(host\)

这种方法在初始化时通过\[\[交易主机\]\]传递给控制器。

#### configFlags\(\)

实现这个方法来提供配置标志对象。 结果是具有以下键的对象，即可以`true`/`false`:

* supportReversePosition

  经纪商支持反向交易。  
    如果经纪商不支持，则图表将具有相反的按钮，但会按相反的顺序排列。

* supportClosePosition

  经纪商支持平仓。  
    如果经纪人不支持，图表将会有关闭按钮，但会按顺序排列。

* supportReducePosition

  经纪商支持在没有订单的情况下更换仓位。

* supportPLUpdate

  经纪人提供PL的持仓。 如果经纪商自己计算利润/损失，它应该调用 \[\[plUpdate\|Trading-Host\#plupdatepositionid-pl\]\] 一旦PL改变了。 否则图表将计算PL作为当前交易与持仓平均价格之间的差额。

* supportBrackets

  经纪支持括号单（获利和止损单）。如果此标志为 `true` ，则图表将显示仓位的编辑按钮，并将 `Edit position...` 添加到仓位的上下文菜单。

* supportMultiposition

  支持多重仓位可防止为反向交易创建默认实现。

* supportCustomBottomWidget

  此标志可用于使用自定义更改默认的帐户管理器小部件。

* showQuantityInsteadOfAmount

  该标志可用于在订单对话框中将“金额”更改为“数量”

* supportDOM

  此标志用来启用DOM小部件。 如果 `supportLevel2Data` 为 `false` 只有 `last price` 并且订单将被显示。

* supportLevel2Data

  Level2数据用于DOM小部件。`subscribeDepth` 和 `unsubscribeDepth` 应该被实现。

* supportStopLimitOrders

  此标志向订单对话框添加止损订单类型。

* supportMarketBrackets  
    使用此标志可以为市场订单禁用括号单。 默认情况下启用。

* supportEditAmount  
    此标志可帮助您在编辑现有订单时禁用金额控制。

#### durations\(\): array of objects

订单过期期权清单。 这是可选的。 如果您不希望在订单中显示持续时间，请勿实现。  
对象有两个key： `{ name, value }`.

例:

```
return [{ name: 'DAY', value: 'DAY' }, { name: 'GTC', value: 'GTC' }];
```

#### 持仓 : [Deferred](https://api.jquery.com/category/deferred-object/)

#### 订单 : [Deferred](https://api.jquery.com/category/deferred-object/)

#### 执行信号\(symbol\) : [Deferred](https://api.jquery.com/category/deferred-object/)

图表调用这些方法来请求位置/订单/执行并在图表上显示它们。  
您应该返回相应的列表\[\[positions\|Trading-Objects-and-Constants\#position\]\], \[\[orders\|Trading-Objects-and-Constants\#order\]\] or \[\[executions\|Trading-Objects-and-Constants\#execution\]\]

#### supportFloatingPanel\(\)

此方法将返回`true`,以显示浮动交易面板。

#### supportBottomWidget\(\)

此方法将返回`true`,以显示底层交易面板。

#### chartContextMenuItems\(e\)

图表可以在上下文菜单中有子菜单 `交易` 。返回子菜单项的列表。格式是一样的` buttondropdownitems `。
`e` 是浏览器传递的上下文对象

#### bottomContextMenuItems\(\)

底部交易面板可以有一个上下文菜单。 返回此菜单的项目列表。 格式与 `buttonDropdownItems` 相同。

#### isTradable\(symbol\)

此方法是浮动交易面板所必需的。 是否可以访问交易面板取决于这个函数的结果：`true`或`false`。如果所有符号都可以交易，则不需要使用此方法。

#### createBottomWidget\(container\)

当创建底部交易面板时需要调用这个函数。您应该创建DOM对象并将其附加到 `container`中。容器在需要时显示一个垂直滚动条。

#### accountManagerInfo\(\)

当supportCustomBottomWidget为`false`时，调用此方法。 返回用于构建帐户管理器的信息。
有关详细信息，请参阅\ [\ [帐户管理器\] \]。

#### showOrderDialog\(\[\[order\|Trading-Objects-and-Constants\#order\]\]\)

当用户请求创建或修改订单时，图表会调用此函数。

所以我们给您一个自己的对话框，它100％由您管理。

#### placeOrder\(\[\[order\|Trading-Objects-and-Constants\#order\]\], silently\)

当用户想要下订单时调用方法。订单预先填写了部分或全部信息。
如果 `silently` 为`true`，则不显示任何对话框。

#### modifyOrder\(\[\[order\|Trading-Objects-and-Constants\#order\]\], silently, focus\)

`order`是要修改的订单对象
2.`silently` - 如果是`true`，则不显示任何对话框
3.`focus` - \ [\ [Focus constant \ | Trading-Objects-and-Constants \ #focusoptions \] \]。 它可以由图表初始化。

1. `order` 是要修改的订单对象
2. `silently` - 为 `true` 时，不显示任何对话框
3. `focus` - \[\[Focus constant\|Trading-Objects-and-Constants\#focusoptions\]\]. 它可以由图表初始化。

当用户要修改现有的订单时调用方法。

#### cancelOrder\(orderId, silently\)

这个方法被调用来取消指定`id`的订单。
如果 `silently` 为`true`，则不显示任何对话框。

#### cancelOrders\(symbol, side, ordersIds, silently\)

1. `symbol` - 商品字符串
2. `side`: `"sell"` 或 `"buy"`
3. `ordersIds` - 已经被`symbol` 和 `side` 收集的订单id列表
   如果 `silently` 为`true`，则不显示任何对话框。

此方法被调用以取消`symbol`和`side`的多个订单。

#### editPositionBrackets\(positionId, focus\)

如果`supportBrackets`配置标志开启显示用于编辑利润和止损的对话框，则调用此方法。
1. `positionId` 是要修改的现有位置的ID
2. `focus` - \[\[Focus constant\|Trading-Objects-and-Constants\#focusoptions\]\].

#### closePosition\(positionId, silently\)

如果`supportBrackets`配置标志开启显示用于平仓的对话框，则调用此方法。
如果 `silently` 为`true`，则不显示任何对话框。

#### reversePosition\(positionId, silently\)

如果“supportReversePosition”配置标志打开，则通过id来反转持仓，将调用此方法。
如果 `silently` 为`true`，则不显示任何对话框。

#### symbolInfo\(symbol\) : Deferred \(or Promise\)

1. `symbol` - 商品字符串

该方法由内部Order Dialog，DOM面板和浮动交易面板调用以获取商品信息。
结果是具有以下数据的对象：
对象具有 `min`, `max` and `step` 指定数量字段步骤和边界的字段“min”，“max”和“step”。

* `qty` - object with fields `min`, `max` and `step` 它指定数量字段的步骤和边界。
* `pipSize` - 大小为1个点数（例如，欧元兑美元0.0001）
* `pipValue` - 帐户货币为1点的价值\（例如，美元兑换EURUSD的1美元）
* `minTick` - 最低价格变动\（例如，EURUSD \ 0.00001）。 它用于价格领域。
* `description` - 要在对话框中显示的说明
* `type` - 仪器类型，只有“forex”事项 - 它可以在订单对话框中进行负点检查

#### accountInfo\(\) : Deferred \(or Promise\)

内部订单对话框调用此方法获取帐户信息。

现在应该只返回一个字段：
1。currencysign：字符串 - 这是一个帐户币值的符号

#### subscribePL\(positionId\)

如果`supportPLUpdate` 配置标志为`true`，则应该执行方法。
由于该方法被经纪人调用，通过\ [\ [plUpdate \ | Trading-Host \＃plupdatepositionid-pl \]]方法提供损益。

#### unsubscribePL\(positionId\)

如果`supportPLUpdate` 配置标志为`true`，则应该执行方法。
由于这种方法被经纪人调用，来停止提供损益。

#### subscribeEquity\(\)

如果您使用标准订单对话框并支持止损，则应执行方法。
这种方法被经纪人调用，\[\[equityUpdate\|Trading-Host\#equityupdateequity\]\] 

#### unsubscribeEquity\(\)

如果您使用标准订单对话框并支持止损，则应执行方法。
由于这种方法被经纪人导游，停止提供股权更新。

这就是它！

# See Also

* \[\[How to connect\|Widget-Constructor\#chart-trading\_controller\]\] your trading controller to the chart
* \[\[Trading Host\]\]



