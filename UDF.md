**What it is ?**: HTTP-based protocol designed to deliver data to Charting Library in a simple and efficient way.<br>
**What should I do to use it ?**: You should create tiny server-side HTTP service which will get the data from your storage and respond to Charting Library requests.

# Response-as-a-table concept

Datafeeed responses often may be treated as tables. I.e., response about exchange’s symbols list may be treated as a table where each symbol represents a row, and there are some columns (minimal_price_movement, description, has_intraday e.t.c.). Each column may be an array (thus, it will provide separate value for each table’s row). But there may be a situation when all table’s rows has the same values of the column. In this case, the column’s value may be a single value in JSON response .

Example:

Let’s suppose we’ve requested the symbols list of exchange named NYSE. The response (in pseudo-format) might look like

```javascript
{
   symbols: ["MSFT", "AAPL", "FB", "GOOG"],
   min_price_move: 0.1,
   description: ["Microsoft corp.", "Apple Inc", "Facebook", "Google"]
}
```

If we try to imagine this response as a table, it will look like

Symbol|min_price_move|Description
---|---|---
MSFT|0.1|Microsoft corp.
AAPL|0.1|Apple Inc
FB|0.1|Facebook
GOOG|0.1|Google


# API Calls

### Datafeed configuration data
Request: `GET /config`

