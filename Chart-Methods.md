Here is a list of supported chart's methods.

**Before 1.4 version.** You can call these methods using widget object returned to you by widget's constructor.

**Since 1.5 version.** You can call these methods using chart object returned to you by widget's methods [[chart(index)|Widget-Methods#chart-chartindex]] or [[activeChart()|Widget-Methods#chart-activechart]].

# Methods

* Subscribing To Chart Events
  * [[onDataLoaded()|Chart-Methods#ondataloaded]]
  * [[onSymbolChanged()|Chart-Methods#onsymbolchanged]]
  * [[onIntervalChanged()|Chart-Methods#onintervalchanged]]
  * [[dataReady(callback)|Chart-Methods#datareadycallback]]
  * [[crossHairMoved(callback)|Chart-Methods#crosshairmovedcallback]]
* Chart Actions
  * [[setVisibleRange(range, callback)|Chart-Methods#setvisiblerangerange-callback]]
  * [[setSymbol(symbol, callback)|Chart-Methods#setsymbolsymbol-callback]]
  * [[setResolution(resolution, callback)|Chart-Methods#setresolutionresolution-callback]]
  * [[resetData()|Chart-Methods#resetData]]
  * [[executeAction(action)|Chart-Methods#executeactionaction]]
  * [[executeActionById(action)|Chart-Methods#executeactionbyidactionid]]
  * [[getCheckableActionState(action)|Chart-Methods#getcheckableactionstateactionid]]
  * [[refreshMarks()|Chart-Methods#refreshmarks]]
  * [[clearMarks()|Chart-Methods#clearmarks]]
  * [[setChartType(type)|Chart-Methods#setcharttypetype]]
* Studies And Shapes
  * [[getAllShapes()|Chart-Methods#getallshapes]]
  * [[getAllStudies()|Chart-Methods#getallstudies]]
  * [[setEntityVisibility(id, isVisible)|Chart-Methods#setentityvisibilityid-isvisible]]
  * [[createStudy(name, forceOverlay, lock, inputs, callback, overrides, options)|Chart-Methods#createstudyname-forceoverlay-lock-inputs-callback-overrides-options]]
  * [[createShape(point, options, callback)|Chart-Methods#createshapepoint-options-callback]]
  * [[createMultipointShape(points, options, callback)|Chart-Methods#createmultipointshapepoints-options-callback]]
  * [[removeEntity(entityId)|Chart-Methods#removeentityentityid]]
  * [[createVerticalLine(point, options)|Chart-Methods#createverticallinepoint-options]]
  * [[removeAllShapes()|Chart-Methods#removeallshapes]]
  * [[removeAllStudies()|Chart-Methods#removeallstudies]]
* Study Templates
  * [[createStudyTemplate(options, callback)|Chart-Methods#createstudytemplateoptions-callback]]
  * [[applyStudyTemplate(template)|Chart-Methods#applystudytemplatetemplate]]
* Trading Primitives
  * [[createOrderLine()|Chart-Methods#createorderlineoptions]]
  * [[createPositionLine()|Chart-Methods#createpositionlineoptions]]
  * [[createExecutionShape()|Chart-Methods#createexecutionshapeoptions]]
* Getters
  * [[symbol()|Chart-Methods#symbol]]
  * [[symbolExt()|Chart-Methods#symbolExt]]
  * [[resolution()|Chart-Methods#resolution]]
  * [[getVisibleRange()|Chart-Methods#getvisiblerange]]
  * [[getVisiblePriceRange()|Chart-Methods#getvisiblepricerange]]
  * [[priceFormatter()|Chart-Methods#priceformatter]]
  * [[chartType()|Chart-Methods#charttype]]

# Subscribing To Chart Events

#### onDataLoaded()

You can subscribe using [[Subscription]] object returned by this function to be notified when new history bars are loaded and unsubscribe from the event.

#### onSymbolChanged()

You can subscribe using [[Subscription]] object returned by this function to be notified when the symbol is changed and unsubscribe from the event.

#### onIntervalChanged()

You can subscribe using [[Subscription]] object returned by this function to be notified when the interval is changed and unsubscribe from the event.
When the event is fired it will provide the following arguments:
1. `interval`: new interval
2. `timeframeParameters`: object with the only field `timeframe`. It contains a timeframe if the interval is changed as a result of a user click on a timeframe panel.
Otherwise `timeframe` is `undefined` and you can change it to display a certain range of bars. Valid timeframe is a number with letter `D` for days and `M` for months.

Example:
```
widget.chart().onIntervalChanged().subscribe(null, function(interval, obj) {
    obj.timeframe = "12M";
})
```

#### dataReady(callback)
1. `callback`: function(interval)

The Charting Library will call the callback provided immediately if bars are already loaded or when the bars are received.
The function returns `true` if bars are already loaded and `false` otherwise.

#### crossHairMoved(callback)
**Since 1.5 version.**

1. `callback`: function({time, price})

The Charting Library will call the callback every time the crosshair position is changed.

# Chart Actions

#### setVisibleRange(range, callback)
1. `range`: object, `{from to}`
    1. `from`, `to`: unix timestamps, UTC
2. `callback`: `function()`. The Library will call it after it's done with the viewport setup.

Forces the chart to adjust its parameters (scroll, scale) to make the selected time period fit the view port.
Neither `from`, nor `to` must not be in future. This method was introduced in version `1.2`.

#### setSymbol(symbol, callback)
1. `symbol`: string
2. `callback`: function()

Makes the chart to change its symbol. Callback is called after new symbol's data arrived.

#### setResolution(resolution, callback)
1. `resolution`: string. Format is described in another [[article|Resolution]].
2. `callback`: function()

Makes the chart to change its resolution. Callback is called after new data arrived.

#### resetData()

Makes the chart to rerequest data from the data feed. Usually you need to call it when chart's data has changed.
Before calling this you should call [[onResetCacheNeededCallback|JS-Api#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback]].

#### executeAction(action)
**_deprecated, use executeActionById instead_**

1. `action`: string

Executes any action from chart's context menu (the menu which is popped up when one right-clicks the empty space on a main pane) by its name. Use names as you see them in English localization. Examples:
```javascript
// < ... >
widget.chart().executeAction("Insert Indicator..."); // calling this will show `Insert Study` dialog
// < ... >
widget.chart().executeAction("Hide All Drawing Tools"); // this will toggle all shapes visibility
// < ... >
```

#### executeActionById(actionId)
_**since version 1.3**_

1. `actionId`: string

Executes an action by its id.

**Showing a dialog**

	chartProperties 
	compareOrAdd
	scalesProperties
	tmzProperties 
	paneObjectTree
	insertIndicator 
	symbolSearch
	changeInterval

**Other actions**

	timeScaleReset
	chartReset
	seriesHide
	studyHide 
	lineToggleLock
	lineHide 
	showLeftAxis
	showRightAxis
	scaleSeriesOnly
	drawingToolbarAction
	magnetAction
	stayInDrawingModeAction
	lockDrawingsAction
	hideAllDrawingsAction 
	hideAllMarks 
	showCountdown 
	showSeriesLastValue
	showSymbolLabelsAction
	showStudyLastValue
	showStudyPlotNamesAction
	undo
	redo
	takeScreenshot
	paneRemoveAllStudiesDrawingTools

Examples:
```javascript
// < ... >
widget.chart().executeActionById("undo");
// < ... >
widget.chart().executeActionById("drawingToolbarAction"); // hides or shows the drawing toolbar
// < ... >
```

#### getCheckableActionState(actionId)
_**since version 1.7**_

1. `actionId`: string

Get checkable action (e.g. `lockDrawingsAction`, `stayInDrawingModeAction`, `magnetAction`) state by its id (see ids of actions above)

#### refreshMarks()

Calling this method makes the Library to request visible marks once again.

#### clearMarks()

Calling this method makes the Library to remove all visible marks.

#### setChartType(type)
1. `type`: number

Sets the main series style.

```
STYLE_BARS = 0;
STYLE_CANDLES = 1;
STYLE_LINE = 2;
STYLE_AREA = 3;
STYLE_HEIKEN_ASHI = 8;
STYLE_HOLLOW_CANDLES = 9;

STYLE_RENKO* = 4;
STYLE_KAGI* = 5;
STYLE_PNF* = 6;
STYLE_PB* = 7;
```
*- :chart: available in Trading Terminal

#### closePopupsAndDialogs()

Calling this method closes a context menu or a dialog if it is shown.

# Studies And Shapes

#### getAllShapes()
Returns an array of all created shapes objects. Each object has following fields:

- `id`: id of a shape
- `name`: name of a shape

#### getAllStudies()
Returns an array of all created shapes objects. Each object has following fields:

- `id`: id of a study
- `name`: name of a study

#### setEntityVisibility(id, isVisible)
Sets visibility of an entity with passed id.

#### createStudy(name, forceOverlay, lock, inputs, callback, overrides, options)
1. `name`: string, a name of an indicator as you can see it in `Indicators` widget
2. `forceOverlay`: forces the Charting Library to place the created study on main pane
3. `lock`: boolean, shows whether a user will be able to remove/change/hide your study or not
4. `inputs`: (since version `1.2`) an array of study inputs. This array is expected to contain just inputs values in the same order they are printed in study's properties page.
5. `callback`: function(`entityId`)
6. `overrides`: (since version `1.2`) an object [containing properties](https://github.com/tradingview/charting_library/wiki/Studies-Overrides) you'd like to set for your new study. Note: you should not specify study name: start a property path with a plot name.
7. `options`: object with the only possible key `checkLimit`. If it is `true` study limit dialog will be shown if the limit if exceeded.

Creates the study on a main symbol. Examples: 
  * `createStudy('MACD', false, false, [14, 30, "close", 9])`
  * `createStudy('Moving Average Exponential', false, false, [26])`
  * `createStudy('Stochastic', false, false, [26], null, {"%d.color" : "#FF0000"})`

**Remark**: `Compare` study has 2 inputs: `[dataSource, symbol]`. Supported `dataSource` values: `["close", "high", "low", "open"]`.

**Remark 2**: You actually use `Overlay` study when choose to `Add` a series on the chart. This study has the single input -- `symbol`. Here is an example how to add a symbol:

```javascript
    widget.chart().createStudy('Overlay', false, false, ['AAPL']);
```

**Remark 3**: You actually also use `Compare` study when choose to compare a series. This study has two inputs -- `source` and `symbol`. Here is an example how to add a compare series:

```javascript
    widget.chart().createStudy('Compare', false, false, ["open", 'AAPL']);
```


#### createShape(point, options, callback)
1. `point`: object `{time, [price], [channel]}`
    1. `time`: unix time. The only mandatory argument.
    2. `price`: If you specify `price`, then your icon will be placed on its level. If you do not, then the icon sticks to bar at respective time.
    3. `channel`: The price level to stick to is specified by `channel` argument (`open`, `high`, `low`, `close`). If no channel is specified, 'open' is a default.
2. `options`: object `{shape, [text], [lock], [overrides]}`
    1. `shape` may be one of the ['arrow_up', 'arrow_down', 'flag', 'vertical_line', 'horizontal_line']. 'flag' is the default value.
    2. `text` is an optional argument. It's the text that will be assigned to shape if it can contain a text.
    3. `lock` shows whether a user will be able to remove/change/hide your shape or not.
    4. `disableSelection` (since `1.3`) prevents selecting of the shape
    5. `disableSave` (since `1.3`) prevents saving the shape with a chart
    6. `disableUndo` (since `1.4`) prevents adding of the action to the undo stack
    7. `overrides` (since `1.2`). It is an object containing properties you'd like to set for your new shape.
    8. `zOrder` (since `1.3`) may be one of the [`top`, `bottom`]. `top` puts the line tool on top of all other sources, `bottom` puts the line tool below all other sources. If it is not specified the line tool is placed above all existing line tools.
    9. `showInObjectsTree`: `true` by default. Displays the shape in the Objects Tree dialog.
3. `callback`: function(`entityId`)

**Since 1.4 the function returns the result immediately. Callback is kept for compatability.**

This call creates a shape at specified point on main series. 

#### createMultipointShape(points, options, callback)
1. `points`: an array of objects `[{time, [price], [channel]},...]`
    1. `time`: unix time. The only mandatory argument.
    2. `price`: If you specify `price`, then your icon will be placed on its level. If you do not, then the icon sticks to bar at respective time.
    3. `channel`: The price level to stick to is specified by `channel` argument (`open`, `high`, `low`, `close`). If no channel is specified, 'open' is a default.
2. `options`: object `{shape, [text], [lock], [overrides]}`
    1. `shape` may be one of the [[identifiers|Shapes and Overrides]]
    2. `text` is an optional argument. It's the text that will be assigned to shape if it can contain a text.
    3. `lock` shows whether a user will be able to remove/change/hide your shape or not.
    4. `disableSelection` (since `1.3`) prevents selecting of the shape
    5. `disableSave` (since `1.3`) prevents saving the shape with a chart
    6. `disableUndo` (since `1.4`) prevents adding of the action to the undo stack
    7. `overrides`. It is an object containing properties you'd like to set for your new shape.
    8. `zOrder` (since `1.3`) may be one of the [`top`, `bottom`]. `top` puts the line tool on top of all other sources, `bottom` puts the line tool below all other sources. If it is not specified the line tool is placed above all existing line tools.
    9. `showInObjectsTree`: `true` by default. Displays the shape in the Objects Tree dialog.
3. `callback`: function(`entityId`)

**Since 1.4 the function returns the result immediately. Callback is kept for compatability.**

Look [[Shapes and Overrides|Shapes and Overrides]] for more information.

This call creates a shape with specified points on main series.

#### removeEntity(entityId)
1. `entityId`: object. Value which was passed to your callback after the entity (shape of study) was created.

Removes the specified entity.

#### createVerticalLine(point, options)
1. `point`: object `{time}`
2. `options`: obejct `{lock}`

This function is a synonym for `createShape` with shape = 'vertical_line'. It is treated as **obsolete**.

#### removeAllShapes()
Removes all shapes (drawings) from the chart.

#### removeAllStudies()
Removed all studies from the chart.


# Study Templates


#### createStudyTemplate(options, callback)
1. `options`: object `{saveInterval}`
 1. `saveInterval`: boolean
2. `callback`: function(data)

**Since 1.4 the function returns the result immediately. Callback is kept for compatability.**

Saves the study template to JS object. Charting Library will call your callback and pass the state object as argument. This call is a part of low-level [[save/load API|Saving-and-Loading-Charts]].

#### applyStudyTemplate(template)
1. `template`: object 

Loads the study template from state object. This call is a part of low-level [[save/load API|Saving-and-Loading-Charts]].


# Trading Primitives


#### createOrderLine(options)
Creates a new order on the chart and returns an API-object which you can use to control the order properties and behavior. It's strongly recommended to read [[this article|Trading-Primitives]] before using this call.

Arguments (since 1.4):
`options` is an object with one possible key: `disableUndo` which can be `true` or `false`. For compatability reasons the default value is `false`.

API object methods:
* `remove()`: Removes the position from the chart. You can’t use API-object after this call.
* `onModify(callback)` / `onModify(data, callback)`
* `onMove(callback)` / `onMove(data, callback)`

API object has a set of properties listed below. Each property should be used through respective accessors. I.e., if you want to work with `Extend Left` property, use `getExtendLeft()` of `setExtendLeft()` methods.

**General properties**:

Property|Type|Supported Values|Default Value
---|---|---|---
Price|Double|Double|0.0
Text|String|String|""
Tooltip|String|String|""
Quantity|String|String|""
Editable|Boolean|Boolean|true


**Connection line properties**:

Property|Type|Supported Values|Default Value
---|---|---|---
Extend Left|Boolean|"inherit" or Boolean|True
Line Length|Integer|"inherit" or 0 .. 100|0
Line Style|Integer|"inherit" or 0 .. 2|2
Line Width|Integer|"inherit" or 1 .. 4|1

**Fonts**:

Property|Type|Default Value
---|---|---
Body Font|String|"bold 7pt Verdana"
Quantity Font|String|"bold 7pt Verdana"

**Colors**:

Property|Type|Default Value
---|---|---
Line Color|String|"rgb(255, 0, 0)"
Body Border Color|String|"rgb(255, 0, 0)"
Body Background Color|String|"rgba(255, 255, 255, 0.75)"
Body Text Color|String|"rgb(255, 0, 0)"
Quantity Border Color|String|"rgb(255, 0, 0)"
Quantity Background Color|String|"rgba(255, 0, 0, 0.75)"
Quantity Text Color|String|"rgb(255, 255, 255)"
Cancel Button Border Color|String|"rgb(255, 0, 0)"
Cancel Button Background Color|String|"rgba(255, 255, 255, 0.75)"
Cancel Button Icon Color|String|"rgb(255, 0, 0)"

Example:
```javascript
widget.chart().createOrderLine()
    .onMove(function() {
        this.setText("onMove called");
    })
    .onModify("onModify called", function(text) {
        this.setText(text);
    })
    .onCancel("onCancel called", function(text) {
        this.setText(text);
    })
    .setText("STOP: 73.5 (5,64%)")
    .setQuantity("2");
```

#### createPositionLine(options)
Creates a new position on the chart and returns an API-object which you can use to control the position properties and behavior.  It's strongly recommended to read [[this article|Trading-Primitives]] before using this call.

Arguments (since 1.4):
`options` is an object with one possible key: `disableUndo` which can be `true` or `false`. For compatability reasons the default value is `false`.

API object methods:
* `remove()`: Removes the position from the chart. You can’t use API-object after this call.
* `onClose(callback)` / `onClose(data, callback)`
* `onModify(callback)` / `onModify(data, callback)`
* `onReverse(callback)` / `onReverse(data, callback)`

API object has a set of properties listed below. Each property should be used through respective accessors. I.e., if you want to work with `Extend Left` property, use `getExtendLeft()` of `setExtendLeft()` methods.

**General properties**:

Property|Type|Supported Values|Default Value
---|---|---|---
Price|Double|Double|0.0
Text|String|String|""
Tooltip|String|String|""
Quantity|String|String|""


**Connection line properties**:

Property|Type|Supported Values|Default Value
---|---|---|---
Extend Left|Boolean|"inherit" or Boolean|True
Line Length|Integer|"inherit" or 0 .. 100|0
Line Style|Integer|"inherit" or 0 .. 2|2
Line Width|Integer|"inherit" or 1 .. 4|1

**Fonts**:

Property|Type|Default Value
---|---|---
Body Font|String|"bold 7pt Verdana"
Quantity Font|String|"bold 7pt Verdana"

**Colors**:

Property|Type|Default Value
---|---|---
Line Color|String|"rgb(0, 113, 224)"
Body Border Color|String|"rgb(0, 113, 224)"
Body Background Color|String|"rgba(255, 255, 255, 0.75)"
Body Text Color|String|"rgb(0, 113, 224)"
Quantity Border Color|String|"rgb(0, 113, 224)"
Quantity Background Color|String|"rgba(0, 113, 224, 0.75)"
Quantity Text Color|String|"rgb(255, 255, 255)"
Reverse Button Border Color|String|"rgb(0, 113, 224)"
Reverse Button Background Color|String|"rgba(255, 255, 255, 0.75)"
Reverse Button Icon Color|String|"rgb(0, 113, 224)"
Close Button Border Color|String|"rgb(0, 113, 224)"
Close Button Background Color|String|"rgba(255, 255, 255, 0.75)"
Close Button Icon Color|String|"rgb(0, 113, 224)"

Example:
```javascript
widget.chart().createPositionLine()
    .onModify(function() {
        this.setText("onModify called");
    })
    .onReverse("onReverse called", function(text) {
        this.setText(text);
    })
    .onClose("onClose called", function(text) {
        this.setText(text);
    })
    .setText("PROFIT: 71.1 (3.31%)")
    .setQuantity("8.235")
    .setPrice(15.5)
    .setExtendLeft(false)
.setLineStyle(0)
.setLineLength(25);
```
#### createExecutionShape(options)
Creates a new execution on the chart and returns an API-object which you can use to control the execution properties. It's strongly recommended to read [[this article|Trading-Primitives]] before using this call.

Arguments (since 1.4):
`options` is an object with one possible key: `disableUndo` which can be `true` or `false`. For compatability reasons the default value is `false`.

API object has a set of properties listed below. Each property should be used through respective accessors. I.e., if you want to work with `Extend Left` property, use `getExtendLeft()` of `setExtendLeft()` methods.

API object methods:
* `remove()`: Removes the execution shape from the chart. You can’t use API-object after this call.

**General properties**:

Property|Type|Supported Values|Default Value
---|---|---|---
Price|Double|Double|0.0
Time|Integer|Unix time|0
Direction|String|"buy" or "sell"|"buy"
Text|String|String|"execution"
Tooltip|String|String|
Arrow Height|Integer|Integer|8
Arrow Spacing|Integer|Integer|1

**Fonts**:

Property|Type|Default Value
---|---|---
Font|String|"8pt Verdana"

**Colors**:

Property|Type|Default Value
---|---|---
Text Color|String|"rgb(0, 0, 0)""
Arrow Color|String|"rgba(0, 0, 255)"

Example:
```javascript
widget.chart().createExecutionShape()
    .setText("@1,320.75 Limit Buy 1")
    .setTooltip("@1,320.75 Limit Buy 1")
    .setTextColor("rgba(0,255,0,0.5)")
    .setArrowColor("#0F0")
    .setDirection("buy")
    .setTime(1413559061758)
    .setPrice(15.5);
```

# Getters

#### symbol()

Returns chart's symbol.

#### symbolExt()

Returns chart's symbol information object. The object has the following fields:

- `symbol`: the same as [[symbol()|Chart-Methods#symbol]] method result
- `full_name`: full symbol name
- `exchange`: symbol's exchange
- `description`: symbol's description
- `type`: symbol's type

#### resolution()

Returns chart's resolution. Format is described in another [[article|Resolution]].

#### getVisibleRange()

Returns object `{from, to}`. `from` and `to` are Unit timestamps **in the timezone of chart**.

#### getVisiblePriceRange()

**Since 1.7**

Returns object `{from, to}`. `from` and `to` are boundaries of main series price scale visible range.

#### priceFormatter()

Returns object with `format` function that you can use to format prices. Introduced in 1.5.

#### chartType()

Returns the main series style.

# See Also
* [[Widget Methods]]
* [[Customization Overview]]
* [[Widget Constructor]]
* [[Saving and Loading Charts|Saving-and-Loading-Charts]]
* [[Overriding Studies' Defaults|Studies-Overrides]]
* [[Overriding Chart's Defaults|Overrides]]
