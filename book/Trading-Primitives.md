交易原语是一种低级机制，旨在为您提供对交易原语行为的最详细控制。

# 通用数据
### 属性
您可以对Trading Lines对象的某些属性使用特殊值 `inherit` 他们将使图书馆使用其属性的出厂默认值。您可以开启 `trading_options` 功能来显示交易界面。

您不能控制特定对象的可见性 - 位置，, orders and executions are available for user in Trading tab of Chart Properties window.

### 颜色和字体
您可以使用以下字符串格式设置颜色：

1. "#RGB"
2. "#RRGGBB"
3. "rgb(red, green, blue)"
4. "rgba(red, green, blue, alpha)"

您可以使用以下字符串格式设置字体： `<bold> <italic> <size>pt <family>`. 颜色和字体字符串将懂自动分析，以确定GUI控件的值。

### 线条样式

支持以下线条样式：

Style|Value
---|---
Solid|0
Dotted|1
Dashed|2

### 回调
1. 您用过 `this` 关键字从回调函数内访问API对象
2. 您可以将两个参数传递给回调注册函数 - 在这种情况下，第一个参数是将作为第一个参数传递给回调函数的对象（请参阅示例）。
3. 如果未设置回调，则相应的按钮将被隐藏（影响`onReverse`, `onClose` 和 `onCancel` c的回调).
