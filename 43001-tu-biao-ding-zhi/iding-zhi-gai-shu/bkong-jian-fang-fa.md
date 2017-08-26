# Widget方法

---

以下是widget支持的方法列表。您可以使用widget构造函数返回给您的widget对象来调用它们。

**Remark**: 请注意，只有在onChartReady回调触发后才可以调用这些方法。 所以常见的做法就是这样：

```js
widget.onChartReady(function() {
    // now it's safe to call any other widget's methods
});
```

# Methods

**在1.5之前**[**Chart Methods**](https://github.com/tradingview/charting_library/wiki/Chart-Methods)** 归属于 Widget. 请参阅完整的操作列表**[**here**](https://github.com/tradingview/charting_library/wiki/Chart-Methods)

* Subscribing To Chart Events
  * [onChartReady\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#onchartreadycallback)
  * [onSymbolChange\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#onsymbolchangecallback)\[已过时\]
  * [onIntervalChange\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#onintervalchangecallback)\[已过时\]
  * [onAutoSaveNeeded\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#onautosaveneededcallback)\[已过时\]
  * [onBarMarkClicked\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#onbarmarkclickedcallback)\[已过时\]
  * [onTimescaleMarkClicked\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#ontimescalemarkclickedcallback)\[已过时\]
  * [onGrayedObjectClicked\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#ongrayedobjectclickedcallback)
  * [onScreenshotReady\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#onscreenshotreadycallback)\[已过时\]
  * [onTick\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#ontickcallback)\[已过时\]
  * [onShortcut\(shortcut, callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#onshortcutshortcut-callback)
  * [subscribe\(event, callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#subscribeevent-callback)
* Chart Actions
  * [chart\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#chart)
  * [setLanguage\(locale\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#setlanguagelocale)
  * [setSymbol\(symbol, interval, callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#setsymbolsymbol-interval-callback)
  * [remove\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#remove)
  * [closePopupsAndDialogs\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#closepopupsanddialogs)
  * [selectLineTool\(drawingId\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#selectlinetooldrawingid)
  * [selectedLineTool\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#selectedlinetool)
* Saving/Loading Charts
  * [save\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#savecallback)
  * [load\(state\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#loadstate)
  * [getSavedCharts\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#getsavedchartscallback)
  * [loadChartFromServer\(chartRecord\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#loadchartfromserverchartrecord)
  * [saveChartToServer\(onCompleteCallback, onFailCallback, saveAsSnapshot, options\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#savecharttoserveroncompletecallback-onfailcallback-saveassnapshot-options)
  * [removeChartFromServer\(chartId, onCompleteCallback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#removechartfromserverchartid-oncompletecallback)
* Custom UI Controls
  * [onContextMenu\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#oncontextmenucallback)
  * [createButton\(options\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#createbuttonoptions)
* Dialogs
  * [showNoticeDialog\(params\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#shownoticedialogparams)
  * [showConfirmDialog\(params\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#showconfirmdialogparams)
  * [showLoadChartDialog\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#showloadchartdialog)
  * [showSaveAsChartDialog\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#showsaveaschartdialog)
* Getters
  * [symbolInterval\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#symbolintervalcallback)
  * [mainSeriesPriceFormatter\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#mainseriespriceformatter)
  * [getIntervals\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#getintervals)
  * [getStudiesList\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#getstudieslist)
* Customization
  * [addCustomCSSFile\(url\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#addcustomcssfileurl)
  * [applyOverrides\(overrides\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#applyoverridesoverrides)
  * [applyStudiesOverrides\(overrides\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#applystudiesoverridesoverrides)
* ![](/assets/17_4_19_6_57_26.png)[Trading Terminal](https://github.com/tradingview/charting_library/wiki/Trading-Terminal) specific
  * [showSampleOrderDialog\(order\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#chart-showsampleorderdialogorder)
  * [watchList\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#chart-watchlist)
* ![](/assets/17_4_19_6_57_26.png)Multiple Charts Layout
  * [chart\(index\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#chart-chartindex)
  * [activeChart\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#chart-activechart)
  * [chartsCount\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#chart-chartscount)
  * [layout\(\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#chart-layout)
  * [setLayout\(layout\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#chart-setlayoutlayout)

# Subscribing To Chart Events

#### onChartReady\(callback\)

1. `callback`: function\(\)

当图表初始化并准备就绪时，图表库将调用提供的回调。 你可以从这一刻安全地调用所有其他方法。

#### onSymbolChange\(callback\)

1. `callback`: function\(symbolData\)
   1. `symbolData`: object`{name, exchange, description, type, interval}`

每当主系列商品发生变化时，图表库将调用回调。 新商品信息将作为参数传递。

**已过时 将被删除 **在1.8开始，使用 [onSymbolChanged](https://github.com/tradingview/charting_library/wiki/Chart-Methods#onsymbolchanged) 注册`chart`来代替。

#### onIntervalChange\(callback\)

1. `callback`: function\(interval\)
   1. `interval`: string

图表库将调用回调提供每次主系列间隔的更改。新的间隔将作为参数传递。

**已过时 将被删除 **在1.8开始，使用 [onIntervalChanged](https://github.com/tradingview/charting_library/wiki/Chart-Methods#onintervalchanged) 注册`chart`来代替。

#### onAutoSaveNeeded\(callback\)

1. `callback`: function\(\)

每当用户更改图表时，库将调用该回调。`Chart change`意味着可以撤消用户的任何操作。回调不会在五秒内多次调用。参见[auto\_save\_delay](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#auto_save_delay).

**已过时 将被删除 **在1.8开始，使用 [subscribe](https://github.com/tradingview/charting_library/wiki/Widget-Methods#subscribeevent-callback) 方法中的`onAutoSaveNeeded`事件代替。

#### onBarMarkClicked\(callback\)

1. `callback`: function\(markId\)

Library将提供回调，每次当用户点击K线上的标记时。标记ID将作为参数传递。

**已过时 将被删除 **在1.8开始，使用 [subscribe](https://github.com/tradingview/charting_library/wiki/Widget-Methods#subscribeevent-callback)方法中的`onMarkClick`事件代替。

#### onTimescaleMarkClicked\(callback\)

1. `callback`: function\(markId\)

Library将提供回调，每次当用户点击时间刻度标记时。标记ID将作为参数传递。

**已过时 将被删除 **在1.8开始，使用 [subscribe](https://github.com/tradingview/charting_library/wiki/Widget-Methods#subscribeevent-callback)方法中的`onTimescaleMarkClick`事件代替。

#### onGrayedObjectClicked\(callback\)

1. `callback`: function\(subject\)
   1. `subject`: object`{type, name}`
      1. `type`:`drawing`\|`study`
      2. `name`: string, 被点击的主题名称

Library将提供回调，每当用户点击灰色对象时。例：

```js
new TradingView.widget({
    drawings_access: {
        type: "black",
        tools: [
            { name: "Regression Trend" },
            { name: "Trend Angle", grayed: true },
        ]
    },
    studies_access: {
        type: "black",
        tools: [
            { name: "Aroon" },
            { name: "Balance of Power", grayed: true },
        ]
    },
    <...> // other widget settings
});

widget.onChartReady(function() {
    widget.onGrayedObjectClicked(function(data) {
        // this function will be called when one tries to
        // create Balance Of Power study or Trend Angle shape

        alert(data.name + " is grayed out!");
    })
});
```

#### onScreenshotReady\(callback\)

1. `callback`: function\(imageName\)

Library将提供回调，每当用户创建屏幕截图和服务器返回创建的图像名称时。

**已过时 将被删除 **在1.8开始，使用 [subscribe](https://github.com/tradingview/charting_library/wiki/Widget-Methods#subscribeevent-callback)方法中的`onScreenshotReady`事件代替。

#### onTick\(callback\)

1. `callback`
   : function\(data\)

Library将提供回调，每当最近的K线更新时。

**已过时 将被删除 **在1.8开始，使用 [subscribe](https://github.com/tradingview/charting_library/wiki/Widget-Methods#subscribeevent-callback)方法中的`onTick`事件代替。

#### onShortcut\(shortcut, callback\)

1. `shortcut`
2. `callback`: function\(data\)

Library将提供回调，每次按快捷方式时。

例:

```js
widget.onShortcut("alt+s", function() {
  widget.executeActionById("symbolSearch");
});
```

subscribe\(event, callback\)

1. `event`: can be

| Event name | Library Version | Description |
| :--- | :--- | :--- |
| toggle\_sidebar |  | 绘图工具栏 显示/隐藏 |
| indicators\_dialog |  | 显示指标对话框 |
| toggle\_header |  | 图表头 显示/隐藏 |
| edit\_object\_dialog |  | 显示图/研究属性对话框 |
| chart\_load\_requested |  | 即将载入的新图表 |
| chart\_loaded |  |  |
| mouse\_down |  |  |
| mouse\_up |  |  |
| drawing | 1.7 | 在图表上增加绘图。参数包含具有`value`字段的对象，该字段为绘图的名称。 |
| study | 1.7 | 在图表上增加指标。参数包含具有`value`字段的对象，该字段为指标的名称。 |
| undo | 1.7 |  |
| redo | 1.7 |  |
| reset\_scales | 1.7 | 复位比例按钮被点击后 |
| compare\_add | 1.7 | 显示比较对话框 |
| add\_compare | 1.7 | 添加比较工具 |
| load\_study template | 1.7 | 研究模板被载入后 |
| onTick |  | 回调将被调用每当最近的K线更新时 |
| onAutoSaveNeeded |  | 每当用户更改图表时，库将调用该回调。`Chart change`意味着可以撤消用户的任何操作。回调不会在五秒内多次调用。参见[auto\_save\_delay](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#auto_save_delay) |
| onScreenshotReady |  | 每当用户创建屏幕截图和服务器返回创建的图像名称时。 |
| onMarkClick |  | 每次当用户点击K线上的标记时。[mark on bar](https://github.com/tradingview/charting_library/wiki/Marks-On-Bars). 标记ID将作为参数传递。 |
| onTimescaleMarkClick |  | 每当用户单击时间刻度标记时，将调用回调。 标记ID将作为参数传递 |
| onSelectedLineToolChanged |  | 每次当选择的线工具更改时，将调用回调。 |
| ![](/assets/17_4_19_6_57_26.png)layout\_about\_to\_be\_changed |  | 要更改图表的数量或位置时 |
| ![](/assets/17_4_19_6_57_26.png)layout\_changed |  | 已经更改图表的数量或位置时 |
| ![](/assets/17_4_19_6_57_26.png)activeChartChanged |  | 活动图表被更改 |

2.`callback`: function\(arguments\)

当GUI事件发生时，库将调用回调。 每个事件都可以有不同的参数。

# Chart Actions

#### chart\(\)

返回图表对象，可用于调用[Chart-Methods](https://github.com/tradingview/charting_library/wiki/Chart-Methods)

#### setLanguage\(locale\)

1. `locale`
   :
   [language code](https://github.com/tradingview/charting_library/wiki/Localization)

设置Widget的语言。 目前此调用将重新加载图表。请避免使用它。

#### setSymbol\(symbol, interval, callback\)

1. `symbol`: string
2. `interval`: string
3. `callback`: function\(\)

使图表更改其商品和分辨率。 新商品的数据到达后调用回调。

#### remove\(\)

从您的页面中删除widget。

#### closePopupsAndDialogs\(\)

调用此方法会关闭上下文菜单或对话框（如果已显示）。

#### selectLineTool\(drawingId\)

1. `drawingId`: 可能是其中一个标识符[identifiers](https://github.com/tradingview/charting_library/wiki/Shapes-and-Overrides) 或
   1. `cursor`
   2. `dot`
   3. `arrow_cursor`
   4. `eraser`
   5. `measure`
   6. `zoom`
   7. `brush`

选择与绘图按钮上的单击相同的图形或光标。

#### selectedLineTool\(\)

返回所选图形或光标的标识符[identifiers](https://github.com/tradingview/charting_library/wiki/Shapes-and-Overrides)（见上文）。

# Saving/Loading Charts

#### save\(callback\)

1. `callback`: function\(object\)

将图表状态保存到JS对象。图表库将调用您的回调函数并将状态对象作为参数传递。 这个调用是一部分低级别的[save/load API](https://github.com/tradingview/charting_library/wiki/Saving-and-Loading-Charts).

#### load\(state\)

1. `state`: object

从状态对象加载图表。这个调用是一部分低级别的[save/load API](https://github.com/tradingview/charting_library/wiki/Saving-and-Loading-Charts).

#### getSavedCharts\(callback\)

1. `callback`: function\(objects\)

`objects`is an array of:

1. `id`
2. `name`
3. `image_url`
4. `modified_iso`
5. `short_symbol`
6. `interval`

返回当前用户在服务器上保存的图表描述列表。

#### loadChartFromServer\(chartRecord\)

1. `chartRecord是您使用`[getSavedCharts\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#getsavedchartscallback) 的对象

从服务器加载并显示图表。

#### saveChartToServer\(onCompleteCallback, onFailCallback, saveAsSnapshot, options\)

1. `onCompleteCallback`: function\(\)
2. `onFailCallback`: function\(\)
3. `saveAsSnapshot`: should be always`false`
4. `options`: object`{ chartName }`
   1. `chartName`: 图表名称。应指定新图表并重命名。
   2. `defaultChartName`: 图表的默认名称。 如果当前图表没有名称，它将被使用。

将当前图表保存到服务器。

#### removeChartFromServer\(chartId, onCompleteCallback\)

1. `chartId`:`调用`[getSavedCharts\(callback\)](https://github.com/tradingview/charting_library/wiki/Widget-Methods#getsavedchartscallback)后获得的`id`
2. `onCompleteCallback`: function\(\)

从服务器移除图表。

# Custom UI Controls

#### onContextMenu\(callback\)

1. `callback`: function\(unixtime, price\). 此回调将返回一个值（见下文）。

当用户打开图表上的上下文菜单时，库将调用回调函数。UNIX时间和上下文菜单点的价格将作为参数提供。要自定义上下文菜单项，您必须返回项目描述符的数组。项目描述符具有以下结构：

```
{
    position: 'top' | 'bottom',
    text: 'Menu item text',
    click: <onItemClicked callback>
}
```

* `position`: 项目在上下文菜单中的位置
* `text`: 菜单项文本
* `click`: 当用户选择您的菜单项时将被调用

添加分隔符使用减号。 例:`{ text: "-", position: "top" }`.

要从菜单中删除现有项目，请在项目文本前面使用减号。 例:`{ text: "-Objects Tree..." }`

例:

```js
widget.onChartReady(function() {
    widget.onContextMenu(function(unixtime, price) {
        return [{
            position: "top",
            text: "First top menu item, time: " + unixtime + ", price: " + price,
            click: function() { alert("First clicked."); }
        },
        { text: "-", position: "top" },
        { text: "-Objects Tree..." },
        {
            position: "top",
            text: "Second top menu item 2",
            click: function() { alert("Second clicked."); }
        }, {
            position: "bottom",
            text: "Bottom menu item",
            click: function() { alert("Third clicked."); }
        }];
    });
```

#### createButton\(options\)

1. `options`: object`{ align: "left" }`
   1. `align`: "right" \| "left". default: "left"

在图表顶部工具栏中创建一个新的DOM元素，并返回此按钮的jQuery对象。 您可以使用它直接在图表上附加自定义控件。 例：

```js
widget.onChartReady(function() {
    widget.createButton()
        .attr('title', "My custom button tooltip")
        .on('click', function (e) { alert("My custom button pressed!"); })
        .append($('<span>My custom button caption</span>'));
});
```

# Dialogs

**Since 1.6 version**

#### showNoticeDialog\(params\)

1. `params`: object:
   1. `title`: text to be shown in the title
   2. `body`: text to be shown in the body
   3. `callback`: function to be called when ok button is pressed

This method shows a dialog with custom title and text and "OK" button.

#### showConfirmDialog\(params\)

1. `params`: object:
   1. `title`: text to be shown in the title
   2. `body`: text to be shown in the body
   3. `callback(result)`: function to be called when ok button is pressed.
      `result`is`true`if`OK`is pressed, otherwise it is`false`.

This method shows a dialog with custom title and text and "OK", "CANCEL" buttons.

#### showLoadChartDialog\(\)

Displays Load chart dialog.

#### showSaveAsChartDialog\(\)

Displays Save As... chart dialog.

# Getters

#### symbolInterval\(callback\)

1. `callback`: function\(result\)
   1. `result`: object`{symbol, interval}`

**由于1.4开始方法会立即返回结果。回调是为了保证兼容性。**

Charting Library will call your callback with an object containing chart's symbol and interval.

#### mainSeriesPriceFormatter\(\)

Returns object with method`format`that you can use to format prices. Introduced in 1.5.

#### getIntervals\(\)

Returns an array of supported resolutions. Introduced in 1.7.

#### getStudiesList\(\)

Returns an array of all studies ids. They can be used to create a study.

# Customization

#### addCustomCSSFile\(url\)

1. `url`should be absolute or relative path to 'static\` folder

该方法在版本`1.3`中引入。从1.4开始，使用[custom\_css\_url](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#custom_css_url)替代。

#### applyOverrides\(overrides\)

_Introduced in Charting Library 1.5_

1. `overrides`is an object. It is the same as [overrides](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#overrides) in Widget Constructor.

此方法在不重新加载图表的情况下将覆盖应用属性。

#### applyStudiesOverrides\(overrides\)

_Introduced in Charting Library 1.9_

1. `overrides`is an object. It is the same as[studies\_overrides](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#studies_overrides)in Widget Constructor.

This method applies studies overrides to indicators' style or inputs without reloading the chart.

# ![](/assets/17_4_19_6_57_26.png)Trading Terminal

The following methods are available in[Trading Terminal](https://github.com/tradingview/charting_library/wiki/Trading-Terminal)only.

#### ![](/assets/17_4_19_6_57_26.png)showSampleOrderDialog\(order\)

1. `order`: object

显示样品订单对话框。 这个对话框看起来像Trading View Paper一样。 通常您不需要使用样品对话框。 这种方法用于交易样本。

#### ![](/assets/17_4_19_6_57_26.png)watchList\(\)

_Introduced in Charting Library 1.9_

返回一个对象来操作监视列表。 该对象具有以下方法：

1. `getList()`- allows you to get current list of the symbols.

2. `setList(symbols)`- allows you to set a list of symbols into the watchlist. It will replace the whole list.

3. `onListChanged()`- 您可以使用订阅此方法返回的[Subscription](https://github.com/tradingview/charting_library/wiki/Subscription)对象，以便在更改观察列表并取消订阅事件时收到通知。 如果没有WatchList将返回null。

# ![](/assets/17_4_19_6_57_26.png)Multiple Charts Layout

#### ![](/assets/17_4_19_6_57_26.png)chart\(index\)

1. `index`: index of a chart starting from 0.`index`is 0 by default.

Returns a chart object that you can use to call[Chart-Methods](https://github.com/tradingview/charting_library/wiki/Chart-Methods)

#### ![](/assets/17_4_19_6_57_26.png)activeChart\(\)

Returns current active chart object that you can use to call[Chart-Methods](https://github.com/tradingview/charting_library/wiki/Chart-Methods)

#### ![](/assets/17_4_19_6_57_26.png)chartsCount\(\)

Returns amount of charts in the current layout

#### ![](/assets/17_4_19_6_57_26.png)layout\(\)

Returns current layout mode. Possible values:`4`,`6`,`8`,`s`,`2h`,`2-1`,`2v`,`3h`,`3v`,`3s`.

#### ![](/assets/17_4_19_6_57_26.png)setLayout\(layout\)

1. `layout`: Possible values:`4`,`6`,`8`,`s`,`2h`,`2-1`,`2v`,`3h`,`3v`,`3s`.

Changes current chart layout.

# See Also

* [Chart-Methods](https://github.com/tradingview/charting_library/wiki/Chart-Methods)
* [Customization Overview](https://github.com/tradingview/charting_library/wiki/Customization-Overview)
* [Widget Constructor](https://github.com/tradingview/charting_library/wiki/Widget-Constructor)
* [Saving and Loading Charts](https://github.com/tradingview/charting_library/wiki/Saving-and-Loading-Charts)
* [Overriding Studies' Defaults](https://github.com/tradingview/charting_library/wiki/Studies-Overrides)
* [Overriding Chart's Defaults](https://github.com/tradingview/charting_library/wiki/Overrides) 



