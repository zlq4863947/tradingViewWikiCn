# Widget构造器

---

当调用构造函数时，您可以定义图表库widget的参数。例：

```javascript
new TradingView.widget({
    symbol: 'A',
    interval: 'D',
    timezone: "America/New_York",
    container_id: "tv_chart_container",
    locale: "ru",
    datafeed: new Datafeeds.UDFCompatibleDatafeed("https://demo_feed.tradingview.com")
});
```

查看下列完整支持的参数列表。请记住，在图表初始化后在更改这些参数是不起作用的。如果要在初始化图表之后更改图表的状态，请使用[widget方法](/book/Widget-Methods.md)。

属性标记为![](../images/trading.png)的只在交易终端可用。

#### symbol, interval
您的图表的初始商品和周期。`interval`的格式在另一篇[文章](/book/Resolution.md)中说明。 *必须项*

#### timeframe

设置图表的初始时间范围。时间范围是加载并显示在屏幕上的K线范围。有效的时间范围是一个数字加一个字母，D为数天，M为数月。

#### container\_id

`id`属性为指定要包含widget的DOM元素id。 *必须项*

#### datafeed

JavaScript对象的实现接口 [JS API](/book/JS-Api.md) 以反馈图表及数据。 *必须项*

#### timezone

图表的初始时区。时间刻度上的数字取决于这个时区。请参阅[支持的时区列表](/book/Symbology.md#timezone)。设置为交易所时区。覆盖默认值，您应该使用[覆盖章节](/book/Widget-Constructor.md#overrides)。

#### debug

将此属性设置为 `true`时，可使图表将详细的API日志写入控制台。与功能集的`charting_library_debug_mode`用法相同。

#### library\_path

`static`文件夹的路径

#### width, height

widget的尺寸，请确保widget拥有足够的空间。

**Remark**: 如果您想让图表占据所有可用的空间，请不要使用 '100%' 这样的字段。使用`fullscreen`参数来代替（见下文）。这是因为DOM节点在不同浏览器中有调整大小的问题。

#### fullscreen

*默认值:* `false`

布尔值显示图表是否占用窗口中所有可用的空间。

#### autosize

*默认值:* `false`

布尔值，显示图表是否应使用容器中的所有可用空间，并在调整容器本身大小时自动调整大小。

#### symbol\_search\_request\_delay

延迟阈值（以毫秒为单位），用于在用户在搜索框中键入商品名称时减少商品搜索请求的数量。

#### auto\_save\_delay

延迟秒数等待 `onAutoSaveNeeded` 可以被再次调用。 该参数介绍在1.5版本中。

#### toolbar\_bg

工具栏背景颜色

#### study\_count\_limit

*自1.5版本起。*

多图布局图表的最大指标数量。 最小值为2。

#### studies\_access

版本：1.1具有以下结构的对象：

```js
{
    type: "black" | "white",
    tools: [
        {
            name: "<study name>",
            grayed: true
        },
        < ... >
    ]
}
```

* `type`是列表类型。 支持的值:`black`\(所有列出的项目会被禁用\),`white`\(只有列出的项目会被启用\)。
* `tools`对象数组。每个对象可以具有以下属性：
  * `name`\(强制的\) 指标的名称。使用相同的名称，你可以看到他们在指标控件。
  * `grayed`布尔值，表明这项指标将可见，但看起来像是被禁用的。 如果指标为`grayed`，当用户点击它时，会调用`onGrayedObjectClicked`回调方法。

#### drawings\_access

版本：1.1 该属性与上述的`studies_access`具有相同的结构。 使用与您在UI中看到的名称相同的名称。

**Remark**: 基于字体的绘图有一个特殊情况。 使用`Font Icons`的名字时， 这个组是一个特例，它的绘图不能被启用或禁用 - 可以启用或禁用整个组。

#### saved\_data

JS对象包含保存的图表内容（JSON，请参阅下面的保存/加载调用）。如果在创建图表时已经有图表的JSON，请使用此参数。如果要将图表内容加载到已初始化的图表中，请使用`loadData()`控件方法。

#### locale

图表库的本地化处理 。详情：[本地化](/book/Localization.md)

#### numeric\_formatting

该对象包含数字的格式化选项。目前唯一可能的选择是`decimal_sign`。例:`numeric_formatting: { decimal_sign: "," }`

#### customFormatters

它是一个包含以下字段的对象：

1. timeFormatter
2. dateFormatter

您可以使用这些格式化方法自定义显示日期和时间的值。这两个值都是具有方法`format`和`formatLocal`的对象:

```js
function format(date)
function formatLocal(date)
```

这些函数返回表示date或time的文本。`formatLocal`将日期和时间转换为本地时区。

例:

```js
customFormatters: {
  timeFormatter: {
    format: function(date) { var _format_str = '%h:%m'; return _format_str.replace('%h', date.getUTCHours(), 2). replace('%m', date.getUTCMinutes(), 2). replace('%s', date.getUTCSeconds(), 2); }
  },
  dateFormatter: {
    format: function(date) { return date.getUTCFullYear() + '/' + date.getUTCMonth() + '/' + date.getUTCDate(); }
  }
}
```

#### overrides

对Widget对象的默认属性进行覆盖。 覆盖属性意味着为其分配默认值。 您可以覆盖大部分图表的属性（也可以由用户通过UI编辑）使用`overrides`参数构造控件 。`overrides`应该是一个具有范围的对象。每个字段名是重写属性的名称，字段值是这些属性的期望值。例子:

```js
overrides: {
    "symbolWatermarkProperties.color": "rgba(0, 0, 0, 0)"
}
```

这个 `override`将使水印100％不透明（不可见）。 所有可定制的属性都列在[单独的文章](/book/Overrides.md)中。 从1.5开始，您可以使用绘图覆盖。[绘图覆盖](/book/Drawings-Overrides.md).

#### disabled\_features, enabled\_features

包含功能在默认情况下启用/禁用名称的数组。功能表示图表功能的一部分（更是UI/UX的一部分）。 [这里](http://tradingview.gitee.io/featuresets). 此处列出了支持的功能。 例：

```js
TradingView.onready(function()
{
    var widget = new TradingView.widget({
        /* .... */
        disabled_features: ["header_widget", "left_toolbar"],
        enabled_features: ["move_logo_to_main_pane"]
    });
});
```

#### snapshot\_url

当用户按快照按钮时,使用base64编码将当前图表快照保存并返回URL。该服务返回完整的保存图像URL。

#### indicators\_file\_name

包含您编写的指标的文件路径。 查看[更多细节](/book/Creating-Custom-Studies.md)。

#### preset

`preset`是一组预定义窗口小部件设置的名称。预设中使用的所有设置也可以直接在窗口小部件的构造函数中使用。现在只支持`mobile`预设。此预设的示例可[在线获取](https://demo_chart.tradingview.com/mobile_black.html)。

#### studies\_overrides

使用此选项自定义默认指标的样式及输入值。 您还可以使用此参数自定义`Compare`数据列的样式和输入值。 [查看更多](/book/Studies-Overrides.md)

#### time\_frames

在图表底部的时间范围选择器中可以看见这个时间范围列表。 例：

```js
time_frames: [
    { text: "50y", resolution: "6M", description: "50 Years" },
    { text: "3y", resolution: "W", description: "3 Years", title: "3yr" },
    { text: "8m", resolution: "D", description: "8 Month" },
    { text: "3d", resolution: "5", description: "3 Days" },
    { text: "1000y", resolution: "W", description: "All", title: "All" },
]
```

时间范围是一个包含`text`和`resolution属性的对象。文本必须具有以下格式：<integer><y|m|d>`\( \d+\(y\|m\|d\) 为正则表达式 \). 周期是具有通用周期格式的字符串. 请参阅[本主题](/book/Time-Frames.md)了解有关时间范围的更多信息。在1.7中添加了描述属性，并显示在弹出菜单中。此参数是可选的（如果时间范围描述符不包含此属性：title（如果指定）或使用）。title属性在1.9中添加，此值将覆盖从text属性生成的默认标题。 此参数是可选的。

#### charts\_storage\_url, client\_id, user\_id

这些参数是有关于高阶图表的保存/加载。 查看[更多细节](/book/Saving-and-Loading-Charts.md).

#### charts\_storage\_api\_version

您的后台版本。支持的值:`"1.0"`\|`"1.1"`。 指标模板从`1.1`开始得到支持。

#### load\_last\_chart

将此参数设置为`true`如果您希望库加载用户的最后一张图表（您也应该具有\[save/load\|Saving-and-Loading-Charts\]）。

### theme

*从1.13版开始。*

为图表添加自定义主题颜色。 支持的值是: `"Light"` | `"Dark"`.

#### custom\_css\_url \(since 1.4\)

将您的自定义CSS添加到图表中。url应该是到'static\`文件夹的绝对或相对路径。

#### loading\_screen \(since 1.12\)

定制加载进度条。值是具有以下可能 `key` 的对象。

- `backgroundColor`
- `foregroundColor`

Example:
```javascript
loading_screen: { backgroundColor: "#000000" }
```

#### favorites

默认支持该项目。此选项需要禁用localstorage的使用（请参阅[功能集](/book/Featuresets.md)以了解更多\)。`favorites`property 为一个对象，拥有以下属性：

* **intervals\(周期\)**: 收藏的周期数组。 例：`["D", "2D"]`
* **chartTypes\(图表类型\)**: 收藏的图表类型数组 。图表类型名称与图表的UI中的英文版本相同。 例:`["Area", "Candles"]`

#### save_load_adapter (since 1.12)

包含保存/加载功能的对象。 如果设置了，应有以下方法：

**Chart layouts**

 1. `getAllCharts(): Promise<ChartMetaInfo[]>` 
 
    获取所有保存的图表。

    `ChartMetaInfo` 具有以下字段的对象:
      - `id` - 图表id
      - `name` - 图表名
      - `symbol` - 图表的商品
      - `resolution` - 周期
      - `timestamp` - 最后修改日期（从01/01/2015 UTC午夜开始的毫秒数）。

 2. `removeChart(chartId): Promise<void>`
     
     删除图表。 `chartId`是图表的唯一ID（参见上面的`getAllCharts`）。

 3. `saveChart(chartData: ChartData): Promise<ChartId>`
     
     存储图表。

    `ChartData` 具有以下字段的对象:
      - `id` - 图表的唯一标识（如果未保存则可能是`undefined`）。
      - `name` - 图表名
      - `symbol` - 图表的商品
      - `resolution` - 周期
      - `content` - 图表的内容

    `ChartId` - 图表唯一id (string)

 4. `getChartContent(chartId): Promise<ChartContent>`
     
     通过服务器加载图表

    `ChartContent` 带有图表内容的字符串（参见`saveChart`函数中的`ChartData :: content`字段）。

**Study Templates**

 1. `getAllStudyTemplates(): Promise<StudyTemplateMetaInfo[]>`
     
     获取所有保存的指标模板。
     
    `StudyTemplateMetaInfo` 具有以下字段的对象:
      - `name` - 指标模板名称

 2. `removeStudyTemplate(studyTemplateInfo: StudyTemplateMetaInfo): Promise<void>`
     
     删除指标模板

 3. `saveStudyTemplate(studyTemplateData: StudyTemplateData): Promise<void>`
     
     存储指标模板
     
    `StudyTemplateData` 具有以下字段的对象:
      - `name` - 指标模板名称
      - `content` - 指标模板的内容

 4. `getStudyTemplateContent(studyTemplateInfo: StudyTemplateMetaInfo): Promise<StudyTemplateContent>`
 
     通过服务器加载指标模板
     
    `StudyTemplateContent` - 指标模板的内容 (string)

 如果同时设置了 `charts_storage_url` 和 `save_load_adapter` 将被设置 - `save_load_adapter`

 **重要：** 所有函数应该返回`Promise`（或`Promise`类对象）。

#### settings_adapter (since 1.11)

包含设置/删除的方法。 使用它将图表设置保存到您的首选存储，包括服务器端。 如果设置了，应该有以下方法：

1. `initialSettings: Object`
初始化设置

2. `setValue(key: string, value: string): void`
存储键/值对

3. `removeValue(key: string): void`
删除键

## ![](../images/trading.png) 交易终端专属

#### ![](../images/trading.png) widgetbar

该对象包含图表右侧窗口小部件栏的设置。 右侧窗口小部件栏中的数据窗口，观察列表和详细信息选项卡可以使用Widget构造函数中的widgetbar 开启此功能：

```js
widgetbar: {
    details: true,
    watchlist: true,
    watchlist_settings: {
        default_symbols: ["NYSE:AA", "NYSE:AAL", "NASDAQ:AAPL"],
        readonly: false
    }
}
```

* **details**: 启用右侧窗口小部件栏中的详细信息窗口小部件。
* **watchlist**: 启用右侧小部件栏中的观察列表小部件。
* **watchlist\_settings.default\_symbols &lt;\[\]&gt;**: 给观察列表设置商品数组。
* \*\*watchlist\_settings.readonly: 给观察列表开启只读模式。

#### ![](../images/trading.png) rss\_news\_feed

使用此属性更改RSS新闻。 您可以为每个商品类型设置不同的rss，或为每个商品使用一个rss。 对象将拥有`default`属性，其他属性是可选的; 它们的名字为商品的类型. 每个属性都拥有一个对象\(或对象数组\) 并且具有以下属性:

1. `url`请求的URL。 它可以包含以下花括号中的标签（将会被终端所更改）：`{SYMBOL}`,`{TYPE}`,`{EXCHANGE}。`
2. `name 在每一个新闻的底部显示一个反馈。`

例:

```js
{
    "default": [ {
        url: "https://articlefeeds.nasdaq.com/nasdaq/symbols?symbol={SYMBOL}",
        name: "NASDAQ"
      }, {
        url: "http://feeds.finance.yahoo.com/rss/2.0/headline?s={SYMBOL}&region=US&lang=en-US",
        name: "Yahoo Finance"
      } ]
}
```

另一个例子:

```js
{
    "default": {
        url: "https://articlefeeds.nasdaq.com/nasdaq/symbols?symbol={SYMBOL}",
        name: "NASDAQ"
    }
}
```

更多例子:

```js
{
    "default": {
        url: "https://articlefeeds.nasdaq.com/nasdaq/symbols?symbol={SYMBOL}",
        name: "NASDAQ"
     },
    "stock": {
        url: "http://feeds.finance.yahoo.com/rss/2.0/headline?s={SYMBOL}&region=US&lang=en-US",
        name: "Yahoo Finance"
    }
}
```

#### ![](../images/trading.png) news\_provider

代表新闻提供者的对象。 它可能包含以下属性：

1. `is_news_generic`- 如果为`true`新闻小部件的标题将不会有产品名称 \(只有`Headlines`\). 否则`SYMBOL_NAME`将会被添加。

2. `get_news`- 使用此属性设置自己的新闻 getter 方法.`symbol`和`callback`将会传递给此方法。

   回调函数被调用时，会传递一下结构的新闻对象:

   1. `title`\(必须\) - 新闻项目标题。
   2. `published`\(必须\) - 新闻项目时间（以ms为单位）
   3. `source`\(可选\) - 标题的新闻项目来源。
   4. `shortDescription`\(可选\) - 将显示的新闻项目的简短说明。
   5. `link`\(可选\) - 新闻URL 
   6. `fullDescription`\(可选\) - 新闻项目的完整描述（正文）

   **注意:**当用户点击新闻项目时，将打开带有`link`URL的新标签页。 如果没有指定`link`，将显示带有`fullDescription`的对话框弹出窗口。

   **注意2:**如果它设置为`rss_news_feed`则将会被忽略。

例:

```js
news_provider: {
    is_news_generic: true,
    get_news: function(symbol, callback) {
        callback([
            {
                title: 'It is news for symbol ' + symbol,
                shortDescription: 'Short description of the news item',
                fullDescription: 'Full description of the news item',
                published: new Date().valueOf(),
                source: 'My own news source',
                link: 'https://www.tradingview.com/'
            },
            {
                title: 'Another news for symbol ' + symbol,
                shortDescription: 'Short description of the news item',
                fullDescription: 'Full description of the news item. Very long long long long long long long long text.',
                published: new Date().valueOf(),
                source: 'My own news source',
            }
        ]);
    }
}
```

#### ![](../images/trading.png) trading\_controller(已废弃)

交易控制器可以让您在线交易。[阅读更多](/book/Trading-Controller.md)

```js
new TradingView.widget({
    /* ... */
    trading_controller: new MyTradingController()
});
```

#### ![](../images/trading.png) brokerFactory
使用这个字段来传递构造[经纪商API](/book/Broker-API.md)的实现函数。 
这是一个接收[交易主机](/book/Trading-Host.md)并返回[经纪商API](/book/Broker-API.md)的函数。

#### ![](../images/trading.png) brokerConfig
`brokerConfig: { configFlags: {...} }`
使用此字段设置交易终端的配置标志。 [了解更多](/book/Broker-API.md#tradingconfiguration)

# 也可以看看

* [定制概述](/book/Customization-Overview.md)
* [Widget方法](/book/Widget-Methods.md)
* [功能集](/book/Featuresets.md)
* [存储于加载图表](/book/Saving-and-Loading-Charts.md)
* [覆盖默认指标参数](/book/Studies-Overrides.md)
* [覆盖默认图表参数](/book/Overrides.md)



<!--stackedit_data:
eyJoaXN0b3J5IjpbOTY1NzQwNzIxXX0=
-->