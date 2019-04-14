# Widget方法

---

以下是widget支持的方法列表。您可以使用widget构造函数返回给您的widget对象来调用它们。

**Remark**: 请注意，只有在onChartReady回调触发后才可以调用这些方法。

```js
widget.onChartReady(function() {
    // 现在可以调用其他widget的方法了
});
```

# Methods

* [订阅图表事件](#订阅图表事件)
  * [onChartReady\(callback\)](#onchartreadycallback)
  * [headerReady()](#headerready)
  * [onGrayedObjectClicked\(callback\)](#ongrayedobjectclickedcallback)
  * [onShortcut\(shortcut, callback\)](#onshortcutshortcut-callback)
  * [subscribe\(event, callback\)](#subscribeevent-callback)
  * [unsubscribe\(event, callback\)](#unsubscribeevent-callback)
* [图表动作](#图表动作)
  * [chart()](#chart)
  * [setLanguage\(locale\)](#setlanguagelocale)
  * [setSymbol\(symbol, interval, callback\)](#setsymbolsymbol-interval-callback)
  * [remove()](#remove)
  * [closePopupsAndDialogs()](#closepopupsanddialogs)
  * [selectLineTool\(drawingId\)](#selectlinetooldrawingid)
  * [selectedLineTool()](#selectedlinetool)
  * [takeScreenshot()](#takeScreenshot)
  * [lockAllDrawingTools()](#lockAllDrawingTools)
  * [hideAllDrawingTools()](#hideAllDrawingTools)
* [保存/加载图表](#保存加载图表)
  * [save\(callback\)](#savecallback)
  * [load\(state\)](#loadstate)
  * [getSavedCharts\(callback\)](#getsavedchartscallback)
  * [loadChartFromServer\(chartRecord\)](#loadchartfromserverchartrecord)
  * [saveChartToServer\(onCompleteCallback, onFailCallback, saveAsSnapshot, options\)](#savecharttoserveroncompletecallback-onfailcallback-saveassnapshot-options)
  * [removeChartFromServer\(chartId, onCompleteCallback\)](#removechartfromserverchartid-oncompletecallback)
* [自定义UI控件](#自定义UI控件)
  * [onContextMenu\(callback\)](#oncontextmenucallback)
  * [createButton\(options\)](#createbuttonoptions)
* [对话框](#对话框)
  * [showNoticeDialog\(params\)](#shownoticedialogparams)
  * [showConfirmDialog\(params\)](#showconfirmdialogparams)
  * [showLoadChartDialog()](#showloadchartdialog)
  * [showSaveAsChartDialog()](#showsaveaschartdialog)
* [Getters](#Getters)
  * [symbolInterval\(callback\)](#symbolintervalcallback)
  * [mainSeriesPriceFormatter()](#mainseriespriceformatter)
  * [getIntervals()](#getintervals)
  * [getStudiesList()](#getstudieslist)
* [定制](#定制)
  * [changeTheme\(themeName\)](#changethemethemename)
  * [addCustomCSSFile\(url\)](#addcustomcssfileurl)
  * [applyOverrides\(overrides\)](#applyoverridesoverrides)
  * [applyStudiesOverrides\(overrides\)](#applystudiesoverridesoverrides)
* ![](../images/trading.png)[交易终端专属](#交易终端专属)
  * [watchList()](#watchlist)
* ![](../images/trading.png)[多图表布局](#多图表布局)
  * [chart\(index\)](#chartindex)
  * [activeChart()](#activechart)
  * [chartsCount()](#chartscount)
  * [layout()](#layout)
  * [setLayout\(layout\)](#setlayoutlayout)

# 订阅图表事件

#### [onChartReady\(callback\)](#onchartreadycallback)

1. `callback`: function()

当图表初始化并准备就绪时，图表库将调用提供的回调。 你可以从这一刻安全地调用所有其他方法。

### headerReady()

返回一个`Promise`对象，该对象应该在图表库头部widget API准备就绪时用于处理其他事件（例如: [createButton](#createbuttonoptions)）。

#### onGrayedObjectClicked\(callback\)

1. `callback`: function\(subject\)
   1. `subject`: object`{type, name}`
      1. `type`:`drawing`\|`study`
      2. `name`: string, 被点击的主题名称

每次用户点击灰色的对象时，图表库都会调用此回调函数。例：

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
    <...> // 其他widget设置
});

widget.onChartReady(function() {
    widget.onGrayedObjectClicked(function(data) {
        // 当您尝试创建力量平衡指标或趋势图形时
        // 此方法将被调用

        alert(data.name + " is grayed out!");
    })
});
```

#### onShortcut\(shortcut, callback\)

1. `shortcut`
2. `callback`: function\(data\)

每当按下快捷键时，图表库将会调用此回调。

例:

```js
widget.onShortcut("alt+s", function() {
  widget.executeActionById("symbolSearch");
});
```

#### subscribe\(event, callback\)

1. `event`: 

| Event name | Library Version | Description |
|------------|-----------------|-------------|
| `toggle_sidebar` | | 显示/隐藏 绘图工具栏 |
| `indicators_dialog` | | 显示 指标对话框 |
| `toggle_header` | | 显示/隐藏 图表头 |
| `edit_object_dialog` | | 显示 图表/指标属性对话框 |
| `chart_load_requested` | | 即将加载新图表 |
| `chart_loaded` | | |
| `mouse_down` | | |
| `mouse_up` | | |
| `drawing` | 1.7 | 绘图将添加到图表中。参数包含一个带有 `value` 字段的对象，该字段与绘图名称相对应。|
| `study` | 1.7 | 指标将添加到图表中。参数包含一个带有 `value` 字段的对象，该字段与指标名称相对应。 |
| `undo` | 1.7 | |
| `redo` | 1.7 | |
| `undo_redo_state_changed` | 1.14 | Undo/Redo状态已更改。参数包含一个具有Undo/Redo堆栈状态的对象。该对象与[UndoRedoState](Widget-Methods.md#undoredostate)方法的返回值具有相同的结构。 |
| `reset_scales` | 1.7 | 重置比例按钮被点击 |
| `compare_add` | 1.7 | 显示比较对话框 |
| `add_compare` | 1.7 | 添加了一个商品的比较 |
| `load_study` template | 1.7 | 一个指标模板被加载 |
| `onTick` | | 最新k线被更新 |
| `onAutoSaveNeeded` | | 用户修改了图表, `Chart change` 表示可以撤销用户的任何操作。回调函数不可以在5秒内多次调用, 详见: [auto_save_delay](Widget-Constructor.md#auto_save_delay) |
| `onScreenshotReady` | | 服务器返回屏幕截图URL |
| `onMarkClick` | | 用户点击[K线标记](Marks-On-Bars.md)。标记ID将作为参数传递 |
| `onTimescaleMarkClick` | | 用户点击时间刻度标记。标记ID将作为参数传递 |
| `onSelectedLineToolChanged` | | 选择的线条工具已更改 |
| `study_event` | 1.14 | 指标从图表中删除。回调函数接收2个参数: 指标id和event类型 (当前这个参数唯一可能的值是`remove`) |
| `drawing_event` | 1.14 | 隐藏，显示，移动，移除或单击绘图。 回调函数接收2个参数: 指标id和event类型。event类型的可能值是`hide`，`show`、`move`、`remove`、`click` |
| `study_properties_changed` | 1.14 | 指标属性已更改。实体ID将作为参数传递。 |
| ![](../images/trading.png) `layout_about_to_be_changed` | | 图表的数量或位置即将改变 |
| ![](../images/trading.png) `layout_changed` | | 图表的数量或位置已更改 |
| ![](../images/trading.png) `activeChartChanged` | | 活动的图表已变更 |

2.`callback`: function\(arguments\)

当GUI`event`发生时，图表库将调用`callback`。
每个事件都可以有不同的参数。

#### unsubscribe\(event, callback\)

取消订阅特定事件 (即上表中的事件之一) 。

# 图表动作

#### chart()

返回图表对象，可用于调用[图表方法](Chart-Methods.md)

#### setLanguage\(locale\)

1. `locale`: [语言代码](Localization.md)

设置Widget的语言。目前此调用将重新加载图表。 **请避免使用**

#### setSymbol\(symbol, interval, callback\)

1. `symbol`: string
2. `interval`: string
3. `callback`: function()

使图表更改其商品和周期。 新商品的数据到达后调用回调。

#### remove()

从您的页面中删除widget。

#### closePopupsAndDialogs()

调用此方法会关闭上下文菜单或对话框（如果已显示）。

#### selectLineTool\(drawingId\)

1. `drawingId`: 可以为一个[标识符](Shapes-and-Overrides.md) 或
   1. `cursor`
   2. `dot`
   3. `arrow_cursor`
   4. `eraser`
   5. `measure`
   6. `zoom`
   7. `brush`

选择与绘图按钮上的单击相同的图形或光标。

#### selectedLineTool()

返回所选图形或光标的[标识符](Shapes-and-Overrides.md)（见上文）。

### takeScreenshot()
此方法创建图表的快照并将其上传到服务器。

完成后, 调用 [onScreenshotReady](#subscribeevent-callback) 回调函数。

快照的 URL 将作为参数传递给回调函数。

### lockAllDrawingTools()
此方法返回一个 [WatchedValue](WatchedValue.md) 对象,
可用于读取/设置/监视 "锁定所有绘图工具" 按钮的状态。

### hideAllDrawingTools()

此方法返回 [WatchedValue](WatchedValue.md) 对象,
该对象可用于读取/设置/监视 "隐藏所有绘图工具" 按钮的状态。

# 保存/加载图表

#### save\(callback\)

1. `callback`: function\(object\)

将图表状态保存到JS对象。图表库将调用您的回调函数并将状态对象作为参数传递。

此调用是低级[保存/加载API](Saving-and-Loading-Charts.md)的一部分。

#### load\(state\)

1. `state`: object

从`state`对象加载图表。 此调用是低级[保存/加载API](Saving-and-Loading-Charts.md)的一部分。

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

1. `chartRecord`是您使用[getSavedCharts\(callback\)](#getsavedchartscallback) 返回的对象

从服务器加载并显示图表。

#### saveChartToServer\(onCompleteCallback, onFailCallback, saveAsSnapshot, options\)

1. `onCompleteCallback`: function()
2. `onFailCallback`: function()
3. `saveAsSnapshot`: should be always`false`
4. `options`: object`{ chartName }`
   1. `chartName`: 图表名称。应指定新图表并重命名。
   2. `defaultChartName`: 图表的默认名称。 如果当前图表没有名称，它将被使用。

将当前图表保存到服务器。

#### removeChartFromServer\(chartId, onCompleteCallback\)

1. `chartId`:`调用`[getSavedCharts\(callback\)](#getsavedchartscallback)后获得的`id`
2. `onCompleteCallback`: function()

从服务器移除图表。

# 自定义UI控件

#### onContextMenu\(callback\)

1. `callback`: function\(unixtime, price\). 此回调将返回一个值（见下文）。

每当用户在图表上打开文菜单时，图表库就会调用回调函数。
传递给回调函数的参数包含图表上单击点的unix时间和价格。

您必须返回具有以下格式的对象数组，才能在菜单中添加或删除项目。

```javascript
{
    position: 'top' | 'bottom',
    text: 'Menu item text',
    click: <onItemClicked callback>
}
```

* `position`: 项目在菜单中的位置
* `text`: 菜单项文本
* `click`: 当用户选择您的菜单项时将被调用

添加分隔符使用减号。 例:`{ text: "-", position: "top" }`.

要从菜单中删除现有项目，请在项目文本前面使用减号。 例:`{ text: "-Objects Tree..." }`

例:

```javascript
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

1. `options`: object `{ align: "left" }`
    * `align`: `right` | `left`. default: `left`

在图表的顶部工具栏中创建一个新的DOM元素，并为此按钮返回[HTMLElement](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement)。
您可以使用它在图表上添加自定义控件。

**注意：**必须在[headerReady](＃headerready)返回的 `Promise` 为resolved之后使用。

例：

```js
widget.headerReady().then(function() {
    var button = widget.createButton();
    button.setAttribute('title', 'My custom button tooltip');
    button.addEventListener('click', function() { alert("My custom button pressed!"); });
    button.textContent = 'My custom button caption';
});
```

# 对话框

**Since 1.6 version**

#### showNoticeDialog\(params\)

1. `params`: 对象:
   1. `title`: 标题
   2. `body`: 正文
   3. `callback`: 当按下ok按钮时调用的函数。

此方法显示一个对话框，其中包含自定义标题和文本以及“确定”按钮。

#### showConfirmDialog\(params\)

1. `params`: 对象:
   1. `title`: 标题
   2. `body`: 正文
   3. `callback(result)`: 当按下ok按钮时调用的函数。
      `result`点击ok时为`true`, 否则为`false`。

此方法显示一个带有自定义标题和文本以及"确定"、"取消"按钮的对话框。

#### showLoadChartDialog()

显示加载图表对话框。

#### showSaveAsChartDialog()

显示另存为...图表对话框。

# Getters

#### symbolInterval()

图表库返回一个包含symbol和interval的对象。

#### mainSeriesPriceFormatter()

返回一个带有`format`方法的对象，用来批量格式化价格。 被引入在1.5.

#### getIntervals()

返回支持的周期数组。被引入在1.7.

#### getStudiesList()

返回全部技术指标数组，您可以通过它们创建技术指标指示器。

### undoRedoState()

返回具有Undo/Redo堆栈状态的对象。 该对象具有以下属性:

* `enableUndo`: boolean类型, 表示撤消操作是否可用。
* `undoText`: 下一个撤消操作的名称。如果撤消堆栈为空，则它的值为`undefined`。
* `enableRedo`: boolean类型, 表示恢复操作是否可用。
* `redoText`: 下一个恢复操作的名称。如果恢复堆栈为空，则它的值为`undefined`。

# 定制

#### changeTheme(themeName)

*该方法在版本`1.13`中引入*

1. `themeName` 可以为 `"Light"` | `"Dark"`

此方法可更改图表主题而不重新加载图表。

您还可以使用Widget构造函数中的[theme](Widget-Constructor.md#theme)来创建具有自定义主题的图表。

#### addCustomCSSFile(url)

1. `url` 绝对或相对路径的 `static` 文件夹

该方法在版本`1.3`中引入。从1.4开始，使用[custom\_css\_url](Widget-Constructor.md#loadlastchart)替代。

#### applyOverrides(overrides)

*该方法在版本`1.5`中引入*

1. `overrides`为一个对象，和[overrides](Widget-Constructor.md#overrides)相同。

此方法将 `覆盖` 图表属性，而无需重新加载图表。

#### applyStudiesOverrides(overrides)

*该方法在版本`1.9`中引入*

1. `overrides` 为一个对象，和[studies\_overrides](Widget-Constructor.md#studiesoverrides)相同。

此方法将 `覆盖` 指标的指标样式或输入参数，而无需重新加载图表。

# ![](../images/trading.png)交易终端专属

以下方法只在[交易终端](Trading-Terminal.md)可用.

#### ![](../images/trading.png)watchList()

*该方法在版本`1.9`中引入*

返回一个对象来操作观察列表。 该对象具有以下方法：

1. `defaultList()`- 允许您获取默认的商品列表。
2. `getList(id?: string)`- 允许您获取商品列表。 如果未传递`id` 则返回当前列表。 如果没有监视列表则返回 `null` 。  

3.  `getActiveListId()` - 允许您获取当前列表的ID。如果没有监视列表则返回`null` 。
 
4.  `getAllLists()` - 允许您获取所有列表。如果没有监视列表则返回`null` 。
5.  `setList(symbols: string[])`- 允许您将商品列表设置到观察列表中。 它将替换整个列表。**已过时。将在 `1.13`版本中删除。请改用  `updateList`。**  

1.  `updateList(listId: string, symbols: string[])` - 允许您编辑商品列表。  

1.  `renameList(listId: string, newName: string)` - 允许您将列表重命名为 `newName`.

1.  `createList(listName?: string, symbols?: string[])` - 允许您创建具有`listName` 名称的符号列表。如果未传递 `listName` 参数或者没有监视列表，则返回 `null`。

1.  `saveList(list: SymbolList)` - 允许您保存一个商品列表， `list` 是具有以下key的集合对象:

```js
id: string;
title: string;
symbols: string[];
```

如果没有监视列表或者已有一个等价列表，则返回`false` 否则返回 `true` 。

1. `deleteList(listId: string)` - 允许您删除商品列表。
2. `onListChanged()`- 当在监视列表中的商品更改时, 可以使用此方法进行通知。您可以使用此方法返回的 [Subscription](Subscription.md)对象进行订阅和取消订阅。  

3.  `onActiveListChanged()` - 当选择了不同的监视列表时, 可以使用此方法进行通知。您可以使用此方法返回的 [Subscription](Subscription.md)对象进行订阅和取消订阅。

4.  `onListAdded()` - - 当新的列表添加到监视列表中时, 可以使用此方法进行通知。您可以使用此方法返回的 [Subscription](Subscription.md)对象进行订阅和取消订阅。
 
5.  `onListRemoved()` - 当监视列表中删除商品列表时, 可以使用此方法进行通知。您可以使用此方法返回的 [Subscription](Subscription.md)对象进行订阅和取消订阅。

6.  `onListRenamed()` - - 当监视列表中重命名商品列表时, 可以使用此方法进行通知。您可以使用此方法返回的 [Subscription](Subscription.md)对象进行订阅和取消订阅。

# ![](../images/trading.png)多图表布局

#### ![](../images/trading.png)chart\(index\)

1. `index`: 从0开始的图表索引，默认为0。

返回chart对象，用于调用[Chart-Methods](Chart-Methods.md)

#### ![](../images/trading.png)activeChart()

返回当前chart对象，用于调用[Chart-Methods](Chart-Methods.md)

#### ![](../images/trading.png)chartsCount()

返回当前布局的图表数目。

#### ![](../images/trading.png)layout()

返回当前布局模式。 可能的值：`4`, `6`, `8`, `s`, `2h`, `2-1`, `2v`, `3h`, `3v`, `3s`, `1-2`, `3r`, `4h`, `4v`, `4s`, `1-3`, `2-2`, `1-4`, `5s`, `6c`, `8c`.

#### ![](../images/trading.png)setLayout\(layout\)

1. `layout`: 可能的值:`4`, `6`, `8`, `s`, `2h`, `2-1`, `2v`, `3h`, `3v`, `3s`, `1-2`, `3r`, `4h`, `4v`, `4s`, `1-3`, `2-2`, `1-4`, `5s`, `6c`, `8c`.

变更当前图表布局。

### ![](../images/trading.png)layoutName()

返回当前布局名称。 如果尚未保存当前布局，则返回undefined。

# 也可以看看

* [图表方法](Chart-Methods.md)
* [定制概述](Customization-Overview.md)
* [Widgetg构造函数](Widget-Constructor.md)
* [存储与加载图表](Saving-and-Loading-Charts.md)
* [指标覆盖](Studies-Overrides.md)
* [覆盖](Overrides.md)



<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1MzU3MjA3MTgsLTcxNjEyNTEyNCwtMT
QzNDk2ODg0LDE2MDczMTgwNTEsLTI1OTQwNjg5MywxOTc3ODAz
ODgxLDE2ODc5MTQ3MSwtMjAzOTgzMzUwMywtMTI3Mjg1ODY1OC
wzOTQ1MzUyNTYsLTM0NzQxMDQ5NF19
-->