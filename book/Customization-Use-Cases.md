# 定制的使用案例

图表库允许您自定义外观、数据显示的方式、默认属性等等。

客户端和服务端的定制， 其中一些是通过构造函数，其他的可以使用widget或图表方法实现。

这里是唯一可以找到最常用的定制链接和描述的地方。

#### 默认仪表和周期

更改默认商品和周期。

最小支持的周期为1秒。

[文档说明](/book/Widget-Constructor.md#symbol-interval-mandatory)

#### 默认可见范围 \(时间范围\)

更改默认周期K线的时间范围

[文档说明](/book/Widget-Constructor.md#timeframe)

#### 周期的默认可见范围

当用户更改周期时，更改K线的时间范围。 看这里的样本：

[文档说明](/book/Chart-Methods.md#onintervalchanged)

#### 初始时区

您可以设置默认使用的时区。 用户也可以在菜单中更改。

[文档说明](/book/Widget-Constructor.md#timezone-)

#### 图表大小

您可以将图表作为元素放置在网页上或使用全屏模式。

[宽度和高度](/book/Widget-Constructor.md#width-height)

[全屏模式](/book/Widget-Constructor.md#fullscreen)

[自动尺寸](/book/Widget-Constructor.md#autosize)

#### 图表颜色

自定义图表的颜色，使其完美适合您的网站。

1. 工具栏颜色 - [文档说明](/book/Widget-Constructor.md#toolbar)
2. 图表颜色 - [文档说明](/book/Widget-Constructor.md#overrides)

#### 指标

1. 限制1个图表布局的指标量 -  [文档说明](/book/Widget-Constructor.md#studycountlimit)
2. 限制显示和可以添加的指标 - [文档说明](/book/Widget-Constructor.md#studiesaccess)
3. 在服务器上添加您自己的指标 - [文档说明](/book/Creating-Custom-Studies.md)
4. 更改指标的默认属性 - [文档说明](/book/Widget-Constructor.md#studiesoverrides)
5. 更改默认属性（立即生效） - [文档说明](/book/Widget-Methods.md#applystudiesoverridesoverrides)

#### 绘图

1. 限制哪些绘图可以被显示或被添加 - [文档说明](/book/Widget-Constructor.md#drawingsaccess)
2. 更改绘图的默认属性 - [文档说明](/book/Widget-Constructor.md#overrides)
3. 更改默认属性（立即生效） - [文档说明](/book/Widget-Methods.md#applyoverridesoverrides)

#### 语言

选择图表库20多个翻译中的一个。[文档说明](/book/Widget-Constructor.md#locale)

注意：语言是在创建图表时设置的。如果没有重新创建图表，就无法更改。

#### 数字和日期的格式化

1. 更改十进制数字 - [文档说明](/book/Widget-Constructor.md#numericformatting)
2. 为数据和时间设置自定义格式化方法 - [文档说明](/book/Widget-Constructor.md#customformatters)
3. 价格根据商品信息进行格式化 - [文档说明](/book/Symbology.md#minmov最小波动-pricescale价格精度-minmove2-fractional分数)

#### 图表的默认属性

您可以更改属性对话框中显示的任何属性。

1. 初始化 - [文档说明](/book/Widget-Constructor.md#overrides)
2. 立即生效 - [文档说明](/book/Widget-Methods.md#applyoverridesoverrides)

#### 服务器的快照

TradingView允许您在其服务器上保存快照，但如果您希望您也可以更改它。

[文档说明](/book/Widget-Constructor.md#snapshoturl)

#### 显示/隐藏图表的元素

如果您不需要图表的某些元素 \(工具栏、按钮或其他控件\), 您可以隐藏它们。

1. 大多数图表元素可以通过[功能集](/book/Featuresets.md)使用shown/hidden 
2. 您可以添加自己的CSS - [文档说明](/book/Widget-Constructor.md#loadlastchart)

#### 图表底部的时间范围

时间范围是K线的时间段和优先显示时段的周期。 您可以自定义列表。  
[文档说明](/book/Widget-Constructor.md#timeframes)

#### 收藏的周期/图表样式的初始化列表

默认情况下，您可以选择在顶部工具栏上显示什么周期和图表样式。如果在 [功能集](/book/Featuresets.md)中设置`items_favoriting` 为 enabled，则允许用户改变他们。

[文档说明](/book/Widget-Constructor.md#favorites)

#### 菜单中显示周期

1. 在datafeed的配置对象中提供了完整的周期列表 -[文档说明](/book/JS-Api.md#supportedresolutions)
2. 根据商品信息在列表中启用或禁用周期 - [文档说明](/book/Symbology.md#supportedresolutions)
3. 可以设置喜欢的周期的初始列表 - [文档说明](/book/Widget-Constructor.md#favorites)

#### 成交量指标

尽管有其他指标，如果仪表支持，则默认添加成交量指标 [文档说明](/book/Symbology.md#hasnovolume)。  
您可以禁用此特性 [功能集](/book/Featuresets.md)

#### 上下文菜单

您可以向上下文菜单添加新元素或隐藏现有项目。

[文档说明](/book/Widget-Methods.md#oncontextmenucallback)

#### 定制工具栏上的按钮

您可以将自己的按钮添加到图表的顶部工具栏上。

[文档说明](/book/Widget-Methods.md#createbuttonoptions)

#### ![](/images/trading.png)观察列表

可以为观察列表选择默认商品，并根据需要设置只读状态。

[文档说明](/book/Widget-Constructor.md#组件工具栏)

#### ![](/images/trading.png)新闻资讯

您可以附加任何RSS订阅，甚至可以根据金融工具类型选择feed。

[文档说明](/book/Widget-Constructor.md#rssnewsfeed)

