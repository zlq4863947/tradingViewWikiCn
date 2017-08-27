# [JS Api](#js-api)

---

**这是啥?** 一套JS方法（特定的公共接口）。  
**我该怎么使用它?**: 您应该创建一个JS对象，它将以某种方式接收数据，并响应Charting Library请求。

数据缓存（历史和股票信息）在图表库中实现。 当您创建一个实现描述的界面的对象时，只需通过\`datafeed\`参数将其传递给库小部件构造函数。

# [Methods](#methods)

1. [onReady](#onreadycallback)
2. [searchSymbolsByName](#searchsymbolsbynameuserinput-exchange-symboltype-onresultreadycallback)
3. [resolveSymbol](#resolvesymbolsymbolname-onsymbolresolvedcallback-onresolveerrorcallback)
4. [getBars](#getbarssymbolinfo-resolution-from-to-onhistorycallback-onerrorcallback-firstdatarequest)
5. [subscribeBars](#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback)
6. [unsubscribeBars](#unsubscribebarssubscriberuid)
7. [calculateHistoryDepth](#calculatehistorydepthresolution-resolutionback-intervalback)
8. [getMarks](#getmarkssymbolinfo-startdate-enddate-ondatacallback-resolution)
9. [getTimescaleMarks](#gettimescalemarkssymbolinfo-startdate-enddate-ondatacallback-resolution)
10. [getServerTime](#getservertimecallback)

![](../images/trading.png)[交易终端专属](https://github.com/tradingview/charting_library/wiki/Trading-Terminal):

1. [getQuotes](https://github.com/tradingview/charting_library/wiki/JS-Api#chart-getquotessymbols-ondatacallback-onerrorcallback)
2. [subscribeQuotes](https://github.com/tradingview/charting_library/wiki/JS-Api#chart-subscribequotessymbols-fastsymbols-onrealtimecallback-listenerguid)
3. [unsubscribeQuotes](https://github.com/tradingview/charting_library/wiki/JS-Api#chart-unsubscribequoteslistenerguid)
4. ![](../images/trading.png)[subscribeDepth](https://github.com/tradingview/charting_library/wiki/JS-Api#subscribedepthsymbolinfo-callback)
5. ![](../images/trading.png)[unsubscribeDepth](https://github.com/tradingview/charting_library/wiki/JS-Api#unsubscribedepthsubscriberuid)

### [onReady\(callback\)](#onreadycallback)

```js
callback: function(configurationData)
    configurationData: object (见下文)
