# 图表方法

---

以下为图表的方法列表。

**在1.4版本之前** 您可以使用Widget的构造函数返回给您的widget对象来调用下列方法。

**从1.5版本之后** 您可以使用Widget的方法[chart\(index\)](Widget-Methods.md#chartindex) 或 [activeChart\(\)](Widget-Methods.md#activechart)返回给您的图表对象来调用下列方法。

## 方法

* 图表订阅事件
  * [onDataLoaded\(\)](#ondataloaded)
  * [onSymbolChanged\(\)](#onsymbolchanged)
  * [onIntervalChanged\(\)](#onintervalchanged)
  * [dataReady\(callback\)](#datareadycallback)
  * [crossHairMoved\(callback\)](#crosshairmovedcallback)
  * [onVisibleRangeChanged\(\)](#onvisiblerangechanged)
* 图表动作
  * [setVisibleRange\(range, callback\)](#setvisiblerangerange-callback)
  * [setSymbol\(symbol, callback\)](#setsymbolsymbol-callback)
  * [setResolution\(resolution, callback\)](#setresolutionresolution-callback)
  * [resetData\(\)](#resetData)
  * [executeActionById\(action\)](#executeactionbyidactionid)
  * [getCheckableActionState\(action\)](#getcheckableactionstateactionid)
  * [refreshMarks\(\)](#refreshmarks)
  * [clearMarks\(\)](#clearmarks)
  * [setChartType\(type\)](#setcharttypetype)
  * [setTimezone(timezone)](#settimezonetimezone)
* 指标与图形
  * [getAllShapes\(\)](#getallshapes)
  * [getAllStudies\(\)](#getallstudies)
  * [setEntityVisibility\(id, isVisible\)](#setentityvisibilityid-isvisible)[过时]
  * [createStudy\(name, forceOverlay, lock, inputs, callback, overrides, options\)](#createstudyname-forceoverlay-lock-inputs-callback-overrides-options)
  * [getStudyById\(entityId\)](#getstudybyidentityid)
  * [createShape\(point, options\)](#createshapepoint-options)
  * [createMultipointShape\(points, options\)](#createmultipointshapepoints-options)
  * [getShapeById(entityId)](#getshapebyidentityid)
  * [removeEntity\(entityId\)](#removeentityentityid)
  * [removeAllShapes\(\)](#removeallshapes)
  * [removeAllStudies\(\)](#removeallstudies)
  * [getPanes()](#getpanes)
* 指标模板
  * [createStudyTemplate\(options\)](#createstudytemplateoptions)
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
* [其他](#其他)
  * [exportData(options)](#exportdataoptions)

# 图表订阅事件

#### onDataLoaded\(\)

您可以使用此方法返回的订阅[Subscription](/book/Subscription.md)对象进行订阅，以便在加载新历史K线时通知，您还可以使用此订阅对象取消此订阅事件。

#### onSymbolChanged\(\)

您可以使用此方法返回的[Subscription](/book/Subscription.md)对象进行订阅，以便在更改商品时通知，您还可以使用此订阅对象取消此订阅事件。

#### onIntervalChanged\(\)

您可以使用此方法返回的[Subscription](/book/Subscription.md)对象进行订阅，以便在更改时间周期时通知，您还可以使用此订阅对象取消此订阅事件。
当事件被触发时，它将提供以下参数：
1. `interval`: 新周期  
2. `timeframeParameters`: 此对象只有一个字段 `timeframe`. 

    如果在用户单击时间周期面板时更改时间周期，则它包含timeframe。

    否则 `timeframe` 为 `undefined`，你可以改变它来显示某一范围的K线。 有效的timeframe是一个数字，字母`D`代表天数，`M`代表月数。

例如:

```javascript
widget.chart().onIntervalChanged().subscribe(null, function(interval, obj) {
    obj.timeframe = "12M";
})
```

#### dataReady\(callback\)

1. `callback`: function\(interval\)

如果K线数据已被加载或被接收时，图表库将立即调用此回调。  
返回 `true` 为已经加载，否则为`false`。

#### crossHairMoved\(callback\)

*1.5版本开始*

1. `callback`: function\({time, price}\)

每当十字线位置改变时，图表库将会调用回调函数。

### onVisibleRangeChanged()

*1.13版本开始*

您可以使用此功能返回的[Subscription](/book/Subscription.md)对象进行订阅，以便在可见时间范围更改时得到通知。 
您还可以使用同一对象取消订阅该事件。

# 图表动作

#### setVisibleRange\(range, callback\)
*1.2版本开始*

1. `range`: 对象, `{from to}`
   1. `from`, `to`: unix时间戳, UTC
2. `callback`: `function()`. 图表库会调用回调在viewport\(视口\)设置完成时。

强制图表调整其参数 \(scroll, scale\) 使选定的时间段适合视口。  
`from`或`to`都不能设置为将来的日期。 

#### setSymbol\(symbol, callback\)

1. `symbol`: string
2. `callback`: function\(\)

更改图表商品。 新商品的数据到达后调用回调。

#### setResolution\(resolution, callback\)

1. `resolution`: string. 格式化详细参照:[周期](/book/Resolution.md)。
2. `callback`: function\(\)

更改图表周期。 新周期的数据到达后调用回调。

#### resetData\(\)

使图表重新请求datafeed中的数据。 通常你需要在图表数据发生变化时调用它。 
在调用这个之前，你应该调用[onResetCacheNeededCallback](JS-Api.md#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback)。

#### executeActionById\(actionId\)

*1.3版本开始*

1. `actionId`: string

通过它的id执行一个动作。

**显示对话框**

* `chartProperties`
* `compareOrAdd`
* `scalesProperties`
* `tmzProperties`
* `paneObjectTree`
* `insertIndicator`
* `symbolSearch`
* `changeInterval`

**其他动作**

* `timeScaleReset`
* `chartReset`
* `seriesHide`
* `studyHide`
* `lineToggleLock`
* `lineHide`
* `showLeftAxis`
* `showRightAxis`
* `scaleSeriesOnly`
* `drawingToolbarAction`
* `magnetAction`
* `stayInDrawingModeAction`
* `hideAllMarks`
* `showCountdown`
* `showSeriesLastValue`
* `showSymbolLabelsAction`
* `showStudyLastValue`
* `showStudyPlotNamesAction`
* `undo`
* `redo`
* `paneRemoveAllStudiesDrawingTools`

例如:

```javascript
// < ... >
widget.chart().executeActionById("undo");
// < ... >
widget.chart().executeActionById("drawingToolbarAction"); // 隐藏或显示绘图工具栏
// < ... >
```

#### getCheckableActionState\(actionId\)

*1.7版本开始*

1. `actionId`: string

根据操作ID获取是否可以勾选的状态（例如: `stayInDrawingModeAction`、`magnetAction`）（请参阅上面的操作ID）

#### refreshMarks\(\)

再次请求可见标记。

#### clearMarks\(\)

删除所有可见标记。

#### setChartType\(type\)

1. `type`: number

设置主数据列的样式。

```javascript
// 美国线
STYLE_BARS = 0;
// K线图
STYLE_CANDLES = 1;
// 线形图
STYLE_LINE = 2;
// 面积图
STYLE_AREA = 3;
// 平均K线图
STYLE_HEIKEN_ASHI = 8;
// 空心K线图
STYLE_HOLLOW_CANDLES = 9;

// 砖形图
STYLE_RENKO* = 4;
// 卡吉图
STYLE_KAGI* = 5;
// 点数图
STYLE_PNF* = 6;
// 新价图
STYLE_PB* = 7;
```

\*: 交易终端专属
  

### setTimezone\(timezone\)

1.  `timezone`: string  

查看[timezone](book/Widget-Constructor.md#timezone)更多信息

例:

```javascript
widget.activeChart().setTimezone('Asia/Singapore');
```
更改图表时区。

#### closePopupsAndDialogs\(\)

调用此方法关闭上下文菜单或对话框,假设其已经显示。

# 指标与图形

#### getAllShapes\(\)

返回所有已创建的形状对象数组。 每个对象都有以下字段：

* `id`: 形状id
* `name`: 形状名称

#### getAllStudies\(\)

返回所有已创建的指标对象的数组。 每个对象都有以下字段：

* `id`: 指标id
* `name`: 指标名称

#### setEntityVisibility\(id, isVisible\)

设置具有`id`的实体的可见性。

**不推荐使用**：使用形状/指标API（`getShapeById` /`getStudyById`）来代替此方法。 将在未来的版本中删除。

#### createStudy\(name, forceOverlay, lock, inputs, callback, overrides, options\)

1. `name`: string, 指标名称，您可以在`技术指标`工具栏中看到。
2. `forceOverlay`: 强制图表库将创建的指标放在主窗格中
3. `lock`: boolean, 是否锁定指标
4. `inputs`: \(在`1.2`版本开始\) 指标参数数组, 该数组应包含与指标属性对话框中相同顺序的输入值。
5. `callback`: function\(`entityId`\)
6. `overrides`: \(在`1.2`版本开始\) 一个对象 [包含属性](/book/Studies-Overrides.md),覆盖你的新指标 。注意：您不应指定指标名称：应以具有绘图名称的属性路径为起始。
7. `options`: 这个对象只支持关键字`checkLimit`. 如果为 `true` 时，超出限制，将显示指标限制对话框。
    * `checkLimit` - 如果是`true`，则超出限制时将显示指标限制对话框。
    * `priceScale` - 指标的首选价格坐标。 可能的值是：
        * `left` - 将指标缩放到左边
        * `right` - 将指标缩放到右边
        * `no-scale` - 不要将指标纳入任何价格坐标。 该指标将以`界面(无缩放)`模式添加
        * `as-series` - 将指标附加到主数据列所附的价格坐标（仅适用于将指标添加到主数据列的窗格中）


**从1.12版本开始，函数立即返回结果。 回调为保持兼容性**

创建一个关于主商品的指标。 例子:
  * `createStudy('MACD', false, false, [14, 30, "close", 9])`
  * `createStudy('Moving Average Exponential', false, false, [26])`
  * `createStudy('Stochastic', false, false, [26], null, {"%d.color" : "#FF0000"})`
  * `chart.createStudy('Moving Average', false, false, [26], null, {'Plot.linewidth': 10})`

**Remark**: `Compare` 指标有2个参数: `[dataSource, symbol]`. 支持 `dataSource` 的值: `["close", "high", "low", "open"]`.

**Remark 2**: 当您选择在图表上添加数据列时，您实际使用了`Overlay`指标，这个指标只有一个参数 -- `symbol`. 以下是添加商品的示例：

```javascript
    widget.chart().createStudy('Overlay', false, false, ['AAPL']);
```
**Remark 3**: 当您选择比较数据列时，您实际上使用了`Compare`指标。 它有2个参数 -- `source` 和 `symbol`. 下面是一个添加比较数据列的例子:

```javascript
    widget.chart().createStudy('Compare', false, false, ["open", 'AAPL']);
```

#### getStudyById(entityId)

1. `entityId`：对象。 通过API创建指标时返回的值。

返回[指标 API](Study-Api.md#)的一个实例，它允许您与指标进行交互。

#### createShape\(point, options\)

1. `point`: 对象 `{time, [price], [channel]}`
   1. `time`: unix时间戳. 唯一的强制性参数。
   2. `price`: 如果指定`price`，则形状将以相同的价格水平放置。 
        如果未指定，则根据`channel`值将形状放置在K线的相关位置。
   3. `channel`: 要保持价格水平线，要使用`channel` 参数 \(`open`, `high`, `low`, `close`\)。
        如果未指定则以`open`为默认值。
2. `options`: object `{shape, [text], [lock], [overrides]}`
   1. `shape` 可能的值为 `arrow_up`、`arrow_down`、`flag`、`vertical_line`、`horizontal_line`。
       `flag`为默认值。
   2. `text` 是一个可选参数。 如果支持，为包含在形状中的文本。
   3. `lock` 是否锁定图形
   4. `disableSelection` \(开始于 `1.3`\) 禁用选择
   5. `disableSave` \(开始于 `1.3`\) 禁用保存
   6. `disableUndo` \(开始于 `1.4`\) 禁用撤销
   7. `overrides` \(开始于 `1.2`\). 它是一个对象，包含为新形状设置的属性。
   8. `zOrder` \(开始于 `1.3`\) 可能的值为`top`、`bottom`。
        `top` 将线条工具放在所有其他图表对象的顶部, 而`bottom` 将线条工具放在所有其他图表对象底部, `top`为默认值。
   9. `showInObjectsTree`: `true`为默认值。在`工具树状图`对话框中显示形状。

该函数返回`entityId` - 如果创建成功则返回图形的唯一ID，如果不成功则返回`null`。

此调用会在图表上的指定地点创建一个形状，前提是它位于主数据列区域内。

#### createMultipointShape\(points, options\)

1. `points`: 具有以下字段的数组 `[{time, [price], [channel]},...]`
   1. `time`: unix时间戳. 唯一的强制性参数。
   2. `price`: 如果指定`price`，则形状将以相同的价格水平放置。 
        如果未指定，则根据`channel`值将形状放置在K线的相关位置。
   3. `channel`: 要保持价格水平线，要使用`channel` 参数 \(`open`, `high`, `low`, `close`\)。
        如果未指定则以`open`为默认值。
2. `options`: object `{shape, [text], [lock], [overrides]}`
   1. `shape` 可能的值为 `arrow_up`、`arrow_down`、`flag`、`vertical_line`、`horizontal_line`。
       `flag`为默认值。
   2. `text` 是一个可选参数。 如果支持，为包含在形状中的文本。
   3. `lock` 是否锁定图形
   4. `disableSelection` \(开始于 `1.3`\) 禁用选择
   5. `disableSave` \(开始于 `1.3`\) 禁用保存
   6. `disableUndo` \(开始于 `1.4`\) 禁用撤销
   7. `overrides` \(开始于 `1.2`\). 它是一个对象，包含为新形状设置的属性。
   8. `zOrder` \(开始于 `1.3`\) 可能的值为`top`、`bottom`。
        `top` 将线条工具放在所有其他图表对象的顶部, 而`bottom` 将线条工具放在所有其他图表对象底部, `top`为默认值。
   9. `showInObjectsTree`: `true`为默认值。在`工具树状图`对话框中显示形状。

该函数返回`entityId` - 如果创建成功则返回图形的唯一ID，如果不成功则返回`null`。

查看[形状与覆盖](Shapes-and-Overrides.md#)以获取更多信息。

此调用会在图表上的指定地点创建一个形状，前提是它位于主数据列区域内。

### getShapeById\(entityId\)

1. `entityId`：对象。 通过API创建形状时返回的值。

返回允许您与形状交互的[形状API](Shape-Api.md#)实例。

#### removeEntity\(entityId\)

1. `entityId`：对象。 为创建实体 \(形状或指标\) 后返回的值。

删除指定实体。

#### removeAllShapes\(\)

删除全部形状。

#### removeAllStudies\(\)

删除全部指标。

### getPanes()

返回[容器Api](Pane-Api.md) 的实例数组，允许您与容器进行交互。

# 指标模板

#### createStudyTemplate\(options\)

1. `options`: 对象 `{saveInterval}`
   1. `saveInterval`: boolean

将指标模板保存到JS对象。 图表库将调用您的回调函数并将状态对象作为参数传递。

此调用是低级[存储与加载图表](/book/Saving-and-Loading-Charts.md)的一部分。

#### applyStudyTemplate\(template\)

1. `template`: object 

从状态对象加载指标模板。

此调用是低级[存储与加载图表](/book/Saving-and-Loading-Charts.md)的一部分。

# 交易元语（Trading Primitives）

#### createOrderLine\(options\)

`options` 是一个具有字段：`disableUndo`的对象, 可以是 `true` 或 `false`. 出于兼容性原因，默认值为 `false`。

在图表上创建新的交易订单并返回可用于调整其属性和行为的API对象。

强烈建议在使用此调用之前阅读[交易元语](/book/Trading-Primitives.md)。

API对象方法：

* `remove()`: 从图表中移除仓位。 调用方法后不能再使用此API对象。
* `onModify(callback)` / `onModify(data, callback)`
* `onMove(callback)` / `onMove(data, callback)`

API对象具有下面列出的一组属性。 每个属性应通过各自的访问器调用。
例如，如果你想使用`Extend Left`属性，那么请使用`setExtendLeft()`和`getExtendLeft()`方法。

**一般属性**:

| 属性名称 | 类型 | 支持的值 | 默认值 |
| --- | --- | --- | --- |
| Price | Double | Double | 0.0 |
| Text | String | String | "" |
| Tooltip | String | String | "" |
| Quantity | String | String | "" |
| Editable | Boolean | Boolean | true |

**趋势线属性**:

| 属性名称 | 类型 | 支持的值 | 默认值 |
| --- | --- | --- | --- |
| Extend Left | Boolean | "inherit" or Boolean | True |
| Line Length | Integer | "inherit" or 0 .. 100 | 0 |
| Line Style | Integer | "inherit" or 0 .. 2 | 2 |
| Line Width | Integer | "inherit" or 1 .. 4 | 1 |

**字体**:

| 属性名称 | 类型 | 默认值 |
| --- | --- | --- |
| Body Font | String | "bold 7pt Verdana" |
| Quantity Font | String | "bold 7pt Verdana" |

**颜色**:

| 属性名称 | 类型 | 默认值 |
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

`options` 是一个具有字段：`disableUndo`的对象, 可以是 `true` 或 `false`. 出于兼容性原因，默认值为 `false`。

在图表上创建新的交易头寸并返回一个可用于调整其属性和行为的API对象。

强烈建议在使用此调用之前阅读[交易元语](/book/Trading-Primitives.md)。

API对象方法：

* `remove()`: 从图表中移除位置。 调用此方法后不能再使用API对象。
* `onModify(callback)` / `onModify(data, callback)`
* `onMove(callback)` / `onMove(data, callback)`

API对象具有下面列出的一组属性。 每个属性应通过各自的访问器调用。
例如，如果你想使用`Extend Left`属性，那么请使用`setExtendLeft()`和`getExtendLeft()`方法。

**一般属性**:

| 属性名称 | 类型 | 支持的值 | 默认值 |
| --- | --- | --- | --- |
| Price | Double | Double | 0.0 |
| Text | String | String | "" |
| Tooltip | String | String | "" |
| Quantity | String | String | "" |

**趋势线属性**:

| 属性名称 | 类型 | 支持的值 | 默认值 |
| --- | --- | --- | --- |
| Extend Left | Boolean | "inherit" or Boolean | True |
| Line Length | Integer | "inherit" or 0 .. 100 | 0 |
| Line Style | Integer | "inherit" or 0 .. 2 | 2 |
| Line Width | Integer | "inherit" or 1 .. 4 | 1 |

**字体**:

| 属性名称 | 类型 | 默认值 |
| --- | --- | --- |
| Body Font | String | "bold 7pt Verdana" |
| Quantity Font | String | "bold 7pt Verdana" |

**颜色**:

| 属性名称 | 类型 | 默认值 |
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


1. `options` 是一个具有字段：`disableUndo`的对象, 这可以是 `true` 或 `false`. 出于兼容性原因，默认值为 `false`。

在图表上创建新的交易执行并返回可用于控制执行属性的API对象。

强烈建议在使用此调用之前阅读[交易元语](/book/Trading-Primitives.md)。

API对象具有下面列出的一组属性。 每个属性应通过各自的访问器调用。
例如，如果你想使用`Extend Left`属性，那么请使用`setExtendLeft()`和`getExtendLeft()`方法。

API对象方法：

* `remove()`：从图表中删除执行信号图形。调用后，您无法再次使用此API对象。

**一般属性**:

| 属性名称 | 类型 | 支持的值 | 默认值 |
| --- | --- | --- | --- |
| Price | Double | Double | 0.0 |
| Time | Integer | Unix time | 0 |
| Direction | String | "buy" or "sell" | "buy" |
| Text | String | String | "execution" |
| Tooltip | String | String | "" |
| Arrow Height | Integer | Integer | 8 |
| Arrow Spacing | Integer | Integer | 1 |

**字体**:

| 属性名称 | 类型 | 默认值 |
| --- | --- | --- |
| Font | String | "8pt Verdana" |

**颜色**:

| 属性名称 | 类型 | 默认值 |
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

* `symbol`: 与方法[symbol\(\)](#symbol)结果相同
* `full_name`: 商品全称
* `exchange`: 商品交易所
* `description`: 商品描述
* `type`: 商品类型

#### resolution\(\)

返回图表的周期。格式在这个[周期](/book/Resolution.md)中描述。

#### getVisibleRange\(\)

返回对象 `{from, to}`. `from` 和 `to` 是 **图表时区**的单位时间戳

#### getVisiblePriceRange\(\)

**在1.7版本开始**

返回对象 `{from, to}`. `from` 和 `to` 是主数据列的可见范围边界。

#### priceFormatter\(\)

返回带有`format`函数的对象，可用于格式化价格。

#### chartType\(\)

返回图表类型。

## 其他

### exportData(options)

*从1.14版本开始*

1. `options` (可选)是一个对象，它可以包含以下属性：
    * `from` (`number`) - 第一个导出k线的时间(UNIX时间戳，以秒为单位)。
        默认情况下，使用最左侧加载的k线的时间。
    * `to` (`number`) - 最后一个导k线的时间(UNIX时间戳，以秒为单位)。
        默认情况下，使用最右侧(实时)k线的时间。
    * `includeTime`(`boolean`, 默认`true`) - 定义导出数据的每个项目是否应包含时间。
    * `includeSeries`(`boolean`, 默认`true`) - 定义导出的数据是否应包含数据列(open，high，low，close)。
    * `includedStudies` - 哪些指标应包括在导出的数据中
        (默认情况下，值为`'all'`表示包含所有指标, 但如果您只想导出其中一些,则可以在数组中指定[指标ID](＃getallstudies))。

从图表中导出数据，返回Promise对象。 此方法不加载数据。 结果具有以下结构:

* `schema`是一个字段描述符数组，每个描述符可能是以下类型之一：
    * `TimeFieldDescriptor` - 时间字段的描述。 它只包含一个属性 - 带有`'time'`值的`type`。
    * `SeriesFieldDescriptor` - 数据列字段的描述。 它包含以下属性：
      * `type`(`'value'`)
      * `sourceType`(`'series'`)
      * `plotTitle`(`string`) - 绘图的名称（open，high，low，close)。
    * `StudyFieldDescriptor` - 指标字段的描述。 它包含以下属性：
      * `type`(`'value'`)
      * `sourceType`(`'study'`)
      * `sourceId`(`string`) - 指标ID
      * `sourceTitle`(`string`) - 指标的标题
      * `plotTitle`(`string`) - 绘图的标题

* `data` 为[Float64Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Float64Array)类型数组。
   每个 `Float64Array` 数组与 `schema` 数组的长度相同，表示相关字段的项目。

**例如:**

1. `chart.exportData({ includeTime: false, includeSeries: true, includedStudies: [] })` - 仅导出数据列。
1. `chart.exportData({ includeTime: true, includeSeries: true, includedStudies: [] })` - 随时间导出数据列。
1. `chart.exportData({ includeTime: false, includeSeries: false, includedStudies: ['STUDY_ID'] })` - 导出ID为`STUDY_ID`的指标数据。
1. `chart.exportData({ includeTime: true, includeSeries: true, includedStudies: 'all' })` - 从图表中导出所有可用数据。
1. `chart.exportData({ includeTime: false, includeSeries: true, to: Date.UTC(2018, 0, 1) / 1000 })` - 导出`2018-01-01`以前的数据。
1. `chart.exportData({ includeTime: false, includeSeries: true, from: Date.UTC(2018, 0, 1) / 1000 })` - 导出`2018-01-01`之后的数据。
1. `chart.exportData({ includeTime: false, includeSeries: true, from: Date.UTC(2018, 0, 1) / 1000, to: Date.UTC(2018, 1, 1) / 1000 })` - 导出在 `2018-01-01` 和 `2018-02-01` 之间的数据。

# 也可以看看

* [Widget方法](/book/Widget-Methods.md)
* [定制概述](/book/Customization-Overview.md)
* [Widgetg构造函数](/book/Widget-Constructor.md)
* [存储于加载图表](/book/Saving-and-Loading-Charts.md)
* [指标覆盖默认参数](/book/Studies-Overrides.md)
* [覆盖默认参数](/book/Overrides.md)


<!--stackedit_data:
eyJoaXN0b3J5IjpbMTcxMTA2NzU1OCw1MDQxMTA2MDFdfQ==
-->