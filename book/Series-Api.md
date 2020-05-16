## 数据列API

### isUserEditEnabled()

返回 `true` 表示用户可以 删除/更改/隐藏 主数据列。

### setUserEditEnabled(enabled)

1. `enabled` - `true` 或 `false`

启用或禁用用户 删除/更改/隐藏 主数据列。

### mergeUp()

向上合并主数据列（如果可能）。

### mergeDown()

向下合并主数据列（如果可能）。

### unmergeUp()

取消向上合并主数据列（如果可能）。

### unmergeDown()

取消向下合并主数据列（如果可能）。

### detachToRight()

将主要系列固定在右侧的新价格轴上。

### detachToLeft()

将主要系列固定在左侧的新价格轴上。

### detachNoScale()

使主要系列成为叠加数据源。

### changePriceScale(priceScale)

1. `priceScale` 是具有以下值之一的字符串：
    * `"new-left"` - 将主要系列附加到新的左侧价格刻度
    * `"new-right"` - 将主要系列附加到新的左侧价格刻度
    * `entityId` - 将主要系列固定在与指标相同的价格轴上的指标 `id` 

更改主要系列的价格刻度。

### isVisible()

主系列是否可见。

### setVisible(value)

1. `value` - `true` 或 `false`

设置主数据列显示/隐藏。

### bringToFront()

置顶主数据列放置在其他图表对象之上。

### sendToBack()

将主数据列放置在其他图表对象后面。

### chartStyleProperties(chartStyle)

1. `chartStyle` - number

返回指定[图表样式](Chart-Methods#setChartTypetype)的属性。有关返回的对象，请参见[本文](Chart-Style-Properties.md)。

### setChartStyleProperties(chartStyle, newPrefs)

设置指定图表样式的属性。

1. `chartStyle` - number
1. `newPrefs` - object

`newPrefs` 是[图表样式](Chart-Methods.md#setcharttypetype)属性的子集。
请参阅[本文](Chart-Style-Properties.md)以获取指定图表样式的属性的可用值。
