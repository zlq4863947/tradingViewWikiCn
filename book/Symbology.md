# Symbology（商品体系）

---

图表库使用您自己的数据，您自己定义商品体系。 您可以根据需要命名商品。


但有些细节你应该知道:

1. 我们自己定义的商品名称必须为此格式：`EXCHANGE:SYMBOL`。 图表默认使用此格式
2. 如果已经有或者考虑区别不同的商品，那么你可能需要使用`ticker`字段。
   `ticker` 为商品唯一标识符，只用于图表的内部，您的用户将不会看到它。
   `ticker`为 **仅在** 图表库内部使用的商品唯一标识符。 您的用户将永远无法看到它。
    只需在所有SymbolInfo对象和商品搜索结果中输入`ticker`值，图表库将根据这些值请求数据。

## [商品信息结构](#商品信息结构)

这一节非常重要。 图表库用户遇到的72.2％的问题，都是由于错误的/格式错误的SymbolInfo数据引起的。

SymbolInfo是一个包含商品metadata的对象。 该对象是解析商品的结果。 SymbolInfo有以下字段：

##### [name](#name)

商品名称。您的用户将看到它\(作为一个字符串\)。 此外，如果您不使用`tickers`，它将用于数据请求。

##### [ticker](#ticker)

它是您的商品体系中此商品的唯一标识符。如果您指定此属性，则其值将用于所有数据请求，`ticker`如果未明确指定，则被视为等于`symbol`。(译者注：请一定指定`ticker`，如果没有`ticker`可以将`symbol`赋值给`ticker`，未指定`ticker`时会发生错误。)

##### [description](#description)

商品说明。这个商品说明将被打印在图表的标题栏中。

##### [type](#type)

仪表的可选类型。 

*可能的类型是:*

- `stock`
- `index`
- `forex`
- `futures`
- `bitcoin`
- `expression`
- `spread`
- `cfd`
- 或其他字符串。

##### [session](#session)

商品交易时间。请参阅交易日细节了解更多详情。[交易时段](/book/Trading-Sessions.md)

##### [exchange, listed\_exchange](#exchange-listedexchange)

现在，这两个字段都为某个交易所的略称。将被显示在图表的图例中，以表示此商品。目前此字段不用于其他目的。

##### [timezone](#timezone)

这个商品的交易所时区。我们希望以olsondb格式获取时区的名称。

*支持的时区为:*

- `Etc/UTC`
- `Africa/Cairo`
- `Africa/Johannesburg`
- `Africa/Lagos`
- `America/Argentina/Buenos_Aires`
- `America/Bogota`
- `America/Caracas`
- `America/Chicago`
- `America/El_Salvador`
- `America/Juneau`
- `America/Lima`
- `America/Los_Angeles`
- `America/Mexico_City`
- `America/New_York`
- `America/Phoenix`
- `America/Santiago`
- `America/Sao_Paulo`
- `America/Toronto`
- `America/Vancouver`
- `Asia/Almaty`
- `Asia/Ashkhabad`
- `Asia/Bahrain`
- `Asia/Bangkok`
- `Asia/Chongqing`
- `Asia/Dubai`
- `Asia/Ho_Chi_Minh`
- `Asia/Hong_Kong`
- `Asia/Jakarta`
- `Asia/Jerusalem`
- `Asia/Kathmandu`
- `Asia/Kolkata`
- `Asia/Kuwait`
- `Asia/Muscat`
- `Asia/Qatar`
- `Asia/Riyadh`
- `Asia/Seoul`
- `Asia/Shanghai`
- `Asia/Singapore`
- `Asia/Taipei`
- `Asia/Tehran`
- `Asia/Tokyo`
- `Atlantic/Reykjavik`
- `Australia/ACT`
- `Australia/Adelaide`
- `Australia/Brisbane`
- `Australia/Sydney`
- `Europe/Athens`
- `Europe/Belgrade`
- `Europe/Berlin`
- `Europe/Copenhagen`
- `Europe/Helsinki`
- `Europe/Istanbul`
- `Europe/London`
- `Europe/Luxembourg`
- `Europe/Madrid`
- `Europe/Moscow`
- `Europe/Paris`
- `Europe/Riga`
- `Europe/Rome`
- `Europe/Stockholm`
- `Europe/Tallinn`
- `Europe/Vilnius`
- `Europe/Warsaw`
- `Europe/Zurich`
- `Pacific/Auckland`
- `Pacific/Chatham`
- `Pacific/Fakaofo`
- `Pacific/Honolulu`
- `Pacific/Norfolk`
- `US/Mountain`

##### [minmov\(最小波动\), pricescale\(价格精度\), minmove2, fractional\(分数\)](#minmov最小波动-pricescale价格精度-minmove2-fractional分数)

1. 最小的价格变化是由这些值决定的。
2. PriceScale 参数确定了图表价格量表上的价格线之间的周期。

这三个键有不同意义时，使用通常价格和分数价格。

##### [通常价格](#通常价格)

```
MinimalPossiblePriceChange（最小可能价格变动） = minmov / pricescale
```

`minmov`数字型单位组成一个tick。例如，美国股票价格和tick有小数，并可以上下浮动+/- 0.01。

##### [分数价格](#分数价格)

分数显示价格,1 - xx'yy（例如，133'21\)或 2 - xx'yy'zz （例如，133'21'5）。