Response: Library expects to receive JSON of the same structure as for JS API [[setup() call|JS-Api#onreadycallback]]. Also there should be 2 additional properties:

* **supports_search**: Set this one to `true` if your datafeed supports symbol search and individual symbol resolve logic.
* **supports_group_request**: Set this one to `true`  if your datafeed provides full info about symbols group only and is not able to perform symbol search or individual symbol resolve.

Either `supports_search` or `supports_group_request` should be `true`.

**Remark**: If your datafeed does not implement this call (do not respond at all or send 404), default configuration is used. Here it is:
```javascript
{
	supports_search: false,
	supports_group_request: true,
	supported_resolutions: ["1", "5", "15", "30", "60", "1D", "1W", "1M"],
	supports_marks: false,
        supports_time: true
}
```

### Group symbols info
Request: `GET /symbol_info?group=<group_name>`

1. `group_name`: string

Example: `GET /symbol_info?group=NYSE`


Response: Response is expected to be an object with properties listed below. Each property is treated as table column, like described above (see [[response-as-a-table|UDF#response-as-a-table-concept]]). The response structure is similar (but **not equal**) to [[SymbolInfo|Symbology#symbolinfo-structure]] so see its description for details about all fields.

* **symbol**
* **description**
* **exchange-listed** / **exchange-traded**
* **minmov** / **minmovement**
* **minmov2**
* **fractional**
* **pricescale**
* **has-intraday**
* **has-no-volume**
* **type**
* **ticker**
* **timezone**
* **session-regular** (mapped to `SymbolInfo.session`)
* **supported-resolutions**
* **force-session-rebuild**
* **has-daily**
* **intraday-multipliers**
* **has-fractional-volume** (obsolete)
* **volume_precision**
* **has-weekly-and-monthly**
* **has-empty-bars**

Example: Here is the example of datafeed response to `GET /symbol_info?group=NYSE` (all data is artificial):
```javascript
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

**Remark 1**: This call will be used if your datafeed sent `supports_group_request: true` in configuration data or had not responded to configuration request at all.

**Remark 2**: if your datafeed does not support requested group (which should not happen if your response to request #1 (supported groups) is correct), Error 404 is expected.

**Remark 3**: using this mode (getting large bulks of symbols data) makes the browser to store data which user even wasn't asking for. So if your symbols list has more than a few items, please consider supporting symbol search / individual symbol resolve instead.


### Symbol resolve
Request: `GET /symbols?symbol=<symbol>`

1. `symbol`: string. Symbol name or ticker.

Example: `GET /symbols?symbol=AAL`, `GET /symbols?symbol=NYSE:MSFT`

Response: JSON containing object **exactly** similar to [[SymbolInfo|Symbology#symbolinfo-structure]]

**Remark**: This call will be requested if your datafeed sent `supports_group_request: false` and `supports_search: true` in configuration data.

### Symbol search
Request: `GET /search?query=<query>&type=<type>&exchange=<exchange>&limit=<limit>`

1. `query`: string. Text typed by user in Symbol Search edit box
2. `type`: string. One of the types [[supported|JS-Api#symbols_types]] by your back-end
3. `exchange`: string. One of the exchanges [[supported|JS-Api#exchanges]] by your back-end
4. `limit`: integer. Maximal items count in response

Example: `GET /search?query=AA&type=stock&exchange=NYSE&limit=15`

Response: Response is expected to be an array of symbol records as in [[respective JS API call|JS-Api#searchsymbolsbynameuserinput-exchange-symboltype-onresultreadycallback]]

**Remark**: This call will be requested if your datafeed sent `supports_group_request: false` and `supports_search: true` in configuration data.


### Bars
Request: `GET /history?symbol=<ticker_name>&from=<unix_timestamp>&to=<unix_timestamp>&resolution=<resolution>`

1. `symbol`: symbol name or ticker.
2. `from`: unix timestamp (UTC) of leftmost required bar
3. `to`: unix timestamp (UTC) of rightmost required bar
4. `resolution`: string

Example: `GET /history?symbol=BEAM~0&resolution=D&from=1386493512&to=1395133512`

Response: Response is expected to be an object with some properties listed below. Each property is treated as table column, like described above.

* **s**: status code. Expected values: `ok` | `error` | `no_data`
* **errmsg**: error message. Should be present just if `s = 'error'`
* **t**: bar time. unix timestamp (UTC)
* **c**: close price
* **o**: open price (optional)
* **h**: high price (optional)
* **l**: low price (optional)
* **v**: volume (optional)
* **nextTime**: time of the next bar if there is no data (status code is `no_data`) in the requested period (optional)

**Remark**: bar time for daily bars is expected to be a trading day (not session start day) at 00:00 UTC. Charting Library aligns time according to [Session](https://github.com/tradingview/charting_library/wiki/Symbology#session) from SymbolInfo

**Remark**: bar time for monthly bars is the first trading day of the month without the time part

**Remark**: prices should be passed as numbers, not quoted string

Example:
```javascript
{
   s: "ok",
   t: [1386493512, 1386493572, 1386493632, 1386493692],
   c: [42.1, 43.4, 44.3, 42.8]
}
```

```javascript
{
   s: "no_data",
   nextTime: 1386493512
}
```

```javascript
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
##### How `nextTime` works
Assume you watch the chart with resolution = 1 and Library asks you for data in range `[3 Apr 2015 16:00 UTC+0, 3 Apr 2015 19:00 UTC+0]` for stock which is traded in NYSE. 3 Apr was a Good Friday so market was closed. Library assumes that you'll respond something like

```javascript
{
  s: "no_data",
  nextTime: 1428001140000 // 2 Apr 2015 18:59:00 GMT+0
}
```

So `nextTime` is a time of the bar which is next to the left (at the imaginary time line) from left boundary of Library's original request.

All omitted prices will be treated as equal to `close`.

### Marks
Request: `GET /marks?symbol=<ticker_name>&from=<unix_timestamp>&to=<unix_timestamp>&resolution=<resolution>`

1. `symbol`: symbol name or ticker.
2. `from`: unix timestamp (UTC) of leftmost visible bar
3. `to`: unix timestamp (UTC) of rightmost visible bar
4. `resolution`: string

Response: Response is expected to be an object with some properties listed below. This object is similar to [[respective response|JS-Api#getmarkssymbolinfo-startdate-enddate-ondatacallback-resolution]] in JS API, but each property is treated as table column, like described above.

```javascript
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

**Remark**: This call will be requested if your datafeed sent `supports_marks: true` in configuration data.

### Timescale marks
Request: `GET /timescale_marks?symbol=<ticker_name>&from=<unix_timestamp>&to=<unix_timestamp>&resolution=<resolution>`

1. `symbol`: symbol name or ticker.
2. `from`: unix timestamp (UTC) or leftmost visible bar
3. `to`: unix timestamp (UTC) or rightmost visible bar
4. `resolution`: string

Response: Response is expected to be an array of objects with properties listed below.

1. `id`: unique identifier of a mark
2. `color`: rgba color
3. `label`: a letter to be displayed in a circle
4. `time`: unix time
5. `tooltip`: tooltip text

**Remark**: This call will be requested if your datafeed sent `supports_timescale_marks: true` in configuration data.

### Server time
Request: `GET /time`

Response: Numeric unix time without milliseconds. Example: 1445324591

### Quotes
Request: `GET /quotes?symbols=<ticker_name_1>,<ticker_name_2>,...,<ticker_name_n>`

Example: `GET /quotes?symbols=NYSE%3AAA%2CNYSE%3AF%2CNasdaqNM%3AAAPL`

Response: Response is an object.
* **s**: status code for request. Expected values: `ok` | `error`
* **errmsg**: error message for client
* **d**: [[symbols data|Quotes]] array

Example:

```javascript
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

## Constructor

`Datafeeds.UDFCompatibleDatafeed = function(datafeedURL, updateFrequency, protocolVersion)`

### datafeedURL

This is a URL of a data server which will get requests and return data.

### updateFrequency

This in an interval of real-time requests the datafeed will send to the server in milliseconds. Default is 10000 (10 sec).

### protocolVersion

`1` - outdated protocol which re-requests all data from the server every time the chart is scrolled.

`2` (default) - the data requests are incremental. The same data is never requested again when symbol or resolution is not changed (except last 2 bars).
