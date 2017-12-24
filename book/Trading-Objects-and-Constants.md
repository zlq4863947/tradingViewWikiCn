# 交易对象和常量

---

![](/images/trading.png)此页面上的所有内容仅适用于\[\[交易终端\]\]。

**注意：** 如果您使用TypeScript，您可以从`broker-api.d.ts`文件中导入本文的常量/接口/类型。

## 经纪商配置

#### configFlags: object

这是一个应该在交易终端的构造函数中传递给[brokerConfig](/book/Widget-Constructor.md#brokerConfig)的对象。 每个字段应该有一个布尔值（`true` /`false`）：

* supportReversePosition

    经纪商支持反转头寸。
    如果经纪商不支持，图表将有反转按钮，但是它会发出反转订单。

* supportClosePosition

    经纪商支持平仓。
    如果经纪商不支持，图表将有平仓按钮，但它将发出平仓订单。

* supportReducePosition

    经纪商支持在没有订单的情况下更改头寸。

* supportPLUpdate

    经纪商支持持仓损益(PL)。如果经纪商本身计算利润/损失，则应在PL更改后立即调用[PLUpdate](Trading-Host.md#plupdatepositionid-pl)。 否则，图表将计算PL作为当前交易与仓位平均价格之差。

* supportOrderBrackets

    经纪商支持订单的包围单（止盈和止损）。 如果此标志为`true`，则图表将在图表和账户管理器中的订单编号和修改按钮中显示附加字段。

* supportPositionBrackets

    经纪商支持仓位的包围单（止盈和止损）。 如果此标志为`true`，则图表将显示位置的编辑按钮，并将`编辑头寸...`添加到仓位的上下文菜单中。

* supportTradeBrackets

    经纪商支持单一交易的包围单（止盈和止损订单）。 如果此标志为`true`，则图表将显示用于交易（单个头寸）的编辑按钮，并将`编辑头寸...`添加到交易的上下文菜单中。

* supportTrades

    经纪商支持单个头寸（交易）。如果设置为`true`，帐户管理器中将有两个选项卡：单个头寸和净头寸。

* requiresFIFOCloseTrades

    交易账户需要以先进先出顺序结算交易。

* supportCloseTrade

    单个头寸（交易）可以关闭。

* supportMultiposition

    支持多头寸防止创建反转头寸的默认实现。

* showQuantityInsteadOfAmount

  此标志可用于在订单对话框中将"Amount"更改为"Quantity"

* supportLevel2Data

    Level2数据用于DOM小部件。 应该执行`subscribeDepth`和`unsubscribeDepth`。

* supportStopLimitOrders

    此标志将止损限价订单类型添加到订单对话框。
    
* supportMarketBrackets
  使用这个标志你可以禁止市价单的包围单。 默认情况下启用。

* supportModifyDuration
    使用这个标志你可以修改现有订单的持续时间。 默认情况下它被禁用。

#### durations: array of objects

订单到期选项列表。 这是可选的。 如果您不希望持续时间显示在订单故障单中，请不要设置它。
对象有两个键: `{ name, value }`.

例子:

```
durations: [{ name: 'DAY', value: 'DAY' }, { name: 'GTC', value: 'GTC' }]
```

#### customNotificationFields: array of strings

可选字段。 如果您在显示通知时考虑到订单或仓位中的自定义字段，则可以使用它。

例如，如果在订单中有字段`additionalType`，并且希望图表在更改时显示通知，则应该设置：

```
customNotificationFields: ['additionalType']
```

## Order

描述一个订单。

* id : String
* symbol : String
* brokerSymbol : String. 如果经纪商商品代码与TV商品代码相同，则可以为空。
* type : [OrderType](Trading-Objects-and-Constants.md#ordertype)
* side : [Side](Trading-Objects-and-Constants.md#side)
* qty : Double
* status : [OrderStatusSide](Trading-Objects-and-Constants.md#orderstatus)
* limitPrice : double
* stopPrice : double
* avg_price : double
* filledQty : double
* parentId : String. 如果订单是一组parentOrderId应该包含基本订单/仓位ID。
* parentType: [ParentType](Trading-Objects-and-Constants.md#parenttype)

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

用于描述包围单所有者的字符串常量。

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