```

此方法旨在提供填充配置数据的对象。这些数据会影响图表的行为，所以它被调用在服务器端。

Charting Library 要求您使用回调函数来传递datafeed的configurationData参数。

configurationData是一个对象，现在支持以下属性:

##### [exchanges](#exchanges)

一个交易所数组。 Exchange是一个对象`{value, name, desc}`。

`value将被作为exchange参数传递到` searchSymbolsByName \(见下文\)。

`exchanges= []`引导交易所过滤器区别商品查询列表。使用`value= ""`来创建通配符筛选器（所有的交易所）。

##### [symbols\_types](#symbolstypes)

一个商品类型过滤器数组。商品类型过滤器是个对象`{name, value}`。`value`将被作为`symbolType`参数传递给searchSymbolsByName。

`symbolsTypes`= \[\] 引导类型过滤器区别商品查询列表。 使用`value`= ""来创建通配符筛选器（所有的商品类型）。

##### [supported\_resolutions](#supportedresolutions)

一个支持的分辨率数组，分辨率可以是数字或字符串。 如果分辨率是一个数字，它被视为分钟数。 字符串可以是“\*D”，“\*W”，“\_M”（\_的意思是任何数字）。

'resolutions'=undefined 或 \[\] 时，分辨率拥有默认内容 \(见：[http://tradingview.com/e/](http://tradingview.com/e/)\)。

例:`[1, 15, 240, "D", "6M"]`您将在分辨率中得到 "1 分钟, 15 分钟, 4 小时, 1 天, 6 个月" 。

##### [supports\_marks](#supportsmarks)

布尔值来标识您的 datafeed 是否支持使用工具做标记。

##### [supports\_timescale\_marks](#supportstimescalemarks)

布尔值来标识您的 datafeed 是否支持时间量程标记。

##### [supports\_time](#supportstime)

将此设置为`true`假如您的datafeed提供服务器时间（unix时间）。 它用于调整“价格”的规模。

### [searchSymbolsByName\(userInput, exchange, symbolType, onResultReadyCallback\)](#searchsymbolsbynameuserinput-exchange-symboltype-onresultreadycallback)

1. `userInput`: string类型，用户在商品搜索中输入的文字。
2. `exchange`:string类型，请求的交易所（由用户选择）。空值表示没有指定。
3. `symbolType`: string类型，请求的商品类型：指数、股票、外汇等等（由用户选择）。空值表示没有指定。
4. `onResultReadyCallback`: function\(result\)
   1. `result`: 数组 \(见下文\)

方法介绍：提供一个匹配用户搜索的商品列表。`result`为预期的商品 ，像下面这样:

```js
[
    {
        "symbol": <商品缩写名>,
        "full_name": <商品全称 -- 例: BTCE:BTCUSD>,
        "description": <商品描述>,
        "exchange": <交易所名>,
        "ticker": <商品代号, 可选>,
        "type": "stock" | "futures" | "bitcoin" | "forex" | "index"
    }, {
        //    .....
    }
]
```

如果没有找到商品，则应该使用空数组来调用回调。查看更多关于`ticker`值的细节 在这里

### [resolveSymbol\(symbolName, onSymbolResolvedCallback, onResolveErrorCallback\)](#resolvesymbolsymbolname-onsymbolresolvedcallback-onresolveerrorcallback)

1. `symbolName`: string类型，商品名称 或`ticker`
   if provided.
2. `onSymbolResolvedCallback`: function\([SymbolInfo](https://github.com/tradingview/charting_library/wiki/Symbology#symbolinfo-structure)\)
3. `onResolveErrorCallback`: function\(reason\)

方法介绍：通过商品名称解析商品信息\([SymbolInfo](https://github.com/tradingview/charting_library/wiki/Symbology#symbolinfo-structure)\)。

### [getBars\(symbolInfo, resolution, from, to, onHistoryCallback, onErrorCallback, firstDataRequest\)](#getbarssymbolinfo-resolution-from-to-onhistorycallback-onerrorcallback-firstdatarequest)

1. `symbolInfo`:[SymbolInfo](https://github.com/tradingview/charting_library/wiki/Symbology#symbolinfo-structure) 商品信息对象
2. `resolution`: string （分辨率）
3. `from`: unix 时间戳, 最左边必须的K线时间
4. `to`: unix 时间戳, 最又边必须的K线时间
5. `onHistoryCallback`: function\(array of`bar`s,`meta`=_{ noData = false }_\)
   1. `bar`: object`{time, close, open, high, low, volume}`
   2. `meta`: object`{noData = true | false, nextTime - unix time}`
6. `onErrorCallback`: function\(reason：错误原因\)
7. `firstDataRequest`: 布尔值，以标识是否第一次调用此商品/分辨率的历史记录。当设置为`true`时
   你可以忽略`to`参数（这取决于浏览器的`Date.now()`\) 并返回K线数组直到当前K线（包括它）。

方法介绍：通过日期范围获取历史K线数据。Charting library希望通过`onHistoryCallback`仅一次调用，接收所有的请求历史。而不被多次调用。

`nextTime`历史中下一个K线柱的时间。 只有在请求的时间段内没有数据时，才应该被设置。

`noData`只有在请求的时间段内没有数据时，才应该被设置。

**Remark**:`bar.time`为以毫秒开始的Unix时间戳的UTC标准时区。

**Remark**:`bar.time`对于日K线柱预期为 一个交易日 \(未开始交易\) 以 00:00 UTC为起点。 Charting Library 会根据商品的交易（[Session](https://github.com/tradingview/charting_library/wiki/Symbology#session)）时间进行匹配。

**Remark**:`bar.time`对于月K线柱为这个月的第一个交易日，除去时间的部分。

### [subscribeBars\(symbolInfo, resolution, onRealtimeCallback, subscriberUID, onResetCacheNeededCallback\)](#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback)

1. `symbolInfo`:[SymbolInfo](https://github.com/tradingview/charting_library/wiki/Symbology#symbolinfo-structure) object
2. `resolution`: string 分辨率
3. `onRealtimeCallback`: function\(bar\)
   1. `bar`: object`{time, close, open, high, low, volume}`
4. `subscriberUID`: object
5. `onResetCacheNeededCallback`\(从1.7开始\): function\(\)将在bar数据更改时执行

方法介绍：更新实时K线数据。图表将预期您每次更新最近的bar或追加一条新的数据时，调用`onRealtimeCallback`。

**Remark**: 当您调用`onRealtimeCallback`且K线时间等于最近一条K线时间，那么最近一条K线将被您传入的K线所替换。 例:

1. 最近一条K线为
   `{1419411578413, 10, 12, 9, 11}`
2. 您的调用
   `onRealtimeCallback({1419411578413, 10, 14, 9, 14})`
3. Library通过时间找出K线
   `1419411578413`
   已经存在，并且是最近的那一个
4. Library 全部替换K线，因此现在最近一条K线为
   `{1419411578413, 10, 14, 9, 14}`

**Remark 2**: 是否可以更新最近的K线或追加一条新的，取决于`onRealtimeCallback`。 如果您调用此功能尝试更新历史记录中的一个K线，则会收到错误消息。

**Remark 3**: 现在，在图表接收到数据后，没有办法改变历史上的K线。

### [unsubscribeBars\(subscriberUID\)](#unsubscribebarssubscriberuid)

1. `subscriberUID`:bject

方法介绍：取消实时更新K线数据。将与`subscriberUID`相同的对象在`subscribeBars`方法之前跳过。

### [calculateHistoryDepth\(resolution, resolutionBack, intervalBack\)](#calculatehistorydepthresolution-resolutionback-intervalback)

1. `resolution`: 请求商品的分辨率
2. `resolutionBack`: 期望历史周期维度。支持的值:`D`\|`M`
3. `intervalBack`: 数量 或`resolutionBack`

方法介绍：算出历史数据周期维度，使您能够重写所需的历史深度。

通过一些参数，让您知道要获得的是什么样数据。 以下是几个例子:

* `calculateHistoryDepth("D", "M", 12)`
  调用: Library请求 12 个月的日线数据
* `calculateHistoryDepth(60, "D", 15)`
  调用: Library请求15天的60分钟数据

如果你不想重写处理方法，这个函数应该返回`undefined`。如果你想要重写，它应该返回一个对象`{resolutionBack, intervalBack}`. 属性含义类似于各个参数。

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

这意味着当Charting Library将要求分辨率为“1D，历史将是6个月的深度。 在所有其他情况下，历史深度将具有默认值。

### [getMarks\(symbolInfo, startDate, endDate, onDataCallback, resolution\)](#getmarkssymbolinfo-startdate-enddate-ondatacallback-resolution)

1. `symbolInfo`:[SymbolInfo](https://github.com/tradingview/charting_library/wiki/Symbology#symbolinfo-structure) 商品信息对象
2. `startDate`:  unix 时间戳, 最左边必须的K线时间
3. `endDate`: unix 时间戳, 最又边必须的K线时间
4. `onDataCallback`: function\(array of`mark`s\)
5. `resolution`: string

方法介绍：获取可见条范围的标记。图表预期您每个`getMarks`会调用一次`onDataCallback`。

`mark`为具有以下属性的对象:

* **id**: 唯一标识id 。当用户点击标记时，将传递给相应的回调:[respective callback](https://github.com/tradingview/charting_library/wiki/Widget-Methods#onbarmarkclickedcallback) 
* **time**: unix time, UTC
* **color**:`red`\|`green`\|`blue`\|`yellow`\|`{ border: '#ff0000', background: '#00ff00' }`
* **text**: 标记弹出式文字。 支持HTML
* **label**: 印在标记上的文字。单字符
* **labelFontColor**: label的文字颜色
* **minSize**: 标记的最小尺寸 \(diameter, pixels\)

每个K线允许几个标记（现在最多为10个）。不允许标记脱离线。

**Remark**: 只有当您声明您的后端是支持标记时才会调用这个函数。[supporting marks](https://github.com/tradingview/charting_library/wiki/JS-Api#supports_marks).

### [getTimescaleMarks\(symbolInfo, startDate, endDate, onDataCallback, resolution\)](#gettimescalemarkssymbolinfo-startdate-enddate-ondatacallback-resolution)

1. `symbolInfo`:[SymbolInfo](https://github.com/tradingview/charting_library/wiki/Symbology#symbolinfo-structure) object
2. `startDate`: unix timestamp \(UTC\). Leftmost visible bar's time.
3. `endDate`: unix timestamp \(UTC\). Rightmost visible bar's time.
4. `onDataCallback`: function\(array of`mark`s\)
5. `resolution`: string

Library 调用此函数获取可见bar范围的时间刻度标记的功能。图表预期您每个getTimescaleMarks会调用一次onDataCallback。

mark为具有以下属性的对象:

* **id**: 唯一标识id 。当用户点击标记时，将传递给相应的回调:[respective callback](https://github.com/tradingview/charting_library/wiki/Widget-Methods#onbarmarkclickedcallback) 
* **time**: unix time, UTC
* **color**:`red`\|`green`\|`blue`\|`yellow`\| ... \| \#000000
* **label**: 印在标记上的文字。单字符
* **tooltip**: 字符串串数组。数组的每个元素都是工具提示的新文本行。

每个bar只允许一个标记。 不允许标记脱离bar。

**Remark**: 只有当您声明您的后端是支持标记时才会调用这个函数。[upporting marks](https://github.com/tradingview/charting_library/wiki/JS-Api#supports_timescale_marks).

### [getServerTime\(callback\)](#getservertimecallback)

1. `callback`: function\(unixTime\)

当图表需要知道服务器时间时，如果配置标志`supports_time`设置为`true`，则调用此函数。图表库预期只调用一次回调。所提供的时间没有毫秒。例子：1445324591。它是用来显示倒计时的价格规模。

## ![](../images/trading.png)[交易终端专属](#交易终端专属)

### ![](../images/trading.png)[getQuotes\(symbols, onDataCallback, onErrorCallback\)](#getquotessymbols-ondatacallback-onerrorcallback)

1. `symbols`: 商品名称数组
2. `onDataCallback`: function\(array of`data`\)
   1. `data`:商品价格数据[symbol quote data](https://github.com/tradingview/charting_library/wiki/Quotes#symbol-quote-data)
3. `onErrorCallback`: function\(reason\)

当图表需要价格数据时，将调用此函数。图表库预期在收到所有请求数据时调用onDataCallback。No further calls are expected.

### ![](../images/trading.png)[subscribeQuotes\(symbols, fastSymbols, onRealtimeCallback, listenerGUID\)](#subscribequotessymbols-fastsymbols-onrealtimecallback-listenerguid)

1. `symbols`: 要很少更新的产品数组（建议频率为每分钟一次）。这些产品在观察列表中，但它们目前不可见。
2. `fastSymbols`: 要频繁更新的产品数组（一次在10秒或更多次）
3. `onRealtimeCallback`: function\(array of`data`\)
   1. `data`:商品价格数据[symbol quote data](https://github.com/tradingview/charting_library/wiki/Quotes#symbol-quote-data)
4. `listenerGUID`: 侦听器的唯一标识符

交易终端当需要接收产品的实时报价时调用此功能。图表预期您每次要更新报价时都会调用`onRealtimeCallback`。

### ![](../images/trading.png)[unsubscribeQuotes\(listenerGUID\)](#unsubscribequoteslistenerguid)

1. `listenerGUID`: 侦听器的唯一标识符

交易终端当不需要再接收产品的实时报价时调用此函数。`listenerGUID`will be the same object which Library passed to`subscribeQuotes`before.

### ![](../images/trading.png)[subscribeDepth\(symbolInfo, callback\): String](#subscribedepthsymbolinfo-callback-string)

1. `symbolInfo`:[SymbolInfo](https://github.com/tradingview/charting_library/wiki/Symbology#symbolinfo-structure) object
2. `callback`: function\(depth\)
   1. `depth`: object`{snapshot, asks, bids}`
      1. `snapshot`: Boolean - 如果`true`时`askh`和`bids`具有全部深度，否则只包含更新的级别。
      2. `asks`: 买盘数组`{price, volume}`
      3. `bids`: 卖盘数组`{price, volume}`

交易终端当要接收到商品的实时level 2 信息（DOM）时，调用此函数。 图表预期您每次要更新深度数据时都会调用回调。

此方法应返回唯一标识（subscriberUID），用于取消订阅数据。

### ![](../images/trading.png)[unsubscribeDepth\(subscriberUID\)](#unsubscribedepthsubscriberuid)

1. `subscriberUID`: String

交易终端当不希望接收此监听器的更新时调用此函数。