##### [minmove2&lt;0&gt;](#minmove20)

这是一个神奇的数字来格式化复杂情况下的价格。这里有一些例子:

```
典型的股票以0.01价格增量：minmov = 1，pricecale = 100，minmove2 = 0
ZBM2014（国债），1/32：minmov = 1，pricecale = 32，minmove2 = 0
ZCM2014（玉米），2/8：minmov = 2，pricecale = 8，minmove2 = 0
ZFM2014（5年期国债），1/32的1/4：minmov = 1，pricecale = 128，minmove2 = 4
```

##### [has\_intraday](#hasintraday)

布尔值显示商品是否具有日内（分钟）历史数据。 如果它为`false`，则当图表中的该商品处于活动状态时，日内周期的所有按钮将被禁用。 如果设置为`true`，则由datafeed直接提供的所有周期必须在intraday\_multipliers数组中设定。

##### [supported\_resolutions](#supportedresolutions)

在这个商品的周期选择器中启用一个周期数组。 数组的每个项目都是字符串。

被datafeed支持（见datafeed配置数据）但不受当前商品支持的周期,将在周期选择器部件中禁用。 如果更改商品，新商品不支持选定的周期，则周期将切换到支持的周期列表中的第一项。 周期可用性逻辑（伪代码）:

```js
resolutionAvailable  =
    resolution.isIntraday ?
       symbol.has_intraday && symbol.supports_resoluiton(resolution) :
    symbol.supports_resoluiton(resolution);
```

如果在商品信息中没有supported\_resolutionsin，则所有DWM(daily, weekly, monthly)周期都可用。 如果has\_intraday为true，则日内周期可用。

支持的周期也会影响可用的时间范围。 如果使用不支持的周期，则时间范围将不可用。

##### [intraday\_multipliers &lt;\[\]&gt;](#intradaymultipliers-)

这是一个包含日内周期\(分钟单位\)的数组，datafeed将会自行构建它。

举例来说：如果datafeed报告说它支持 \["1", "5", "15"\]，但事实上股票X只有1分钟的数据，股票X将设定 intraday\_multipliers = \[1\]，那么Charting Library将自行构建5分钟和15分钟的周期。

##### [has\_seconds](#hasseconds)

布尔值显示商品是否具有以秒为单位的历史数据。如果它为`false`，那么在图表中此商品处于活动状态时，所有秒的周期的按钮将被禁用。如果它为`true`，则由datafeed直接提供的所有周期必须在`seconds_multipliers`数组中设定。

##### [seconds\_multipliers &lt;\[\]&gt;](#secondsmultipliers-)

这是一个包含秒周期\(以秒为单位，无小数\) ，datafeed将会自行构建它。  
举例来说：如果datafeed报告说它支持 \["1S", "5S", "15S"\]，但事实上股票X只有1秒钟的数据，股票X将设定 seconds\_multipliers = \[1\]，那么Charting Library将自行构建5S和15S的周期。

##### [has\_daily](#hasdaily)

布尔值显示商品是否具有以日为单位的历史数据。如果它为false，则Charting Library将自行构建日单位的周期。如果没有，则会向datafeed请求这些数据。

##### [has\_weekly\_and\_monthly](#hasweeklyandmonthly)

布尔值显示商品是否具有以W和M为单位的历史数据。如果它为false，则Charting Library将通过日单位的周期自行构建。如果没有，则会向datafeed请求这些数据。

##### [has\_empty\_bars](#hasemptybars)

布尔值显示在交易过程中，当datafeed没有数据返回时,library是否会生成空的K柱。

即，如果您的交易时间为0900-1600，而您的实际数据在11:00和12:00之间没有交易，而您的has\_empty\_bars为true，那么Library会在此段时间贴上退化的K柱。

##### [force\_session\_rebuild](#forcesessionrebuild)

布尔值显示library是否会随着当前交易而过滤K柱。如果为false，则当library从其他周期构建数据或将has\_empty\_bars设置为true时，K柱将被过滤。 如果为true，Library将会删除那些不是交易K柱的数据。

##### [has\_no\_volume](#hasnovolume)

布尔表示商品是否拥有成交量数据。

##### [has\_fractional\_volume](#hasfractionalvolume--已过时11---15-用法与volumeprecision相反) \| 已过时\(1.1 - 1.5\), 用法与volume\_precision相反

如果has\_fractional\_volume = true，成交量指标值将不会舍入为整数值。

##### [volume\_precision &lt;0&gt;](#volumeprecision-0)

整数显示此商品的成交量数字的小数位。0表示只显示整数。1表示保留小数位的1个数字字符，等等。

##### [data\_status](#datastatus)

数据状态码。状态显示在图表的右上角。

*支持的值:*

- `streaming`\(实时\)
- `endofday`\(已收盘\)
- `pulsed`\(脉冲\)
- `delayed_streaming`\(延迟流动中\)

##### [expired](#expired)

期满，布尔值显示此商品是否为到期的期货合约。

##### [expiration\_date](#expirationdate)

到期日\(Unix时间戳\)。 如果`expired` = `true`，则必须设置此值。 图表库将从该时间点而不是实际时刻请求该商品的数据。

##### [sector](#sector)

板块，将在股票信息中显示。

##### [industry](#industry)

行业，将在股票信息中显示。

##### [currency\_code](#currencycode)

货币代码，将在商品信息中显示。

