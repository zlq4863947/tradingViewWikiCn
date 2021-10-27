# 账户管理器

---

![](/images/trading.png) 此页面上的所有内容仅适用于[交易终端](Trading-Terminal.md)。

帐户管理器是一个显示交易信息的交互式表格。

它包含3个标签页：订单/持仓和帐户信息。

要创建帐户管理器，您需要提供每个标签页的列和数据。

备注1. [Broker API](Broker-API.md)应实现[accountManagerInfo](Broker-API.md#accountmanagerinfo)

## 帐户管理器Mete信息

[accountManagerInfo](Broker-API.md#accountManagerInfo)应返回以下信息。

### 帐户管理器标头

帐户管理器标头包括经纪商名称。

##### accountTitle: String

## 订单页

### orderColumns: [列对象](#列描述)数组

要在`订单`页面上显示的列描述。

您可以显示[订单](Trading-Objects-and-Constants.md#＃order)上的任何字段，也可以将自己的字段添加到订单对象中并显示它们。

### orderColumnsSorting: [SortingParameters](#sortingparameters)

表格的可选排序。

### possibleOrderStatuses: [OrderStatus](Trading-Objects-and-Constants.md#orderstatus)数组

订单过滤器中使用的可选状态列表。如未设置，则使用默认列表。

### hasHistoryColumns: [列对象](#列描述)数组

如果存在，将显示历史记录页面。之前会话的所有订单都将显示在历史记录中。

### historyColumnsSorting: [SortingParameters](#sortingparameters)

表格的可选排序。

### 持仓页

##### positionColumns: [列数组](#列描述)

您可以显示[仓位](Trading-Objects-and-Constants.md#position)的任何字段，或者将您自己的字段添加到仓位对象中并显示它们。

### 附加页面（例如: 帐户摘要）

##### pages: [页面数组](#page)
 
您可以使用`pages`在帐户管理器中添加新的tab页。每个tab都是一组表。

#### Page

`Page` 是对额外的账户管理器tab页的说明。它是包含以下字段的对象：

1. `id`: String 页面的唯一标识

2. `title`: String 页面标题。显示在tab选项卡上。

3. `tables`: [Table数组](#table).

可以在此tab选项卡中显示一个或多个表。

#### Table

您可以向[Page](#page)添加一个或多个表。
帐户摘要表metainfo是一个包含以下字段的对象：

1. `id`: String 唯一标识

1. `title`: String 表的可选标题。

1. `columns`: [列数组](#列描述)

1. `getData`: Promise

此方法用于请求表的数据。它返回promise（或Deferred）并解析它返回的数据数组。

每一行都是一个对象。此对象的属性值是与列名称一一对应。

预定义字段`isTotalRow`，可用于在表底部显示行的总数。

1. `changeDelegate` : [Delegate](Delegate.md)

此委托用于监视数据的变动并更新表。将新的用户管理器数据传递给委托的`fire`方法。

1. `initialSorting`: [SortingParameters](#sortingparameters)

表格的可选排序。

**注意**：请确保每行中都有唯一 `id` 字段来标识它。

#### SortingParameters

具有以下属性的对象:
- `columnId` - 将用于排序的列的`property`。
- `asc` - (可选, 默认为 `true`) - 为`false`时,初始排序将按将序排列。

### 列描述

帐户管理器描述中最有价值的部分是列描述。

##### label

列标题。它将显示在表的标题行中。

##### alignment
单元格值的水平对齐方式。 默认值为 `left` 。

| 对齐| 说明 |
|--------------|----------------|
| left | 它将单元格值左对齐 |
| right| 它将单元格值向右对齐 |

##### formatter

用于格式化数据的格式化方法。如果没有设置 `formatter`，则按照原样显示该值。
formatter可以是默认格式或自定义格式

以下是默认格式化的列表：

| 名称 | 描述 |
| ---- | ----------- |
| `date` | 显示日期或时间。 |
| `dateOrDateTime` | 显示日期或日期和时间。这个格式化程序接受一个对象`{value: number, hasTime: boolean}`。如果`hasTime` 设置为`true`，则显示日期和时间。否则只显示日期。|
| `fixed` | 显示一个带有 2 个小数位的数字。 |
| `formatPrice` | 格式化商品价格 |
| `formatQuantity` | 显示整数或浮点数，用空格分隔千分位。 |
| `formatPriceForexSup` | 与 `formatPrice` 一样，但它使得价格的最后一个字符被上标。只有当合约的类型为 `forex` 时，它才起作用。|
| `localDate` | 显示本地日期或时间 |
| `localDateOrDateTime` | 与 `dateOrDateTime` 相同，但它显示本地时区的时间。 |
| `pips` | 显示1位小数点的数字。 |
| `profit` | 显示利润。它还添加了 `+`，分隔成千位，并设置红色或绿色的单元文本颜色。 |
| `profitInInstrumentCurrency` | 以期货的货币显示利润。它还添加了 `+` 号，分隔千位并将单元格文本颜色更改为红色或绿色。 |
| `side` | 用于显示交易方向：卖出或买入。 |
| `positionSide` | 用于显示持仓方：空头或多头。 |
| `status` | 格式化状态 |
| `symbol` | 用于商品字段。 它显示 `brokerSymbol`，当单击`symbol`时，图表会更加`symbol`字段而改变。`property`被忽略。|
| `text` | 显示文本值。 |
| `textNoWrap` | 显示没有自动换行的文本值。 |
| `type`| 用于显示订单类型：限价/止损/限价止损/市价。 |
| `variablePrecision` | 显示具有可变精度的数字。 |

有一些特殊的格式化方法用于向表中添加按钮：

`orderSettings`将修改/取消按钮添加到订单选项卡。

`posSettings`将编辑/关闭按钮添加到仓位/净头寸选项卡

`tradeSettings`将编辑/关闭按钮添加到个人头寸选项卡。

##### property

`property` 是用于获取显示数据对象的关键字。

##### sortProp

可选的 `sortProp` 是用于数据排序的数据对象的键。

##### notSortable

可选的 `notSortable` 可以设置为防止列的排序。

##### help

`help` 列的提示字符串。

##### highlightDiff

`highlightDiff` 可以使用`formatPrice`和`formatPriceForexSup`格式化方法来设置字段的更改。

### tooltipProperty

`tooltipProperty` 是行对象的键，用于在将鼠标悬停在单元格上时显示工具提示。 tooltip 属性是指一个对象，其键是属性名称，值是相应的工具提示。

### supportedStatusFilters

订单状态的可选数字数组，仅应用于订单列。如果可用，则该列将仅显示在状态过滤器的指定选项卡中。

以下是可能的订单状态列表：

- 0 - All
- 1 - Canceled
- 2 - Filled
- 3 - Inactive
- 5 - Rejected,
- 6 - Working

### isCapitalize

如果为 `true`，则列中句子中每个单词的第一个字符将大写。 默认值为 `true`。

### showZeroValues

如果它是 `false`，零值将被隐藏。 默认值为 `true`。

### 上下文菜单

#### contextMenuActions(contextMenuEvent, activePageItems)

`e`: 浏览器传递的上下文对象
`contextMenuEvent`：浏览器传递的 MouseEvent 或 TouchEvent 对象

`activePageActions`：当前页面的 `ActionMetaInfo` 项数组

创建自定义上下文菜单的可选函数。
它应该返回用 `ActionMetaInfo` 数组解析的 `Promise`。
