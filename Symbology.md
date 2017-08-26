Charting Library consumes your own data so symbology is 100% up to you. You may use whatever naming convention you want. Just return symbol info in Charting Library format and use arbitrary symbols names. Virtually, symbol name may be an arbitrary string containing any characters.

But there are some fine points you should know about:

1. Our own symbology assumes symbols names have `EXCHANGE:SYMBOL` format. Surely Library supports this by default. So if you like it -- just keep calm and use it.
2. Already having other symbology or just going to have one ? There is `ticker` term defined expecially for you. `Ticker` is symbol's unique identifier which is used **only** inside of Library. Your users will never see it. So just put `ticker` values in all of your SymbolInfo and Symbol Search results and expect Charting Library will ask you for data using those values.

## SymbolInfo Structure

**This section is extremely important. 72.2% of all issues experienced by Charting Library users are caused by wrong/malformed SymbolInfo data.**

SymbolInfo is an object containing symbol metadata. This object is the result of resolving the symbol. SymbolInfo has following fields:

##### name
It's name of a symbol. It is a string which your users will see. Also, it will be used for data requests if you are not using **tickers**.

##### ticker
It's an unique identifier for this symbol in your symbology. If you specify this property then its value will be used for all data requests for this symbol. `ticker` is treated to be equal to `symbol` if not specified explicitly.

##### description
Description of a symbol. Will be printed in chart legend for this symbol.

##### type
Optional type of the instrument. Possible values: `stock`, `index`, `forex`, `futures`, `bitcoin`, `expression`, `spread`, `cfd` or another string value. Some types has specific processing in the chart.

##### session
Trading hours for this symbol. See the [[Trading Sessions|Trading Sessions]] article to know more details.

##### exchange, listed_exchange
For now both of this fields are expected to have short name of exchange where this symbol is traded. This name will be printed in chart's legend for this symbol. This field is not used for other purposes now.

##### timezone
Exchange timezone for this symbol. We expect to get name of time zone in olsondb format. Supported timezones are:
```
America/New_York
America/Los_Angeles
America/Chicago
America/Phoenix
America/Toronto
America/Vancouver
America/Argentina/Buenos_Aires
America/El_Salvador
America/Sao_Paulo
America/Bogota
America/Caracas
Europe/Moscow
Europe/Athens
Europe/Berlin
Europe/London
Europe/Madrid
Europe/Paris
Europe/Warsaw
Europe/Istanbul
Europe/Zurich
Australia/Sydney
Australia/Brisbane
Australia/Adelaide
Australia/ACT
Asia/Almaty
Asia/Ashkhabad
Asia/Tokyo
Asia/Taipei
Asia/Singapore
Asia/Shanghai
Asia/Seoul
Asia/Tehran
Asia/Dubai
Asia/Kolkata
Asia/Hong_Kong
Asia/Bangkok
Pacific/Auckland
Pacific/Chatham
Pacific/Fakaofo
Pacific/Honolulu
America/Mexico_City
Africa/Johannesburg
Asia/Kathmandu
US/Mountain
```

##### minmov, pricescale, minmove2, fractional

These three keys have different meaning when using for common prices and for fractional prices.

###### Common prices

```
 MinimalPossiblePriceChange = minmov / pricescale
```

`minmov` is a number of units that make up one tick. For example, U.S. equities are quotes in decimals, and tick in decimals, and can go up +/- 0.01.
So the tick increment is 1. But the e-mini S&P futures contract, though quoted in decimals, goes up in 0.25 increments, so the tick increment is 25.
`pricescale` defines number of decimal places. Actually it is 10^number-of-decimal-places. If a price is displayed as 1.01, `pricescale` is `100`; If it is displayed as 1.005, `pricescale` is `1000`.
`minmove2` for common prices is `0` or it can be skipped.
`fractional` for common prices is `false` or it can be skipped.

Example:
```
Typical stock with 0.01 price increment: minmov = 1, pricescale = 100, minmove2 = 0
```

###### Fractional prices

Fractional prices are displayed as form 1 - `xx'yy` (for example, `133'21`) or form 2 - `xx'yy'zz` (for example, `133'21'5`).

`xx` is an integer part.

`minmov/pricescale` is a Fraction.

`minmove2` is used in form 2.

`fractional` is `true`

Example:
```
If minmov = 1, pricescale = 128 and minmove2 = 4
119'16'0 represents 119 + 16/32
119'16'2 represents 119 + 16.25/32
119'16'5 represents 119 + 16.5/32
119'16'7 represents 119 + 16.75/32
```

