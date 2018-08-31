# [周期](#周期)

周期或时间周期是K线的时间段。 图表库支持日内周期(seconds, minutes, hours) and DWM 周期 (daily, weekly, monthly)。图表库API有很多方法用以接收和返回周期。

### 日内

#### 秒

格式: `xS`, 条件 `x` 为数字类型的秒数。
例如: 1S - 1秒, 2S - 2秒, 100S - 100秒。

#### 分钟

格式: `x`, 条件 `x` 为数字类型的分钟数。
例如: 1 - 1分钟, 2 - 2分钟, 100 - 100分钟。

#### 小时

**重要:** 用户界面允许用户输入几个小时，格式为 `xh` 或 `xH`, 它永远不会传递给API。小时必须使用图表库API中的分钟数来设置。

例如: 60 - 1小时, 120 - 2小时, 240 - 4小时.

### DWM

#### 天（Days）

格式: `xD`, 条件 `x` 为数字类型的天数。
例如: 1D - 1天, 2D - 2天, 100D - 100天。

#### 周（Weeks）

格式: `xW`, 条件 `x` 为数字类型的周数。
例如: 1W - 1周, 2W - 2周, 100W - 100周。

#### 月（Months）

格式: `xM`, 条件 `x` 为数字类型的月数。
例如: 1M - 1个月, 2M - 2个月, 100M - 100个月。

#### 年

年是使用月数设置的。
例如: 12M - 1年, 24M - 2年, 48 - 4年。

#### 也可以看看

[如何设置图表上可用周期的列表](JS-Api.md#supportedresolutions)

[如何设置产品支持的周期列表](Symbology.md#supportedresolutions)

[在图表上设置初始周期](Widget-Constructor.md#interval)

[获取当前图表周期](Chart-Methods.md#resolution)

[更改图表的周期](Chart-Methods.md#setresolutionresolutioncallback)