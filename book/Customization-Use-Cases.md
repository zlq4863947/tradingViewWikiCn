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

1. 工具栏颜色 - [文档说明](/book/Widget-Constructor.md#toolbar)
2. 图表颜色 - [文档说明](/book/Widget-Constructor.md#overrides)

#### 指标

1. 限制1个图表布局的指标量 -  [文档说明](/book/Widget-Constructor.md##study_count_limit\)
2. 限制显示和可以添加的指标 - 文档说明\[\[documentation\|Widget-Constructor\#studies\_access\]\]
3. 在服务器上添加您自己的指标 - 文档说明\[\[documentation\|Creating-Custom-Studies\]\]
4. 更改指标的默认属性 - 文档说明\[\[documentation\|Widget-Constructor\#studies\_overrides\]\]
5. 更改默认属性（在云协作） - 文档说明\[\[documentation\|Widget-Methods\#applystudiesoverridesoverrides\]\]

#### 绘图

1. 限制显示和可以添加的绘图 - 文档说明\[\[documentation\|Widget-Constructor\#drawings\_access\]\]
2. 更改绘图的默认属性） - \文档说明[\[documentation\|Widget-Constructor\#overrides\]\]
3. 更改绘图默认属性（在运行中 - 文档说明\[\[documentation\|Widget-Methods\#applyoverridesoverrides\]\]

#### 语言

选择图表图书馆20多个翻译中的一个

\[\[documentation\|Widget-Constructor\#locale\]\]

注意：创建图表时设置语言。 如果没有重新创建图表，则无法更改。

#### 数字和日期的格式化

1. 更改十进制数字 - \[\[documentation\|Widget-Constructor\#numeric\_formatting\]\]
2. 为数据和时间设置自定义格式化方法 - \[\[documentation\|Widget-Constructor\#customformatters\]\]
3. 价格根据商品信息进行格式化 - \[\[documentation\|Symbology\#pricescale-minmov\]\]

#### 图表的默认属性

您可以更改属性对话框中显示的任何属性。

1. Initially - \[\[documentation\|Widget-Constructor\#overrides\]\]
2. On the fly - \[\[documentation\|Widget-Methods\#applyoverridesoverrides\]\]

#### 服务器的快照

TradingView允许您在其服务器上保存快照，但如果您希望更改它。

\[\[documentation\|Widget-Constructor\#snapshot\_url\]\]

#### 显示/隐藏图表的元素

如果您不需要图表的某些元素 \(toolbars, buttons, other controls\), 您可以隐藏它们。

1. 大多数图表元素可以通过使用shown/hidden \[\[Featuresets\]\]
2. 您可以添加自己的CSS - \[\[documentation\|Widget-Constructor\#custom\_css\_url-since-14\]\]

#### 图表底部的时间框架

时间框架是K线的时间段和优先显示时段的分辨率。 您可以自定义列表。
\[\[documentation\|Widget-Constructor\#time\_frames\]\]

#### 最喜欢的间隔/图表样式的初始列表

默认情况下，您可以选择在顶部工具栏上显示什么间隔和图表样式。用户可以改吗它们 如果 `items_favoriting` 为 enabled ,\[\[Featuresets\]\].

\[\[documentation\|Widget-Constructor\#favorites\]\]

#### 分辨率显示在菜单中

1. 在数据输入的配置中提供了完整的分辨率列表 -\[\[documentation\|JS-Api\#supported\_resolutions\]\]
2. 基于商品信息在列表中启用或禁用分辨率 - \[\[documentation\|Symbology\#supported\_resolutions\]\]
3. 可以设置喜欢的分辨率的初始列表 - \[\[documentation\|Widget-Constructor\#favorites\]\]

#### 成交量指示器

尽管有其他指示器，如果仪器支持，默认情况下会添加成交量 \(\[\[documentation\|Symbology\#has\_no\_volume-\]\]\).  
您可以禁用此行为 \[\[documentation\|Featuresets\]\].

#### 上下文菜单

您可以向上下文菜单添加新元素或隐藏现有项目。

\[\[documentation\|Widget-Methods\#oncontextmenucallback\]\]

#### 制订工具栏上的自定义按钮

您可以将自己的按钮添加到图表的顶部工具栏。

\[\[documentation\|Widget-Methods\#createbuttonoptions\]\]

#### :图表：观察列表

可以为观察列表选择默认符号，并根据需要设置只读状态。

\[\[documentation\|Widget-Constructor\#chart-widgetbar\]\]

#### 图表：新闻资讯

您可以附加到任何RSS订阅，甚至可以根据金融工具类型选择feed。

\[\[documentation\|Widget-Constructor\#chart-rss\_news\_feed\]\]

