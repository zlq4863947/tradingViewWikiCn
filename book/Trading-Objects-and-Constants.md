# 交易对象和常量

---

![](/images/trading.png)此页面上的所有内容仅适用于[交易终端](Trading-Terminal.md)。

**注意：** 如果您使用TypeScript，您可以从`broker-api.d.ts`文件中导入本文的常量/接口/类型。

## 经纪商配置

### configFlags: object

这是一个应该在交易终端的构造函数中传递给[brokerConfig](Widget-Constructor.md#brokerConfig)的对象。每个字段应该有一个布尔值（`true`/`false`）:

* `supportReversePosition`

    *Default:* `false`

    是否支持反转持仓。
    如果经纪商不支持，图表将有反转按钮，但是它会发出反转订单。

* `supportClosePosition`

    *Default:* `false`

    是否支持平仓。
    如果经纪商不支持，图表将有平仓按钮，但它将发出平仓订单。

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

* `supportPositionBrackets`

    *Default:* `false`

    是否支持仓位的包围单。如果此标志为`true`，则图表将显示仓位的编辑按钮，并将`编辑持仓...`添加到仓位的上下文菜单中。

* `supportTradeBrackets`

    *Default:* `false`

    是否支持单一交易的包围单。 如果此标志为`true`，则图表将显示用于交易（单个持仓）的编辑按钮，并将`编辑持仓...`添加到交易的上下文菜单中。

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

* `cancellingBracketCancelsParentOrder`

    如果止损或止盈被取消，经纪商将取消主订单。

* `cancellingOnePositionBracketsCancelsOther`

    如果第一个保护订单被用户取消，经纪上也会取消第二个保护订单（止损或止盈）。

### durations: 对象数组

订单的到期选项列表。这是可选的。如果您不希望在订单窗口单中显示持续时间，请不要设置它。
对象具有以下键：`{ name, value, hasDatePicker?, hasTimePicker?, default? }`。

例子:

```javascript
durations: [
    { name: 'DAY', value: 'DAY' },
    { name: 'WEEK', value: 'WEEK', default: true },
    { name: 'GTC', value: 'GTC' }
];
```

### customNotificationFields: 对象数组

可选字段。如果您在显示通知时考虑到订单或仓位中的自定义字段，则可以使用它。

例如，如果在订单中有字段`additionalType`，并且希望图表在更改时显示通知，则应该设置：

```javascript
customNotificationFields: ['additionalType']
```

### orderDialogOptions

可选字段。包含订单窗口选项的对象。使用这些选项，您可以自定义订单窗口。

* `showTotal`: boolean

    使用此标志，您可以在订单窗口中的`订单信息`部分中将`Trade Value`更改为`Total`。

* `customFields`: (TextWithCheckboxFieldMetaInfo | CustomComboBoxMetaInfo)[];

    使用`customFields`，您可以向订单窗口添加其他输入字段。

例:

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

### customUI

此可选字段可用于您自己的标准订单窗口和添加保护对话框。
以下两个字段的值是交易终端调用以显示对话框的函数。每个函数都显示一个对话框并返回一个`Promise`对象，该对象应在操作完成或取消时解析。

**NOTE:** The returned ```Promise``` object should be resolved with either `true` or `false` value.
**注意：** 返回的`promise`对象应使用`true`或`false`进行解析。

```ts
customUI: {
    createOrderDialog?: (order: Order, focus?: OrderTicketFocusControl) => Promise<boolean>;
    createPositionDialog?: (position: Position | Trade, brackets: Brackets, focus?: OrderTicketFocusControl) => Promise<boolean>;
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

* `inputType`: 'ComboBox'
* `id`: string
* `title`: string
* `items`: CustomComboBoxItem[]

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
