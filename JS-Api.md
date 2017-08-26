**What it is ?**: A set of JS methods (specific public interface).<br>
**What should I do to use it ?**: You should create a JS object which will receive the data by some way and respond to Charting Library requests.

Data caching (history & symbol info) is implemented in Charting Library. When you create an object implementing described interface, just pass it to Library widget constructor through [[`datafeed` argument|Widget-Constructor#datafeed-mandatory]].

# Methods
1. [[onReady|JS-Api#onreadycallback]]
2. [[searchSymbolsByName|JS-Api#searchsymbolsbynameuserinput-exchange-symboltype-onresultreadycallback]]
3. [[resolveSymbol|JS-Api#resolvesymbolsymbolname-onsymbolresolvedcallback-onresolveerrorcallback]]
4. [[getBars|JS-Api#getbarssymbolinfo-resolution-from-to-onhistorycallback-onerrorcallback-firstdatarequest]]
5. [[subscribeBars|JS-Api#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback]]
6. [[unsubscribeBars|JS-Api#unsubscribebarssubscriberuid]]
7. [[calculateHistoryDepth|JS-Api#calculatehistorydepthresolution-resolutionback-intervalback]]
8. [[getMarks|JS-Api#getmarkssymbolinfo-startdate-enddate-ondatacallback-resolution]]
9. [[getTimescaleMarks|JS-Api#gettimescalemarkssymbolinfo-startdate-enddate-ondatacallback-resolution]]
10. [[getServerTime|JS-Api#getservertimecallback]]

:chart: [[Trading Terminal]] specific:

1. [[getQuotes|JS-Api#chart-getquotessymbols-ondatacallback-onerrorcallback]]
2. [[subscribeQuotes|JS-Api#chart-subscribequotessymbols-fastsymbols-onrealtimecallback-listenerguid]]
3. [[unsubscribeQuotes|JS-Api#chart-unsubscribequoteslistenerguid]]
4. :chart: [[subscribeDepth|JS-Api#subscribedepthsymbolinfo-callback]]
5. :chart: [[unsubscribeDepth|JS-Api#unsubscribedepthsubscriberuid]]

### onReady(callback)
1. `callback`: function(configurationData)
    1. `configurationData`: object (see below)

This call is intended to provide the object filled with configuration data. 
This data affects some of chart behavior aspects so it is called [[server-side customization|Customization Overview#customization-done-through-data-stream]]. 
Charting Library expects you will call callback and pass your datafeed `configurationData` as an argument. 
Configuration data is an object; for now, following properties are supported:

##### exchanges
An array of exchange descriptors. Exchange descriptor is an object `{value, name, desc}`. `value` will be passed as `exchange` argument  to searchSymbolsByName (see below).

`exchanges` = []  leads to exchanges filter absence in Symbol Search list. Use `value` = "" if you want to create wildcard filter (all exchanges).

##### symbols_types
An array of filter descriptors. Filter descriptor is an object `{name, value}`. `value` will be passed as `symbolType` argument  to searchSymbolsByName.

`symbolsTypes` = []  leads to types filter absence in Symbol Search list. Use `value` = "" if you want to create wildcard filter (all types)

##### supported_resolutions
An array of supported resolutions. Resolution may be a number or a string. If the resolution is a number, it is treated as minutes count. Format is described in another [[article|Resolution]].

'resolutions'=undefined or [] leads to resolutons widget having its default content (see <http://tradingview.com/e/> ). Example: `[1, 15, 240, "D", "6M"]` will give you "1 minute, 15 minutes, 4 hours, 1 day, 6 months" in resolution widget.

##### supports_marks
Boolean showing whether your datafeed supports marks on bars or not.

##### supports_timescale_marks
Boolean showing whether your datafeed supports timescale marks or not.

##### supports_time
Set this one to `true` if your datafeed provides server time (unix time). It is used to adjust Countdown on the Price scale.

#####futures_regex
Set it if you want to group futures in the symbol search. This REGEX should divide an instrument name in 2 parts: a root and an expiration.
Sample regex: : `/^(.+)([12]!|[FGHJKMNQUVXZ]\d{1,2})$/`. It will be applied to the instruments whose `type` is `futures`.

####

### searchSymbolsByName(userInput, exchange, symbolType, onResultReadyCallback)
1. `userInput`: string. It is text entered by user in symbol search field
2. `exchange`: string. The requested exchange (chosen by user). Empty value means no filter was specified.
3. `symbolType`: string. The requested symbol type: index, stock, forex e.t.c. (chosen by user). Empty value means no filter was specified.
4. `onResultReadyCallback`: function(result)
    1. `result`: array (see below)

This call is intended to provide the list of symbols matching to user's search query. `result` is expected to be smth like this:

```javascript
[
    {
        "symbol": <short symbol name>,
        "full_name": <full symbol name> // e.g., BTCE:BTCUSD
        "description": <symbol description>,
        "exchange": <symbol exchange name>,
        "ticker": <symbol ticker name, optional>,
        "type": "stock" | "futures" | "bitcoin" | "forex" | "index"
    }, {
        //    .....
    }
]
```

If no symbols are found, then callback should be called with an empty array. See more details about `ticker` value [[here|Symbology#ticker]]

### resolveSymbol(symbolName, onSymbolResolvedCallback, onResolveErrorCallback)
1. `symbolName`: string. Symbol name or `ticker` if provided.
2. `onSymbolResolvedCallback`: function([[SymbolInfo|Symbology#symbolinfo-structure]])
3. `onResolveErrorCallback`: function(reason)

Charting Library will call this function when it need to get [[SymbolInfo|Symbology#symbolinfo-structure]] by symbol's name.

### getBars(symbolInfo, resolution, from, to, onHistoryCallback, onErrorCallback, firstDataRequest)
1. `symbolInfo`: [[SymbolInfo|Symbology#symbolinfo-structure]] object
2. `resolution`: string
3. `from`: unix timestamp, leftmost required bar time
3. `to`: unix timestamp, rightmost required bar time
4. `onHistoryCallback`: function(array of `bar`s, `meta` = _{ noData = false }_)
    1. `bar`: object `{time, close, open, high, low, volume}`
    2. `meta`: object `{noData = true | false, nextTime - unix time}`
5. `onErrorCallback`: function(reason)
6. `firstDataRequest`: boolean to identify the first history call for this symbol/resulution. When it is `true` you can ignore `to` (which depends on browser's `Date.now()`) and return bars up to current bar (including it).

This function is called when chart needs a history fragment defined by dates range. The charting library expects `onHistoryCallback` to be called **just once** after receiving all the requesting history. No further calls are expected.

**Important**: `nextTime` is a time of the next bar in the history. It should be set when there is no data in the requested period only.

**Important**: `noData` should be set when there is no data in the requested period and earlier only.

**Remark**: `bar.time` is expected to be the amount of milliseconds since Unix epoch start in **UTC** timezone.

**Remark**: `bar.time` for daily bars is expected to be a trading day (not session start day) at 00:00 UTC. Charting Library aligns time according to [Session](https://github.com/tradingview/charting_library/wiki/Symbology#session) from SymbolInfo

**Remark**: `bar.time` for monthly bars is the first trading day of the month without the time part


### subscribeBars(symbolInfo, resolution, onRealtimeCallback, subscriberUID, onResetCacheNeededCallback)
1. `symbolInfo`: [[SymbolInfo|Symbology#symbolinfo-structure]] object
2. `resolution`: string
3. `onRealtimeCallback`: function(bar)
    1. `bar`: object `{time, close, open, high, low, volume}`
4. `subscriberUID`: object
5. `onResetCacheNeededCallback` (since 1.7): function() to be executed when bars data has changed

Charting Library calls this function when it wants to receive realtime updates for a symbol. Chart expects you will call `onRealtimeCallback` every time you want to update the most recent bar or to append a new one.

**Remark**: When you call `onRealtimeCallback` with bar having time equal to most recent bar's time, the whole last bar is replaced with the `bar` object you've passed into the call. Example:

1. The most recent bar is `{1419411578413, 10, 12, 9, 11}`
2. You call `onRealtimeCallback({1419411578413, 10, 14, 9, 14})`
3. Library finds out that bar with time `1419411578413` already exists and is the most recent one
4. Library replaces the whole bar so now the most recent bar is `{1419411578413, 10, 14, 9, 14}`

**Remark 2**: Is it possible either to update the most recent bar or to append a new one with `onRealtimeCallback`. You've get an error if you call this function trying to update a bar in history.

**Remark 3**: For now, there is no way to change bars in history after the chart received it.

### unsubscribeBars(subscriberUID)
1. `subscriberUID`: object

Library calls this function when is doesn't want to receive updates for this subscriber any more. `subscriberUID` will be the same object which Library passed to `subscribeBars` before.

### calculateHistoryDepth(resolution, resolutionBack, intervalBack). Optional.
1. `resolution`: requested symbol's resolution
2. `resolutionBack`: desired history period dimension. Supported values: `D` | `M`
3. `intervalBack`: amount or `resolutionBack` periods which Library is going to request

Charting Library calls this function when it is going to request some history data to give you an ability to override required history depth. It passes some arguments so you could know how much bars is it going to get. Here are a few examples:

* `calculateHistoryDepth("D", "M", 12)` called: the Library is going to request 12 months of daily bars
* `calculateHistoryDepth(60, "D", 15)` called: the Library is going to request 15 days of hourly bars

This function should return `undefined` if you do not want to override anything. If you do, it should return an object `{resolutionBack, intervalBack}`. Properties meaning is similar to respective arguments' one.

Example:

Assume the implementation is
```javascript
Datafeed.prototype.calculateHistoryDepth = function(resolution, resolutionBack, intervalBack) {
    if (period == "1D") {
        return {
            resolutionBack: 'M',
            intervalBack: 6
        };
    }
}
```

This means when Charting Library will request the data for '1D' resolution, the history will be 6 months in depth. In all other cases the history depth will have the default value.


### getMarks(symbolInfo, startDate, endDate, onDataCallback, resolution). Optional.
1. `symbolInfo`: [[SymbolInfo|Symbology#symbolinfo-structure]] object
2. `startDate`: unix timestamp (UTC). Leftmost visible bar's time.
3. `endDate`: unix timestamp (UTC). Rightmost visible bar's time.
4. `onDataCallback`: function(array of `mark`s)
5. `resolution`: string

Library calls this function to get [[marks|Marks-On-Bars]] for visible bars range. Chart expects you to call `onDataCallback` only once per each `getMarks` call. `mark` is an object having following properties:

* **id**: unique mark id. Will be passed to a [[respective callback|Widget-Methods#onbarmarkclickedcallback]] when user clicks on a mark
* **time**: unix time, UTC
* **color**: `red` | `green` | `blue` | `yellow` | `{ border: '#ff0000', background: '#00ff00' }`
* **text**: mark popup text. HTML supported
* **label**: a letter to be printed on a mark. Single character
* **labelFontColor**: color of a letter on a mark
* **minSize**: minimal size of mark (diameter, pixels)

A few marks per bar are allowed (for now, maximum is 10). Marks out of bars are not allowed.

**Remark**: This function will be called only if you declared your back-end is [[supporting marks|JS-Api#supports_marks]].

### getTimescaleMarks(symbolInfo, startDate, endDate, onDataCallback, resolution). Optional.
1. `symbolInfo`: [[SymbolInfo|Symbology#symbolinfo-structure]] object
2. `startDate`: unix timestamp (UTC). Leftmost visible bar's time.
3. `endDate`: unix timestamp (UTC). Rightmost visible bar's time.
4. `onDataCallback`: function(array of `mark`s)
5. `resolution`: string

Library calls this function to get timescale marks for visible bars range. Chart expects you to call `onDataCallback` only once per each `getTimescaleMarks` call. `mark` is an object having following properties:

* **id**: unique mark id. Will be passed to a [[respective callback|Widget-Methods#ontimescalemarkclickedcallback]] when user clicks on a mark
* **time**: unix time, UTC
* **color**: `red` | `green` | `blue` | `yellow` | ... | #000000
* **label**: a letter to be printed on a mark. Single character
* **tooltip**: array of text strings. Each element of the array is a new text line of a tooltip.

Only one mark per bar is allowed. Marks out of bars are not allowed.

**Remark**: This function will be called only if you declared your back-end is [[supporting marks|JS-Api#supports_timescale_marks]].

### getServerTime(callback). Optional.
1. `callback`: function(unixTime)

This function is called if configuration flag `supports_time` is set to `true` when chart needs to know the server time. The charting library expects callback to be called once. The time is provided without milliseconds. Example: `1445324591`. It is used to display Countdown on the price scale.

## :chart: [[Trading Terminal]] specific

### :chart: getQuotes(symbols, onDataCallback, onErrorCallback)
1. `symbols`: array of symbols names
2. `onDataCallback`: function(array of `data`)
    1. `data`: [[symbol quote data|Quotes#symbol-quote-data]]
3. `onErrorCallback`: function(reason)

This function is called when chart needs quotes data. The charting library expects onDataCallback to be called once when all requesting data received. No further calls are expected.

### :chart: subscribeQuotes(symbols, fastSymbols, onRealtimeCallback, listenerGUID)
1. `symbols`: array of symbols to be updated rarely (suggested frequency is once per minute). These symbols are in the watch list but they are not visible at the moment.
2. `fastSymbols`: array of symbols to be updated quite frequently (once in 10 seconds or more often)
3. `onRealtimeCallback`: function(array of `data`)
    1. `data`: [[symbol quote data|Quotes#symbol-quote-data]]
4. `listenerGUID`: unique identifier of the listener

Trading Terminal calls this function when it wants to receive realtime quotes for a symbol. Chart expects you will call `onRealtimeCallback` every time you want to update quotes.

### :chart: unsubscribeQuotes(listenerGUID)
1. `listenerGUID`: unique identifier of the listener

Trading Terminal calls this function when is doesn't want to receive updates for this listener any more. `listenerGUID` will be the same object which Library passed to `subscribeQuotes` before.

### :chart: subscribeDepth(symbolInfo, callback): String
1. `symbolInfo`: [[SymbolInfo|Symbology#symbolinfo-structure]] object
2. `callback`: function(depth)
    1. `depth`: object `{snapshot, asks, bids}`
        1. `snapshot`: Boolean - if `true` `asks` and `bids` have full set of depth, otherwise they contain only updated levels.
        2. `asks`: Array of `{price, volume}`
        3. `bids`: Array of `{price, volume}`

Trading Terminal calls this function when it wants to receive realtime level 2 (DOM) for a symbol. Chart expects you will call `callback` every time you want to update depth data.
This method should return unique identified (subscriberUID) that will be used to unsubscribe data.

### :chart: unsubscribeDepth(subscriberUID)
1. `subscriberUID`: String

Trading Terminal calls this function when is doesn't want to receive updates for this listener any more. `subscriberUID` will be the same object which you have returned from `subscribeDepth`.
