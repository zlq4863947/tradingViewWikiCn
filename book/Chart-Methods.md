# 图表方法

---

以下为图表的方法列表。

**在 1.4 版本之前** 您可以使用 Widget 的构造函数返回给您的 widget 对象来调用下列方法。

**从 1.5 版本之后** 您可以使用 Widget 的方法[chart\(index\)](Widget-Methods.md#chartindex) 或 [activeChart\(\)](Widget-Methods.md#activechart)返回给您的图表对象来调用下列方法。

## 方法

- [图表订阅事件](#图表订阅事件)
  - [onDataLoaded\(\)](#ondataloaded)
  - [onSymbolChanged\(\)](#onsymbolchanged)
  - [onIntervalChanged\(\)](#onintervalchanged)
  - [onChartTypeChanged()](#oncharttypechanged)
  - [dataReady\(\)](#dataready)
  - [crossHairMoved\(\)](#crosshairmoved)
  - [onVisibleRangeChanged\(\)](#onvisiblerangechanged)
- [图表动作](#图表动作)
  - [setVisibleRange\(range, options\)](#setvisiblerangerange-options)
  - [setSymbol\(symbol, callback\)](#setsymbolsymbol-callback)
  - [setResolution\(resolution, callback\)](#setresolutionresolution-callback)
  - [resetData\(\)](#resetData)
  - [executeActionById\(action\)](#executeactionbyidactionid)
  - [getCheckableActionState\(action\)](#getcheckableactionstateactionid)
  - [refreshMarks\(\)](#refreshmarks)
  - [clearMarks\(\)](#clearmarks)
  - [setChartType\(type\)](#setcharttypetype)
  - [setTimezone(timezone)](#settimezonetimezone)
  - [getTimezone()](#gettimezone)
  - [canZoomOut\(\)](#canzoomout)
  - [zoomOut\(\)](#zoomout)
- [指标与形状](#指标与形状)
  - [getAllShapes\(\)](#getallshapes)
  - [getAllStudies\(\)](#getallstudies)
  - [setEntityVisibility\(id, isVisible\)](#setentityvisibilityid-isvisible)[过时]
  - [createStudy\(name, forceOverlay, lock, inputs, overrides, options\)](#createstudyname-forceoverlay-lock-inputs-overrides-options)
  - [getStudyById\(entityId\)](#getstudybyidentityid)
  * [getSeries()](#getseries)
  * [showPropertiesDialog\(entityId\)](#showpropertiesdialogentityid)
  - [createShape\(point, options\)](#createshapepoint-options)
  - [createMultipointShape\(points, options\)](#createmultipointshapepoints-options)
  - [getShapeById(entityId)](#getshapebyidentityid)
  - [removeEntity\(entityId\)](#removeentityentityid-options)
  - [removeAllShapes\(\)](#removeallshapes)
  - [removeAllStudies\(\)](#removeallstudies)
  - [getPanes()](#getpanes)
  - [shapesGroupController()](#shapesgroupcontroller)
- [Z-order operations](#z-order-operations)
  - [availableZOrderOperations(entities)](#availablezorderoperationsentities)
  - [sendToBack(entities)](#sendtobackentities)
  - [bringToFront(entities)](#bringtofrontentities)
  - [bringForward(entities)](#bringforwardentities)
  - [sendBackward(entities)](#sendbackwardentities)
- [指标模板](#指标模板)
  - [createStudyTemplate\(options\)](#createstudytemplateoptions)
  - [applyStudyTemplate\(template\)](#applystudytemplatetemplate)
- [Trading Primitives](#交易元语trading-primitives)
  - [createOrderLine\(\)](#createorderlineoptions)
  - [createPositionLine\(\)](#createpositionlineoptions)
  - [createExecutionShape\(\)](#createexecutionshapeoptions)
- [Getters](#getters)
  - [symbol\(\)](#symbol)
  - [symbolExt\(\)](#symbolExt)
  - [resolution\(\)](#resolution)
  - [getVisibleRange\(\)](#getvisiblerange)
  - [getVisiblePriceRange\(\)](#getvisiblepricerange)
  - [scrollPosition()](#scrollposition)
  - [defaultScrollPosition()](#defaultscrollposition)
  - [priceFormatter\(\)](#priceformatter)
  - [chartType\(\)](#charttype)
  - [getPriceToBarRatio()](#getpricetobarratio)
  - [isPriceToBarRatioLocked()](#ispricetobarratiolocked)
  - [getAllPanesHeight()](#getAllPanesHeight)
  - [setAllPanesHeight(heights)](#setAllPanesHeightheights)
- [其他](#其他)
  - [exportData(options)](#exportdataoptions)
  - [selection()](#selection)
  - [setZoomEnabled(enabled)](#setzoomenabledenabled)
  - [setScrollEnabled(enabled)](#setscrollenabledenabled)
  * [getTimeScale()](#gettimescale)
  * [isSelectBarRequested()](#isselectbarrequested)
  * [requestSelectBar()](#requestselectbar)
  * [cancelSelectBar()](#cancelselectbar)
  * [setPriceToBarRatio(value, options)](#setpricetobarratiovalue-options)
  * [setPriceToBarRatioLocked(value, options)](#setpricetobarratiolockedvalue-options)

# 图表订阅事件

#### onDataLoaded\(\)

您可以使用此方法返回的[订阅](Subscription.md)对象进行订阅，以便在加载新历史 K 线时收到通知，您还可以使用此订阅对象取消此订阅事件。

示例:

```javascript
widget.activeChart().onDataLoaded().subscribe(
    null,
    () => console.log('New history bars are loaded',
    true
);
```

#### onSymbolChanged\(\)

您可以使用此方法返回的[订阅](Subscription.md)对象进行订阅，此函数返回的对象，用于在间隔更改时收到通知。 您还可以使用相同的对象取消订阅事件。

示例:

```javascript
widget.activeChart().onSymbolChanged().subscribe(null, () => console.log('The symbol is changed'));
```

#### onIntervalChanged\(\)

您可以使用此方法返回的[订阅](Subscription.md)对象进行订阅，以便在更改时间周期时收到通知，您还可以使用此订阅对象取消此订阅事件。
当事件被触发时，它将提供以下参数：

1. `interval`: 新周期
2. `timeframeObj`: 此对象只有一个字段 `timeframe`

   如果在用户单击时间周期面板时更改时间周期，则它包含 `timeframe`。

   否则 `timeframe` 为 `undefined`，您可以更改它以显示特定范围的 K 线。 有效的时间范围是一个 `TimeFrameValue` 对象。

   `TimeFrameValue` 可以是：
    1. 一个时间期限对象，`{type, value}`：
        * `type`：`period-back`。
        * `value`：有效时间范围是一个数字，字母 D 表示天，M 表示月。
    2. 一个范围对象，`{type, from, to}`
        * `type`： `time-range`。
        * `from`, `to`：UNIX 时间戳，UTC。
示例:

```javascript
widget.activeChart().onIntervalChanged().subscribe(null, (interval, timeframeObj) => timeframeObj.timeframe = { value: "12M", type: "period-back" });

widget.activeChart().onIntervalChanged().subscribe(null,
    (interval, timeframeObj) => timeframeObj.timeframe = { from: new Date('2015-01-01').getTime() / 1000, to: new Date('2017-01-01').getTime() / 1000, type: "time-range" }
);
```
### onChartTypeChanged()

您可以使用此函数返回的 [Subscription](Subscription.md) 对象进行订阅，以便在图表类型更改时收到通知。 您还可以使用相同的对象取消订阅事件。
当事件被触发时，它将提供 `chartType` 参数，可能的值在 [这里](#setcharttypetype) 描述。

例子：

```javascript
widget.activeChart().onChartTypeChanged().subscribe(null, (chartType) => console.log('图表类型改变'));
```

#### dataReady\(\)

如果K线已经加载，则该函数返回`true`，否则返回`false`。

示例:

```javascript
if (widget.activeChart().dataReady()) {
    /* do something */
}
```

#### crossHairMoved\(\)

您可以使用此函数返回的 [Subscription](Subscription.md) 对象进行订阅，以便在可见时间范围更改时收到通知。 您还可以使用相同的对象取消订阅事件。

当事件被触发时，它将提供以下参数：

1.`params`：对象`{time price}`
    * `time`：unix 时间戳，UTC。
    * `price`：数字。

示例:

```javascript
widget.activeChart().crossHairMoved().subscribe(
    null,
    ({ time, price }) => console.log(time, price)
);
```

### onVisibleRangeChanged()

_1.13 版本开始_

您可以使用此功能返回的[Subscription](Subscription.md)对象进行订阅，以便在可见时间范围更改时得到通知。
您还可以使用同一对象取消订阅该事件。

触发事件时，它将提供以下参数：

1. `range`: 对象, `{from, to}`
   * `from`, `to`: unix时间戳, UTC
   
示例:

```javascript
widget.activeChart().onVisibleRangeChanged().subscribe(
    null,
    ({ from, to }) => console.log(from, to)
);
```

# 图表动作

#### setVisibleRange\(range, options\)

1. `range`: 对象, `{from, to}`
   * `from`, `to`: unix时间戳, UTC
2. `options`: `{applyDefaultRightMargin, percentRightMargin}`
    * `applyDefaultRightMargin`: 布尔值，表示如果指向最后一个线，是否应将默认的右边距应用于右边框。
    * `percentRightMargin`: 布尔值，表示如果指向最后一个线，是否应将默认的右边距百分比应用于右边框。

强制图表调整其参数 \(scroll, scale\) 以使选定的时间段适合视口。  

返回一个Promise对象，将在应用可见范围后，返回resolved。

_此方法是在版本1.2中引入_

```javascript
widget.activeChart().setVisibleRange(
    { from: 1420156800, to: 1451433600 },
    { percentRightMargin: 20 }
).then(() => console.log('New visible range is applied'));
```

#### setSymbol\(symbol, callback\)

1. `symbol`: string
2. `callback`: function\(\), 可选

更改图表商品。 新商品的数据到达后调用回调。

```javascript
widget.activeChart().setSymbol('IBM');
```

#### setResolution\(resolution, callback\)

1. `resolution`: string. 格式化详细参照:[周期](Resolution.md)。
2. `callback`: function\(\), 可选

更改图表周期。 新周期的数据到达后调用回调。

```javascript
widget.activeChart().setResolution('2M');
```

#### resetData\(\)

使图表重新请求 datafeed 中的数据。 通常你需要在图表数据发生变化时调用它。
在调用这个函数之前，你应该从 `subscribeBars` 调用 [`onResetCacheNeededCallback`](JS-Api.md#subscribebarssymbolinfo-resolution-onrealtimecallback-subscriberuid-onresetcacheneededcallback)。

```javascript
widget.activeChart().resetData();
```

#### executeActionById\(actionId\)

_1.3 版本开始_

1. `actionId`: string

通过它的 id 执行一个动作。

**显示对话框**

- `chartProperties`
- `compareOrAdd`
- `scalesProperties`
- `paneObjectTree`
- `insertIndicator`
- `symbolSearch`
- `changeInterval`
- `gotoDate`

**其他动作**

- `timeScaleReset`
- `chartReset`
- `seriesHide`
- `studyHide`
- `lineToggleLock`
- `lineHide`
- `showLeftAxis`
- `showRightAxis`
- `scaleSeriesOnly`
- `drawingToolbarAction`
- `stayInDrawingModeAction`
- `hideAllMarks`
- `showCountdown`
- `showSeriesLastValue`
- `showSymbolLabelsAction`
- `showStudyLastValue`
- `showStudyPlotNamesAction`
- `undo`
- `redo`
- `paneRemoveAllStudiesDrawingTools`

例如:

```javascript
// < ... >
widget.chart().executeActionById("undo");
// < ... >
widget.chart().executeActionById("drawingToolbarAction"); // 隐藏或显示绘图工具栏
// < ... >
```

#### getCheckableActionState\(actionId\)

_1.7 版本开始_

1. `actionId`: string

根据动作 ID 获取是否可以勾选的状态（例如: `stayInDrawingModeAction`、`showSymbolLabelsAction`）（请参阅上面的动作ID）

```javascript
if (widget.activeChart().getCheckableActionState("drawingToolbarAction")) {
    /* do something */
};
```

#### refreshMarks\(\)

再次请求可见标记。

```javascript
widget.activeChart().refreshMarks();
```


#### clearMarks\(\)

清除所有可见标记。

```javascript
widget.activeChart().clearMarks();
```

#### setChartType\(type\)

1. `type`: number

设置主数据列的样式。

| Style | JavaScript type | Typescript Enum | Charting Library | Trading Terminal |
| --- | --- | --- | :---: | :---: |
| Bar | 0 | ChartStyle.Bar | ✓ | ✓ |
| Candle | 1 | ChartStyle.Candle | ✓ | ✓ |
| Line | 2 | ChartStyle.Line | ✓ | ✓ |
| Area | 3 | ChartStyle.Area | ✓ | ✓ |
| Renko | 4 | ChartStyle.Renko | | ✓ |
| Kagi | 5 | ChartStyle.Kagi | | ✓ |
| PnF | 6 | ChartStyle.PnF | | ✓ |
| Line Break | 7 | ChartStyle.LineBreak | | ✓ |
| Heikin-Ashi | 8 | ChartStyle.HeikinAshi | ✓ | ✓ |
| Hollow Candle | 9 | ChartStyle.HollowCandle | ✓ | ✓ |
| Baseline | 10 | ChartStyle.Baseline | ✓ | ✓ |
| Hi-Lo | 12 | ChartStyle.HiLo | ✓ | ✓ |

```javascript
widget.activeChart().setChartType(12);
```

### setTimezone\(timezone\)

1. `timezone`: string

查看[timezone](Widget-Constructor.md#timezone)更多信息

例:

```javascript
widget.activeChart().setTimezone("Asia/Singapore");
```

更改图表时区。

### getTimezone()

*Since version 1.15.*

返回图表的当前[timezone](Widget-Constructor#timezone)。

```javascript
console.log(widget.activeChart().getTimezone());
```

### canZoomOut()

_该方法在版本`1.14`中引入_

当您调用此方法时，图表库会检查是否有任何缩放事件要撤消。

```javascript
console.log(widget.activeChart().canZoomOut());
```

### zoomOut()

_该方法在版本`1.14`中引入_

当您调用此方法时，它会模拟点击“缩小”按钮。 仅在图表缩放时才有效。 使用`canZoomOut`检查是否可以调用此方法。

```javascript
if(widget.activeChart().canZoomOut()) {
    widget.activeChart().zoomOut();
};
```

# 指标与形状

#### getAllShapes\(\)

返回所有已创建的形状对象数组。 每个对象都有以下字段：

- `id`: 形状 id
- `name`: 形状名称

```javascript
widget.activeChart().getAllShapes().forEach(({ name }) => console.log(name));
```

#### getAllStudies\(\)

返回所有已创建的指标对象的数组。 每个对象都有以下字段：

- `id`: 指标 id
- `name`: 指标名称

```javascript
widget.activeChart().getAllStudies().forEach(({ name }) => console.log(name));
```

#### setEntityVisibility\(id, isVisible\)

设置具有`id`的实体的可见性。

**不推荐使用**：使用形状/指标 API（`getShapeById` /`getStudyById`）来代替此方法。 将在未来的版本中删除。

#### createStudy\(name, forceOverlay, lock, inputs, overrides, options\)

1. `name`: string, 指标名称，您可以在`技术指标`工具栏中看到。
2. `forceOverlay`: 强制图表库将创建的指标放在主窗格中
3. `lock`: boolean, 是否锁定指标
4. `inputs`: \(在`1.2`版本开始\) 指标参数数组, 该数组应包含与指标属性对话框中相同顺序的输入值。
5. `overrides`: \(在`1.2`版本开始\) 一个对象 [包含属性](Studies-Overrides.md),覆盖你的新指标 。注意：您不应指定指标名称：应以具有绘图名称的属性路径为起始。
6. `options`: 这个对象只支持关键字`checkLimit`. 如果为 `true` 时，超出限制，将显示指标限制对话框。
   - `checkLimit` - 如果是`true`，则超出限制时将显示指标限制对话框。
   - `priceScale` - 指标的首选价格刻度。 可能的值是：
     - `new-left` - 依附在左侧价格刻度
     - `new-right` - 依附在右侧价格刻度
     - `no-scale` - 不要将指标依附在任何价格刻度上。 该指标将以`界面(无缩放)`模式添加
     - `as-series` - 将指标依附在主数据列所依附的价格刻度（仅适用于将指标添加到主数据列的窗格中）
     - `entityId` - 将指标和具有相应 `id` 的指标锁定在同一价格轴上。

请参阅[此处](Panes-And-Scales-Behavior.md)有关与指标相关的窗格和刻度特性的更多信息。

返回一个 Promise 类型的 `entityId`。

**从 1.12 版本开始，函数立即返回结果。 回调为保持兼容性**

创建一个关于主商品的指标。 例子:

* `widget.activeChart().createStudy('MACD', false, false, [14, 30, "close", 9])`
* `widget.activeChart().createStudy('Moving Average Exponential', false, false, [26])`
* `widget.activeChart().createStudy('Stochastic', false, false, [26], {"%d.color" : "#FF0000"})`
* `widget.activeChart().createStudy('Price Channel', true, false, [26], null, {checkLimit: false, priceScale: 'new-left'})`


**Remark**: `Compare` 指标有 2 个参数: `[dataSource, symbol]`. `dataSource` 支持的值: `["close", "high", "low", "open"]`.

**Remark 2**: 当您选择在图表上添加数据列时，您实际使用了`Overlay`指标，这个指标只有一个参数 -- `symbol`. 以下是添加商品的示例：

```javascript
widget.activeChart().createStudy('Overlay', false, false, ['AAPL']);
```

**Remark 3**: 当您选择比较数据列时，您实际上使用了`Compare`指标。 它有 2 个参数 -- `source` 和 `symbol`. 下面是一个添加比较数据列的例子:

```javascript
widget.activeChart().createStudy('Compare', false, false, ["open", 'AAPL']);
```

#### getStudyById(entityId)

1. `entityId`：对象。 通过 API 创建指标时返回的值。

返回[指标 API](Study-Api.md#)的一个实例，它允许您与指标进行交互。

```javascript
widget.activeChart().getStudyById(id).setVisible(false);
```

### getSeries()

返回允许您与主数据列进行交互的[SeriesApi](Series-Api)的实例。

```javascript
widget.activeChart().getSeries().setVisible(false);
```

### showPropertiesDialog(entityId)

1. `entityId`: 实体id。通过API创建指标或形状时返回的值。

用于显示指定的指标或形状的属性对话框。

```javascript
const chart = widget.activeChart();
chart.showPropertiesDialog(chart.getAllShapes()[0].id);`
```

#### createShape\(point, options\)

1. `point`: 对象 `{time, [price], [channel]}`
   - `time`: unix 时间戳. 唯一的强制性参数。
   - `price`: 如果指定`price`，则形状将以此价格位置放置。
      如果未指定，则根据`channel`值将形状放置在 K 线的相关位置。
   - `channel`: 如果未设置`price`，则通过`channel`设置的k线位置放置形状，可能的值： \(`open`, `high`, `low`, `close`\)。
      如果未指定`channel`，则以`open`为默认值。
2. `options`: object `{shape, [text], [lock], [overrides]}`
   - `shape` 可能的值为 `arrow_up`、`arrow_down`、`flag`、`vertical_line`、`horizontal_line`。
      `flag`为默认值。
   - `text` 是一个可选参数。 如果支持，为包含在形状中的文本。
   - `lock` 是否锁定形状
   - `disableSelection` \(开始于 `1.3`\) 禁用选中
   - `disableSave` \(开始于 `1.3`\) 禁用保存
   - `disableUndo` \(开始于 `1.4`\) 禁用撤销
   - `overrides` \(开始于 `1.2`\). 它是一个对象，包含为新形状设置的属性。
   - `zOrder` \(开始于 `1.3`\) 可能的值为`top`、`bottom`。
      `top` 将线条工具放在所有其他图表对象的顶部, 而`bottom` 将线条工具放在所有其他图表对象底部, `top`为默认值。
   - `showInObjectsTree`: `true`为默认值。在`工具树状图`对话框中显示形状。
   - `ownerStudyId`: `EntityId`类型的可选参数。它可用于将线工具绑定到指标。 例如，它可以用于在其他窗格上创建形状。
   
该函数返回`entityId` - 如果创建成功则返回形状的唯一 ID，如果不成功则返回`null`。

此调用会在图表上的指定地点创建一个形状，前提是它位于主数据列区域内。

```javascript
widget.activeChart().createShape({ time: 1514764800 }, { shape: 'vertical_line' });
```

#### createMultipointShape\(points, options\)

1. `points`: 具有以下字段的数组 `[{time, [price], [channel]},...]`
   - `time`: unix 时间戳. 唯一的强制性参数。
   - `price`: 如果指定`price`，则形状将以此价格位置放置。
      如果未指定，则根据`channel`值将形状放置在 K 线的相关位置。
   - `channel`: 如果未设置`price`，则通过`channel`设置的k线位置放置形状，可能的值： \(`open`, `high`, `low`, `close`\)。
      如果未指定`channel`，则以`open`为默认值。
2. `options`: object `{shape, [text], [lock], [overrides]}`
   - `shape` 可能的值为 `arrow_up`、`arrow_down`、`flag`、`vertical_line`、`horizontal_line`。
      `flag`为默认值。
   - `text` 是一个可选参数。 如果支持，为包含在形状中的文本。
   - `lock` 是否锁定形状
   - `disableSelection` \(开始于 `1.3`\) 禁用选中
   - `disableSave` \(开始于 `1.3`\) 禁用保存
   - `disableUndo` \(开始于 `1.4`\) 禁用撤销
   - `overrides` \(开始于 `1.2`\). 它是一个对象，包含为新形状设置的属性。
   - `zOrder` \(开始于 `1.3`\) 可能的值为`top`、`bottom`。
      `top` 将线条工具放在所有其他图表对象的顶部, 而`bottom` 将线条工具放在所有其他图表对象底部, `top`为默认值。
   - `showInObjectsTree`: `true`为默认值。在`工具树状图`对话框中显示形状。
   - `ownerStudyId`: `EntityId`类型的可选参数。它可用于将线工具绑定到指标。 例如，它可以用于在其他窗格上创建形状。

该函数返回`entityId` - 如果创建成功则返回形状的唯一 ID，如果不成功则返回`null`。

查看[形状与覆盖](Shapes-and-Overrides.md#)以获取更多信息。

此调用会在图表上的指定地点创建一个多点形状，前提是它位于主数据列区域内。

```javascript
const from = Date.now() / 1000 - 500 * 24 * 3600 * 1000; // 500 days ago
const to = Date.now() / 1000;
widget.activeChart().createMultipointShape(
    [{ time: from, price: 150 }, { time: to, price: 150 }],
    {
        shape: "trend_line",
        lock: true,
        disableSelection: true,
        disableSave: true,
        disableUndo: true,
        text: "text",
    }
);

```

### getShapeById\(entityId\)

1. `entityId`：对象。 通过 API 创建形状时返回的值。

返回允许您与形状交互的[形状 API](Shape-Api.md#)实例。

```javascript
widget.activeChart().getShapeById(id).bringToFront();
```

#### removeEntity\(entityId, options\)

1. `entityId`：对象。 为创建实体 \(形状或指标\) 后返回的值。

删除指定实体。

```javascript
widget.activeChart().removeEntity(id);
```

#### removeAllShapes\(\)

删除全部形状。

```javascript
widget.activeChart().removeAllShapes();
```

#### removeAllStudies\(\)

删除全部指标。

```javascript
widget.activeChart().removeAllStudies();
```

### getPanes()

返回[窗格Api](Pane-Api.md) 的实例数组，允许您与窗格进行交互。

```javascript
widget.activeChart().getPanes()[1].moveTo(0);
```

### shapesGroupController()

返回可用于处理形状组的[API](Shapes-Group-Api)。

```javascript
widget.activeChart().shapesGroupController().createGroupFromSelection();
```

## Z-order operations

### availableZOrderOperations(entities)

1. `entities` 标识符数组

返回具有可用于指定对象集的操作的对象。

此对象的结构具有以下字段：

* `bringForwardEnabled`: 如果可以将视觉次序设置为上移一层，则设置为true
* `bringToFrontEnabled`: 如果可以将视觉次序设置为置于顶层，则设置为true
* `sendBackwardEnabled`: 如果可以将视觉次序设置为下移一层，则设置为true
* `sendToBackEnabled`: 如果可以将视觉次序设置为置于底层，则设置为true

```javascript
widget.activeChart().availableZOrderOperations([id]);
```

### sendToBack(entities)

1. `entities` is an array of identifiers

Sends specified entities to back.

```javascript
widget.activeChart().sendToBack([id]);
```

### bringToFront(entities)

1. `entities` 标识符数组

将指定的实体置于最前面。

```javascript
widget.activeChart().bringToFront([id]);
```

### bringForward(entities)

1. `entities` 标识符数组

使指定的实体上移一层。

```javascript
widget.activeChart().bringForward([id]);
```

### sendBackward(entities)

1. `entities` 标识符数组

使指定的实体下移一层。

```javascript
widget.activeChart().sendBackward([id]);
```

# 指标模板

#### createStudyTemplate\(options\)

1. `options`: 对象 `{saveInterval}`
   1. `saveInterval`: boolean

将指标模板保存到 JS 对象。 图表库将调用您的回调函数并将状态对象作为参数传递。

此调用是低级[存储与加载图表](Saving-and-Loading-Charts.md)的一部分。

```javascript
const template = widget.activeChart().createStudyTemplate({ saveInterval: true });
```

#### applyStudyTemplate\(template\)

1. `template`: object

从状态对象加载指标模板。

此调用是低级[存储与加载图表](Saving-and-Loading-Charts.md)的一部分。

```javascript
widget.activeChart().applyStudyTemplate(template);
```

# 交易元语\(Trading Primitives\)

#### createOrderLine\(options\)

`options` 是一个具有字段：`disableUndo`的对象, 可以是 `true` 或 `false`. 出于兼容性原因，默认值为 `false`。

在图表上创建新的交易订单并返回可用于调整其属性和特性的 API 对象。

强烈建议在使用此调用之前阅读[交易元语](Trading-Primitives.md)。

API 对象方法：

- `remove()`: 从图表中移除仓位。 调用方法后不能再使用此 API 对象。
- `onModify(callback)` / `onModify(data, callback)`
- `onMove(callback)` / `onMove(data, callback)`
- `onCancel(callback)` / `onCancel(data, callback)`

API 对象具有下面列出的一组属性。 每个属性应通过各自的访问器调用。
例如，如果你想使用`Extend Left`属性，那么请使用`setExtendLeft()`和`getExtendLeft()`方法。

**一般属性**:

| 属性名称 | 类型    | 支持的值 | 默认值 |
| -------- | ------- | -------- | ------ |
| Price    | Double  | Double   | 0.0    |
| Text     | String  | String   | ""     |
| Tooltip  | String  | String   | ""     |
| Modify Tooltip	 | String  | String   | ""     |
| Cancel Tooltip	 | String  | String   | ""     |
| Quantity | String  | String   | ""     |
| Editable | Boolean | Boolean  | true   |

**趋势线属性**:

| 属性名称    | 类型    | 支持的值              | 默认值 |
| ----------- | ------- | --------------------- | ------ |
| Extend Left | Boolean | "inherit" or Boolean  | True   |
| Line Length | Integer | "inherit" or 0 .. 100 | 0      |
| Line Style  | Integer | "inherit" or 0 .. 2   | 2      |
| Line Width  | Integer | "inherit" or 1 .. 4   | 1      |

**字体**:

| 属性名称      | 类型   | 默认值             |
| ------------- | ------ | ------------------ |
| Body Font     | String | "bold 7pt Verdana" |
| Quantity Font | String | "bold 7pt Verdana" |

**颜色**:

| 属性名称                       | 类型   | 默认值                        |
| ------------------------------ | ------ | ----------------------------- |
| Line Color                     | String | "rgb\(255, 0, 0\)"            |
| Body Border Color              | String | "rgb\(255, 0, 0\)"            |
| Body Background Color          | String | "rgba\(255, 255, 255, 0.75\)" |
| Body Text Color                | String | "rgb\(255, 0, 0\)"            |
| Quantity Border Color          | String | "rgb\(255, 0, 0\)"            |
| Quantity Background Color      | String | "rgba\(255, 0, 0, 0.75\)"     |
| Quantity Text Color            | String | "rgb\(255, 255, 255\)"        |
| Cancel Button Border Color     | String | "rgb\(255, 0, 0\)"            |
| Cancel Button Background Color | String | "rgba\(255, 255, 255, 0.75\)" |
| Cancel Button Icon Color       | String | "rgb\(255, 0, 0\)"            |

例子:

```javascript
widget.chart().createOrderLine()
    .setTooltip("Additional order information")
    .setModifyTooltip("Modify order")
    .setCancelTooltip("Cancel order")
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

在图表上创建新的交易头寸并返回一个可用于调整其属性和特性的 API 对象。

强烈建议在使用此调用之前阅读[交易元语](Trading-Primitives.md)。

API 对象方法：

- `remove()`: 从图表中移除位置。 调用此方法后不能再使用 API 对象。
- `onClose(callback)` / `onClose(data, callback)`
- `onModify(callback)` / `onModify(data, callback)`
- `onReverse(callback)` / `onReverse(data, callback)`

API 对象具有下面列出的一组属性。 每个属性应通过各自的访问器调用。
例如，如果你想使用`Extend Left`属性，那么请使用`setExtendLeft()`和`getExtendLeft()`方法。

**一般属性**:

| 属性名称 | 类型   | 支持的值 | 默认值 |
| -------- | ------ | -------- | ------ |
| Price    | Double | Double   | 0.0    |
| Text     | String | String   | ""     |
| Tooltip  | String | String   | ""     |
| Protect Tooltip	     | String | String   | ""     |
| Reverse Tooltip	  | String | String   | ""     |
| Close Tooltip  | String | String   | ""     |
| Quantity | String | String   | ""     |

**趋势线属性**:

| 属性名称    | 类型    | 支持的值              | 默认值 |
| ----------- | ------- | --------------------- | ------ |
| Extend Left | Boolean | "inherit" or Boolean  | True   |
| Line Length | Integer | "inherit" or 0 .. 100 | 0      |
| Line Style  | Integer | "inherit" or 0 .. 2   | 2      |
| Line Width  | Integer | "inherit" or 1 .. 4   | 1      |

**字体**:

| 属性名称      | 类型   | 默认值             |
| ------------- | ------ | ------------------ |
| Body Font     | String | "bold 7pt Verdana" |
| Quantity Font | String | "bold 7pt Verdana" |

**颜色**:

| 属性名称                        | 类型   | 默认值                        |
| ------------------------------- | ------ | ----------------------------- |
| Line Color                      | String | "rgb\(0, 113, 224\)"          |
| Body Border Color               | String | "rgb\(0, 113, 224\)"          |
| Body Background Color           | String | "rgba\(255, 255, 255, 0.75\)" |
| Body Text Color                 | String | "rgb\(0, 113, 224\)"          |
| Quantity Border Color           | String | "rgb\(0, 113, 224\)"          |
| Quantity Background Color       | String | "rgba\(0, 113, 224, 0.75\)"   |
| Quantity Text Color             | String | "rgb\(255, 255, 255\)"        |
| Reverse Button Border Color     | String | "rgb\(0, 113, 224\)"          |
| Reverse Button Background Color | String | "rgba\(255, 255, 255, 0.75\)" |
| Reverse Button Icon Color       | String | "rgb\(0, 113, 224\)"          |
| Close Button Border Color       | String | "rgb\(0, 113, 224\)"          |
| Close Button Background Color   | String | "rgba\(255, 255, 255, 0.75\)" |
| Close Button Icon Color         | String | "rgb\(0, 113, 224\)"          |

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
    .setTooltip("附加仓位信息")
    .setProtectTooltip("保护仓位")
    .setCloseTooltip("关闭仓位")
    .setReverseTooltip("翻转仓位")
    .setQuantity("8.235")
    .setPrice(15.5)
    .setExtendLeft(false)
    .setLineStyle(0)
    .setLineLength(25);

```

#### createExecutionShape\(options\)

1. `options` 是一个具有字段：`disableUndo`的对象, 这可以是 `true` 或 `false`. 出于兼容性原因，默认值为 `false`。

在图表上创建新的交易执行并返回可用于控制执行属性的 API 对象。

强烈建议在使用此调用之前阅读[交易元语](Trading-Primitives.md)。

API 对象具有下面列出的一组属性。 每个属性应通过各自的访问器调用。
例如，如果你想使用`Extend Left`属性，那么请使用`setExtendLeft()`和`getExtendLeft()`方法。

API 对象方法：

- `remove()`：从图表中删除执行信号形状。调用后，您无法再次使用此 API 对象。

**一般属性**:

| 属性名称      | 类型    | 支持的值        | 默认值      |
| ------------- | ------- | --------------- | ----------- |
| Price         | Double  | Double          | 0.0         |
| Time          | Integer | Unix time       | 0           |
| Direction     | String  | "buy" or "sell" | "buy"       |
| Text          | String  | String          | "execution" |
| Tooltip       | String  | String          | ""          |
| Arrow Height  | Integer | Integer         | 8           |
| Arrow Spacing | Integer | Integer         | 1           |

**字体**:

| 属性名称 | 类型   | 默认值        |
| -------- | ------ | ------------- |
| Font     | String | "8pt Verdana" |

**颜色**:

| 属性名称    | 类型   | 默认值              |
| ----------- | ------ | ------------------- |
| Text Color  | String | "rgb\(0, 0, 0\)""   |
| Arrow Color | String | "rgba\(0, 0, 255\)" |

例子:

```javascript
widget.activeChart().createExecutionShape()
    .setText("@1,320.75 Limit Buy 1")
    .setTooltip("@1,320.75 Limit Buy 1")
    .setTextColor("rgba(0,255,0,0.5)")
    .setArrowColor("#0F0")
    .setDirection("buy")
    .setTime(widget.activeChart().getVisibleRange().from)
    .setPrice(160);
```

# Getters

#### symbol\(\)

返回图表商品。

```javascript
console.log(widget.activeChart().symbol());
```

#### symbolExt\(\)

返回图表的商品信息对象。 该对象具有以下字段：

- `symbol`: 与方法[symbol\(\)](#symbol)结果相同
- `full_name`: 商品全称
- `exchange`: 商品交易所
- `description`: 商品描述
- `type`: 商品类型

```javascript
console.log(widget.activeChart().symbolExt().full_name);
```

#### resolution\(\)

返回图表的周期。格式在这个[周期](Resolution.md)中描述。

```javascript
console.log(widget.activeChart().resolution());
```

#### getVisibleRange\(\)

返回对象 `{from, to}`. `from` 和 `to` 是 **图表时区**的单位时间戳

```javascript
console.log(widget.activeChart().getVisibleRange());
```

#### getVisiblePriceRange\(\)

**在 1.7 版本开始**

不建议使用，请改用[Price Scale API](Price-Scale-Api#getVisiblePriceRange)。

返回对象 `{from, to}`. `from` 和 `to` 是主数据列的可见范围边界。

```javascript
console.log(widget.activeChart().getVisiblePriceRange());
```

### scrollPosition()

*在 1.15 版本开始*

返回从图表右边缘到最后一根K线的距离，以K线为单位。
这实际上是图表的当前滚动位置，包含右边距。

```javascript
console.log(widget.activeChart().scrollPosition());
```

### defaultScrollPosition()

*在 1.15 版本开始*

返回从图表右边缘到最后一根K线的默认距离，以K线为单位。

```javascript
console.log(widget.activeChart().defaultScrollPosition());
```

#### priceFormatter\(\)

返回带有`format`函数的对象，可用于格式化价格。

```javascript
widget.activeChart().priceFormatter().format(123);
```

#### chartType\(\)

返回图表类型。

```javascript
console.log(widget.activeChart().chartType());
```

## 其他

### exportData(options)

_从 1.14 版本开始_

1. `options` (可选)是一个对象，它可以包含以下属性：
   - `from` (`number`) - 第一个导出 k 线的时间(UNIX 时间戳，以秒为单位)。
     默认情况下，使用最左侧加载的 k 线的时间。
   - `to` (`number`) - 最后一个导 k 线的时间(UNIX 时间戳，以秒为单位)。
     默认情况下，使用最右侧(实时)k 线的时间。
   - `includeTime`(`boolean`, 默认`true`) - 定义导出数据的每个项目是否应包含时间。
   - `includeSeries`(`boolean`, 默认`true`) - 定义导出的数据是否应包含数据列(open，high，low，close)。
   - `includedStudies` - 哪些指标应包括在导出的数据中
     (默认情况下，值为`'all'`表示包含所有指标, 但如果您只想导出其中一些,则可以在数组中指定[指标 ID](＃getallstudies))。

从图表中导出数据，返回 Promise 对象。 此方法不加载数据。 结果具有以下结构:

- `schema`是一个字段描述符数组，每个描述符可能是以下类型之一：

  - `TimeFieldDescriptor` - 时间字段的描述。 它只包含一个属性 - 带有`'time'`值的`type`。
  - `SeriesFieldDescriptor` - 数据列字段的描述。 它包含以下属性：
    - `type`(`'value'`)
    - `sourceType`(`'series'`)
    - `plotTitle`(`string`) - 绘图的名称（open，high，low，close)。
  - `StudyFieldDescriptor` - 指标字段的描述。 它包含以下属性：
    - `type`(`'value'`)
    - `sourceType`(`'study'`)
    - `sourceId`(`string`) - 指标 ID
    - `sourceTitle`(`string`) - 指标的标题
    - `plotTitle`(`string`) - 绘图的标题

- `data` 为[Float64Array](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Float64Array) 类型数组。
  每个 `Float64Array` 数组与 `schema` 数组的长度相同，表示相关字段的项目。

**示例:**

1. `chart.exportData({ includeTime: false, includeSeries: true, includedStudies: [] })` - 仅导出数据列。
1. `chart.exportData({ includeTime: true, includeSeries: true, includedStudies: [] })` - 随时间导出数据列。
1. `chart.exportData({ includeTime: false, includeSeries: false, includedStudies: ['STUDY_ID'] })` - 导出 ID 为`STUDY_ID`的指标数据。
1. `chart.exportData({ includeTime: true, includeSeries: true, includedStudies: 'all' })` - 从图表中导出所有可用数据。
1. `chart.exportData({ includeTime: false, includeSeries: true, to: Date.UTC(2018, 0, 1) / 1000 })` - 导出`2018-01-01`以前的数据。
1. `chart.exportData({ includeTime: false, includeSeries: true, from: Date.UTC(2018, 0, 1) / 1000 })` - 导出`2018-01-01`之后的数据。
1. `chart.exportData({ includeTime: false, includeSeries: true, from: Date.UTC(2018, 0, 1) / 1000, to: Date.UTC(2018, 1, 1) / 1000 })` - 导出在 `2018-01-01` 和 `2018-02-01` 之间的数据。

### selection()

**在 1.15 版本开始**

返回[SelectionApi](Selection-Api.md)，可用于更改图表选择和订阅图表选择的更改。

```javascript
widget.activeChart().selection().clear();
```

### setZoomEnabled(enabled)

**在 1.15 版本开始**

启用 (true) 或 禁用 (false) 缩放图表。

```javascript
widget.activeChart().setZoomEnabled(false);
```

### setScrollEnabled(enabled)

**在 1.15 版本开始**

启用 (true) 或 禁用 (false) 滚动图表。

```javascript
widget.activeChart().setScrollEnabled(false);
```

### getTimeScale()

*从版本18开始。*

返回带有与时间轴关联的方法的[TimeScaleApi](Time-Scale-Api) 实例。

```javascript
var time = widget.activeChart().getTimeScale().coordinateToTime(100);
```

### isSelectBarRequested()

*从版本18开始。*

返回k先的选择模式是否处于活动状态。

```javascript
var isRequested = widget.activeChart().isSelectBarRequested();
```

### requestSelectBar()

*从版本18开始。*

图表状态切换到K线选择模式。例如，用于开启K线回放。

返回一个Promise对象，该对象为resolved时，将返回用户选择的K线的时间（unix时间戳），或者如果已经请求或取消了K线选择（通过用户操作或[`cancelSelectBar()`](#cancelselectbar)方法），则为rejected。

```javascript
widget.activeChart().requestSelectBar()
    .then(function(time) {
        console.log('user selects bar with time', time);
    })
    .catch(function() {
        console.log('bar selection was rejected');
    });
```

### cancelSelectBar()

*从版本18开始。*

取消活动的选择K线请求（如果存在），否则不执行任何操作。

```javascript
widget.activeChart().cancelSelectBar();
```

### setPriceToBarRatio（value, options）

1. `value` 是要设置的新的比率（数字）
2. `options` 是一个只包含 `disableUndo` 布尔属性的对象

设置一个新的比率以及一些选项。

```javascript
widget.activeChart().setPriceToBarRatio(0.4567, { disableUndo: true });
```

### setPriceToBarRatioLocked（值，选项）

1. `value` 用于锁定/解锁 k线比率的价格(布尔值)
2. `options` 是一个只包含 `disableUndo` 布尔属性的对象

设置/取消设置锁定属性以及一些选项。

```javascript
widget.activeChart().setPriceToBarRatioLocked(true, { disableUndo: false });
```

# 也可以看看

- [Widget 方法](Widget-Methods.md)
- [定制概述](Customization-Overview.md)
- [Widgetg 构造函数](Widget-Constructor.md)
- [存储于加载图表](Saving-and-Loading-Charts.md)
- [指标覆盖默认参数](Studies-Overrides.md)
- [覆盖默认参数](Overrides.md)
