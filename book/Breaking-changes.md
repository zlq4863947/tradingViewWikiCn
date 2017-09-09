#版本变更点

---

我们尽最大努力使每个新版本与前一版本完全兼容，但有时需要大的更改需要在升级到新版本时对代码进行微小的更改。


_注意：您可以通过在浏览器控制台中执行 `TradingView.version()` 来检查图表库版本。_

以下是变更列表：

**Version 1.11**
交易终端中仍然支持以下内容，但在将来的版本中将不再使用以下内容：
- `supportDOME` 重命名为 `supportDOM`
- 更改了签名 `showClosePositionDialog
- `showEditBracketsDialog` 重命名为 `showPositionBracketsDialog`, 更改了签名


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
