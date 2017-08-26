# Widget构造器

当调用构造函数时，您可以定义Charting library控件的参数。例：

```js
new TradingView.widget({
    symbol: 'A',
    interval: 'D',
    timezone: "America/New_York",
    container_id: "tv_chart_container",
    locale: "ru",
    datafeed: new Datafeeds.UDFCompatibleDatafeed("https://demo_feed.tradingview.com")
});
```

查看下列完整支持的参数列表。请记住，在图表初始化后在更改这些参数是不起作用的。如果要在初始化图表之后更改图表的状态，请使用控件方法。

属性标记为![](../images/trading.png)的只在交易终端可用。

#### symbol, interval \[mandatory\]

图表的初始产品和间隔。

#### timeframe

设置图表的初始时间表。 时间框架是将被加载并显示在屏幕上的条形周期。有效的时间表是一个数字加一个字母，D为数天，M为数月。

#### container\_id \[mandatory\]

`id`属性为指定要包含控件的DOM元素。

#### datafeed \[mandatory\]

JavaScript对象实现的接口 \([JS API](https://github.com/tradingview/charting_library/wiki/JS-Api)\) 以反馈图表和数据。

#### timezone

图表的初始时区。时间刻度上的数字取决于这个时区。请参阅支持的时区列表中的可用值。设置为交易所使用交易所时区。覆盖默认值，您应该使用覆盖章节。

#### debug

将此属性设置为true时，可使图表将详细的API日志写入控制台。与Feature的charting\_library\_debug\_mode是此字段用法相同。

#### library\_path

`static`文件夹的路径

#### width, height

请确保控件拥有足够的空间。

**Remark**: 如果您想让图表占据所有可用的空间，请不要使用 '100%' 这样的字段。使用`fullscreen`参数来代替（见下文）。这是因为DOM节点在不同浏览器中有调整大小的问题。

#### fullscreen

布尔值显示图表是否占用窗口中所有可用的空间。

#### autosize

显示图表是否应占据容器中所有可用空间并在窗口调节大小时自动进行调整。 该参数介绍在1.3版本中被引入。

#### symbol\_search\_request\_delay

在商品搜索按下键后请求之前，以毫秒为单位延迟。

#### auto\_save\_delay

延迟秒数等待 onAutoSaveNeeded 可以被再次调用。 该参数介绍在1.5版本中。

#### toolbar\_bg

工具栏背景颜色

#### study\_count\_limit

**自1.5版本起。                  
**

图表或多功能图布局的最大数量。最小值为2。

#### studies\_access

版本：1.1具有以下结构的对象：

```
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

* `type`是一种类型的列表。 支持的值:`black`\(所有列出的项目会被禁用\),`white`\(只有列出的项目会被启用\)。
* `tools`一个数组对象。每个对象可以具有以下属性：
  * `name`\(mandatory\) is the name of a study. Use the same names as you can see them in Indicators widget
  * `grayed`一个布尔值，表明这项研究是否应该是可见的，但看起来像是被禁用的。 如果研究是灰色的并且用户点击它，则`onGrayedObjectClicked`回调会被调用。

#### drawings\_access

版本：1.1此属性的结构与`studies_access`如上所述。使用与您在UI中看到的相同的名称。

**Remark**: 基于字体的绘图有特殊情况。 为他们使用“字体图标”的名称。 该组是一种特殊情况，其绘图无法启用或禁用特别 - 可以启用或禁用整个组。

#### saved\_data

JS对象包含保存的图表内容（JSON，请参阅下面的保存/加载调用）。如果在创建图表时已经有图表的JSON，请使用此参数。如果要将图表内容加载到已初始化的图表中，请使用`loadData()`控件方法。

#### locale

Charting Library的本地化处理 。详情：[Localization](https://github.com/tradingview/charting_library/wiki/Localization)

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

这些函数应该返回表示date或time.format的文本。本地应将日期和时间转换为本地时区。

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

对Widget对象的默认属性进行覆盖。 覆盖属性意味着为其分配默认值。 您可以覆盖大部分Charting Library属性（也可以由用户通过UI编辑）使用`overrides`参数构造控件 。`overrides`应该是一个具有范围的对象。每个字段名是重写属性的名称，字段值是这些属性的期望值。例子:

```
overrides: {
    "symbolWatermarkProperties.color": "rgba(0, 0, 0, 0)"
}
```

这个 `override`将使水印100％不透明（不可见）。 所有可定制的属性都列在单独的文章中。 从1.5开始，您可以使用绘图覆盖。[Drawings-Overrides](https://github.com/tradingview/charting_library/wiki/Drawings-Overrides).

#### disabled\_features, enabled\_features

包含功能在默认情况下启用/禁用名称的数组。功能表示图表功能的一部分（更是UI/UX的一部分）。 [here](https://github.com/tradingview/charting_library/wiki/Featuresets). 此处列出了支持的功能。 例：

```js
TradingView.onready(function()
{
    var widget = new TradingView.widget({
        /* .... */
        disabled_features: ["header_widget", "left_toolbar"],
    });
});
```

#### snapshot\_url

当用户按快照按钮时,使用base64编码将当前图表快照保存并返回URL。该服务返回完整的保存图像URL。

#### indicators\_file\_name

包含您编写的指标的文件路径。 查看更多细节[here](https://github.com/tradingview/charting_library/wiki/Creating-Custom-Studies).

#### preset

`preset是一组预定义窗口小部件设置的名称。预设中使用的所有设置也可以直接在窗口小部件的构造函数中使用。现在只支持mobile`预设。此预设的示例可在线获取。

#### studies\_overrides

使用此选项自定义默认指示器的样式或输入。 您还可以使用此参数自定义`Compare`系列的样式和输入。 查看更多[here](https://github.com/tradingview/charting_library/wiki/Studies-Overrides)

#### time\_frames

在图表底部的时间框架选择器中可以看见这个时间框架列表。 例：

```
time_frames: [
    { text: "50y", resolution: "6M", description: "50 Years" },
    { text: "3y", resolution: "W", description: "3 Years", title: "3yr" },
    { text: "8m", resolution: "D", description: "8 Month" },
    { text: "3d", resolution: "5", description: "3 Days" },
    { text: "1000y", resolution: "W", description: "All", title: "All" },
]
```

时间框架是一个包含`text`和`resolution属性的对象。文本必须具有以下格式：<integer><y|m|d>`\( \d+\(y\|m\|d\) 为正则表达式 \). 分辨率是具有通用分辨率格式的字符串. 请参阅本主题[this topic](https://github.com/tradingview/charting_library/wiki/Time-Frames)了解有关时间框架的更多信息。在1.7中添加了描述属性，并显示在弹出菜单中。此参数是可选的（如果时间框架描述符不包含此属性：title（如果指定）或使用）。title属性在1.9中添加，此值将覆盖从text属性生成的默认标题。 此参数是可选的。

#### charts\_storage\_url, client\_id, user\_id

这些参数是有关于高阶图表的保存/加载。 查看更多细节[here](https://github.com/tradingview/charting_library/wiki/Saving-and-Loading-Charts).

#### charts\_storage\_api\_version

您的后台版本。支持的值:`"1.0"`\|`"1.1"`。 指标模板从`1.1`开始得到支持。

#### load\_last\_chart

将此参数设置为`true`如果您希望库加载用户的最后一张图表（您也应该具有\[save/load\|Saving-and-Loading-Charts\]）。

#### custom\_css\_url \(since 1.4\)

将您的自定义CSS添加到图表中。url应该是到'static\`文件夹的绝对或相对路径。

#### favorites

默认支持该项目。此选项需要禁用localstorage的使用（请参阅功能集列表[featuresets](https://github.com/tradingview/charting_library/wiki/Featuresets)以了解更多\)。`favorites`property 为一个对象，拥有以下属性：

* **intervals\(间隔\)**: 收藏的间隔数组。 例：`["D", "2D"]`
* **chartTypes\(图表类型\)**: 收藏的图表类型数组 。图表类型名称与图表的UI中的英文版本相同。 例:`["Area", "Candles"]`
  .

## ![](../images/trading.png)交易终端专属

#### ![](../images/trading.png)组件工具栏

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

#### ![](../images/trading.png)rss\_news\_feed

使用此属性更改RSS新闻。 您可以为每个商品类型设置不同的rss，或为每个商品使用一个rss。 对象将拥有`default`属性，其他属性是可选的; 它们的名字为商品的类型. 每个属性都拥有一个对象\(或对象数组\) 并且具有以下属性:

1. `url`请求的URL。 它可以包含以下花括号中的标签（将会被终端所更改）：`{SYMBOL}`,`{TYPE}`,`{EXCHANGE}。`
2. `name 在每一个新闻的底部显示一个反馈。`

例:

```
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

```
{
    "default": {
        url: "https://articlefeeds.nasdaq.com/nasdaq/symbols?symbol={SYMBOL}",
        name: "NASDAQ"
    }
}
```

更多例子:

```
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

#### ![](../images/trading.png)news\_provider

代表新闻提供者的对象。 它可能包含以下属性：

1. `is_news_generic`- 如果为`true`新闻小部件的标题将不会有产品名称 \(只是`Headlines`\). 否则`SYMBOL_NAME`将会被添加。

2. `get_news`- 使用此属性设置自己的新闻 getter 方法.`symbol`和`callback`将会传递给此方法。

   回调函数将被调用，并且传递一下结构的新闻对象:

   1. `title`\(required\) - 新闻项目标题。
   2. `published`\(required\) - 新闻项目时间（以ms为单位）
   3. `source`\(optional\) - 标题的新闻项目来源。
   4. `shortDescription`\(optional\) - 将显示的新闻项目的简短说明。
   5. `link`\(optional\) - 新闻故事的URL 
   6. `fullDescription`\(optional\) - 新闻项目的完整描述（正文）

   **注意:**当用户点击新闻项目时，将打开带有`link`URL的新标签页。 如果没有指定`link`，将显示带有`fullDescription`的对话框弹出窗口。

   **注意2:**如果它设置为`rss_news_feed`则将会被忽略.

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

#### ![](../images/trading.png)trading\_controller

交易控制器是一个能使您的交易活跃起来的东西。[Read more](https://github.com/tradingview/charting_library/wiki/Trading-Controller).

```js
new TradingView.widget({
    /* ... */
    trading_controller: new MyTradingController()
});
```

# See Also

* [Customization Overview](https://github.com/tradingview/charting_library/wiki/Customization-Overview)
* [Widget Methods](https://github.com/tradingview/charting_library/wiki/Widget-Methods)
* [Featuresets](https://github.com/tradingview/charting_library/wiki/Featuresets)
* [Saving and Loading Charts](https://github.com/tradingview/charting_library/wiki/Saving-and-Loading-Charts)
* [Overriding Studies' Defaults](https://github.com/tradingview/charting_library/wiki/Studies-Overrides)
* [Overriding Chart's Defaults](https://github.com/tradingview/charting_library/wiki/Overrides)



