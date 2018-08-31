# [UDF](#udf)

---

**这是啥?**: Universal Data Feed 通用数据饲料，基于HTTP协议的旨在以简单有效的方式向图表库提供数据。
**我该怎么使用它?**: 您应该创建小型的HTTP服务，让它从您的数据库中获取数据并响应图表库请求。

# [表式响应概念](#表式响应概念)

Datafeed 响应通常可以被视为表。例如，关于交易所的商品列表的响应，可以被视为每个商品代表一行，并有存在一些列（minimal\_price\_movement，description，has\_intraday等）。每个列可以是一个数组（因此，它将为每个表的行提供单独的值）。但是当所有表的行具有相同的列值时，可能会出现这种情况：列的值可以是单独的JSON响应。

例如:

让我们假设我们已经请求了名称为NYSE\(纽约证券交易所\)的商品列表。响应（伪格式）可能像这样

```
{
   symbols: ["MSFT", "AAPL", "FB", "GOOG"],
   min_price_move: 0.1,
   description: ["Microsoft corp.", "Apple Inc", "Facebook", "Google"]
}
```

如果我们试图将这个回应设想成一张表，那么它就像这样

| Symbol（商品代码） | min\_price\_move（最小价格变动） | 描述 |
| :--- | :--- | :--- |
| MSFT | 0.1 | Microsoft corp. |
| AAPL | 0.1 | Apple Inc |
| FB | 0.1 | Facebook |
| GOOG | 0.1 | Google |

# [API调用](#api-calls)

### [Datafeed 配置数据](#datafeed-配置数据)

Request:`GET /config`

