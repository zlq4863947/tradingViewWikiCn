# 图表方法

---

Here is a list of supported chart's methods.

**Before 1.4 version.**You can call these methods using widget object returned to you by widget's constructor.

**Since 1.5 version.**You can call these methods using chart object returned to you by widget's methods[chart\(index\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#chart-chartindex)or[activeChart\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#chart-activechart).

# Methods

* Subscribing To Chart Events
  * [onDataLoaded\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#ondataloaded)
  * [onSymbolChanged\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#onsymbolchanged)
  * [onIntervalChanged\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#onintervalchanged)
  * [dataReady\(callback\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#datareadycallback)
  * [crossHairMoved\(callback\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#crosshairmovedcallback)
* Chart Actions
  * [setVisibleRange\(range, callback\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#setvisiblerangerange-callback)
  * [setSymbol\(symbol, callback\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#setsymbolsymbol-callback)
  * [setResolution\(resolution, callback\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#setresolutionresolution-callback)
  * [resetData\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#resetData)
  * [executeAction\(action\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#executeactionaction)
  * [executeActionById\(action\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#executeactionbyidactionid)
  * [getCheckableActionState\(action\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#getcheckableactionstateactionid)
  * [refreshMarks\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#refreshmarks)
  * [clearMarks\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#clearmarks)
  * [setChartType\(type\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#setcharttypetype)
* Studies And Shapes
  * [getAllShapes\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#getallshapes)
  * [getAllStudies\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#getallstudies)
  * [setEntityVisibility\(id, isVisible\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#setentityvisibilityid-isvisible)
  * [createStudy\(name, forceOverlay, lock, inputs, callback, overrides, options\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#createstudyname-forceoverlay-lock-inputs-callback-overrides-options)
  * [createShape\(point, options, callback\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#createshapepoint-options-callback)
  * [createMultipointShape\(points, options, callback\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#createmultipointshapepoints-options-callback)
  * [removeEntity\(entityId\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#removeentityentityid)
  * [createVerticalLine\(point, options\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#createverticallinepoint-options)
  * [removeAllShapes\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#removeallshapes)
  * [removeAllStudies\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#removeallstudies)
* Study Templates
  * [createStudyTemplate\(options, callback\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#createstudytemplateoptions-callback)
  * [applyStudyTemplate\(template\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#applystudytemplatetemplate)
* Trading Primitives
  * [createOrderLine\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#createorderlineoptions)
  * [createPositionLine\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#createpositionlineoptions)
  * [createExecutionShape\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#createexecutionshapeoptions)
* Getters
  * [symbol\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#symbol)
  * [symbolExt\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#symbolExt)
  * [resolution\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#resolution)
  * [getVisibleRange\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#getvisiblerange)
  * [getVisiblePriceRange\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#getvisiblepricerange)
  * [priceFormatter\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#priceformatter)
  * [chartType\(\)](https://github.com/tradingview/charting_library/wiki/Chart-Methods#charttype)

# Subscribing To Chart Events

#### onDataLoaded\(\)

You can subscribe using[Subscription](https://github.com/tradingview/charting_library/wiki/Subscription)object returned by this function to be notified when new history bars are loaded and unsubscribe from the event.

#### onSymbolChanged\(\)

You can subscribe using[Subscription](https://github.com/tradingview/charting_library/wiki/Subscription)object returned by this function to be notified when the symbol is changed and unsubscribe from the event.

#### onIntervalChanged\(\)

You can subscribe using[Subscription](https://github.com/tradingview/charting_library/wiki/Subscription)object returned by this function to be notified when the interval is changed and unsubscribe from the event. When the event is fired it will provide the following arguments:

1. `interval`
   : new interval
2. `timeframeParameters`
   : object with the only field
   `timeframe`
   . It contains a timeframe if the interval is changed as a result of a user click on a timeframe panel. Otherwise
   `timeframe`
   is
   `undefined`
   and you can change it to display a certain range of bars. Valid timeframe is a number with letter
   `D`
   for days and
   `M`
   for months.

Example:

```
widget.chart().onIntervalChanged().subscribe(null, function(interval, obj) {
    obj.timeframe = "12M";
})
```



