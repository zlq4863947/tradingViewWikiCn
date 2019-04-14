## 价格坐标Api

### getMode()

返回价格坐标的当前[模式](#pricescalemode) 。

### setMode(newMode)

1. `newMode` - 为价格坐标创建新[模式](#pricescalemode)

改变价格坐标的当前模式。

## 原始类型

### PriceScaleMode

以下为价格坐标的可用模式:

* `0` - 价格坐标的正常模式
* `1` - 价格坐标的对数模式
* `2` - 价格坐标的百分比模式
* `3` - 索引到价格坐标的100模式