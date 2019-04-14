## 窗格Api

### hasMainSeries()

如果窗格包含主系列，则返回`true`。

### getLeftPriceScale()

返回[价格坐标Api](Price-Scale-Api.md)的实例，它允许您与左侧价格坐标进行交互。

### getRightPriceScale()

返回[价格坐标Api](Price-Scale-Api.md)的实例，它允许您与右侧价格坐标进行交互。

### getMainSourcePriceScale()

返回:

* [价格坐标Api](Price-Scale-Api.md)的一个实例，它允许您与主窗口的价格坐标进行交互
* 如果主窗口未附加到任何价格格坐标，则为`null` (处于“无比例”模式)
