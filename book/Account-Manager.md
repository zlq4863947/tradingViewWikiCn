# 账户管理器

---

![](/images/trading.png)此页面上的所有内容仅适用于\[\[交易终端](Trading-Terminal.md)\]\]。

帐户管理器是一个显示交易信息的交互式表格。

通常它有3个标签页：订单/持仓和帐户信息。

要创建帐户管理器，您需要描述每个标签页的列并提供数据。

备注 1. [Broker API](Broker-API.md)[supportCustomBottomWidget|Trading-Controller#configFlags]] 标志应被禁用，以显示客户经理。

备注 2. [[Trading Controller]] 应实现 [[accountManagerInfo](Broker-API.md|Trading-Controller#accountmanagerinfo)]]

## 帐户管理器Mete信息

此信息将返回 [[accountManagerInfo](Broker-API.md|Trading-Controller#accountManagerInfo)]].

### 帐户管理器头信息

帐户管理器头信息由经纪商的标题和帐户名或帐户列表组成。

##### accountTitle: String
##### accountsList: AccountInfo数组
##### account: 账户信息的[WatchedValue](WatchedValue.md)

`AccountInfo` 是一个只有`name`为必须键和对应值的对象。

1. `id` - 帐户ID
1. `name` - 账户名称
1. `currency` - 账户货币

如果未设置`currency`，则`USD`将用作默认值。

### 订单页

##### orderColumns: array of [[Column](|Account-Manager#column-description)]]

要在订单页面中显示的列的说明。
您可以显示[[order](|Trading-Objects-and-Constants.md#＃order)]]的任何字段，也可以将自己的字段添加到订单对象中并显示它们。

##### possibleOrderStatuses: array of [[OrderStatus](|Trading-Objects-and-Constants.md#orderstatus)]]
在订单过滤器中使用的可选状态列表。如果未设置，则使用默认列表。

#### hasHistoryColumns: array of [Column](#column-description)

如果存在
如果是 `true` ，将显示历史页面。 之前会话历史上的所有订单都将显示在历史记录中。

### historyColumnsSorting: [SortingParameters](#sortingparameters)

表的可选排序。 如果未设置，则表按第一列排序。

### 持仓页

##### positionColumns: array of [[Column](|Account-Manager#column-description)]]

您可以显示[[position](|Trading-Objects-and-Constants.md#＃position)]]的任何字段，或者将您自己的字段添加到位置对象并显示它们。

### 附加页面（例如帐户摘要）

##### pages: array of [[Page](|Account-Manager#page)]]
 
使用`pages`您可以向账户管理器添加新的tab页。每个选项卡都是一组列表。

#### Page

`Page` 是额外的账户管理器tab页说明。 它是一个包含以下字段的对象：

1. `id`: String

页面的唯一标识

2. `title`: String

页面标题。 显示在选项卡上。

3. `tables`: Array of [[Table|Account-Manager#table]]. 

可以在此选项卡中显示一个或多个表。

#### Table

您可以向[[Page](|Account-Manager#page)]]添加一个或多个表。
帐户摘要表metainfo是一个包含以下字段的对象：

1. `id`: String

唯一标识

2. `title`: String 

表的可选标题。

3. `columns`: array of [[Column](|Account-Manager#column-description)]]

4. `getData`: Promise

此方法用于请求表数据。 它返回promise（或Deferred）并接收它返回的数据数组。
每一行都是一个对象。 此对象的键是具有相应值的列名称。
有一个预定义的字段 `isTotalRow` 可以用来标记一个表的底部的一行。

5. `changeDelegate` : [[Delegate](Delegate.md)]

用于观察数据更改并更新表。 通过`fire`方法将新的账户管理器数据传递给delegate。

6. `initialSorting`: 具有以下属性的对象:
    - `columnId` - 将用于排序的列的`id`或`property`。
    - `asc` - （可选，默认为`false`） - 如果是`true`，则初始排序将按升序排列。

    `initialSorting` 是表的可选排序。 如果未设置，则表按第一列排序。

**注意**：如果表中有多行，并且想使用 `changeDelegate` 更新一行，请确保每行中都有 `id` 字段来标识它。
如果表中只有一行，则不是必须的。

### Formatters

##### customFormatters: 一组列格式的描述

可选数组定义自定义格式化。 每个描述都是一个包含以下字段的对象：

`name`: 唯一标识
`format(options)`: 用于格式化单元格值的方法。 `options` 是一个具有以下键的对象：
1. `value` - 要格式化的值
2. `priceFormatter` - 价格标准格式。 您可以使用`format(price)` 方法来设置价格的值。
3. `prevValue` - 可选字段。 它是一个以前的值，所以你可以相应地进行比较和格式化。如果当前列具有 `highlightDiff: true` key.
4. `row` - 具有当前行中所有键/值对的对象

### 列描述

帐户管理器描述中最有价值的部分是其列的描述。

##### label

列标题。 它将显示在表的标题行中。

##### className

可选的 `className` 被添加到每个值单元格的html标签。
您可以使用它来自定义表的样式。

以下是预定义类的列表：

| class名   |   描述  |
|--------------|----------------|
| tv-data-table__cell--symbol-cell | 商品字段的特殊格式化器 |
| tv-data-table__cell--right-align | 它将单元格值右对齐 |
| tv-data-table__cell--buttons-cell | 单元格按钮 |

##### formatter

用于格式化数据的格式化器。 如果没有设置 `formatter` ，则按照原样显示该值。
格式化器可以是默认的或者是定制的

以下是默认格式化程序列表：

| 名称 | 描述 |
| ---- | ----------- |
| symbol | 它用于商品字段。 它显示 `brokerSymbol` ，但是当您单击符号时，将 `symbol` 字段设置为图表。 `property`键被忽略。|
| side | 它用于显示方向：卖或买。 |
| type| 用于显示类型：限价/停损/限价停损/市价。 |
| formatPrice | 格式化价格 |
| formatPriceForexSup | 与 `formatPrice` 一样，但它使得价格的最后一个字符被上标。 只有当仪器的类型为 `forex` 时，它才起作用。|
| status | 格式化`status` |
| date | 显示日期或时间 |
| localDate | 显示的日期或时间在本地时区。 |
| fixed | 显示一个小数点后2位的数字。 |
| pips | 显示一个小数点后1位的数字。 |
| profit | 显示利润。它还添加了 `+`，分隔成千位，并设置红色或绿色的单元文本颜色。 |

有一些特殊的格式化程序用于向表中添加按钮：

`orderSettings`将修改/取消按钮添加到订单选项卡。 始终为此格式化程序将`modificationProperty`值设置为`status`。

`posSettings`将编辑/关闭按钮添加到位置/净位置选项卡

`tradeSettings`将编辑/关闭按钮添加到个人位置选项卡。 始终为此格式化程序将`modificationProperty`值设置为`canBeClosed`。

##### property

`property` 是用于获取显示数据对象的关键字。

##### sortProp

可选的 `sortProp` 是用于数据排序的数据对象的键。

##### modificationProperty

可选的 `modifyProperty` 是数据对象的一个关键字，它被用于修改。

##### notSortable

可选的 `notSortable` 可以设置为防止列的排序。

##### help

`help` 是列的提示字符串。

##### highlightDiff

`highlightDiff` 可以使用`formatPrice`和`formatPriceForexSup`格式化器来设置字段的更改。

##### fixedWidth
如果为`true`，则当数字数字减少时，列宽不会减小。

### supportedStatusFilters

订单状态的可选数字数组，仅应用于订单列。 如果可用，则该列将仅显示在状态过滤器的指定选项卡中。

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