More examples:
```
ZBM2014 (T-Bond) with 1/32: minmov = 1, pricescale = 32, minmove2 = 0
ZCM2014 (Corn) with 2/8: minmov = 2, pricescale = 8, minmove2 = 0
ZFM2014 (5 year t-note) with 1/4 of 1/32: minmov=1, pricescale=128, minmove2= 4
```

##### has_intraday <false>
Boolean showing whether symbol has intraday (minutes) history data. If it's false then all buttons for intradays resolutions will be disabled when this symbol is active in chart.
If it is set to true, all resolutions that are supplied directly by the datafeed must be provided in `intraday_multipliers` array.

##### supported_resolutions
An array of resolutions which should be enabled in resolutions picker for this symbol. Each item of an array is expected to be a string. Format is described in another [[article|Resolution]].

Resolutions treated as supported by datafeed (see datafeed configuration data) but not supported by the current symbol will be disabled in Resolution picker widget. If one changes the symbol and new symbol does not support the selected resolution then resolution will be switched to first one in supported resolutions list. Resolution availability logic (pseudocode):
```
resolutionAvailable  =
    resolution.isIntraday ?
       symbol.has_intraday && symbol.supports_resoluiton(resolution) :
    symbol.supports_resoluiton(resolution);
```

In case of absence of `supported_resolutions` in a symbol info all DWM resolutions will be available. Intraday resolutions will be available if `has_intraday` is `true`.

Supported resolutions affect available time frames too. The timeframe will not be available if it requires the resolution which is not supported.

##### intraday_multipliers <[]>
It is an array containing intraday resolutions (in minutes) the datafeed wants to build by itself. E.g., if the datafeed reported he supports resolutions ["1", "5", "15"], but in fact it has only 1 minute bars for symbol X, it should set intraday_multipliers of X = [1]. This will make Charting Library to build 5 and 15 resolutions by itself.

##### has_seconds <false>
Boolean showing whether symbol has sedonds history data. If it's false then all buttons for seconds resolutions will be disabled when this symbol is active in chart.
If it is set to true, all resolutions that are supplied directly by the datafeed must be provided in `seconds_multipliers` array.

##### seconds_multipliers <[]>
It is an array containing seconds resolutions (in seconds without a postfix) the datafeed wants to build by itself. E.g., if the datafeed reported he supports resolutions ["1S", "5S", "15S"], but in fact it has only 1 second bars for symbol X, it should set seconds_multipliers of X = [1]. This will make Charting Library to build 5S and 15S resolutions by itself.

##### has_daily <false>
The boolean value showing whether datafeed has its own D resolution bars or not. If `has_daily` = false then Charting Library will build respective resolutions from intraday by itself. If not, then it will request those bars from datafeed.

##### has_weekly_and_monthly <false>
The boolean value showing whether datafeed has its own W and M resolution bars or not. If has_weekly_and_monthly = false then Charting Library will build respective resolutions from D by itself. If not, then it will request those bars from datafeed.

##### has_empty_bars <false>
The boolean value showing whether the library should generate empty bars in session when there is no data from datafeed for this time. I.e., if your session is `0900-1600` and your real data lacks of trades between `11:00` and `12:00` and your `has_empty_bars` is true, then Library will paste degenerate bars in this time.

##### force_session_rebuild <true>
The boolean value showing whether library should filter bars using current session. If `false`, bars will be filtered only when the library builds data from another resolution or if `has_empty_bars` was set to true. If `true`, the Library will remove from your data those bars that does not belong to the trading session.

##### has_no_volume <false>
Boolean showing whether symbol has volume data or not.

##### volume_precision <0>
Integer showing typical volume value decimal places for this symbol. 0 means volume always in an integer. 1 means there may be 1 numeric character after comma and so on.

##### data_status
The status code of a series with this symbol. The status is shown in upper right corner of a chart. Supported values:
* streaming
* endofday
* pulsed
* delayed_streaming

##### expired <false>
Boolean showing whether this symbol is expired futures contract or not.

##### expiration_date
Unix timestamp of expiration date. One must set this value if `expired` = true. Charting Library will request data for this symbol starting from that time point instead of actual moment.

##### sector
Sector for stocks to be displayed in Symbol Info.

##### industry
Industry for stocks to be displayed in Symbol Info.

##### currency_code
Currency to be displayed in Symbol Info.
