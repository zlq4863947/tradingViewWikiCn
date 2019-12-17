## 窗格 Api

### hasMainSeries()

如果窗格包含主系列，则返回`true`。

### getLeftPriceScales()

返回[价格刻度 Api](Price-Scale-Api.md)的实例数组，它允许您与左侧价格刻度进行交互。
如果窗格左侧没有任何价格刻度，则改数组可能为空。

### getRightPriceScales()

返回[价格刻度 Api](Price-Scale-Api.md)的实例数组，它允许您与右侧价格刻度进行交互。
如果窗格右侧没有任何价格刻度，则改数组可能为空。

### getMainSourcePriceScale()

返回:

- [价格刻度 Api](Price-Scale-Api.md)的一个实例，它允许您与主窗口的价格刻度进行交互
- 如果主窗口未附加到任何价格格刻度，则为`null` (处于“无比例”模式)

### getHeight()

*从1.15版开始*

返回窗格的高度。

### setHeight()

*从1.15版开始*

Sets the pane's height.

### paneIndex()

*从1.15版开始*

返回窗格的索引，它是0到所有窗格计数-1之间的数字。

### moveTo(paneIndex)

*从1.15版开始*

将窗格移动到新位置，`paneIndex`应该是介于0和所有窗格计数-1之间的数字。
