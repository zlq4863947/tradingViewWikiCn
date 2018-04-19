# 图表方法

---

以下为图表的方法列表。

**在1.4版本之前** 您可以使用Widget的构造函数返回给您的widget对象来调用这些方法。

**从1.5版本之后** 您可以使用Widget的方法返回给您的图表对象来调用这些方法 [chart\(index\)](Widget-Methods.md#chartindex) 或 [activeChart\(\)](Widget-Methods.md#activechart)。

## 方法

* 订阅图表事件
  * [onDataLoaded\(\)](#ondataloaded)
  * [onSymbolChanged\(\)](#onsymbolchanged)
  * [onIntervalChanged\(\)](#onintervalchanged)
  * [dataReady\(callback\)](#datareadycallback)
  * [crossHairMoved\(callback\)](#crosshairmovedcallback)
* 图表动作
  * [setVisibleRange\(range, callback\)](#setvisiblerangerange-callback)
  * [setSymbol\(symbol, callback\)](#setsymbolsymbol-callback)
  * [setResolution\(resolution, callback\)](#setresolutionresolution-callback)
  * [resetData\(\)](#resetData)
  * [executeAction\(action\)](#executeactionaction)
  * [executeActionById\(action\)](#executeactionbyidactionid)
  * [getCheckableActionState\(action\)](#getcheckableactionstateactionid)
  * [refreshMarks\(\)](#refreshmarks)
  * [clearMarks\(\)](#clearmarks)
  * [setChartType\(type\)](#setcharttypetype)
  *  [setTimezone(timezone)](#settimezonetimezone)
* 研究与图形
  * [getAllShapes\(\)](#getallshapes)
  * [getAllStudies\(\)](#getallstudies)
  * [setEntityVisibility\(id, isVisible\)](#setentityvisibilityid-isvisible)[过时]
  * [createStudy\(name, forceOverlay, lock, inputs, callback, overrides, options\)](#createstudyname-forceoverlay-lock-inputs-callback-overrides-options)
  * [createShape\(point, options, callback\)](#createshapepoint-options-callback)
  * [createMultipointShape\(points, options, callback\)](#createmultipointshapepoints-options-callback)
  * [getShapeById(entityId)](#getshapebyidentityid)
  * [removeEntity\(entityId\)](#removeentityentityid)
  * [createVerticalLine\(point, options\)](#createverticallinepoint-options)
  * [removeAllShapes\(\)](#removeallshapes)
  * [removeAllStudies\(\)](#removeallstudies)
* 指标模板
  * [createStudyTemplate\(options, callback\)](#createstudytemplateoptions-callback)
  * [applyStudyTemplate\(template\)](#applystudytemplatetemplate)
* Trading Primitives
  * [createOrderLine\(\)](#createorderlineoptions)
  * [createPositionLine\(\)](#createpositionlineoptions)
  * [createExecutionShape\(\)](#createexecutionshapeoptions)
* Getters
  * [symbol\(\)](#symbol)
  * [symbolExt\(\)](#symbolExt)
  * [resolution\(\)](#resolution)
  * [getVisibleRange\(\)](#getvisiblerange)
  * [getVisiblePriceRange\(\)](#getvisiblepricerange)
  * [priceFormatter\(\)](#priceformatter)
  * [chartType\(\)](#charttype)

# 订阅图表事件

#### onDataLoaded\(\)

您可以使用此方法返回的订阅[Subscription](/book/Subscription.md)对象进行订阅，以便在加载新历史K线时通知并取消订阅事件。

#### onSymbolChanged\(\)

您可以使用此方法返回的[Subscription](/book/Subscription.md)对象进行订阅，以便在更改商品时通知并取消订阅该事件。

#### onIntervalChanged\(\)

您可以使用此方法返回的[Subscription](/book/Subscription.md)对象进行订阅，以便在更改时间间隔时通知并取消订阅该事件。 
当事件被触发时，它将提供以下参数：
1. `interval`: 新间隔  
2. `timeframeParameters`: 此对象只有一个字段 `timeframe`. 用户改变时间间隔时，它包含一个时间间隔。  
否则 `timeframe` 为 `undefined` 然后你可以修改它以显示某一时段的K线。有效的时间间隔是一个数字，字母'D'为天，'M'为月。

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

每当十字线位置改变时，图表库将会调用回调函数。

# 图表动作

#### setVisibleRange\(range, callback\)

1. `range`: object, `{from to}`
   1. `from`, `to`: unix timestamps, UTC
2. `callback`: `function()`. 图表库会调用回调在viewport\(视口\)设置完成时。

强制图表调整其参数 \(scroll, scale\) 使选定的时间段适合视口。  
今后将必须设置`from`或`to`。此方法也引入在`1.2`版本。

#### setSymbol\(symbol, callback\)

1. `symbol`: string
2. `callback`: function\(\)

使图表更改商品。 新商品的数据到达后调用回调。

#### setResolution\(resolution, callback\)

1. `resolution`: string. 格式化详细参照:[文章](/book/Resolution.md)。
2. `callback`: function\(\)

使图表更改分辨率。 新分辨率的数据到达后调用回调。

#### resetData\(\)

使图表重新请求datafeed中的数据。 通常你需要在图表数据发生变化时调用它。 
在调用这个之前，你应该调用[onResetCacheNeededCallback](JS-Api.md#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback)。

#### executeActionById\(actionId\)

_**since version 1.3**_

1. `actionId`: string

通过它的id执行一个动作。

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

获取可选的操作 \(例. `lockDrawingsAction`, `stayInDrawingModeAction`, `magnetAction`\) 状态通过它们的id \(请参阅上述动作的ID\)

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
  

### setTimezone\(timezone\)

1.  `timezone`: string  

查看[timezone](book/Widget-Constructor.md#timezone)更多信息

例:

```javascript

widget.activeChart().setTimezone('Asia/Singapore');
```
使图表更改时区。

#### closePopupsAndDialogs\(\)

调用此方法关闭一个上下文菜单或对话框,假设其已经显示。

# 研究与图形

#### getAllShapes\(\)

返回所有已创建的图形对象的数组。 每个对象都有以下字段：

* `id`: id of a shape
* `name`: name of a shape

#### getAllStudies\(\)

返回所有已创建的图形对象的数组。 每个对象都有以下字段：

* `id`: id of a study
* `name`: name of a study

#### setEntityVisibility\(id, isVisible\)

通过id设置实体能见度

#### createStudy\(name, forceOverlay, lock, inputs, callback, overrides, options\)

1. `name`: string, 技术指标指示器，你可以在`技术指标`工具栏中看到。
2. `forceOverlay`: 强制图表库将创建的指标放在主窗格中
3. `lock`: boolean, 是否锁定指标
4. `inputs`: \(从版本`1.2`之后\) 指标数组参数, 这个数组只包含与指标属性页面打印相同顺序的输入值。
5. `callback`: function\(`entityId`\)
6. `overrides`: \(从版本`1.2`之后\) 一个对象 [containing properties](/book/Studies-Overrides.md) 。注意：您不应指定指标名称：应以具有绘图名称的属性路径为起始。
7. `options`: 这个对象只支持关键字`checkLimit`. 如果为 `true` 时，超出限制，将显示学习限制对话框。


**从1.12开始，函数立即返回结果。 回调为保持兼容性**

创建一个关于主商品的研究。 例子:
  * `createStudy('MACD', false, false, [14, 30, "close", 9])`
  * `createStudy('Moving Average Exponential', false, false, [26])`
  * `createStudy('Stochastic', false, false, [26], null, {"%d.color" : "#FF0000"})`
  * `chart.createStudy('Moving Average', false, false, [26], null, {'Plot.linewidth': 10})`

**Remark**: `Compare` 研究有2个参数: `[dataSource, symbol]`. 支持 `dataSource` values: `["close", "high", "low", "open"]`.

**Remark 2**: 当您选择在图表上添加数据列时，您实际使用了`Overlay`指标，这个指标只有一个参数 -- `symbol`. 以下是添加商品的示例：

```javascript
    widget.chart().createStudy('Overlay', false, false, ['AAPL']);
```
**Remark 3**: 当您选择比较数据列时，您实际上使用了`Compare`指标。 它有2个参数 -- `source` 和 `symbol`. 下面是一个添加比较数据列的例子:

```javascript
    widget.chart().createStudy('Compare', false, false, ["open", 'AAPL']);
```

#### getStudyById(entityId)
1. `entityId`: object. 通过API创建研究时返回的值。

使用以下方法返回一个对象与研究交互：
1. `isUserEditEnabled()` - 如果用户能够删除/更改/隐藏您的形状，则返回`true`
1. `setUserEditEnabled(enabled)` - 启用或禁用删除/更改/隐藏 用户的研究
1. `getInputsInfo()` - 返回有关所有输入的信息。 返回值是具有以下字段的对象数组：
    - `id` - 研究ID
    - `name` - 名称
    - `type` - 类型
    - `localizedName` - 输入翻译成当前语言的名称

1. `getInputValues()` - 返回研究输入的值。 返回值是一个对象数组（`StudyInputValue`），它包含以下字段：
    - `id` - 研究ID
    - `value` - 值

1. `setInputValues(inputs)` - 将输入值分配给研究。 `inputs`应该是一个包含`StudyInputValue`对象的数组（见上文）。 它可能只包含一些你想改变的输入。

1. `mergeUp()` - 向上合并（如果可以）
1. `mergeDown()` - 向下合并（如果可以）
1. `unmergeUp()` - 向上分解（如果可以）
1. `unmergeDown()` - 向下分解（如果可以）

#### createShape\(point, options, callback\)

1. `point`: object `{time, [price], [channel]}`
   1. `time`: unix time. 唯一的强制性参数。
   2. `price`: 如果您指定`price`, 如果您指定“price”，则您的图标将被放置在其水平之上。 如果没有指定，则图标会在相应的时间粘贴到K线上。
   3. `channel`: 要保持价格水平线，要使用`channel` 参数 \(`open`, `high`, `low`, `close`\)。如果未指定则以'open'为默认值。
2. `options`: object `{shape, [text], [lock], [overrides]}`
   1. `shape` 可能的值为\['arrow\_up', 'arrow\_down', 'flag', 'vertical\_line', 'horizontal\_line'\]，'flag'为默认值。
   2. `text` 图形的内容
   3. `lock` 是否锁定图形
   4. `disableSelection` \(since `1.3`\) 禁用选择
   5. `disableSave` \(since `1.3`\) 禁用保存
   6. `disableUndo` \(since `1.4`\) 禁用撤销
   7. `overrides` \(since `1.2`\). 它是一个对象，包含为新图形设置的属性。
   8. `zOrder` \(since `1.3`\) 可能的值为\[`top`, `bottom`\]. `top` 将线工具放在所有其他资源之上, `bottom` 将线工具放在所有其他资源之下, 'top'为默认值。
   9. `showInObjectsTree`: `true`为默认值。在“对象树”对话框中显示图形。
3. `callback`: function\(`entityId`\)

**从1.4开始，函数立即返回结果。回调保函数为持兼容性。**

此调用会在主数据列上指定点位创建一个形状。

#### createMultipointShape\(points, options, callback\)

1. `point`: object `{time, [price], [channel]}`
   1. `time`: unix time. 唯一的强制性参数。
   2. `price`: 如果您指定`price`, 如果您指定“price”，则您的图标将被放置在其水平之上。 如果没有指定，则图标会在相应的时间粘贴到K线上。
   3. `channel`: 要保持价格水平线，要使用`channel` 参数 \(`open`, `high`, `low`, `close`\)。如果未指定则以'open'为默认值。
2. `options`: object `{shape, [text], [lock], [overrides]}`
   1. `shape` 可能的值为\['arrow\_up', 'arrow\_down', 'flag', 'vertical\_line', 'horizontal\_line'\]，'flag'为默认值。
   2. `text` 图形的内容
   3. `lock` 是否锁定图形
   4. `disableSelection` \(since `1.3`\) 禁用选择
   5. `disableSave` \(since `1.3`\) 禁用保存
   6. `disableUndo` \(since `1.4`\) 禁用撤销
   7. `overrides` \(since `1.2`\). 它是一个对象，包含为新图形设置的属性。
   8. `zOrder` \(since `1.3`\) 可能的值为\[`top`, `bottom`\]. `top` 将线工具放在所有其他资源之上, `bottom` 将线工具放在所有其他资源之下, 'top'为默认值。
   9. `showInObjectsTree`: `true`为默认值。在“对象树”对话框中显示图形。
3. `callback`: function\(`entityId`\)

**从1.4开始，函数立即返回结果。回调保函数为持兼容性。**

查看[形状与覆盖](book/Shapes-and-Overrides.md)了解更多信息。

此调用会在主数据列上指定几个点位创建一个图形。  

### getShapeById(entityId)

  

1.  `entityId`: object. The value that is returned when a shape is created via API

  

Returns an object with the following methods that allows you to interact with the study:

  

1.  `isSelectionEnabled()` - returns `true` if the shape cannot be selected by a user

1.  `setSelectionEnabled(enable)` - enables or disables shape selection (see `disableSelection` option of `createMultipointShape`)

1.  `isSavingEnabled()` - returns `true` if the shape is not saved on the chart

1.  `setSavingEnabled(enable)` - enables or disables saving of the shape in the chart layout (see `disableSave` option of `createMultipointShape`)

1.  `isShowInObjectsTreeEnabled()` - returns `true` if the shape is displayed in the Objects Tree dialog

1.  `setShowInObjectsTreeEnabled(enabled)` - enables or disables displaying of the shape in the Objects Tree dialog

1.  `isUserEditEnabled()` - returns `true` if a user can remove/change/hide the shape

1.  `setUserEditEnabled(enabled)` - enables or disables removing/changing/hiding of the shape by a user

1.  `bringToFront()` - places the line tool on top of all other chart objects.

1.  `sendToBack()` - places the line tool behind all other chart objects.

1.  `getProperties()` - gets all the properties of the shape.

1.  `setProperties(properties)` - sets the properties of the shape.

`properties` should have the same structure as an object from `getProperties`. It can only include the properties that you want to override.

1.  `getPoints()` - returns the points of the shape. `Point` is an object with the following keys `{ price, time }`.

1.  `setPoints(points)` - set the new points of the shape.

The point format is the same as `points` argument from `createMultipointShape` method.

#### removeEntity\(entityId\)

1. `entityId`: object. 值为创建实体 \(图形的研究\) 后通过回调传递的值.

删除指定实体。

#### createVerticalLine\(point, options\)

1. `point`: object `{time}`
2. `options`: obejct `{lock}`

此方法为`createShape`的同义词，并且 shape = 'vertical\_line'. 它被视为 **已过时**.

#### removeAllShapes\(\)

删除全部图形\(绘图\)。

#### removeAllStudies\(\)

删除全部指标。

# 指标模板

#### createStudyTemplate\(options, callback\)

1. `options`: object `{saveInterval}`
   1. `saveInterval`: boolean
2. `callback`: function\(data\)

**从1.4开始，函数立即返回结果。回调保函数为持兼容性。**

将指标模板保存到JS对象。 图表库将调用您的回调函数并将状态对象作为参数传递。 该调用为低级的一部分 [存储与加载图表](/book/Saving-and-Loading-Charts.md)。

#### applyStudyTemplate\(template\)

1. `template`: object 

从状态对象加载指标模板。这个调用是低级的一部分。[存储与加载图表](/book/Saving-and-Loading-Charts.md)。

# 交易元语（Trading Primitives）

#### createOrderLine\(options\)

在图表上创建一个新订单，并返回一个API对象，您可以使用它来控制订单属性和行为。 强烈推荐阅读[交易元语](/book/Trading-Primitives.md)在调用此方法之前。

参数 \(自1.4\):  
`options` 是一个具有：`disableUndo`的对象, 这可以是 `true` 或 `false`. 出于兼容性原因，默认值为 `false`。

API对象方法：

* `remove()`: 从图表中移除位置。 调用此方法后不能再使用API对象。
* `onModify(callback)` / `onModify(data, callback)`
* `onMove(callback)` / `onMove(data, callback)`

API对象具有以下列出的一组属性。 每个属性都可以通过各自的访问器调用。 即，如果要使用`Extend Left`属性，请使用`getExtendLeft()` 或 `setExtendLeft()` 方法。

**一般属性**:

| Property | Type | Supported Values | Default Value |
| --- | --- | --- | --- |
| Price | Double | Double | 0.0 |
| Text | String | String | "" |
| Tooltip | String | String | "" |
| Quantity | String | String | "" |
| Editable | Boolean | Boolean | true |

**趋势线属性**:

| Property | Type | Supported Values | Default Value |
| --- | --- | --- | --- |
| Extend Left | Boolean | "inherit" or Boolean | True |
| Line Length | Integer | "inherit" or 0 .. 100 | 0 |
| Line Style | Integer | "inherit" or 0 .. 2 | 2 |
| Line Width | Integer | "inherit" or 1 .. 4 | 1 |

**字体**:

| Property | Type | Default Value |
| --- | --- | --- |
| Body Font | String | "bold 7pt Verdana" |
| Quantity Font | String | "bold 7pt Verdana" |

**颜色**:

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

例子:

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

在图表上创建一个新的位置并返回一个API对象，您可以使用它来控制位置属性和行为。 强烈推荐阅读[交易元语](/book/Trading-Primitives.md)在调用此方法之前。

参数 \(自 1.4\):  
`options` 是一个具有：`disableUndo`的对象, 这可以是 `true` 或 `false`. 出于兼容性原因，默认值为 `false`。

API对象方法：

* `remove()`: 从图表中移除位置。 调用此方法后不能再使用API对象。
* `onModify(callback)` / `onModify(data, callback)`
* `onMove(callback)` / `onMove(data, callback)`

API对象具有以下列出的一组属性。 每个属性都可以通过各自的访问器调用。 即，如果要使用`Extend Left`属性，请使用`getExtendLeft()` 或 `setExtendLeft()` 方法。

**一般属性**:

| Property | Type | Supported Values | Default Value |
| --- | --- | --- | --- |
| Price | Double | Double | 0.0 |
| Text | String | String | "" |
| Tooltip | String | String | "" |
| Quantity | String | String | "" |

**趋势线属性**:

| Property | Type | Supported Values | Default Value |
| --- | --- | --- | --- |
| Extend Left | Boolean | "inherit" or Boolean | True |
| Line Length | Integer | "inherit" or 0 .. 100 | 0 |
| Line Style | Integer | "inherit" or 0 .. 2 | 2 |
| Line Width | Integer | "inherit" or 1 .. 4 | 1 |

**字体**:

| Property | Type | Default Value |
| --- | --- | --- |
| Body Font | String | "bold 7pt Verdana" |
| Quantity Font | String | "bold 7pt Verdana" |

**颜色**:

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

例子:

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

在图表上创建一个新的执行，并返回一个可以用来控制执行属性的API对象。 在使用此呼叫之前，强烈建议您阅读[交易元语](/book/Trading-Primitives.md)。

参数 \(自 1.4\):  
`options` 是一个具有：`disableUndo`的对象, 这可以是 `true` 或 `false`. 出于兼容性原因，默认值为 `false`。

API对象具有以下列出的一组属性。 每个属性都可以通过各自的访问器调用。 即，如果要使用`Extend Left`属性，请使用`getExtendLeft()` 或 `setExtendLeft()` 方法。

API对象方法：

* `remove()`: 从图表中删除执行信号图形。 此调用后不能使用API对象。

**一般属性**:

| Property | Type | Supported Values | Default Value |
| --- | --- | --- | --- |
| Price | Double | Double | 0.0 |
| Time | Integer | Unix time | 0 |
| Direction | String | "buy" or "sell" | "buy" |
| Text | String | String | "execution" |
| Tooltip | String | String | "" |
| Arrow Height | Integer | Integer | 8 |
| Arrow Spacing | Integer | Integer | 1 |

**字体**:

| Property | Type | Default Value |
| --- | --- | --- |
| Font | String | "8pt Verdana" |

**颜色**:

| Property | Type | Default Value |
| --- | --- | --- |
| Text Color | String | "rgb\(0, 0, 0\)"" |
| Arrow Color | String | "rgba\(0, 0, 255\)" |

例子:

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

返回图表商品。

#### symbolExt\(\)

返回图表的商品信息对象。 该对象具有以下字段：

* `symbol`: the same as [symbol\(\)](#symbol) method result
* `full_name`: 商品全称
* `exchange`: 商品交易所
* `description`: 商品描述
* `type`: 商品类型

#### resolution\(\)

返回图表的分辨率。格式在这个[文章](/book/Resolution.md)中描述。

#### getVisibleRange\(\)

返回对象 `{from, to}`. `from` 和 `to` 是 **图表时区**的单位时间戳

#### getVisiblePriceRange\(\)

**Since 1.7**

返回对象 `{from, to}`. `from` 和 `to` 主数据列的可见数据内容。

#### priceFormatter\(\)

返回`format` 方法，用以格式化价格。在1.5中引入。

#### chartType\(\)

返回图表类型。

# 也可以看看

* [Widget方法](/book/Widget-Methods.md)
* [定制概述](/book/Customization-Overview.md)
* [Widgetg构造函数](/book/Widget-Constructor.md)
* [存储于加载图表](/book/Saving-and-Loading-Charts.md)
* [覆盖默认研究参数](/book/Studies-Overrides.md)
* [覆盖默认图表参数](/book/Overrides.md)


<!--stackedit_data:
eyJoaXN0b3J5IjpbMTgwNDExMzE3NCw1MDQxMTA2MDFdfQ==
-->