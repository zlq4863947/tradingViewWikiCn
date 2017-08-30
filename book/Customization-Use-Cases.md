# 定制的使用案例

图表库允许您自定义其外观，显示数据的方式，默认属性和许多其他事情。

定制为客户端和服务器端。 其中一些是通过构造函数，其他的可以使用小部件/图表方法。

这里是唯一可以找到最常用的自定义链接和描述的地方。

#### 默认仪表和分辨率

更改默认商品（仪表）和分辨率（间隔）。

最小支持的分辨率为1秒。

[文档说明](/book/Widget-Constructor.md#symbol-interval-mandatory)

#### 默认可见范围 \(时间框架\)

更改默认分辨率K线的时间范围

[文档说明](/book/Widget-Constructor.md#timeframe)

#### 分辨率的默认可见范围

当用户更改分辨率时，更改K线的时间范围。 看这里的样本：

[文档说明](/book/Chart-Methods.md#onintervalchanged)

#### 初始时区

您可以设置默认使用的时区。 用户也可以在菜单中更改。

[文档说明](/book/Widget-Constructor.md#timezone-)

#### 图表大小

您可以将图表作为元素放置在网页上或使用全屏模式。

[宽度和高度](/book/Widget-Constructor.md#width-height)

[全屏模式](/book/Widget-Constructor#fullscreen-)

[自动尺寸](/book/Widget-Constructor#autosize-)

#### 图表颜色

自定义图表的颜色，使其完美适合您的网站。

1. 工具栏颜色](/book/Widget-Constructor.md#width-height)\[\[documentation\|Widget-Constructor\#toolbar\_bg\]\]
2. 图表颜色 - \[\[documentation\|Widget-Constructor\#overrides\]\]

#### Indicators

1. Limit amount of indicators for 1 chart layout - \[\[documentation\|Widget-Constructor\#study\_count\_limit\]\]
2. Limit what indicators are displayed and can be added - \[\[documentation\|Widget-Constructor\#studies\_access\]\]
3. Add your own indicators calculated on a server - \[\[documentation\|Creating-Custom-Studies\]\]
4. Change default properties of indicators - \[\[documentation\|Widget-Constructor\#studies\_overrides\]\]
5. Change default properties on the fly - \[\[documentation\|Widget-Methods\#applystudiesoverridesoverrides\]\]

#### Drawings

1. Limit what drawings are displayed and can be added - \[\[documentation\|Widget-Constructor\#drawings\_access\]\]
2. Change default properties of drawings - \[\[documentation\|Widget-Constructor\#overrides\]\]
3. Change default properties on the fly - \[\[documentation\|Widget-Methods\#applyoverridesoverrides\]\]

#### Language

Choose one of more than 20 translations of the library

\[\[documentation\|Widget-Constructor\#locale\]\]

Note: Language is set when the chart is created. It cannot be changed without recreating of a chart.

#### Formatting of numbers and dates

1. Change decimal sign of numbers - \[\[documentation\|Widget-Constructor\#numeric\_formatting\]\]
2. Set custom formatters for data and time - \[\[documentation\|Widget-Constructor\#customformatters\]\]
3. Prices are formatted according to the symbol information - \[\[documentation\|Symbology\#pricescale-minmov\]\]

#### Default properties of a chart

You can change any properties that present in the properties dialog.

1. Initially - \[\[documentation\|Widget-Constructor\#overrides\]\]
2. On the fly - \[\[documentation\|Widget-Methods\#applyoverridesoverrides\]\]

#### Server for snapshots

TradingView allows you to save snapshot on its servers, but if you wish you can change it.

\[\[documentation\|Widget-Constructor\#snapshot\_url\]\]

#### Show/hide elements of the chart

If you don't need some elements of the chart \(toolbars, buttons, other controls\), you can hide them:

1. Most of the chart elements can be shown/hidden by using \[\[Featuresets\]\]
2. You can add your own CSS - \[\[documentation\|Widget-Constructor\#custom\_css\_url-since-14\]\]

#### Time frames at the bottom of the chart

Time frame is a time period of bars and a resolution preferred for displaying of the period. You can customize the list.

\[\[documentation\|Widget-Constructor\#time\_frames\]\]

#### Initial list of favorite intervals / chart styles

You can select what intervals and chart styles should be shown on the top toolbar by default. A user can change it if `items_favoriting` is enabled in the \[\[Featuresets\]\].

\[\[documentation\|Widget-Constructor\#favorites\]\]

#### Resolutions displayed in the menu

1. Full list of resolution is provided in the configuration of the datafeed - \[\[documentation\|JS-Api\#supported\_resolutions\]\]
2. Resolutions are enabled or disabled in the list basing on the symbol information - \[\[documentation\|Symbology\#supported\_resolutions\]\]
3. Initial list of favorite resolutions can be set - \[\[documentation\|Widget-Constructor\#favorites\]\]

#### Volume indicator

In spite of other indicators Volume is added by default if the instrument supports it \(\[\[documentation\|Symbology\#has\_no\_volume-\]\]\).  
You can disable this behaviour using \[\[documentation\|Featuresets\]\].

#### Context menu

You can add new elements to the context menu or hide existing items.

\[\[documentation\|Widget-Methods\#oncontextmenucallback\]\]

#### Custom buttons on the toolbar

You can add your own buttons to the top toolbar of the chart.

\[\[documentation\|Widget-Methods\#createbuttonoptions\]\]

#### :chart: Watch list

It is possible to choose default symbols for the watch list and set read-only state if needed.

\[\[documentation\|Widget-Constructor\#chart-widgetbar\]\]

#### :chart: News feed

You can attach to any RSS feed and even select the feed depending on the instrument type.

\[\[documentation\|Widget-Constructor\#chart-rss\_news\_feed\]\]

