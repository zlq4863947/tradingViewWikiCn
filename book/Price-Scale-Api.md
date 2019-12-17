## 价格刻度 Api

### getMode()

返回价格刻度的当前[模式](#pricescalemode) 。

### setMode(newMode)

1. `newMode` - 为价格刻度创建新[模式](#pricescalemode)

改变价格刻度的当前模式。

### isInverted()

*从1.15版开始*

返回价格刻度是否反转。

### setInverted(isInverted)

*从1.15版开始*

1. `isInverted` - 设置价格刻度的新反转状态。

改变价格刻度为当前的倒置状态。

### getVisiblePriceRange()

*从1.15版开始*

返回价格刻度的当前可见价格范围。返回是带有`from`和`to`的对象，这是价格刻度的可见范围的边界。

### setVisiblePriceRange(range)

*从1.15版开始*

设置当前价格刻度的可见价格范围，`range`是带有`from`和`to`的对象，这是价格刻度可见范围的边界。

## 原始类型

### PriceScaleMode

以下为价格刻度的可用模式:

- `0` - 价格刻度的正常模式
- `1` - 价格刻度的对数模式
- `2` - 价格刻度的百分比模式
- `3` - 索引到价格刻度的 100 模式
