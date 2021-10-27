# 交易对象和常量

---

![](/images/trading.png)此页面上的所有内容仅适用于[交易终端](Trading-Terminal.md)。

**注意：** 如果您使用TypeScript，您可以从`broker-api.d.ts`文件中导入本文的常量/接口/类型。

## 经纪商配置

### configFlags: object

这是一个应该在交易终端的构造函数中传递给[brokerConfig](Widget-Constructor.md#broker_config)的对象。每个字段应该有一个布尔值（`true`/`false`）:

* `supportReversePosition`

    *Default:* `false`

    是否支持反转持仓。
    如果经纪商不支持，图表将有反转按钮，但是它会发出反向订单。

* `supportNativeReversePosition`

  *Default:* `false`

    经纪商是否原生支持反转持仓。
    如果经纪商本身不支持它，图表库将发出反向订单。

* `supportClosePosition`

    *Default:* `false`

    是否支持平仓。
    如果经纪商不支持，图表将有平仓按钮，但它将发出平仓订单。

* `supportPartialClosePosition`

    *Default:* `false`

    经纪商是否支持部分平仓。

* `supportPartialCloseTrade`

    *Default:* `false`

    经纪商是否支持部分关闭交易。
  
* `supportReducePosition`

    *Default:* `false`

    是否支持在没有订单的情况下更改持仓。

* `supportPLUpdate`

    *Default:* `false`

    是否支持持仓损益(PL)。如果经纪商本身计算利润/损失，则应在PL更改后立即调用[PLUpdate](Trading-Host.md#plupdatepositionid-pl)。否则，图表将通过当前交易与仓位平均价格之差计算PL。

* `supportMargin`

    *Default:* `false`

    是否支持保证金。如果支持保证金，当交易终端使用[subscribeMarginAvailable](Broker-API.md#subscribemarginavailable)订阅时，应该调用[marginAvailableUpdate](Trading-Host.md#marginavailableupdatemarginavailable)。

* `supportOrderBrackets`

    *Default:* `false`

    是否支持订单的包围单。如果此标志为`true`，则图表将显示附加字段在图表和账户管理器中的订单窗口和修改按钮中。

* `supportCryptoBrackets`

    *Default:* `false`
  
    是否支持加密货币的包围单（止盈和止损）。
    如果此标志设置为 `true`，图表将在订单单中显示其他字段。

* `supportPositionBrackets`

    *Default:* `false`

    是否支持仓位的包围单。如果此标志为`true`，则图表将显示仓位的编辑按钮，并将`编辑持仓...`添加到仓位的上下文菜单中。

* `supportTradeBrackets`

    *Default:* `false`

    是否支持单一交易的包围单。 如果此标志为`true`，则图表将显示用于交易（单个持仓）的编辑按钮，并将`编辑持仓...`添加到交易的上下文菜单中。


* `supportTrailingStop`

    *Default:* `false`

    是否支持追踪止损单。
    如果此标志设置为 `true`，则图表显示追踪止损订单，用户可以使用订单对话框设置追踪止损订单。

* `supportPositions`

    *Default:* `true`
  
    是否支持持仓。
    如果设置为 `false`，则账户管理器中的持仓选项卡将被隐藏。
  
* `supportTrades`

    *Default:* `false`
  
    是否支持单个持仓（交易）。如果设置为`true`，帐户管理器中将有两个选项卡：单个持仓和净持仓。

* `requiresFIFOCloseTrades`

    *Default:* `false`

    是否交易账户需要以先进先出顺序结算交易。

* `supportCloseTrade`

    *Default:* `false`

    是否支持单个持仓（交易）的关闭。

* `supportMultiposition`

    *Default:* `false`

    是否支持多持仓,防止创建反转持仓的默认实现。

* `showQuantityInsteadOfAmount`

    *Default:* `false`

    是否将`Amount`更改为`Quantity`

* `supportCryptoExchangeOrderTicket`

    *Default:* `false`
  
    账户是否用于兑换（交易）加密货币。
    此标志将订单对话框切换到加密货币交易所模式。它增加了第二个货币数量控制，货币标签等。

* `supportLevel2Data`

    *Default:* `false`

    是否支持Level2数据用于DOM小部件。应实现`subscribeDepth`和`unsubscribeDepth`方法。

* `supportMarketOrders`

    *Default:* `true`

    是否支持将市价订单添加到订单对话框。

* `supportLimitOrders`

    *Default:* `true`

    是否支持将限价订单添加到订单对话框。

* `supportStopOrders`

    *Default:* `true`

    是否支持将止损订单添加到订单对话框。

* `supportStopOrdersInBothDirections`

  *Default:* `false`

  止损订单是否应该在两个方向上都像 Market-if-touched(触价指令) 一样。 启用此标志将从订单对话框中删除方向检查。

* `upportStopLimitOrders`

    *Default:* `true`

    是否支持将止损限价订单添加到订单对话框。

* `upportStopLimitOrders`

    *Default:* `true`

    是否支持将止损限价订单添加到订单对话框。
    
* `supportMarketBrackets`

    *Default:* `true`

    是否支持将市价包围订单添加到订单对话框。

* `supportModifyDuration`

    *Default:* `false`

    是否支持修改现有订单的持续时间。默认情况下它被禁用。

* `supportModifyOrder`

    *Default:* `true`

    是否支持修改现有订单。 它默认启用。

* `supportModifyTrailingStop`

  *Default:* `true`

  经纪商是否支持修改追踪止损单。

* `supportAddBracketsToExistingOrder`

  *Default:* `true`

  使用此标志，您可以禁用向现有订单添加包围单。

* `supportBalances`

  *Default:* `false`

  仅用于加密货币。允许获取帐户的加密货币余额。余额显示在 "帐户摘要" 选项卡的第一个表格。

* `supportDisplayBrokerNameInSymbolSearch`

  *Default:* `true`

  是否在交易商品搜索中显示经纪商交易商品名称。如果经纪商交易商品相同或者您使用内部数字作为经纪商交易商品名称，您通常可能希望禁用它。

* `supportCancellingBothBracketsOnly`

  *Default:* `false`

  取消包围单（止盈或止损）会取消它的1对组合订单。

* `supportPlaceOrderPreview`

  *Default:* `false`

  经纪商在下单前提供预估的佣金、费用、保证金等订单信息，但并未实际下单。

* `supportModifyOrderPreview`

  *Default:* `false`

  经纪商在修改订单前提供预估的佣金、费用、保证金等订单信息，无需实际修改。

* `supportOrdersHistory`

  *Default:* `false`

  经纪商是否支持订单历史记录。如果设置为 `true`，则帐户管理器中将有一个附加选项卡 - 订单历史记录。
  应该实现`ordersHistory` 方法。它应该返回一个订单列表，其中包含之前交易时段的`filled`, `cancelled` 和 `rejected`状态的订单。

* `closePositionCancelsOrders`

  *Default:* `false`

  平仓会取消它的包围单。

* `supportOnlyPairPositionBrackets`

    *Default:* `false`

    `Stop Loss` 和 `Take Profit` 只能一起添加或删除。

* `durationForMarketOrders`

  *Default:* `false`

  经纪商支持市价单的持续时间。 如果设置为 `true`，则将显示市价单的持续时间控件。

* `showNotificationsLog`

  *Default:* `true`

  使用此标志，您可以显示/隐藏帐户管理器中的 `通知日志` 选项卡。
  
* `positionPLInInstrumentCurrency`

  *Default:* `false`

  使用此标志，您可以以期货货币显示 PL。

* `supportConfirmations`

  *Default:* `false`

  使用此标志，您可以显示一个复选框以禁用确认对话框显示。

* `supportExecutions`

  *Default:* `false`

  经纪人支持执行。
  如果此标志设置为 `true` ，则图表将显示执行情况。

### durations: 对象数组

订单到期选项列表。它是可选的。如果您不想在订单对话框中显示持续时间，请不要设置它。
对象具有以下属性：`{ name, value, hasDatePicker?, hasTimePicker?, default? }`。

* `name`: String. 持续时间的本地化标题。标题将显示在订单对话框的持续时间控件中。
* `value`: String. 持续时间标识符。
* `hasDatePicker`: Boolean. 如果它被设置为`true`，那么此持续时间类型的订单对话框中的显示日期控件将被显示。
* `hasTimePicker`: Boolean. 如果设置为“true”，则订单对话框中此持续时间类型的显示时间控件将被显示。
* `default`: Boolean. 默认持续时间。持续时间数组中只有一个持续时间对象可以具有此字段的`true`值。 当用户在静默模式下下订单时将使用默认持续时间，当用户第一次打开订单对话框时将使用默认持续时间。
* `supportedOrderTypes`: [OrderType](#ordertype) 数组。此持续时间类型将显示在订单对话框的持续时间控件中的订单类型列表。

例子:

```javascript
durations: [{ name: 'DAY', value: 'DAY' }, { name: 'WEEK', value: 'WEEK', default: true }, { name: 'GTC', value: 'GTC' }, { name: 'FOK', value: 'FOK', supportedOrderTypes: [OrderType.Market] }]
```

### customNotificationFields: 对象数组

可选字段。如果您在显示通知时考虑到订单或仓位中的自定义字段，则可以使用它。

例如，如果在订单中有字段`additionalType`，并且希望图表在更改时显示通知，则应该设置：

```javascript
customNotificationFields: ['additionalType']
```

### customUI

此可选字段可用于将标准订单对话框和添加保护对话框替换为您自己的对话框。
以下两个字段的值是交易终端调用以显示对话框的函数。每个函数显示一个对话框并返回一个 ```Promise``` 对象，该对象应该在操作完成或取消时解析。

**注意：** 返回的 ```Promise``` 对象应该使用 `true` 或 `false` 值解析。

```ts
customUI: {
    showOrderDialog?: (order: Order, focus?: OrderTicketFocusControl) => Promise<boolean>;
    showPositionDialog?: (position: Position | Trade, brackets: Brackets, focus?: OrderTicketFocusControl) => Promise<boolean>;
}
```

## Order

描述单个订单。

* `id` : String
* `symbol` : String
* `brokerSymbol` : String. 如果经纪商商品代码与TV商品代码相同，可以为空。
* `type` : [OrderType](#ordertype)
* `side` : [Side](#side)
* `qty` : double
* `status` : [OrderStatus](#orderstatus)
* `limitPrice` : double
* `stopPrice` : double
* `avgPrice` : double
* `filledQty` : double
* `parentId` : String. 如果订单是包围单，则parentOrderId应该包含基本订单/仓位的ID。
* `parentType`: [ParentType](#parenttype)
* `duration`: [OrderDuration](#orderduration)
* `customFields`: [CustomInputFieldsValues](#custominputfieldsvalues)

## Position

描述单个仓位。

* `id`: String. 通常id应等于brokerSymbol
* `symbol` : String
* `brokerSymbol` : String. 如果经纪商商品代码与TV商品代码相同，可以为空。
* `qty` : 正数
* `side`: [Side](#side)
* `avgPrice` : number

## Trade

描述单笔交易（个别仓位）。

* `id`: String. 通常id应等于brokerSymbol
* `symbol`: String
* `date`: number (UNIX时间戳，毫秒单位)
* `brokerSymbol` : String. 如果经纪商商品代码与TV商品代码相同，可以为空。
* `qty`: 正数
* `side`: [Side](#side)
* `price`: number

## Execution

描述单个执行。执行是图表上显示交易信息的标记。

* `symbol` : String
* `brokerSymbol` : String. 如果经纪商商品代码与TV商品代码相同，则可以为空。
* `price` : number
* `time`: Date
* `side` : [Side](#side)
* `qty` : number


## ActionMetainfo

描述一个操作将其放入下拉菜单或菜单中。它有如下结构:

* `text` : String
* `checkable` : Boolean. 如果需要复选框，将其设置为true。
* `checked` : Boolean
* `enabled`: Boolean
* `action`: function. 当用户单击该项目时执行的方法。它有一个参数 - 复选框的值（如果存在）。

## OrderPreviewSection

描述单个订单预览部分。订单预览可以有多个由分隔符分隔的部分，并且可能有标题。

* `rows` - 订单预览项数组 [OrderPreviewSectionRow](#OrderPreviewSectionRow)[]。每一项都是.section表的一行。
* `header` - 部分的可选标题。

## OrderPreviewSectionRow

OrderPreviewSectionRow - 描述订单预览的section表的单行。

* `title` - 项目的描述。
* `value` - 项目的格式化值。
* 
## OrderType

用于描述订单状态的字符串常量。

```javascript
OrderType.Limit = 1
OrderType.Market = 2
OrderType.Stop = 3
OrderType.StopLimit = 4
```

## Side

用于描述订单/交易执行方向的字符串常量。

```javascript
Side.Buy = 1
Side.Sell = -1
```


## ParentType

用于描述包围单类型的字符串常量。

```javascript
ParentType.Order = 1
ParentType.Position = 2
```

## OrderStatus

用于描述订单状态的字符串常量。

```JavaScript
// 订单被取消
OrderStatus.Canceled = 1
// 订单已完全执行
OrderStatus.Filled = 2
// 创建了包围单，但等待基本订单全部成交
OrderStatus.Inactive = 3
// 提交订单中
OrderStatus.Placing = 4
// 由于某种原因拒绝订单
OrderStatus.Rejected = 5
// 已创建订单但尚未执行
OrderStatus.Working = 6
```

## OrderDuration

订单的持续时间或到期时间。

* `type`：传递给[durations](#orderduration)列表中的字符串标识符
* `datetime`number

## DOMEObject

描述单个DOM响应的对象。

* `snapshot`: Boolean
正值意味着以前的数据应该被清理

* `asks`: DOMELevel数组按价格按升序排序
* `bids`: DOMELevel数组按价格按升序排序

## DOMELevel

单个DOM价格level对象。

* `price`: number
* `volume`: number

## OrderTicketFocusControl

打开标准`订单`对话框或`仓位`对话框时用于设置焦点的常量。

```JavaScript
// 设置焦点到止损控制
OrderTicketFocusControl.StopLoss = 1
// 设置焦点到止损价格
OrderTicketFocusControl.StopPrice = 2
// 设置焦点到获利控制
OrderTicketFocusControl.TakeProfit = 3
```

## Brackets

# `stopLoss`: number
# `takeProfit`: number

## Formatter

具有`format`方法的对象可用于将数字格式化为字符串。

## CustomInputFieldsValues

包含特定于代理的用户输入结果的对象（例如数字签名）。
自定义字段有两种可能的值：带有复选框的输入字段和自定义组合框。

```javascript
{
    [fieldId: string]: TextWithCheckboxValue | string
}
```

`TextWithCheckboxValue` 是一个用于带有复选框的输入字段的对象，它有两个属性:

* `text`: string
* `checked`: boolean

自定义组合框的结果始终是用户输入的`字符串`。

## TextWithCheckboxFieldMetaInfo

描述带有复选框的自定义输入字段的对象。

* `inputType`: 'TextWithCheckBox'
* `id`: string
* `title`: string
* `placeHolder?`: string
* `value`: TextWithCheckboxValue
* `validator?`: (value: string) => PositiveBaseInputFieldValidatorResult | NegativeBaseInputFieldValidatorResult
* `customInfo`: TextWithCheckboxFieldCustomInfo

## TextWithCheckboxValue

包含复选框的自定义输入字段初始值的对象。

* `text`: string
* `checked`: boolean

## TextWithCheckboxFieldCustomInfo

使用复选框描述自定义输入字段的其他设置的对象。
使用`asterix`属性可以管理输入类型。如果`asterix`设置为`true`，则将呈现密码输入。

* `checkboxTitle`: string
* `asterix`: boolean

## CustomComboBoxMetaInfo

描述自定义组合框的对象。
如果将 `saveToSettings` 设置为 `true`，则 ComboBox 的值将被保存并在您下次打开订单对话框或面板时用作默认值。

* `inputType`: 'ComboBox'
* `id`: string
* `title`: string
* `items`: CustomComboBoxItem[]
* `saveToSettings?`: boolean

## CustomComboBoxItem

描述自定义组合框的项目的对象。

* `text`: string
* `value`: string

## PositiveBaseInputFieldValidatorResult

描述正数验证结果的对象。

* `valid`: true

## NegativeBaseInputFieldValidatorResult

描述负数验证结果的对象。

* `valid`: false
* `errorMessage`: string

## PlaceOrderResult

描述下单结果的对象。

* `orderId`: string

## QuantityMetainfo

描述数量字段的步长和边界的对象。

* `min`: number
* `max`: number
* `step`: number
* `uiStep?`: number. 滚动的步长。
* `default?`: number. 这是一个默认的数量值。
