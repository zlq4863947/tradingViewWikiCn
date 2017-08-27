以下为图表的方法列表。

**在1.4版本之前** 您可以使用Widget的构造函数返回给您的widget对象来调用这些方法。

**从1.5版本之后** 您可以使用Widget的方法返回给您的图表对象来调用这些方法 \[\[chart\(index\)\|Widget-Methods\#chart-chartindex\]\] 或 \[\[activeChart\(\)\|Widget-Methods\#chart-activechart\]\].

# 方法

* 订阅图表事件
  * \[\[onDataLoaded\(\)\|Chart-Methods\#ondataloaded\]\]
  * \[\[onSymbolChanged\(\)\|Chart-Methods\#onsymbolchanged\]\]
  * \[\[onIntervalChanged\(\)\|Chart-Methods\#onintervalchanged\]\]
  * \[\[dataReady\(callback\)\|Chart-Methods\#datareadycallback\]\]
  * \[\[crossHairMoved\(callback\)\|Chart-Methods\#crosshairmovedcallback\]\]
* 图表动作
  * \[\[setVisibleRange\(range, callback\)\|Chart-Methods\#setvisiblerangerange-callback\]\]
  * \[\[setSymbol\(symbol, callback\)\|Chart-Methods\#setsymbolsymbol-callback\]\]
  * \[\[setResolution\(resolution, callback\)\|Chart-Methods\#setresolutionresolution-callback\]\]
  * \[\[resetData\(\)\|Chart-Methods\#resetData\]\]
  * \[\[executeAction\(action\)\|Chart-Methods\#executeactionaction\]\]
  * \[\[executeActionById\(action\)\|Chart-Methods\#executeactionbyidactionid\]\]
  * \[\[getCheckableActionState\(action\)\|Chart-Methods\#getcheckableactionstateactionid\]\]
  * \[\[refreshMarks\(\)\|Chart-Methods\#refreshmarks\]\]
  * \[\[clearMarks\(\)\|Chart-Methods\#clearmarks\]\]
  * \[\[setChartType\(type\)\|Chart-Methods\#setcharttypetype\]\]
* 研究与形态
  * \[\[getAllShapes\(\)\|Chart-Methods\#getallshapes\]\]
  * \[\[getAllStudies\(\)\|Chart-Methods\#getallstudies\]\]
  * \[\[setEntityVisibility\(id, isVisible\)\|Chart-Methods\#setentityvisibilityid-isvisible\]\]
  * \[\[createStudy\(name, forceOverlay, lock, inputs, callback, overrides, options\)\|Chart-Methods\#createstudyname-forceoverlay-lock-inputs-callback-overrides-options\]\]
  * \[\[createShape\(point, options, callback\)\|Chart-Methods\#createshapepoint-options-callback\]\]
  * \[\[createMultipointShape\(points, options, callback\)\|Chart-Methods\#createmultipointshapepoints-options-callback\]\]
  * \[\[removeEntity\(entityId\)\|Chart-Methods\#removeentityentityid\]\]
  * \[\[createVerticalLine\(point, options\)\|Chart-Methods\#createverticallinepoint-options\]\]
  * \[\[removeAllShapes\(\)\|Chart-Methods\#removeallshapes\]\]
  * \[\[removeAllStudies\(\)\|Chart-Methods\#removeallstudies\]\]
* 研究模板
  * \[\[createStudyTemplate\(options, callback\)\|Chart-Methods\#createstudytemplateoptions-callback\]\]
  * \[\[applyStudyTemplate\(template\)\|Chart-Methods\#applystudytemplatetemplate\]\]
* Trading Primitives
  * \[\[createOrderLine\(\)\|Chart-Methods\#createorderlineoptions\]\]
  * \[\[createPositionLine\(\)\|Chart-Methods\#createpositionlineoptions\]\]
  * \[\[createExecutionShape\(\)\|Chart-Methods\#createexecutionshapeoptions\]\]
* Getters
  * \[\[symbol\(\)\|Chart-Methods\#symbol\]\]
  * \[\[symbolExt\(\)\|Chart-Methods\#symbolExt\]\]
  * \[\[resolution\(\)\|Chart-Methods\#resolution\]\]
  * \[\[getVisibleRange\(\)\|Chart-Methods\#getvisiblerange\]\]
  * \[\[getVisiblePriceRange\(\)\|Chart-Methods\#getvisiblepricerange\]\]
  * \[\[priceFormatter\(\)\|Chart-Methods\#priceformatter\]\]
  * \[\[chartType\(\)\|Chart-Methods\#charttype\]\]

# 订阅图表事件

#### onDataLoaded\(\)

您可以通过订阅\[\[Subscription\]\]对象返回的此回调函数，通知当历史K线数组被加载并退订事件。

#### onSymbolChanged\(\)

您可以通过订阅\[\[Subscription\]\]对象返回的此回调函数，通知当商品发生变化并退订事件。

#### onIntervalChanged\(\)

您可以通过订阅\[\[Subscription\]\]对象返回的此回调函数，通知当间隔发生变化并退订事件。
当事件被触发时，它将提供以下参数：
1. `interval`: 新间隔  
2. `timeframeParameters`: 此对象只有一个字段 `timeframe`. 用户改变时间周期时，它包含一个时间周期。
否则 `timeframe` 为 `undefined` 然后你可以修改它以显示某一时段的K线。有效的时间周期是一个数字，字母'D'为天，'M'为月。

例如:

```
widget.chart().onIntervalChanged().subscribe(null, function(interval, obj) {
    obj.timeframe = "12M";
})
```

#### dataReady\(callback\)

1. `callback`: function\(interval\)

如果K线数据已被加载或被接收时，图表库将立即调用此回调。  
返回 `true` 为已经加载，否则为`false`。

#### crossHairMoved\(callback\)

**在1.5版本之前**

1. `callback`: function\({time, price}\)

图表库会调用回调在每次准星位置改变时。

# 图表动作

#### setVisibleRange\(range, callback\)

1. `range`: object, `{from to}`
   1. `from`, `to`: unix timestamps, UTC
2. `callback`: `function()`. 图表库会调用回调在viewport(视口)设置完成时。

强制图表调整其参数 \(scroll, scale\) 使选定的时间段适合视口。
今后将必须设置`from`或`to`。此方法也引入在`1.2`版本。

#### setSymbol\(symbol, callback\)

1. `symbol`: string
2. `callback`: function\(\)

使图表更改其商品。 新商品的数据到达后调用回调。

#### setResolution\(resolution, callback\)

1. `resolution`: string. Format is described in another \[\[article\|Resolution\]\].
2. `callback`: function\(\)

使图表更改其分辨率。 新分辨率的数据到达后调用回调。

#### resetData\(\)

使图表从数据饲料中请求数据。 通常当图表的数据发生更改时，您需要调用它。  
调用此方法前您应该调用：\[\[onResetCacheNeededCallback\|JS-Api\#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback\]\].

#### executeAction\(action\)

_**已弃用，使用executeActionById代替**_

1. `action`: string

执行图表的菜单中的任意动作\(当右击主窗格上的空白空间时弹出的菜单\) 通过他们的名字。 使用英文本地化的名称。 例:

```javascript
// < ... >
widget.chart().executeAction("Insert Indicator..."); // calling this will show `Insert Study` dialog
// < ... >
widget.chart().executeAction("Hide All Drawing Tools"); // this will toggle all shapes visibility
// < ... >
```

#### executeActionById\(actionId\)

_**since version 1.3**_

1. `actionId`: string

Executes an action by its id.

**显示对话框**

```
chartProperties 
compareOrAdd
scalesProperties
tmzProperties 
paneObjectTree
insertIndicator 
symbolSearch
changeInterval
```

**其他动作**

```
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
```

例如:

```javascript
// < ... >
widget.chart().executeActionById("undo");
// < ... >
widget.chart().executeActionById("drawingToolbarAction"); // hides or shows the drawing toolbar
// < ... >
```

#### getCheckableActionState\(actionId\)

_**从1.7版本之后**_

1. `actionId`: string

获取可检查的操作 \(例. `lockDrawingsAction`, `stayInDrawingModeAction`, `magnetAction`\) 状态通过它们的id \(请参阅上述动作的ID\)

#### refreshMarks\(\)

再次请求可见标记。

#### clearMarks\(\)

删除所有可见标记。

#### setChartType\(type\)

1. `type`: number

设置主数据列的状态。

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

\*- :chart: available in Trading Terminal

#### closePopupsAndDialogs\(\)

调用此方法关闭一个上下文菜单或对话框,假设其已经显示。

# 研究与形态

#### getAllShapes\(\)

返回所有已创建的形态对象的数组。 每个对象都有以下字段：

* `id`: id of a shape
* `name`: name of a shape

#### getAllStudies\(\)

返回所有已创建的形态对象的数组。 每个对象都有以下字段：

* `id`: id of a study
* `name`: name of a study

#### setEntityVisibility\(id, isVisible\)

通过id设置实体能见度

#### createStudy\(name, forceOverlay, lock, inputs, callback, overrides, options\)

1. `name`: string, 技术指标指示器，你可以在`技术指标`工具栏中看到。
2. `forceOverlay`: 强制图表库将创建的研究放在主窗格中
3. `lock`: boolean, 显示用户是否能够删除/更改/隐藏您的研究
4. `inputs`: \(从版本`1.2`之后\) 输入参数数组。 预计这个数组只包含与学习属性页面打印相同顺序的输入值。
5. `callback`: function\(`entityId`\)
6. `overrides`: \(从版本`1.2`之后\) an object [containing properties](https://github.com/tradingview/charting_library/wiki/Studies-Overrides) y您想为您的新研究做好准备。 注意：您不应指定学习名称：启动具有绘图名称的属性路径。
7. `options`: 这个对象只支持关键字`checkLimit`. 如果为 `true` 时，超出限制，将显示学习限制对话框。

创建一个主要商品的研究。 例子：

* `createStudy('MACD', false, false, [14, 30, "close", 9])`
* `createStudy('Moving Average Exponential', false, false, [26])`
* `createStudy('Stochastic', false, false, [26], null, {"%d.color" : "#FF0000"})`

**Remark**: `Compare` 研究有两个输入参数: `[dataSource, symbol]`.  `dataSource` 的值: `["close", "high", "low", "open"]`.

**Remark 2**: You actually use `Overlay` study when choose to `Add` a series on the chart. This study has the single input -- `symbol`. Here is an example how to add a symbol:

```javascript
    widget.chart().createStudy('Overlay', false, false, ['AAPL']);
```

**Remark 3**: You actually also use `Compare` study when choose to compare a series. This study has two inputs -- `source` and `symbol`. Here is an example how to add a compare series:

```javascript
    widget.chart().createStudy('Compare', false, false, ["open", 'AAPL']);
```

#### createShape\(point, options, callback\)

1. `point`: object `{time, [price], [channel]}`
   1. `time`: unix time. The only mandatory argument.
   2. `price`: If you specify `price`, then your icon will be placed on its level. If you do not, then the icon sticks to bar at respective time.
   3. `channel`: The price level to stick to is specified by `channel` argument \(`open`, `high`, `low`, `close`\). If no channel is specified, 'open' is a default.
2. `options`: object `{shape, [text], [lock], [overrides]}`
   1. `shape` may be one of the \['arrow\_up', 'arrow\_down', 'flag', 'vertical\_line', 'horizontal\_line'\]. 'flag' is the default value.
   2. `text` is an optional argument. It's the text that will be assigned to shape if it can contain a text.
   3. `lock` shows whether a user will be able to remove/change/hide your shape or not.
   4. `disableSelection` \(since `1.3`\) prevents selecting of the shape
   5. `disableSave` \(since `1.3`\) prevents saving the shape with a chart
   6. `disableUndo` \(since `1.4`\) prevents adding of the action to the undo stack
   7. `overrides` \(since `1.2`\). It is an object containing properties you'd like to set for your new shape.
   8. `zOrder` \(since `1.3`\) may be one of the \[`top`, `bottom`\]. `top` puts the line tool on top of all other sources, `bottom` puts the line tool below all other sources. If it is not specified the line tool is placed above all existing line tools.
   9. `showInObjectsTree`: `true` by default. Displays the shape in the Objects Tree dialog.
3. `callback`: function\(`entityId`\)

**Since 1.4 the function returns the result immediately. Callback is kept for compatability.**

This call creates a shape at specified point on main series.

#### createMultipointShape\(points, options, callback\)

1. `points`: an array of objects `[{time, [price], [channel]},...]`
   1. `time`: unix time. The only mandatory argument.
   2. `price`: If you specify `price`, then your icon will be placed on its level. If you do not, then the icon sticks to bar at respective time.
   3. `channel`: The price level to stick to is specified by `channel` argument \(`open`, `high`, `low`, `close`\). If no channel is specified, 'open' is a default.
2. `options`: object `{shape, [text], [lock], [overrides]}`
   1. `shape` may be one of the \[\[identifiers\|Shapes and Overrides\]\]
   2. `text` is an optional argument. It's the text that will be assigned to shape if it can contain a text.
   3. `lock` shows whether a user will be able to remove/change/hide your shape or not.
   4. `disableSelection` \(since `1.3`\) prevents selecting of the shape
   5. `disableSave` \(since `1.3`\) prevents saving the shape with a chart
   6. `disableUndo` \(since `1.4`\) prevents adding of the action to the undo stack
   7. `overrides`. It is an object containing properties you'd like to set for your new shape.
   8. `zOrder` \(since `1.3`\) may be one of the \[`top`, `bottom`\]. `top` puts the line tool on top of all other sources, `bottom` puts the line tool below all other sources. If it is not specified the line tool is placed above all existing line tools.
   9. `showInObjectsTree`: `true` by default. Displays the shape in the Objects Tree dialog.
3. `callback`: function\(`entityId`\)

**Since 1.4 the function returns the result immediately. Callback is kept for compatability.**

Look \[\[Shapes and Overrides\|Shapes and Overrides\]\] for more information.

This call creates a shape with specified points on main series.

#### removeEntity\(entityId\)

1. `entityId`: object. Value which was passed to your callback after the entity \(shape of study\) was created.

Removes the specified entity.

#### createVerticalLine\(point, options\)

1. `point`: object `{time}`
2. `options`: obejct `{lock}`

This function is a synonym for `createShape` with shape = 'vertical\_line'. It is treated as **obsolete**.

#### removeAllShapes\(\)

Removes all shapes \(drawings\) from the chart.

#### removeAllStudies\(\)

Removed all studies from the chart.

# Study Templates

#### createStudyTemplate\(options, callback\)

1. `options`: object `{saveInterval}`
   1. `saveInterval`: boolean
2. `callback`: function\(data\)

**Since 1.4 the function returns the result immediately. Callback is kept for compatability.**

Saves the study template to JS object. Charting Library will call your callback and pass the state object as argument. This call is a part of low-level \[\[save/load API\|Saving-and-Loading-Charts\]\].

#### applyStudyTemplate\(template\)

1. `template`: object 

Loads the study template from state object. This call is a part of low-level \[\[save/load API\|Saving-and-Loading-Charts\]\].

# Trading Primitives

#### createOrderLine\(options\)

Creates a new order on the chart and returns an API-object which you can use to control the order properties and behavior. It's strongly recommended to read \[\[this article\|Trading-Primitives\]\] before using this call.

Arguments \(since 1.4\):  
`options` is an object with one possible key: `disableUndo` which can be `true` or `false`. For compatability reasons the default value is `false`.

API object methods:

* `remove()`: Removes the position from the chart. You can’t use API-object after this call.
* `onModify(callback)` / `onModify(data, callback)`
* `onMove(callback)` / `onMove(data, callback)`

API object has a set of properties listed below. Each property should be used through respective accessors. I.e., if you want to work with `Extend Left` property, use `getExtendLeft()` of `setExtendLeft()` methods.

**General properties**:

| Property | Type | Supported Values | Default Value |
| --- | --- | --- | --- |
| Price | Double | Double | 0.0 |
| Text | String | String | "" |
| Tooltip | String | String | "" |
| Quantity | String | String | "" |
| Editable | Boolean | Boolean | true |

**Connection line properties**:

| Property | Type | Supported Values | Default Value |
| --- | --- | --- | --- |
| Extend Left | Boolean | "inherit" or Boolean | True |
| Line Length | Integer | "inherit" or 0 .. 100 | 0 |
| Line Style | Integer | "inherit" or 0 .. 2 | 2 |
| Line Width | Integer | "inherit" or 1 .. 4 | 1 |

**Fonts**:

| Property | Type | Default Value |
| --- | --- | --- |
| Body Font | String | "bold 7pt Verdana" |
| Quantity Font | String | "bold 7pt Verdana" |

**Colors**:

| Property | Type | Default Value |
| --- | --- | --- |
| Line Color | String | "rgb\(255, 0, 0\)" |
| Body Border Color | String | "rgb\(255, 0, 0\)" |
| Body Background Color | String | "rgba\(255, 255, 255, 0.75\)" |
| Body Text Color | String | "rgb\(255, 0, 0\)" |
| Quantity Border Color | String | "rgb\(255, 0, 0\)" |
| Quantity Background Color | String | "rgba\(255, 0, 0, 0.75\)" |
| Quantity Text Color | String | "rgb\(255, 255, 255\)" |
| Cancel Button Border Color | String | "rgb\(255, 0, 0\)" |
| Cancel Button Background Color | String | "rgba\(255, 255, 255, 0.75\)" |
| Cancel Button Icon Color | String | "rgb\(255, 0, 0\)" |

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

#### createPositionLine\(options\)

Creates a new position on the chart and returns an API-object which you can use to control the position properties and behavior.  It's strongly recommended to read \[\[this article\|Trading-Primitives\]\] before using this call.

Arguments \(since 1.4\):  
`options` is an object with one possible key: `disableUndo` which can be `true` or `false`. For compatability reasons the default value is `false`.

API object methods:

* `remove()`: Removes the position from the chart. You can’t use API-object after this call.
* `onClose(callback)` / `onClose(data, callback)`
* `onModify(callback)` / `onModify(data, callback)`
* `onReverse(callback)` / `onReverse(data, callback)`

API object has a set of properties listed below. Each property should be used through respective accessors. I.e., if you want to work with `Extend Left` property, use `getExtendLeft()` of `setExtendLeft()` methods.

**General properties**:

| Property | Type | Supported Values | Default Value |
| --- | --- | --- | --- |
| Price | Double | Double | 0.0 |
| Text | String | String | "" |
| Tooltip | String | String | "" |
| Quantity | String | String | "" |

**Connection line properties**:

| Property | Type | Supported Values | Default Value |
| --- | --- | --- | --- |
| Extend Left | Boolean | "inherit" or Boolean | True |
| Line Length | Integer | "inherit" or 0 .. 100 | 0 |
| Line Style | Integer | "inherit" or 0 .. 2 | 2 |
| Line Width | Integer | "inherit" or 1 .. 4 | 1 |

**Fonts**:

| Property | Type | Default Value |
| --- | --- | --- |
| Body Font | String | "bold 7pt Verdana" |
| Quantity Font | String | "bold 7pt Verdana" |

**Colors**:

| Property | Type | Default Value |
| --- | --- | --- |
| Line Color | String | "rgb\(0, 113, 224\)" |
| Body Border Color | String | "rgb\(0, 113, 224\)" |
| Body Background Color | String | "rgba\(255, 255, 255, 0.75\)" |
| Body Text Color | String | "rgb\(0, 113, 224\)" |
| Quantity Border Color | String | "rgb\(0, 113, 224\)" |
| Quantity Background Color | String | "rgba\(0, 113, 224, 0.75\)" |
| Quantity Text Color | String | "rgb\(255, 255, 255\)" |
| Reverse Button Border Color | String | "rgb\(0, 113, 224\)" |
| Reverse Button Background Color | String | "rgba\(255, 255, 255, 0.75\)" |
| Reverse Button Icon Color | String | "rgb\(0, 113, 224\)" |
| Close Button Border Color | String | "rgb\(0, 113, 224\)" |
| Close Button Background Color | String | "rgba\(255, 255, 255, 0.75\)" |
| Close Button Icon Color | String | "rgb\(0, 113, 224\)" |

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

#### createExecutionShape\(options\)

Creates a new execution on the chart and returns an API-object which you can use to control the execution properties. It's strongly recommended to read \[\[this article\|Trading-Primitives\]\] before using this call.

Arguments \(since 1.4\):  
`options` is an object with one possible key: `disableUndo` which can be `true` or `false`. For compatability reasons the default value is `false`.

API object has a set of properties listed below. Each property should be used through respective accessors. I.e., if you want to work with `Extend Left` property, use `getExtendLeft()` of `setExtendLeft()` methods.

API object methods:

* `remove()`: Removes the execution shape from the chart. You can’t use API-object after this call.

**General properties**:

| Property | Type | Supported Values | Default Value |
| --- | --- | --- | --- |
| Price | Double | Double | 0.0 |
| Time | Integer | Unix time | 0 |
| Direction | String | "buy" or "sell" | "buy" |
| Text | String | String | "execution" |
|  | Tooltip | String | String |
| Arrow Height | Integer | Integer | 8 |
| Arrow Spacing | Integer | Integer | 1 |

**Fonts**:

| Property | Type | Default Value |
| --- | --- | --- |
| Font | String | "8pt Verdana" |

**Colors**:

| Property | Type | Default Value |
| --- | --- | --- |
| Text Color | String | "rgb\(0, 0, 0\)"" |
| Arrow Color | String | "rgba\(0, 0, 255\)" |

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

#### symbol\(\)

Returns chart's symbol.

#### symbolExt\(\)

Returns chart's symbol information object. The object has the following fields:

* `symbol`: the same as \[\[symbol\(\)\|Chart-Methods\#symbol\]\] method result
* `full_name`: full symbol name
* `exchange`: symbol's exchange
* `description`: symbol's description
* `type`: symbol's type

#### resolution\(\)

Returns chart's resolution. Format is described in another \[\[article\|Resolution\]\].

#### getVisibleRange\(\)

Returns object `{from, to}`. `from` and `to` are Unit timestamps **in the timezone of chart**.

#### getVisiblePriceRange\(\)

**Since 1.7**

Returns object `{from, to}`. `from` and `to` are boundaries of main series price scale visible range.

#### priceFormatter\(\)

Returns object with `format` function that you can use to format prices. Introduced in 1.5.

#### chartType\(\)

Returns the main series style.

# See Also

* \[\[Widget Methods\]\]
* \[\[Customization Overview\]\]
* \[\[Widget Constructor\]\]
* \[\[Saving and Loading Charts\|Saving-and-Loading-Charts\]\]
* \[\[Overriding Studies' Defaults\|Studies-Overrides\]\]
* \[\[Overriding Chart's Defaults\|Overrides\]\]



