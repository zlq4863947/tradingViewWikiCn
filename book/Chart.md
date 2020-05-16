## 默认商品和周期

更改默认商品和分辨率（时间间隔）。

支持的最小分辨率为1秒。

[symbol, interval](Widget-Constructor.md#symbol-interval)

## 默认可见范围（时间范围）

更改K线默认分辨率的时间范围

[timeframe](Widget-Constructor.md#timeframe)

## 分辨率的默认可见范围

用户更改K线分辨率的时间范围时的事件。 此处提供示例：

[onIntervalChanged()](Chart-Methods.md#onintervalchanged)

## 初始时区

您可以设置默认时区。 用户可以在菜单中更改它。

[timezone](Widget-Constructor.md#timezone)

## 图表颜色

自定义图表的颜色，使其与您的网站设计相匹配。

1. [工具栏颜色](Toolbars.md)
1. 图表颜色修改 初始- [覆盖](Widget-Constructor.md#overrides), 运行时 - [图表样式属性](Chart-Style-Properties.md)
1. [CSS颜色主题](CSS-Color-Themes.md)

## 图表的默认属性

您可以在属性对话框中更改任何可用的属性。

1. [初始](Widget-Constructor.md#overrides)
1. [运行时](Widget-Methods.md#applyoverridesoverrides)

## 显示/隐藏图表元素

如果您不需要某些图表元素（工具栏，按钮，其他控件），则可以将其隐藏。

1. 使用[功能集](Featuresets.md)可以显示/隐藏大多数图表元素
1. 您可以添加[自己的CSS](Widget-Constructor.md#custom_css_url)

## 收藏的 时间间隔/图表 样式

您可以选择默认情况下在顶部工具栏中显示的间隔和图表的样式。如果在[功能集](Featuresets.md)中启用了 `items_favoriting`，则用户将可以更改它。

[收藏](Widget-Constructor.md#favorites)

## 菜单中显示的分辨率

1. [分辨率的完整列表](JS-Api.md) 在数据Feed的配置中提供
1. 根据 [商品信息](Symbology.md) 在列表中启用或禁用分辨率
1. [调整收藏分辨率](Widget-Constructor.md#favorites)的初始列表

## 上下文菜单

您可以将新元素添加到上下文菜单，也可以隐藏现有项目。

[onContextMenu(callback)](Widget-Methods.md#oncontextmenucallback)
