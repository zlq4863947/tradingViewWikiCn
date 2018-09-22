# 版本变更点

我们将尽最大努力使每个新版本与前一版本完全兼容，但有时重大的更改需要您在升级到新版本时对代码进行微小的更改。


_注意：您可以通过在浏览器控制台中执行 `TradingView.version()` 来检查图表库版本。_

以下是变更列表：

## Version 1.14

- [createButton](Widget-Methods.md#createButtonoptions) 返回 `HTMLElement` 以代替 `JQuery`.
- [createButton](Widget-Methods.md#createButtonoptions) 必须在 [headerReady()](Widget-Methods.md#headerready)返回的 `Promise` 为resolved之后使用.

**TypeScript 类型定义**

- `StudyInputValueType` 改名为 `StudyInputValue`.

**功能集**

- 从此版本开始，您将无法再使用`keep_left_toolbar_visible_on_small_screens`功能集。 此功能集已删除，左侧工具栏可见性不再取决于屏幕大小。

## Version 1.13

- 动作 `takeScreenshot` 从 [executeActionById](Chart-Methods.md#executeactionbyidactionid) 方法中被删除。 改用 [takeScreenshot](Widget-Methods.md#takescreenshot) 方法。
- 动作 `lockDrawingsAction` 从[executeActionById](Chart-Methods.md#executeactionbyidactionid) 和 [getCheckableActionState](Chart-Methods#getcheckableactionstateactionid) 方法中被删除。 改用[lockAllDrawingTools](Widget-Methods#lockalldrawingtools) 代替。
- 动作 `hideAllDrawingsAction` 从 [executeActionById](Chart-Methods.md#executeactionbyidactionid) 和 [getCheckableActionState](Chart-Methods#getcheckableactionstateactionid) 方法中被删除。 改用[hideAllDrawingTools](Widget-Methods#hidealldrawingtools) 代替。
- 功能集 `caption_buttons_text_if_possible` 默认开启。
- 修复一个[问题](https://github.com/tradingview/charting_library/issues/2652) 导致K线发生偏移。当日K线有一个负交易所时区偏移至24x7交易时段时，会出现K线的偏移。 如果您已通过变通方法解决此问题，请在更新此版本之前将其删除。

## Version 1.12

**图表库**

- `charting_library/charting_library.min.js` 现在为 [UMD](https://github.com/umdjs/umd) 通用模块规范。
如果您只是将这个脚本嵌入到HTML中 - 没有任何改变。
但是，如果将它作为模块导入，则应该直接导入它的`widget`，`version`和`onready`函数。

- `searchSymbolsByName` 从 `JS-API` 中移除, 使用 `searchSymbols` 代替。

指标覆盖:
-  `Overlay` 的覆盖只能通过 `studies_overrides` (或运行时的 `applyStudiesOverrides` )。 在以前版本中您可以使用 `overrides` 和 `applyOverrides`). 参见 [指标覆盖](Studies-Overrides.md) 页.
- 从这个版本开始，您将不能再使用 `options` 关键字以覆盖 `showStudyArguments` 和 `showLastValue` 。

**交易终端**

- `hasHistory` flag 被删除。 使用 `historyColumns` 来显示账户管理器中的历史记录。

交易终端中仍然支持以下内容，但在未来的版本中将不再使用：:
- `subscribePL` 和 `unsubscribePL`。 每当损益变化时经纪商应该调用 `plUpdate` 方法。
- `supportDOM` 被删除。 DOM widget 的可见性可以使用 `dome_widget` 功能集。

**交易控制器被替换为[经纪商API](Broker-API.md)**.

下列变更将让您的交易控制器实现迁移到新的经纪商API:
- 方法 `setHost` 被删除。 主机将传递给经纪商API的构造函数。
- 方法 `buttonDropdownItems` 被删除。 经纪商API将使用 `setButtonDropdownActions` 更新[交易主机](Trading-Host.md)。
- 方法 `configFlags` 和 `durations` 被删除。 使用 [Widget构造器](Widget-Constructor.md) 的字段代替。
- 全部方法返回 `$.Deferred` 的变为返回 Promise。
- 方法 `chartContextMenuItems` 重命名为 `chartContextMenuActions`。
- 方法 `isTradable` 变更为返回一个Promise的布尔值。
- 全部字符串常量 ("working", "buy" etc.) 被替换为数字常量
- 仓位的 `avg_price` 重命名为 `avgPrice`。
- `tradingController` 字段在 [Widget构造器](Widget-Constructor.md) 被删除。 改用 `brokerFactory`。

## Version 1.11

**交易终端**

交易终端中仍然支持以下内容，但在未来的版本中将不再使用：
- `supportDOME` 重命名为 `supportDOM`
- 更改了 `showClosePositionDialog` 的签名
- `showEditBracketsDialog` 重命名为 `showPositionBracketsDialog`, 更改了签名。


## Version 1.10
- 更改成交量指标的默认行为。

先前的行为：在仪表或周期切换时，根据成交量支持选项来确定成交量指标的添加/删除。 您可以通过禁用`create_volume_indicator_by_default_once` 功能集来恢复到此行为。

新的行为：如果当前仪表支持成交量，则在空白图表的第一次加载时会添加成交量指标。

## Version 1.9
- 我们不再编译更多Pine脚本。您仍然可以使用以前编译过的脚本。

## Version 1.8 的交易终端
-  图表不可以只显示当前订单。适当的方法已被删除。
- `showOrderDialog` 输入参数时一个对象而不是列表
- `showSampleOrderDialog` 已被移除。 请使用 [showOrderDialog](Trading-Host.md#showorderdialogorder-handler) 代替。
- 在 [交易控制器](Trading-Controller.md) 中删除`showOrderDialog`, 使用 `placeOrder` 和 `modifyOrder` 接收 `silently` 参数。
- `reversePosition`, `closePosition`, `cancelOrder` 有一个额外的参数 `silently`. 从现在起他们有了自己的对话框。

## Version 1.7

- 从这个版本开始不能够用相同的商品代码调用 `setSymbol`。 您应该先从 `subscribeBars` 调用 `onResetCacheNeededCallback` 开始。 然后您才可以使用图表的 `setSymbol` 或 新的 `resetData` 方法。
- JSAPI 协议版本 1 不在被支持。必须提供 `nextTime` 和 `noData`。

## Version 1.5

* 添加 `source` 参数给 MACD. 您也可以通过创建代码传递 `source` 参数来改变 MACD 。
`chartWidget.chart().createStudy('MACD', false, false, [12, 26, "close", 9])`

## Version 1.4

* 覆盖 `transparency` 不在被支持。 我们为每个颜色数据添加了透明度支持。 使用 `rgba` 来定义颜色的透明度。 例如: 
`"symbolWatermarkProperties.color" : "rgba(60, 70, 80, 0.05)"`

## Version 1.3

* 覆盖 `paneProperties.gridProperties.*` 不在被支持。
请使用 `paneProperties.vertGridProperties.*` 和 `paneProperties.horzGridProperties.*`

* 覆盖 `mainSeriesProperties.candleStyle.wickColor` 不在被支持。
请使用 `mainSeriesProperties.candleStyle.wickUpColor` 和 `mainSeriesProperties.candleStyle.wickDownColor`
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE2NjI1OTA2OTcsMTQwNTE3NDg5OSwtMT
k3NjE4NjU5NSw1NDU2NDA0NjMsLTE1NTc2NzYzNTZdfQ==
-->