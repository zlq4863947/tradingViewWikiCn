# [JS Api](#js-api)

---

**这是啥?** 一套JS方法（以实现指定的公共接口）。  
**我该怎么使用它?**: 您应该创建一个JS对象，它将以某种方式接收数据，并响应图表库的请求。

在图表库中实现了数据缓存（历史和商品信息）。当您创建一个实现接口的对象时，只需将它传递给图表库[Widget的构造函数](/book/Widget-Constructor.md)。

# [Methods](#methods)

1. [onReady](#onreadycallback)
2. [searchSymbols](#searchsymbolsuserinput-exchange-symboltype-onresultreadycallback)
3. [resolveSymbol](#resolvesymbolsymbolname-onsymbolresolvedcallback-onresolveerrorcallback)
4. [getBars](#getbarssymbolinfo-resolution-periodparams-onhistorycallback-onerrorcallback)
5. [subscribeBars](#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback)
6. [unsubscribeBars](#unsubscribebarssubscriberuid)
7. [getMarks](#getmarkssymbolinfo-startdate-enddate-ondatacallback-resolution)
8. [getTimescaleMarks](#gettimescalemarkssymbolinfo-startdate-enddate-ondatacallback-resolution)
9. [getServerTime](#getservertimecallback)
10. [getVolumeProfileResolutionForPeriod](#getvolumeprofileresolutionforperiodcurrentresolution-from-to-symbolinfo)

![](../images/trading.png)[交易终端专属](#交易终端专属):

1. [getQuotes](#getquotessymbols-ondatacallback-onerrorcallback)
2. [subscribeQuotes](#subscribequotessymbols-fastsymbols-onrealtimecallback-listenerguid)
3. [unsubscribeQuotes](#unsubscribequoteslistenerguid)
4. [subscribeDepth](#subscribedepthsymbolinfo-callback-string)
5. [unsubscribeDepth](#unsubscribedepthsubscriberuid)

### [onReady\(callback\)](#onreadycallback)

1. `callback`: function(configurationData)
   1. `configurationData`: object (见下文)

此方法可以设置图表库支持的图表配置。这些数据会影响到图表支持的功能，所以它被称为[服务端定制](Customization-Overview.md#customization-done-through-data-stream)。

图表库要求您使用回调函数来传递datafeed的 `configurationData`参数。

configurationData是一个对象，现在支持以下属性:

##### [exchanges](#exchanges)

交易所对象数组。 交易所对象的结构为: `{value, name, desc}`。

`value`将被作为`exchange`参数传递给 [searchSymbols](#searchsymbolsuserinput-exchange-symboltype-onresultreadycallback)。

`exchanges = []`会导致商品查询列表中看不到交易所过滤器。`value = ""`来创建通配符筛选器（所有的交易所）。

##### [symbols\_types](#symbolstypes)

商品类型对象数组。商品类型对象的结构为: `{name, value}`。`value`将被作为`symbolType`参数传递给[searchSymbols](#searchsymbolsuserinput-exchange-symboltype-onresultreadycallback)。

`symbolsTypes`= \[\] 会导致商品查询列表中看不到商品类型过滤器。 使用`value= ""`来创建通配符筛选器（所有的商品类型）。

##### [supported\_resolutions](#supportedresolutions)

支持的周期数组，周期可以是数字或字符串。 如果周期是一个数字，它被视为分钟数。 字符串可以是“\*D”，“\*W”，“\_M”（\_的意思是任何数字）。格式化详细参照:[文章](/book/Resolution.md)。

`resolutions = undefined` 或 `resolutions = []` 时，周期拥有`widget`中的默认内容。

例:`[1, 15, 240, "D", "6M"]`您将在周期中得到 "1 分钟, 15 分钟, 4 小时, 1 天, 6 个月" 。

##### [currency\_codes](#currencycodes)

用于货币转换的支持的货币数组。

示例：[“USD”，“EUR”，“GBP”]。

#### [units](#units)

列出支持的单位组的对象。 每个组可以有多个单位对象。 每个单位对象应具有以下字段：

* `id`: string. 唯一主键
* `name`: string. 缩略名
* `description`: string. 简介

例子:

```javascript
{
    weight: [
        { id: 'kg', name: 'kg', description: 'Kilograms' },
        { id: 'lb', name: 'lb', description: 'Pounds'},
    ]
}
```

##### [supports\_marks](#supportsmarks)

布尔值来标识您的 datafeed 是否支持在K线上显示标记。

##### [supports\_timescale\_marks](#supportstimescalemarks)

布尔值来标识您的 datafeed 是否支持时间刻度标记。

##### [supports\_time](#supportstime)

将此设置为`true`假如您的datafeed提供服务器时间（unix时间）。 它仅用于在价格刻度上显示倒计时。

##### [symbols\_grouping](#symbolsgrouping)

如果要在商品搜索中对商品进行分组，请设置它。
值为一个对象，其中键是商品类型，值是正则表达式（每个正则表达式应该将一个期货名称分为两部分：合约种类和到期时间）。

例子:

```javascript
    {
      "futures": `/^(.+)([12]!|[FGHJKMNQUVXZ]\d{1,2})$/`,
      "stock": `/^(.+)([12]!|[FGHJKMNQUVXZ]\d{1,2})$/`,
    }
```

它将应用于 `type` 为 `futures` 和 `stock`的商品。


### [searchSymbols\(userInput, exchange, symbolType, onResultReadyCallback\)](#searchsymbolsuserinput-exchange-symboltype-onresultreadycallback)

1. `userInput`: string，用户在商品搜索框中输入的文字。
2. `exchange`:string，请求的交易所（由用户选择）。空值表示没有指定。
3. `symbolType`: string，请求的商品类型：`index`、`stock`、`forex`等等（由用户选择）。空值表示没有指定。
4. `onResultReadyCallback`: function\(result\)
   1. `result`: 数组 \(见下文\)

方法介绍：提供一个匹配用户搜索的商品列表。`result`为预期的商品 ，像下面这样:

```js
[
    {
        "symbol": "<商品缩写名>",
        "full_name": "<商品全称 -- 例: BTCE:BTCUSD>",
        "description": "<商品描述>",
        "exchange": "<交易所名>",
        "ticker": "<商品代码, 可选>",
        "type": "stock" | "futures" | "bitcoin" | "forex" | "index"
    }, {
        //    .....
    }
]
```

如果没有找到商品，则应该使用空数组来调用回调。查看更多关于`ticker`的细节 [在这里](/book/Symbology.md#ticker)

### [resolveSymbol\(symbolName, onSymbolResolvedCallback, onResolveErrorCallback\)](#resolvesymbolsymbolname-onsymbolresolvedcallback-onresolveerrorcallback)

1. `symbolName`: string，商品名称 或`ticker`
2. `onSymbolResolvedCallback`: function\([SymbolInfo](/book/Symbology.md#商品信息结构)\)
3. `onResolveErrorCallback`: function\(reason\)
4. `extension`: 具有附加参数的可选对象。 它具有以下字段：
   1. `currencyCode`: string,  如果设置了currency_codes配置字段并且在原始商品信息中提供了currency_code，则可以提供它来表示要转换的货币。
   1. `unitId`: string. 如果 `units` 配置，它可以被提供来指示要转换的单位。
      设置字段并在商品信息中提供 `unit_id` 。

方法介绍：通过商品名称解析商品信息\([SymbolInfo](/book/Symbology.md#商品信息结构)\)。

### [getBars\(symbolInfo, resolution, periodParams, onHistoryCallback, onErrorCallback\)](#getbarssymbolinfo-resolution-periodparams-onhistorycallback-onerrorcallback)

1. `symbolInfo`:[SymbolInfo](/book/Symbology.md#商品信息结构) 商品信息对象
1. `resolution`: string （周期）
1. `periodParams`: 具有以下字段的对象:
   1. `from` - unix 时间戳, 最左边请求的K线时间(K线时间 >= from)
   1. `countBack` - 要加载的K线的确切数量，如果您的datafeed支持它（见下文），则将视为拥有比 `from` 更高的优先级。 如果用户请求特定时间段，则可以不指定。
   1. `to`: unix 时间戳, 最右边请求的K线时间(K线时间 < to)
   1. `firstDataRequest`: 布尔值，以标识是否第一次调用此商品/周期的历史记录。当设置为`true`时
      你可以忽略`to`参数（这取决于浏览器的`Date.now()`\) 并返回K线数组直到最新K线。
1. `onHistoryCallback`: function\(数组`bars`,`meta`=_{ noData = false }_\) 历史数据的回调函数。每次请求只应被调用一次。 此函数有2个参数：
   1. `bars`: Bar对象数组`{time, close, open, high, low, volume}[]`
   1. `meta`: object`{noData = true | false, nextTime = unix time}`
1. `onErrorCallback`: function\(reason：错误原因\) 错误的回调函数。 此函数的唯一参数是文本错误消息。

方法介绍：当图表库需要由日期范围定义的历史K线片段时，将调用此函数。

`Bar`是具有以下字段的对象：

1. `time`: number **UTC** 时区的毫秒单位时间戳。`time`对于日K线的时间应为00:00 UTC(而非交易时段的开始时间)。图表库讲根据商品信息中的交易时段调整时间。每个月K线的时间是该月的第一个交易日，且无时间部分。
2. `open`: number K线开盘价
3. `high`: number K线最高价
4. `low`: number K线最低价
5. `close`: number K线收盘价
6. `volume`: number K线交易量

`meta`是具有以下字段的对象：

1. `noData` 布尔值, 只有在请求的时间段内没有数据时，才应该被设置。
2. `nextTime` unix 时间戳(UTC), 历史K线的下一K线时间。只有在请求的时间段内没有数据时，才应该被设置。

#### 关于 `periodParams`

从 18 版本开始，图表库提供了 `countBack` 参数，可用于提高数据加载的性能。

`from` 参数过去并且现在仍然不准确，因为它没有完全考虑到交易品种的交易时段。计算不准确的原因是速度（准确的计算具有线性时间复杂度，而不准确的计算具有恒定的复杂度）。

`countBack` 图表需要的最小K线数（它可以稍微大一些），用来填充可见范围，以及 `to` 日期（这是最后加载的K线的日期） ，您只需一个请求即可轻松获取所需的数据。

建议考虑`countBack`的优先级高于`from`的优先级，即必须返回`[from, to)`范围内的数据，但K线数不应小于`countBack`。如果K线的数量少于 `countBack`，图表库将再次调用 `getBars`。

如果您的数据提供服务可以返回准确的K线数，最好在使用`from`日期的基础上，再使用`countBack`以提高效率：

* 示例 1：假设图表在请求中请求 300 根K线，范围为 `[2019-06-01T00:00:00..2020-01-01T00:00:00]`。
  如果您在请求的时间段 (`[2019-06-01T00:00:00..2020-01-01T00:00:00]`) 中只有 250 根K线并且您返回这 250 根K线，则图表将再次请求在`2019-06-01T00:00:00`日期之前的数据，以在加载 50 根K线。

* 示例 2：假设图表在请求中请求 300 根K线，范围为 `[2019-06-01T00:00:00..2020-01-01T00:00:00]`。
  如果您在请求的时间段内没有K线，也可以不需返回 {`noData: true`，和等于下一个可用数据的时间的`nextTime`}。您可以简单地返回 `2020-01-01T00:00:00` 之前的 300 根K线，即使该数据早于 `from` 日期。
  
### [subscribeBars\(symbolInfo, resolution, onRealtimeCallback, subscriberUID, onResetCacheNeededCallback\)](#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback)

1. `symbolInfo`:object [SymbolInfo](/book/Symbology.md#商品信息结构)
2. `resolution`: string 周期
3. `onRealtimeCallback`: function\(bar\)
   1. `bar`: object`{time, close, open, high, low, volume}`
4. `subscriberUID`: object
5. `onResetCacheNeededCallback`\(从1.7开始\): function\(\)将在bars数据发生变化时执行

方法介绍：订阅K线数据。图表库将调用`onRealtimeCallback`方法以更新实时数据。

**Remark**: 当您调用`onRealtimeCallback`且K线时间等于最新K线时间时，那么这条最新K线将被您传入的K线所替换。 例:

1. 最近一条K线为 `{1419411578413, 10, 12, 9, 11}`
2. 调用 `onRealtimeCallback({1419411578413, 10, 14, 9, 14})`
3. 图表库通过时间`1419411578413`找出K线，已存在并且是最近的那一个
4. 图表库替换K线，因此现在最近一条K线为 `{1419411578413, 10, 14, 9, 14}`

**Remark 2**: 可以使用 `onRealtimeCallback` 更新最近的K线或添加新K线。 如果您调用此功能尝试更新历史记录中的一个K线时，则会收到错误消息。

**Remark 3**: 现在，在图表接收到数据后，没有办法改变历史上的K线。

### [unsubscribeBars\(subscriberUID\)](#unsubscribebarssubscriberuid)

1. `subscriberUID`:object

方法介绍：取消订阅K线数据。在调用`subscribeBars`方法时,图表库将跳过与`subscriberUID`相同的对象。

### [getMarks\(symbolInfo, startDate, endDate, onDataCallback, resolution\)](#getmarkssymbolinfo-startdate-enddate-ondatacallback-resolution)

1. `symbolInfo`:[SymbolInfo](/book/Symbology.md#商品信息结构) 商品信息对象
2. `startDate`:  unix 时间戳, 最左边请求的K线时间
3. `endDate`: unix 时间戳, 最右边请求的K线时间
4. `onDataCallback`: function\(标记数字`marks`\)
5. `resolution`: string

方法介绍：图表库调用这个函数来获得可见的K线范围的标记。 图表预期每调用一次`getMarks`就会调用一次`onDataCallback`。
    
`mark`为具有以下属性的对象:

* **id**: 唯一标识id 。当用户点击标记时，将传递给相应的回调:[respective callback](/book/Widget-Methods.md#onbarmarkclickedcallback) 
* **time**: unix time, UTC
* **color**:`red`\|`green`\|`blue`\|`yellow`\|`{ border: '#ff0000', background: '#00ff00' }`
* **text**: 标记弹出式文字。 支持HTML
* **label**: 印在标记上的文字。单字符
* **labelFontColor**: label的文字颜色
* **minSize**: 标记的最小尺寸 \(diameter, pixels\)

每个K线允许几个标记（现在最多为10个）。不允许标记脱离K线。

**Remark**: 只有当您声明您的后端是支持标记时才会调用这个函数。[supporting marks](/book/JS-Api.md#supports_marks).

### [getTimescaleMarks\(symbolInfo, startDate, endDate, onDataCallback, resolution\)](#gettimescalemarkssymbolinfo-startdate-enddate-ondatacallback-resolution)

1. `symbolInfo`:[SymbolInfo](/book/Symbology.md#商品信息结构) object
2. `startDate`: unix时间戳 \(UTC\). Leftmost visible bar's time.
3. `endDate`: unix时间戳 \(UTC\). Rightmost visible bar's time.
4. `onDataCallback`: function\(array of`mark`s\)
5. `resolution`: string

图表库调用此函数获取可见K线范围的时间刻度标记。图表预期您每个调用getTimescaleMarks会调用一次onDataCallback。

mark为具有以下属性的对象:

* **id**: 唯一标识id 。当用户点击标记时，将传递给相应的回调:[respective callback](/book/Widget-Methods.md#onbarmarkclickedcallback) 
* **time**: unix time, UTC
* **color**:`red`\|`green`\|`blue`\|`yellow`\| ... \| \#000000
* **label**: 印在标记上的文字。单字符
* **tooltip**: 字符串串数组。数组的每个元素都是工具提示的单独行内容。

每个K线只允许一个标记。 不允许标记脱离K线。

**Remark**: 只有当您声明您的后端是支持标记时才会调用这个函数。[upporting marks](/book/JS-Api.md#supports_timescale_marks).

### [getServerTime\(callback\)](#getservertimecallback)

1. `callback`: function\(unixTime\)

当图表需要知道服务器时间时，如果配置标志`supports_time`设置为`true`，则调用此函数。图表库预期只调用一次回调。所提供的时间没有毫秒。例子：1445324591。它是用来显示倒数的价格范围。

### [getVolumeProfileResolutionForPeriod\(currentResolution, from, to, symbolInfo\)](#getvolumeprofileresolutionforperiodcurrentresolution-from-to-symbolinfo)

*可选的*

1. `currentResolution`：字符串。 图表上当前选择的分辨率
   1.`from`：unix时间戳（UTC）。 最左边可见K线的时间
1. `to`：unix 时间戳（UTC）。 最右侧可见K线的时间
1. `symbolInfo`: [SymbolInfo](Symbology.md#symbolinfo-structure) 对象

图表库调用此函数来获取将用于计算成交量分布图指标的分辨率。通常，您可能希望实现此方法以更准确地计算指标。实现实际上取决于您可以传输到图表库的成交量以及datafeed中的数据深度。

**备注**：如果未提供此功能，则图表库使用 `currentResolution`。

## ![](../images/trading.png)[交易终端专属](#交易终端专属)

### ![](../images/trading.png)[getQuotes\(symbols, onDataCallback, onErrorCallback\)](#getquotessymbols-ondatacallback-onerrorcallback)

1. `symbols`: 商品名称数组
2. `onDataCallback`: function\(array of`data`\)
   1. `data`:[商品报价数据](/book/Quotes.md#symbol-quote-data)
3. `onErrorCallback`: function\(reason\)

当图表需要报价数据时，将调用此函数。图表库预期在收到所有请求数据时调用onDataCallback。

### ![](../images/trading.png)[subscribeQuotes\(symbols, fastSymbols, onRealtimeCallback, listenerGUID\)](#subscribequotessymbols-fastsymbols-onrealtimecallback-listenerguid)

1. `symbols`: 很少更新的商品数组（建议频率为每分钟一次）。这些商品在观察列表中，但它们目前不可见。
2. `fastSymbols`: 频繁更新的商品数组（一次在10秒或更快）
3. `onRealtimeCallback`: function\(array of`data`\)
   1. `data`:[商品报价数据](/book/Quotes.md#symbol-quote-data)
4. `listenerGUID`: 监听的唯一标识符

交易终端当需要接收商品的实时报价时调用此功能。图表预期您每次要更新报价时都会调用`onRealtimeCallback`。

### ![](../images/trading.png)[unsubscribeQuotes\(listenerGUID\)](#unsubscribequoteslistenerguid)

1. `listenerGUID`: 监听的唯一标识符

交易终端当不需要再接收商品的实时报价时调用此函数。当图表库遇到`listenerGUID`相同的对象会跳过`subscribeQuotes`方法。

### ![](../images/trading.png)[subscribeDepth\(symbolInfo, callback\): String](#subscribedepthsymbolinfo-callback-string)

1. `symbolInfo`:[SymbolInfo](/book/Symbology.md#商品信息结构) object
2. `callback`: function\(depth\)
   1. `depth`: object`{snapshot, asks, bids}`
      1. `snapshot`: Boolean - 如果`true`时`asks`和`bids`具有全部深度，否则只包含更新的级别。
      2. `asks`: 买盘数组`{price, volume}`
      3. `bids`: 卖盘数组`{price, volume}`

交易终端当要接收商品的实时level 2 信息（DOM）时，调用此函数。 图表预期您每次要更新深度数据时都会调用回调。

此方法应返回唯一标识（subscriberUID），用于取消订阅数据。

### ![](../images/trading.png)[unsubscribeDepth\(subscriberUID\)](#unsubscribedepthsubscriberuid)

1. `subscriberUID`: String

交易终端当不希望接收此监听时调用此函数。

<!--stackedit_data:
eyJoaXN0b3J5IjpbLTc2NDg3ODgxMV19
-->