Response: 图表库期望接收与JS API调用[setup\(\)](/book/JS-Api.md#onreadycallback)相同结构的JSON数据。 此外，还应该有2个附加属性：:

* **supports\_search**: 设置这一选项为`true`如果你的datafed 支持商品查询和人商品解析逻辑。
* **supports\_group\_request**: 设置这一选项为`true`如果您的datafeed只提供所有商品集合的完整信息，并且无法进行商品搜索或单个商品解析。

`supports_search`和`supports_group_request`两者之中有只有一个可以为`true`。

**Remark**: 如果你的datafeed 没有实现这个调用\(根本不响应或发送404\)，将使用默认配置。 这样：:

```
{
    supports_search: false,
    supports_group_request: true,
    supported_resolutions: ["1", "5", "15", "30", "60", "1D", "1W", "1M"],
    supports_marks: false,
    supports_time: true
}
```

### [商品集合信息](#商品集合信息)

Request:`GET /symbol_info?group=<group_name>`

1. `group_name`: string

Example:`GET /symbol_info?group=NYSE`

Response: 预期响应是具有以下列出的属性的对象。 每个属性都被视为表的一列，如上所述（请参见[表式响应](#表式响应概念)）。响应结构与[SymbolInfo](/book/Symbology.md#symbolinfo-structure)类似（但不等于），因此有关所有字段的详细信息，请参见其描述。

* **symbol**
* **description**
* **exchange-listed**/**exchange-traded**
* **minmovement**/**minmov**（注意：minmov已被弃用，并将在未来的版本中被删除）
* **minmovement2**/**minmov2**（注意：minmov2已被弃用，并将在未来的版本中被删除）
* **fractional**
* **pricescale**
* **has-intraday**
* **has-no-volume**
* **type**
* **ticker**
* **timezone**
* **session-regular**\(mapped to`SymbolInfo.session`\)
* **supported-resolutions**
* **force-session-rebuild**
* **has-daily**
* **intraday-multipliers**
* **has-fractional-volume**\(obsolete\)
* **volume\_precision**
* **has-weekly-and-monthly**
* **has-empty-bars**

示例：以下是对datafeed的响应示例`GET /symbol_info?group=NYSE`\(数据为手工制造\):

```
{
   symbol: ["AAPL", "MSFT", "SPX"],
   description: ["Apple Inc", "Microsoft corp", "S&P 500 index"],
   exchange-listed: "NYSE",
   exchange-traded: "NYSE",
   minmov: 1,
   minmov2: 0,
   pricescale: [1, 1, 100],
   has-dwm: true,
   has-intraday: true,
   has-no-volume: [false, false, true]
   type: ["stock", "stock", "index"],
   ticker: ["AAPL~0", "MSFT~0", "$SPX500"],
   timezone: “America/New_York”,
   session-regular: “0900-1600”,
}
```

**Remark 1**: 如果您的datafeed配置supports\_group\_request：true或根本没有响应配置请求，则将使用此调用。

**Remark 2**: 如果您的datafeed 被请求不支持的集合（如果您对请求＃1（支持的集合）的响应是正确的），则会发生404错误）。

**Remark 3**: 使用此模式（获取大量的商品数据）在浏览器中存储一些用户不需要的数据。 因此，如果您的商品列表有多个项目，请考虑支持商品搜索/单个商品解析。

### [商品解析](#商品解析)

Request:`GET /symbols?symbol=<symbol>`

1. `symbol`: string. 商品名称或者代码.

例:`GET /symbols?symbol=AAL`,`GET /symbols?symbol=NYSE:MSFT`

Response: JSON包含的对象与[SymbolInfo](/book/Symbology.md#symbolinfo-structure)完全一样

**Remark**: 如果您的datafeed配置supports\_group\_request：false 和 supports\_search：true，则将执行此调用。

### [商品检索](#商品检索)

Request:`GET /search?query=<query>&type=<type>&exchange=<exchange>&limit=<limit>`

1. `query`: string. 用户在商品搜索编辑框中输入的文本
2. `type`: string. 您的后台[支持的类型](/book/JS-Api.md#symbolstypes)之一
3. `exchange`: string. 您的后台[支持的交易所](/book/JS-Api.md#exchanges)之一
4. `limit`: integer. 响应最大项目数

例:`GET /search?query=AA&type=stock&exchange=NYSE&limit=15`

Response: 响应将是调用[JS API](/book/JS-Api.md#searchsymbolsbynameuserinput-exchange-symboltype-onresultreadycallback)后返回的一个数组类型的商品记录

**Remark**: 如果您的datafeed配置supports\_group\_request：false 和 supports\_search：true，则将执行此调用。

### [K线柱](#k线柱)

Request:`GET /history?symbol=<ticker_name>&from=<unix_timestamp>&to=<unix_timestamp>&resolution=<resolution>`

1. `symbol`: 商品名称或者代码
2. `from`: unix timestamp \(UTC\) or leftmost required bar
3. `to`: unix timestamp \(UTC\) or rightmost required bar
4. `resolution`: string

例:`GET /history?symbol=BEAM~0&resolution=D&from=1386493512&to=1395133512`

Response: 响应的预期是一个对象，下面列出了一些属性。每个属性都被视为表的列，如上所述。

* **s**: 状态码。 预期值:`ok`\|`error`\|`no_data`
* **errmsg**: 错误消息。只在`s = 'error'时出现`
* **t**: K线时间. unix时间戳 \(UTC\)
* **c**: 收盘价
* **o**: 开盘价 \(可选\)
* **h**: 最高价 \(可选\)
* **l**: 最低价\(可选\)
* **v**: 成交量 \(可选\)
* **nextTime**: 下一个K线柱的时间 如果在请求期间无数据 \(状态码为`no_data`\)  \(可选\)

**Remark**: bar time 对于日K线柱预期为 一个交易日 \(not session start day\) 以 00:00 UTC为起点。 Charting Library 会根据SymbolInfo的[Session](/book/Symbology.md#session)时间进行匹配。

**Remark**: K线时间对于月K线柱为这个月的第一个交易日，除去时间的部分。

**Remark**: 价格应作为数字传递，而不是使用字符串。

例:

```
{
   s: "ok",
   t: [1386493512, 1386493572, 1386493632, 1386493692],
   c: [42.1, 43.4, 44.3, 42.8]
}
```

```
{
   s: "no_data",
   nextTime: 1386493512
}
```

```
{
   s: "ok",
   t: [1386493512, 1386493572, 1386493632, 1386493692],
   c: [42.1, 43.4, 44.3, 42.8],
   o: [41.0, 42.9, 43.7, 44.5],
   h: [43.0, 44.1, 44.8, 44.5],
   l: [40.4, 42.1, 42.8, 42.3],
   v: [12000, 18500, 24000, 45000]
}
```

##### `nextTime`是怎么工作的

假设您以周期= 1观看图表，并且Library要求您以\[2015年4月3日16:00 UTC + 0，2015年4月3日19:00 UTC + 0\]为范围，向纽约证券交易所请求股票数据。 4月3日为受难节，交易所休假。 Library假定你会作出如下响应:

```
{  
    s: "no_data",
    nextTime: 1428001140000 //2015年4月2日 18:59:00 GMT+0
}
```

因此`nextTime`是一个从Library的原始请求边界的左侧（在假想时间线上）的K线柱时间。

所有省略的价格将被视为等于收盘价。

### [标识](#标识)

Request:`GET /marks?symbol=<ticker_name>&from=<unix_timestamp>&to=<unix_timestamp>&resolution=<resolution>`

1. `symbol`: symbol name or ticker.
2. `from`: unix timestamp \(UTC\) or leftmost visible bar
3. `to`: unix timestamp \(UTC\) or rightmost visible bar
4. `resolution`: string

Response: 响应预期是一个对象，下面列出了一些属性。此对象与JS API中的[respective response](/book/JS-Api.md#getmarkssymbolinfo-startdate-enddate-ondatacallback-resolution)相似，但每个属性都被视为表的列，如上所述。

```
{
    id: [array of ids],
    time: [array of times],
    color: [array of colors],
    text: [array of texts],
    label: [array of labels],
    labelFontColor: [array of label font colors],
    minSize: [array of minSizes],
}
```

**Remark**: 备注：如果您的datafeed在传输的配置数据中发送了supports\_marks：true，则会调用此方法。

### [时间刻度标记](#时间刻度标记)

Request:`GET /timescale_marks?symbol=<ticker_name>&from=<unix_timestamp>&to=<unix_timestamp>&resolution=<resolution>`

1. `symbol`: symbol name or ticker.
2. `from`: unix timestamp \(UTC\) or leftmost visible bar
3. `to`: unix timestamp \(UTC\) or rightmost visible bar
4. `resolution`: string

Response: 响应预期为一个具有下列属性的数组对象。

1. `id`: unique identifier of a mark
2. `color`: rgba color
3. `label`: 显示在圆圈中的文字
4. `time`: unix time
5. `tooltip`: 提示文本

**Remark**: This call will be requested if your datafeed sent`supports_timescale_marks: true`in configuration data.

### [服务器时间](#服务器时间)

Request:`GET /time`

Response: 数字unix时间没有毫秒。 例: 1445324591

### [报价](#报价)

Request:`GET /quotes?symbols=<ticker_name_1>,<ticker_name_2>,...,<ticker_name_n>`

Example:`GET /quotes?symbols=NYSE%3AAA%2CNYSE%3AF%2CNasdaqNM%3AAAPL`

Response: Response is an object.

* **s**: status code for request. Expected values:`ok`\|`error`
* **errmsg**: error message for client
* **d**:[symbols data](/book/Quotes.md) array

Example:

```
{
    "s": "ok",
    "d": [{
        "s": "ok",
        "n": "NYSE:AA",
        "v": {
            "ch": "+0.16",
            "chp": "0.98",
            "short_name": "AA",
            "exchange": "NYSE",
            "description": "Alcoa Inc. Common",
            "lp": "16.57",
            "ask": "16.58",
            "bid": "16.57",
            "open_price": "16.25",
            "high_price": "16.60",
            "low_price": "16.25",
            "prev_close_price": "16.41",
            "volume": "4029041"
        }
    }, {
        "s": "ok",
        "n": "NYSE:F",
        "v": {
            "ch": "+0.15",
            "chp": "0.89",
            "short_name": "F",
            "exchange": "NYSE",
            "description": "Ford Motor Compan",
            "lp": "17.02",
            "ask": "17.03",
            "bid": "17.02",
            "open_price": "16.74",
            "high_price": "17.08",
            "low_price": "16.74",
            "prev_close_price": "16.87",
            "volume": "7713782"
        }
    }]
}
```

## [构造函数](#构造函数)

`Datafeeds.UDFCompatibleDatafeed = function(datafeedURL, updateFrequency, protocolVersion)`

### [datafeedURL](#datafeedurl)

这是一个数据服务器的URL，它将得到请求和返回数据。

### [updateFrequency](#updatefrequency（更新频率）)（更新频率）

这是一个有周期的实时数据请求，datafeed将以毫秒为单位发送到服务器。 默认值为10000（10秒）。