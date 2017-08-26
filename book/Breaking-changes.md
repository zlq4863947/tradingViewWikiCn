We do our best to make every next version fully compartible with the previous one, but sometimes big changes requires you to make minor changes in your code when upgrading to a new version.

_Note: you can check Charting Library version by executing `TradingView.version()` in a browser console._

Here is the list of breaking changes:

**Version 1.11**
The following stuff is still supported in Trading Terminal, but will be deprecated in future versions:
- `supportDOME` renamed to `supportDOM`
- Changed signature of `showClosePositionDialog
- `showEditBracketsDialog` renamed to `showPositionBracketsDialog`, changed signature


**Version 1.10**
- Default behavior of Volume indicator is changed.

Previous behavior: Volume indicator is added/removed when an instrument or a resolution is switched depending on volume support by the instrument. You can get back to this behavior by disabling `create_volume_indicator_by_default_once` featureset.

New behavior: Volume indicator is added on first load of an empty chart if it is supported by an active instrument.

**Version 1.9**
- We don't compile Pine scripts anymore. You can still use scripts compiled before.

**Version 1.8 of Trading Terminal**
-  Chart has no option to show only actual orders anymore. Appropriate methods have been removed.
- `showOrderDialog` receives an object instead of arguments list
- `showSampleOrderDialog` removed, use [[showOrderDialog|Trading-Host#showorderdialogorder-handler]] instead
- `showOrderDialog` removed from [[Trading Controller|Trading-Controller]], use `placeOrder` and `modifyOrder` receive `silently` argument instead
- `reversePosition`, `closePosition`, `cancelOrder` have an additional argument `silently`. They should should appropriate dialogs by themselves from now.

**Version 1.7**

- Since this version it is not enough to call `setSymbol` with the same symbol. You should call `onResetCacheNeededCallback` from `subscribeBars` first. Then you can use `setSymbol` or new `resetData` method of the chart.
- JSAPI protocol version 1 is not supported any more. `nextTime` and `noData` must be provided.

**Version 1.5**

* Added `source` argument to MACD. You should change MACD creation code to pass `source` also.
`chartWidget.chart().createStudy('MACD', false, false, [12, 26, "close", 9])`

**Version 1.4**

* Override `transparency` is not supported anymore. We added transparency support to every color property. Use `rgba` form to define a color with transparency. Example: 
`"symbolWatermarkProperties.color" : "rgba(60, 70, 80, 0.05)"`

**Version 1.3**

* Override `paneProperties.gridProperties.*` is not supported anymore. 
Please use `paneProperties.vertGridProperties.*` and `paneProperties.horzGridProperties.*`

* Override `mainSeriesProperties.candleStyle.wickColor` is not supported anymore.
Use `mainSeriesProperties.candleStyle.wickUpColor` and `mainSeriesProperties.candleStyle.wickDownColor`
