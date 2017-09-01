交易控制器

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

  经纪人提供PL的头寸。 如果经纪商自己计算利润/损失，它应该调用 \[\[plUpdate\|Trading-Host\#plupdatepositionid-pl\]\] 一旦PL改变了。 否则图表将计算PL作为当前交易与头寸平均价格之间的差额。

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

#### 头寸 : [Deferred](https://api.jquery.com/category/deferred-object/)

#### 订单 : [Deferred](https://api.jquery.com/category/deferred-object/)

#### 执行信号\(symbol\) : [Deferred](https://api.jquery.com/category/deferred-object/)

图表调用这些方法来请求位置/订单/执行并在图表上显示它们。  
您应该返回相应的列表\[\[positions\|Trading-Objects-and-Constants\#position\]\], \[\[orders\|Trading-Objects-and-Constants\#order\]\] or \[\[executions\|Trading-Objects-and-Constants\#execution\]\]

#### supportFloatingPanel\(\)

Function should return `true` for Floating Trading Panel to be displayed.

#### supportBottomWidget\(\)

Function should return `true` for Bottom Trading Panel to be displayed.

#### chartContextMenuItems\(e\)

Chart can have a sub-menu `Trading` in the context menu. Return the list of items for a sub-menu. Format is the same as for `buttonDropdownItems`.

`e` is a context object passed by a broswer

#### bottomContextMenuItems\(\)

Bottom Trading Panel can have a context menu. Return a list of items for this menu. Format is the same as for `buttonDropdownItems`.

#### isTradable\(symbol\)

This function is required for the Floating Trading Panel. Ability to trade via the panel depends on the result of this function: `true` or `false`. You don't need to imlement this method if all the symbols can be traded.

#### createBottomWidget\(container\)

This function is called when it is needed to create a Bottom Trading Panel. You should create DOM object and append it to the `container`. The container shows a vertical scroll bar when it is needed.

#### accountManagerInfo\(\)

This function is called when supportCustomBottomWidget is false. It should return information that will be used to build an account manager.  
See \[\[Account Manager\]\] for more information.

#### showOrderDialog\(\[\[order\|Trading-Objects-and-Constants\#order\]\]\)

This function is invoked by the chart when user requests to create or modify an order.

So we give you the ability to use your own dialog and it's 100% up to you how to manage it.

#### placeOrder\(\[\[order\|Trading-Objects-and-Constants\#order\]\], silently\)

Method is invoked when a user want to place an order. Order is pre-filled with partial or full information.  
If `silently` is `true` no order dialog show be shown.

#### modifyOrder\(\[\[order\|Trading-Objects-and-Constants\#order\]\], silently, focus\)

1. `order` is an order object to modify
2. `silently` - if it is `true` no order dialog show be shown
3. `focus` - \[\[Focus constant\|Trading-Objects-and-Constants\#focusoptions\]\]. It can be already initialized by the chart.

Method is invoked when a user want to modify an existing order.

#### cancelOrder\(orderId, silently\)

This method is invoked to cancel single order with given `id`.  
If `silently` is `true` no dialogs show be shown.

#### cancelOrders\(symbol, side, ordersIds, silently\)

1. `symbol` - symbol string
2. `side`: `"sell"` or `"buy"`
3. `ordersIds` - ids already collected by `symbol` and `side`
   If `silently` is `true` no dialogs show be shown.

This method is invoked to cancel multiple orders for a `symbol` and `side`.

#### editPositionBrackets\(positionId, focus\)

This method is invoked if `supportBrackets` configuration flag is on to display a dialog for editing of take profit and stop loss.  
1. `positionId` is ID of existing position to be modified  
2. `focus` - \[\[Focus constant\|Trading-Objects-and-Constants\#focusoptions\]\].

#### closePosition\(positionId, silently\)

This method is invoked if `supportClosePosition` configuration flag is on to close the position by id.  
If `silently` is `true` no dialogs show be shown.

#### reversePosition\(positionId, silently\)

This method is invoked if `supportReversePosition` configuration flag is on to reverse the position by id.  
If `silently` is `true` no dialogs show be shown.

#### symbolInfo\(symbol\) : Deferred \(or Promise\)

1. `symbol` - symbol string

This method is invoked by the internal Order Dialog, DOM panel and floating trading panel to get symbol information.  
Result is an object with the following data:

* `qty` - object with fields `min`, `max` and `step` that specifies Quantity field step and boundaries.
* `pipSize` - size of 1 pip \(e.g., 0.0001 for EURUSD\)
* `pipValue` - values of 1 pip in account currency \(e.g., 1 for EURUSD for an account in USD\)
* `minTick` - minimal price change \(e.g., 0.00001 for EURUSD\). It is used for price fields.
* `description` - a description to be displayed in the dialog
* `type` - instrument type, only `forex` matters - it enables negative pips check in the order dialog

#### accountInfo\(\) : Deferred \(or Promise\)

This method is invoked by the internal Order Dialog to get account information.  
It should return only one field for now:  
1. currencySign: string - which is a sign of acccount currency

#### subscribePL\(positionId\)

Method should be implemented if `supportPLUpdate` config flag is `true`.  
Since this method is called the broker should provide profit/loss via \[\[plUpdate\|Trading-Host\#plupdatepositionid-pl\]\] method.

#### unsubscribePL\(positionId\)

Method should be implemented if `supportPLUpdate` config flag is `true`.  
Since this method is called the broker should stop providing profit/loss.

#### subscribeEquity\(\)

Method should be implemented if you use standard order dialog and support stop loss.  
Since this method is called the broker should provide equity updates via \[\[equityUpdate\|Trading-Host\#equityupdateequity\]\] method.

#### unsubscribeEquity\(\)

Method should be implemented if you use standard order dialog and support stop loss.  
Since this method is called the broker should stop providing equity updates.

And this is it !

# See Also

* \[\[How to connect\|Widget-Constructor\#chart-trading\_controller\]\] your trading controller to the chart
* \[\[Trading Host\]\]



