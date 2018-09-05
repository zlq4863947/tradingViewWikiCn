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

* 订阅图表事件
  * [onChartReady\(callback\)](#onchartreadycallback)
  * [headerReady()](#headerready)
  * [onGrayedObjectClicked\(callback\)](#ongrayedobjectclickedcallback)
  * [onShortcut\(shortcut, callback\)](#onshortcutshortcut-callback)
  * [subscribe\(event, callback\)](#subscribeevent-callback)
  * [unsubscribe\(event, callback\)](#unsubscribeevent-callback)
* 图表动作
  * [chart\(\)](/book/Widget-Methods.md#chart)
  * [setLanguage\(locale\)](/book/Widget-Methods.md#setlanguagelocale)
  * [setSymbol\(symbol, interval, callback\)](/book/Widget-Methods.md#setsymbolsymbol-interval-callback)
  * [remove\(\)](/book/Widget-Methods.md#remove)
  * [closePopupsAndDialogs\(\)](/book/Widget-Methods.md#closepopupsanddialogs)
  * [selectLineTool\(drawingId\)](/book/Widget-Methods.md#selectlinetooldrawingid)
  * [selectedLineTool\(\)](/book/Widget-Methods.md#selectedlinetool)
  * [takeScreenshot\(\)](/book/Widget-Methods.md#takeScreenshot)
  * [lockAllDrawingTools\(\)](/book/Widget-Methods.md#lockAllDrawingTools)
  * [hideAllDrawingTools\(\)](/book/Widget-Methods.md#hideAllDrawingTools)
* 保存/加载图表
  * [save\(callback\)](/book/Widget-Methods.md#savecallback)
  * [load\(state\)](/book/Widget-Methods.md#loadstate)
  * [getSavedCharts\(callback\)](/book/Widget-Methods.md#getsavedchartscallback)
  * [loadChartFromServer\(chartRecord\)](/book/Widget-Methods.md#loadchartfromserverchartrecord)
  * [saveChartToServer\(onCompleteCallback, onFailCallback, saveAsSnapshot, options\)](/book/Widget-Methods.md#savecharttoserveroncompletecallback-onfailcallback-saveassnapshot-options)
  * [removeChartFromServer\(chartId, onCompleteCallback\)](/book/Widget-Methods.md#removechartfromserverchartid-oncompletecallback)
* 自定义UI控件
  * [onContextMenu\(callback\)](/book/Widget-Methods.md#oncontextmenucallback)
  * [createButton\(options\)](/book/Widget-Methods.md#createbuttonoptions)
* 对话框 
  * [showNoticeDialog\(params\)](/book/Widget-Methods.md#shownoticedialogparams)
  * [showConfirmDialog\(params\)](/book/Widget-Methods.md#showconfirmdialogparams)
  * [showLoadChartDialog\(\)](/book/Widget-Methods.md#showloadchartdialog)
  * [showSaveAsChartDialog\(\)](/book/Widget-Methods.md#showsaveaschartdialog)
* Getters
  * [symbolInterval\(callback\)](/book/Widget-Methods.md#symbolintervalcallback)
  * [mainSeriesPriceFormatter\(\)](/book/Widget-Methods.md#mainseriespriceformatter)
  * [getIntervals\(\)](/book/Widget-Methods.md#getintervals)
  * [getStudiesList\(\)](/book/Widget-Methods.md#getstudieslist)
* 定制
  * [changeTheme\(themeName\)](/book/Widget-Methods.md#changethemethemename)
  * [addCustomCSSFile\(url\)](/book/Widget-Methods.md#addcustomcssfileurl)
  * [applyOverrides\(overrides\)](/book/Widget-Methods.md#applyoverridesoverrides)
  * [applyStudiesOverrides\(overrides\)](/book/Widget-Methods.md#applystudiesoverridesoverrides)
* ![](../images/trading.png)[交易终端特制](/book/Trading-Terminal.md)
  * [watchList\(\)](/book/Widget-Methods.md#watchlist)
* ![](../images/trading.png)多图表布局
  * [chart\(index\)](/book/Widget-Methods.md#chartindex)
  * [activeChart\(\)](/book/Widget-Methods.md#activechart)
  * [chartsCount\(\)](/book/Widget-Methods.md#chartscount)
  * [layout\(\)](/book/Widget-Methods.md#layout)
  * [setLayout\(layout\)](/book/Widget-Methods.md#setlayoutlayout)

# 订阅图表事件

#### [onChartReady\(callback\)](#onchartreadycallback)

1. `callback`: function\(\)

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
    <...> // other widget settings
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

每当按下快捷键时，图书馆将会调用此回调。

例:

```js
widget.onShortcut("alt+s", function() {
  widget.executeActionById("symbolSearch");
});
```

#### subscribe\(event, callback\)

1. `event`: can be

| Event name | Library Version | Description |
| :--- | :--- | :--- |
| toggle\_sidebar |  | 绘图工具栏 显示/隐藏 |
| indicators\_dialog |  | 显示指标对话框 |
| toggle\_header |  | 图表头 显示/隐藏 |
| edit\_object\_dialog |  | 显示图/指标属性对话框 |
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
| load\_study template | 1.7 | 指标模板被载入后 |
| onTick |  | 回调将被调用每当最近的K线更新时 |
| onAutoSaveNeeded |  | 每当用户更改图表时，库将调用该回调。`Chart change`意味着可以撤消用户的任何操作。回调不会在五秒内多次调用。参见[auto\_save\_delay](/book/Widget-Constructor#auto_save_delay) |
| onScreenshotReady |  | 每当用户创建屏幕截图和服务器返回创建的图像名称时。 |
| onMarkClick |  | 每次当用户点击K线上的标记时。[mark on bar](/book/Marks-On-Bars). 标记ID将作为参数传递。 |
| onTimescaleMarkClick |  | 每当用户单击时间刻度标记时，将调用回调。 标记ID将作为参数传递 |
| onSelectedLineToolChanged |  | 每次当选择的线工具更改时，将调用回调。 |
| ![](../images/trading.png)layout\_about\_to\_be\_changed |  | 要更改图表的数量或位置时 |
| ![](../images/trading.png)layout\_changed |  | 已经更改图表的数量或位置时 |
| ![](../images/trading.png)activeChartChanged |  | 活动图表被更改 |

2.`callback`: function\(arguments\)

当GUI事件发生时，图表库将调用回调。 每个事件都可以有不同的参数。

#### unsubscribe\(event, callback\)

取消订阅特定事件 (即上表中的事件之一) 。

# 图表功能

#### chart\(\)

返回图表对象，可用于调用[Chart-Methods](/book/Chart-Methods.md)

#### setLanguage\(locale\)

1. `locale`
   :
   [language code](/book/Localization.md)

设置Widget的语言。 目前此调用将重新加载图表。请避免使用它。

#### setSymbol\(symbol, interval, callback\)

1. `symbol`: string
2. `interval`: string
3. `callback`: function\(\)

使图表更改其商品和周期。 新商品的数据到达后调用回调。

#### remove\(\)

从您的页面中删除widget。

#### closePopupsAndDialogs\(\)

调用此方法会关闭上下文菜单或对话框（如果已显示）。

#### selectLineTool\(drawingId\)

1. `drawingId`: 可以为一个[标识符](/book/Shapes-and-Overrides.md) 或
   1. `cursor`
   2. `dot`
   3. `arrow_cursor`
   4. `eraser`
   5. `measure`
   6. `zoom`
   7. `brush`

选择与绘图按钮上的单击相同的图形或光标。

#### selectedLineTool\(\)

返回所选图形或光标的[标识符](/book/Shapes-and-Overrides.md)（见上文）。

### takeScreenshot\(\)
此方法创建图表的快照并将其上传到服务器。

完成后, 调用 [onScreenshotReady](#subscribeevent-callback) 回调函数。

快照的 URL 将作为参数传递给回调函数。

### lockAllDrawingTools\(\)
此方法返回一个 [WatchedValue](/book/WatchedValue.md) 对象,
可用于读取/设置/监视 "锁定所有绘图工具" 按钮的状态。

### hideAllDrawingTools()

此方法返回 [WatchedValue](/book/WatchedValue.md) 对象,
该对象可用于读取/设置/监视 "隐藏所有绘图工具" 按钮的状态。

# 保存/加载图表

#### save\(callback\)

1. `callback`: function\(object\)

将图表状态保存到JS对象。图表库将调用您的回调函数并将状态对象作为参数传递。

此调用是低级[保存/加载API](/book/Saving-and-Loading-Charts.md)的一部分。

#### load\(state\)

1. `state`: object

从`state`对象加载图表。 此调用是低级[保存/加载API](/book/Saving-and-Loading-Charts.md)的一部分。

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

1. `chartRecord`是您使用[getSavedCharts\(callback\)](/book/Widget-Methods.md#getsavedchartscallback) 返回的对象

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

1. `chartId`:`调用`[getSavedCharts\(callback\)](/book/Widget-Methods.md#getsavedchartscallback)后获得的`id`
2. `onCompleteCallback`: function\(\)

从服务器移除图表。

# 自定义UI控件

#### onContextMenu\(callback\)

1. `callback`: function\(unixtime, price\). 此回调将返回一个值（见下文）。

当用户打开图表上的菜单时，库将调用回调函数。UNIX时间和菜单点的价格将作为参数提供。要自定义菜单项，您必须返回项目描述数组。项目描述对象具有以下结构：

```
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

#### showLoadChartDialog\(\)

显示加载图表对话框。

#### showSaveAsChartDialog\(\)

显示另存为...图表对话框。

# Getters

#### symbolInterval\(callback\)

1. `callback`: function\(result\)
   1. `result`: object`{symbol, interval}`

**由于1.4开始方法会立即返回结果。回调是为了保证兼容性。**

图表库将调用回调函数，参数对象包含图表商品和时间周期。

#### mainSeriesPriceFormatter\(\)

返回一个带有`format`方法的对象，用来批量格式化价格。 被引入在1.5.

#### getIntervals\(\)

返回支持的周期数组。被引入在1.7.

#### getStudiesList\(\)

返回全部技术指标数组，您可以通过它们创建技术指标指示器。

# 定制

#### changeTheme\(themeName\)

*从1.13版开始.*

1. `themeName` 可以为 `"Light"` | `"Dark"`

此方法更改图表主题而不重新加载图表。

您还可以使用Widget构造函数中的[theme](Widget-Constructor.md#theme)来创建具有自定义主题的图表。

#### addCustomCSSFile\(url\)

1. `url` 绝对或相对路径的 `static` 文件夹

该方法在版本`1.3`中引入。从1.4开始，使用[custom\_css\_url](/book/Widget-Constructor.md#loadlastchart)替代。

#### applyOverrides\(overrides\)

_该方法在版本`1.5`中引入_

1. `overrides`为一个对象，和[overrides](/book/Widget-Constructor.md#overrides)相同。

此方法在不重新加载图表的情况下将覆盖应用属性。

#### applyStudiesOverrides\(overrides\)

_该方法在版本`1.9`中引入_

1. `overrides` 为一个对象，和[studies\_overrides](/book/Widget-Constructor.md#studiesoverrides)相同。

此方法将重写指标的指标样式或输入参数，而无需重新加载图表。

# ![](../images/trading.png)交易终端特制

以下方法只在[交易终端](/book/Trading-Terminal)可用.

#### ![](../images/trading.png)watchList\(\)

_该方法在版本`1.9`中引入_

返回一个对象来操作观察列表。 该对象具有以下方法：

1. `defaultList()`- 允许您获取默认的商品列表。
2. `getList(id?: string)`- 允许您获取商品列表。 如果未传递`id` 则返回当前列表。 如果没有监视列表则返回 `null` 。  

3.  `getActiveListId()` - 允许您获取当前列表的ID。如果没有监视列表则返回`null` 。
 
4.  `getAllLists()` - 允许您获取所有列表。如果没有监视列表则返回`null` 。
5.  `setList(symbols: string[])`- 允许您将商品列表设置到观察列表中。 它将替换整个列表。**过时。将在 `1.13`版本中删除。用  `updateList` 替换。**  

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

1.  `deleteList(listId: string)` - 允许您删除商品列表。
2. `onListChanged()`- 当在监视列表中的商品更改时, 可以使用此方法进行通知。您可以使用此方法返回的 [Subscription](/book/Subscription.md)对象进行订阅和取消订阅。  

3.  `onActiveListChanged()` - 当选择了不同的监视列表时, 可以使用此方法进行通知。您可以使用此方法返回的 [Subscription](/book/Subscription.md)对象进行订阅和取消订阅。

4.  `onListAdded()` - - 当新的列表添加到监视列表中时, 可以使用此方法进行通知。您可以使用此方法返回的 [Subscription](/book/Subscription.md)对象进行订阅和取消订阅。
 
5.  `onListRemoved()` - 当监视列表中删除商品列表时, 可以使用此方法进行通知。您可以使用此方法返回的 [Subscription](/book/Subscription.md)对象进行订阅和取消订阅。

6.  `onListRenamed()` - - 当监视列表中重命名商品列表时, 可以使用此方法进行通知。您可以使用此方法返回的 [Subscription](/book/Subscription.md)对象进行订阅和取消订阅。

# ![](../images/trading.png)多图表布局

#### ![](../images/trading.png)chart\(index\)

1. `index`: 从0开始的图表索引，默认为0。

返回chart对象，用于调用[Chart-Methods](/book/Chart-Methods.md)

#### ![](../images/trading.png)activeChart\(\)

返回当前chart对象，用于调用[Chart-Methods](/book/Chart-Methods.md)

#### ![](../images/trading.png)chartsCount\(\)

返回当前布局的图表数目。

#### ![](../images/trading.png)layout\(\)

返回当前布局模式。 可能的值：`4`,`6`,`8`,`s`,`2h`,`2-1`,`2v`,`3h`,`3v`,`3s`.

#### ![](../images/trading.png)setLayout\(layout\)

1. `layout`: Possible values:`4`,`6`,`8`,`s`,`2h`,`2-1`,`2v`,`3h`,`3v`,`3s`.

变更当前图表布局。

# 也可以看看

* [图表方法](/book/Chart-Methods.md)
* [定制概述](/book/Customization-Overview.md)
* [Widgetg构造函数](/book/Widget-Constructor.md)
* [存储与加载图表](/book/Saving-and-Loading-Charts.md)
* [指标覆盖默](/book/Studies-Overrides.md)
* [覆盖](/book/Overrides.md)



<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1MzU3MjA3MTgsLTcxNjEyNTEyNCwtMT
QzNDk2ODg0LDE2MDczMTgwNTEsLTI1OTQwNjg5MywxOTc3ODAz
ODgxLDE2ODc5MTQ3MSwtMjAzOTgzMzUwMywtMTI3Mjg1ODY1OC
wzOTQ1MzUyNTYsLTM0NzQxMDQ5NF19
-->