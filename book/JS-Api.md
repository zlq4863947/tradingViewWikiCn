# [JS Api](#js-api)

---

**这是啥?** 一套JS方法（以实现指定的公共接口）。  
**我该怎么使用它?**: 您应该创建一个JS对象，它将以某种方式接收数据，并响应图表库的请求。

在图表库中实现了数据缓存（历史和商品信息）。当您创建一个实现接口的对象时，只需将它传递给图表库[Widget的构造函数](/book/Widget-Constructor.md)。

# [Methods](#methods)

1. [onReady](#onreadycallback)
2. [searchSymbols](#searchsymbolsuserinput-exchange-symboltype-onresultreadycallback)
3. [resolveSymbol](#resolvesymbolsymbolname-onsymbolresolvedcallback-onresolveerrorcallback)
4. [getBars](#getbarssymbolinfo-resolution-from-to-onhistorycallback-onerrorcallback-firstdatarequest)
5. [subscribeBars](#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback)
6. [unsubscribeBars](#unsubscribebarssubscriberuid)
7. [calculateHistoryDepth](#calculatehistorydepthresolution-resolutionback-intervalback)
8. [getMarks](#getmarkssymbolinfo-startdate-enddate-ondatacallback-resolution)
9. [getTimescaleMarks](#gettimescalemarkssymbolinfo-startdate-enddate-ondatacallback-resolution)
10. [getServerTime](#getservertimecallback)

![](../images/trading.png)[交易终端专属](#交易终端专属):

1. [getQuotes](#getquotessymbols-ondatacallback-onerrorcallback)
2. [subscribeQuotes](#subscribequotessymbols-fastsymbols-onrealtimecallback-listenerguid)
3. [unsubscribeQuotes](#unsubscribequoteslistenerguid)
4. [subscribeDepth](#subscribedepthsymbolinfo-callback-string)
5. [unsubscribeDepth](#unsubscribedepthsubscriberuid)

### [onReady\(callback\)](#onreadycallback)

```js
1.callback: function(configurationData)
    i.configurationData: object (见下文)
```

此方法旨在提供填充配置数据的对象。这些数据会影响图表的特性表现，所以它被调用在[服务端定制](Customization-Overview.md#customization-done-through-data-stream)。

图表库要求您使用回调函数来传递datafeed的 `configurationData`参数。

configurationData是一个对象，现在支持以下属性:

##### [exchanges](#exchanges)

一个交易所数组。 Exchange是一个对象`{value, name, desc}`。

`value`将被作为`exchange`参数传递给 [searchSymbols](#searchsymbolsuserinput-exchange-symboltype-onresultreadycallback)。

`exchanges = []`会导致商品查询列表中看不到交易所过滤器。使用`value = ""`来创建通配符筛选器（所有的交易所）。

##### [symbols\_types](#symbolstypes)

一个商品类型过滤器数组。该商品类型过滤器是个对象`{name, value}`。`value`将被作为`symbolType`参数传递给[searchSymbols](#searchsymbolsuserinput-exchange-symboltype-onresultreadycallback)。

`symbolsTypes`= \[\] 会导致商品查询列表中看不到商品类型过滤器。 使用`value= ""`来创建通配符筛选器（所有的商品类型）。

##### [supported\_resolutions](#supportedresolutions)

一个表示服务器支持的周期数组，周期可以是数字或字符串。 如果周期是一个数字，它被视为分钟数。 字符串可以是“\*D”，“\*W”，“\_M”（\_的意思是任何数字）。格式化详细参照:[文章](/book/Resolution.md)。

`resolutions = undefined` 或 `resolutions = []` 时，周期拥有默认内容。

例:`[1, 15, 240, "D", "6M"]`您将在周期中得到 "1 分钟, 15 分钟, 4 小时, 1 天, 6 个月" 。

##### [supports\_marks](#supportsmarks)

布尔值来标识您的 datafeed 是否支持在K线上显示标记。

##### [supports\_timescale\_marks](#supportstimescalemarks)

布尔值来标识您的 datafeed 是否支持时间刻度标记。

##### [supports\_time](#supportstime)

将此设置为`true`假如您的datafeed提供服务器时间（unix时间）。 它用于调整时间刻度上的价格比例。

##### futures_regex 

如果您想在商品搜索中对期货进行分组，请设置它。 这个正则表达式会将仪器名称分为两部分：根和期满。 

实例 regex: : `/^(.+)([12]!|[FGHJKMNQUVXZ]\d{1,2})$/`. 它将应用于类型为期货的图表。

### [searchSymbols\(userInput, exchange, symbolType, onResultReadyCallback\)](#searchsymbolsuserinput-exchange-symboltype-onresultreadycallback)

1. `userInput`: string，用户在商品搜索框中输入的文字。
2. `exchange`:string，请求的交易所（由用户选择）。空值表示没有指定。
3. `symbolType`: string，请求的商品类型：指数、股票、外汇等等（由用户选择）。空值表示没有指定。
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

1. `symbolName`: string类型，商品名称 或`ticker`
   if provided.
2. `onSymbolResolvedCallback`: function\([SymbolInfo](/book/Symbology.md#商品信息结构)\)
3. `onResolveErrorCallback`: function\(reason\)

方法介绍：通过商品名称解析商品信息\([SymbolInfo](/book/Symbology.md#商品信息结构)\)。

### [getBars\(symbolInfo, resolution, from, to, onHistoryCallback, onErrorCallback, firstDataRequest\)](#getbarssymbolinfo-resolution-from-to-onhistorycallback-onerrorcallback-firstdatarequest)

1. `symbolInfo`:[SymbolInfo](/book/Symbology.md#商品信息结构) 商品信息对象
2. `resolution`: string （周期）
3. `from`: unix 时间戳, 最左边请求的K线时间
4. `to`: unix 时间戳, 最右边请求的K线时间
5. `onHistoryCallback`: function\(数组`bars`,`meta`=_{ noData = false }_\)
   1. `bars`: Bar对象数组`{time, close, open, high, low, volume}[]`
   2. `meta`: object`{noData = true | false, nextTime = unix time}`
6. `onErrorCallback`: function\(reason：错误原因\)
7. `firstDataRequest`: 布尔值，以标识是否第一次调用此商品/周期的历史记录。当设置为`true`时
   你可以忽略`to`参数（这取决于浏览器的`Date.now()`\) 并返回K线数组直到当前K线（包括它）。

方法介绍：通过日期范围获取历史K线数据。图表库希望通过`onHistoryCallback`仅一次调用，接收所有的请求历史。而不是被多次调用。

> 发生不断自动刷新图表问题时，请检查`from`和`to`与`onHistoryCallback`方法返回的K线时间范围是否一致，没有数据时请返回`noData = true`

`nextTime`历史中下一个K线柱的时间。 只有在请求的时间段内没有数据时，才应该被设置。

`noData`只有在请求的时间段内没有数据时，才应该被设置。

**Remark**:`bar.time`为以毫秒开始的Unix时间戳（UTC标准时区）。

**Remark**:`bar.time`对于日K线预期一个交易日 \(未开始交易时\) 以 00:00 UTC为起点。 图表库会根据商品的交易（[Session](/book/Symbology.md#session)）时间进行匹配。

**Remark**:`bar.time`对于月K线为这个月的第一个交易日，除去时间的部分。

### [subscribeBars\(symbolInfo, resolution, onRealtimeCallback, subscriberUID, onResetCacheNeededCallback\)](#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback)

1. `symbolInfo`:object [SymbolInfo](/book/Symbology.md#商品信息结构)
2. `resolution`: string 周期
3. `onRealtimeCallback`: function\(bar\)
   1. `bar`: object`{time, close, open, high, low, volume}`
4. `subscriberUID`: object
5. `onResetCacheNeededCallback`\(从1.7开始\): function\(\)将在bars数据发生变化时执行

方法介绍：订阅K线数据。图表库将调用`onRealtimeCallback`方法以更新实时数据。

**Remark**: 当您调用`onRealtimeCallback`且K线时间等于最近一条K线时间时，那么这条最近的K线将被您传入的K线所替换。 例:

1. 最近一条K线为 `{1419411578413, 10, 12, 9, 11}`
2. 调用 `onRealtimeCallback({1419411578413, 10, 14, 9, 14})`
3. 图表库通过时间`1419411578413`找出K线，已存在并且是最近的那一个
4. 图表库替换K线，因此现在最近一条K线为 `{1419411578413, 10, 14, 9, 14}`

**Remark 2**: 是否可以更新最近的K线或追加一条新的，取决于`onRealtimeCallback`。 如果您调用此功能尝试更新历史记录中的一个K线时，则会收到错误消息。

**Remark 3**: 现在，在图表接收到数据后，没有办法改变历史上的K线。

### [unsubscribeBars\(subscriberUID\)](#unsubscribebarssubscriberuid)

1. `subscriberUID`:object

方法介绍：取消订阅K线数据。在调用`subscribeBars`方法时,图表库将跳过与`subscriberUID`相同的对象。

### [calculateHistoryDepth\(resolution, resolutionBack, intervalBack\)](#calculatehistorydepthresolution-resolutionback-intervalback)

1. `resolution`: 请求商品的周期
2. `resolutionBack`: 期望历史周期刻度。支持的值:`D`\|`M`
3. `intervalBack`: 数量

方法介绍：图表库在它要请求一些历史数据的时候会调用这个函数，让你能够覆盖所需的历史深度。

通过传递的参数，可以让您知道要获得什么样的K线数据。 以下是几个例子:

* `calculateHistoryDepth("D", "M", 12)`
  调用: 图表库请求12个月的日线数据
* `calculateHistoryDepth(60, "D", 15)`
  调用: 图表库请求15天的60分钟数据

如果你不想重写处理方法，这个函数应该返回`undefined`。如果你想要重写，它应该返回一个对象`{resolutionBack, intervalBack}`。

例子:

假设实现为

```js
Datafeed.prototype.calculateHistoryDepth = function(resolution, resolutionBack, intervalBack) {
    if (period == "1D") {
        return {
            resolutionBack: 'M',
            intervalBack: 6
        };
    }
}
```

以上代码为当图表库将要求周期为`1D`，历史为6个月的深度。 在其他情况下，历史深度将具有其他默认值。

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