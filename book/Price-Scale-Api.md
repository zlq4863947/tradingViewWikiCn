## 价格刻度 Api

### getMode()

返回价格刻度的当前[模式](#pricescalemode) 。

### setMode(newMode)

1. `newMode` - 为价格刻度创建新[模式](#pricescalemode)

改变价格刻度的当前模式。

### isInverted()

_v1.15 开始_

返回价格刻度是否反转。

### setInverted(isInverted)

_v1.15 开始_

1. `isInverted` - 设置价格刻度的新反转状态。

改变价格刻度为当前的倒置状态。

## 原始类型

### PriceScaleMode

以下为价格刻度的可用模式:

- `0` - 价格刻度的正常模式
- `1` - 价格刻度的对数模式
- `2` - 价格刻度的百分比模式
- `3` - 索引到价格刻度的 100 模式
