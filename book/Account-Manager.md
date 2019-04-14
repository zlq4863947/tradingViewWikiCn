# 账户管理器

---

![](/images/trading.png) 此页面上的所有内容仅适用于[交易终端](Trading-Terminal.md)。

帐户管理器是一个显示交易信息的交互式表格。

它包含3个标签页：订单/持仓和帐户信息。

要创建帐户管理器，您需要提供每个标签页的列和数据。

备注1. [Broker API](Broker-API.md)应实现[accountManagerInfo](Broker-API.md#accountmanagerinfo)

## 帐户管理器Mete信息

[accountManagerInfo](Broker-API.md#accountManagerInfo)应返回以下信息。

### 帐户管理器标题信息

帐户管理器的标题包括经纪商名称和帐户名称或帐户列表。

##### accountTitle: String
##### accountsList: AccountInfo数组
##### account: 账户信息的[WatchedValue](WatchedValue.md)

`AccountInfo` 是以下属性的对象。

1. `id` - 帐户ID
1. `name` - 账户名称
1. `currency` - 账户货币

未设置`currency`时，默认值为`USD`。

## 订单页

### orderColumns: [列数组](#列描述)

要在`订单`页面上显示的列描述。

您可以显示[订单](Trading-Objects-and-Constants.md#＃order)上的任何字段，也可以将自己的字段添加到订单对象中并显示它们。

### orderColumnsSorting: [SortingParameters](#sortingparameters)

可选的表格排序。如未设置，则表格按第一列排序。

### possibleOrderStatuses: array of [OrderStatus](Trading-Objects-and-Constants.md#orderstatus)

订单过滤器中使用的可选状态列表。如未设置，则使用默认列表。

### hasHistoryColumns: array of [Column](#列描述)

如果存在，将显示历史记录页面。之前会话的所有订单都将显示在历史记录中。

### historyColumnsSorting: [SortingParameters](#sortingparameters)

可选的表格排序。如未设置，则表格按第一列排序。

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

2. `title`: String 表的可选标题。

3. `columns`: [列数组](#列描述)

4. `getData`: Promise

此方法用于请求表的数据。它返回promise（或Deferred）并解析它返回的数据数组。

每一行都是一个对象。此对象的属性值是与列名称一一对应。

预定义字段`isTotalRow`，可用于在表底部显示行的总数。

5. `changeDelegate` : [Delegate](Delegate.md)

此委托用于监视数据的变动并更新表。将新的用户管理器数据传递给委托的`fire`方法。

6. `initialSorting`: [SortingParameters](#sortingparameters)

可选的表格排序。如未设置，则表格按第一列排序。

**注意**：如果表中有多行，并且想使用 `changeDelegate` 更新一行，请确保每行中都有 `id` 字段来标识它。
如果表中只有一行，则不是必须的。

#### SortingParameters

具有以下属性的对象:
- `columnId` - 将用于排序的列的`id`或`property`。
- `asc` - (可选, 默认为 `false`) - 为`true`时,初始排序将按升序排列。

### Formatters

##### customFormatters: 列格式的描述数组

用于定义自定义格式器的可选数组。每个描述都是一个包含以下字段的对象：

`name`: 唯一标识
`format(options)`: 用于格式化单元格值的方法。 `options` 是一个具有以下键的对象：
1. `value` - 要格式化的值
2. `priceFormatter` - 价格标准格式。 您可以使用`format(price)` 方法来设置价格的值。
3. `prevValue` - 可选字段。 它是一个以前的值，所以你可以相应地进行比较和格式化。如果当前列具有 `highlightDiff: true` key.
4. `row` - 具有当前行中所有键/值对的对象

### 列描述

帐户管理器描述中最有价值的部分是其列的描述。

##### label

列标题。它将显示在表的标题行中。

##### className

可选的 `className` 被添加到每个值单元格的html标签。
您可以使用它来自定义表的样式。

以下是预定义类的列表：

| class名   |   描述  |
|--------------|----------------|
| `tv-data-table__cell--symbol-cell` | 商品字段的特殊格式化方法 |
| `tv-data-table__cell--right-align` | 它将单元格值右对齐 |
| `tv-data-table__cell--buttons-cell` | 单元格按钮 |

##### formatter

用于格式化数据的格式化方法。如果没有设置 `formatter`，则按照原样显示该值。
formatter可以是默认格式或自定义格式

以下是默认格式化的列表：

| 名称 | 描述 |
| ---- | ----------- |
| `symbol` | 用于商品字段。 它显示 `brokerSymbol`，当单击`symbol`时，图表会更加`symbol`字段而改变。`property`被忽略。|
| `side` | 用于显示交易方向：卖出或买入。 |
| `type`| 用于显示订单类型：限价/止损/限价止损/市价。 |
| `formatPrice` | 格式化价格 |
| `formatPriceForexSup` | 与 `formatPrice` 一样，但它使得价格的最后一个字符被上标。只有当合约的类型为 `forex` 时，它才起作用。|
| `status` | 格式化状态 |
| `date` | 显示日期或时间 |
| `localDate` | 显示本地日期或时间 |
| `fixed` | 显示2位小数点的数字。 |
| `pips` | 显示1位小数点的数字。 |
| `profit` | 显示利润。它还添加了 `+`，分隔成千位，并设置红色或绿色的单元文本颜色。 |

有一些特殊的格式化方法用于向表中添加按钮：

`orderSettings`将修改/取消按钮添加到订单选项卡。始终为此格式化方法将`modificationProperty`值设置为`status`。

`posSettings`将编辑/关闭按钮添加到仓位/净头寸选项卡

`tradeSettings`将编辑/关闭按钮添加到个人位置选项卡。始终为此格式化方法将`modificationProperty`值设置为`canBeClosed`。

##### property

`property` 是用于获取显示数据对象的关键字。

##### sortProp

可选的 `sortProp` 是用于数据排序的数据对象的键。

##### modificationProperty

可选的 `modifyProperty` 是数据对象的一个关键字，它被用于修改。

##### notSortable

可选的 `notSortable` 可以设置为防止列的排序。

##### help

`help` 列的提示字符串。

##### highlightDiff

`highlightDiff` 可以使用`formatPrice`和`formatPriceForexSup`格式化方法来设置字段的更改。

##### fixedWidth
如果为`true`，则当数字减少时，列宽不会减小。

### supportedStatusFilters

订单状态的可选数字数组，仅应用于订单列。如果可用，则该列将仅显示在状态过滤器的指定选项卡中。

以下是可能的订单状态列表：

- 0 - All
- 1 - Canceled
- 2 - Filled
- 3 - Inactive
- 5 - Rejected,
- 6 - Working

### 上下文菜单

#### contextMenuActions(e, activePageItems)

`e`: 浏览器传递的上下文对象

`activePageItems`: 当前页面的`ActionMetainfo`项目数组

可选方法以创建一个自定义上下文菜单。
它返回用`ActionMetainfo`数组解析的 `Promise`。
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE2NzE2MDMzODYsMTUwMTA5Mjk5MF19
-->