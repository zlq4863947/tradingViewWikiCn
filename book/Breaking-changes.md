# 版本变更点

我们将尽最大努力使每个新版本与前一版本完全兼容，但有时重大的更改需要您在升级到新版本时对代码进行微小的更改。

_注意：您可以通过在浏览器控制台中执行 `TradingView.version()` 来检查图表库版本。_

以下是重大变更列表：

## Version 21

- 功能集`show_dialog_on_snapshot_ready` 已被删除。 [takeScreenshot](Widget-Methods.md#takescreenshot) 静默生成快照，因此您可以使用 [onScreenshotReady](Widget-Methods.md#subscribeevent-callback) 回调中的 URL 来显示您自己的对话框。

- [SymbolInfo](Symbology.md) 中的字段 `holidays` 已重命名为 [`session_holidays`](Symbology.md#session_holidays)。

**交易终端**

- `empty` 格式化方法已被删除。

- 标记 `durationForMarketOrders` 已从 Broker 配置 `configFlags` 对象中删除。 要对市价订单使用持续时间，请将适当的订单类型添加到 `supportedOrderTypes` 数组。

- `supportReducePosition` 标志已从 Broker 配置 `configFlags` 对象中删除。

- 已添加`supportExecutions` 标志。 如果经纪人支持执行，您需要将标志设置为 `true`。

- [SortingParameters](Account-Manager.md#sortingparameters) 的 `asc` 字段的默认值已更改为 `true`。

- `customFormatters` 字段已从 [accountManagerInfo](Broker-API.md#accountManagerInfo) 中删除。

- `id`、`modificationProperty`、`fixedWidth`、`showOnMobile` 和`showTooltipOnCell` 字段已从[Account Manager 列描述](Account-Manager.md#Column-description) 中删除。 `property` 字段已变为必填字段，因此您可以使用它代替 `id`。

- 每个 [table](Account-Manager.md#Table) 行中的字符串 `id` 字段已变为必填字段。

- [Broker API](Broker-API.md)中`placeOrder`方法的返回值由`Promise<void>`改为[Promise\<PlaceOrderResult\>](Trading-Objects-and-Constants.md#PlaceOrderResult)。

- `AccountManagerInfo` 接口中`contextMenuActions` 中的`contextMenuEvent` 类型已从`MouseEvent` 更改为`MouseEvent | TouchEvent`。

- [Widget Constructor options](Widget-Constructor.md#news_provider) 中`news_provider` 属性已更改。 `is_news_generic` 和 `get_news` 属性已被替换为单个函数。

## Version 20

- 功能集 `caption_buttons_text_if_possible` 已被移除并被新参数替换 [`header_widget_buttons_mode`](Widget-Constructor.md#header_widget_buttons_mode)

- 功能集 `high_density_bars` 已被移除并替换为 `min_bar_spacing`, 这是 [`time_scale`](Widget-Constructor.md#time_scale) 的一个新参数。

- 指标 `Moving Average Modified` 已被删除。 改用`Smoothed Moving Average`。 请注意，`length` 输入的默认值是不同的。


**交易终端**

- `unixTimeAgo` 格式化方法已被删除。
  
- [Account Manager](Account-Manager.md) 格式化方法的属性`$container: JQuery` 已替换为`container: HTMLElement`。格式化方法将返回`string | HTMLElement` 而不是 `string | jQuery`。

- 选项`showOrderPanel`、`showDOM` 和`showSellBuyButtons` 已从`defaultDropdownMenuActions` 选项列表中删除。

- 方法`getOrderDialogOptions` 的返回值变为 Promise。
- [交易主机](Trading-Host.md) `symbolSnapshot` 方法已被删除。

- `cancellingBracketCancelsParentOrder` 和 `cancellingOnePositionBracketsCancelsOther` 标志已被删除。它们可以部分替换为 `supportCancellingBothBracketsOnly` 标志。
  
## Version 19

_注意：container_id 已被标记为已弃用。现在应更改为 container 。 container 现在可以仍然是一个 id，也可以是您希望将widget添加到的 HTMLElement。_
  
- [crossHairMoved](Chart-Methods.md#crossHairMoved) 已从 _callback_ 参数更改为具有 `Subscription` 模型的 `crossHairMoved()`。
  它仍然会返回相同的对象`params: {time, price}`。

**交易终端**

- [交易主机](Trading-Host.md)`defaultDropdownMenuActions` 选项已更改。选项`selectAnotherBroker` 和`disconnect` 已被删除。

- [交易主机](Trading-Host.md) 中方法`buttonDropdownActions` 的返回值已从`BindPopupMenuActionDescription[]` 更改为[ActionMetaInfo](Trading-Objects-and-Constants.md#ActionMetaInfo) 数组。

- `orderDialogOptions` 对象已从Broker的配置中删除。请使用`getOrderDialogOptions` 方法自定义订单对话框。
- `className` 字段已从 [Account Manager 列描述](Account-Manager.md#Column-description) 中删除。使用 [alignment](Account-Manager.md#alignment) 字段来控制单元格值的对齐方式。
- 商品信息中的`force_session_rebuild` 字段已被删除

- [getBars](JS-Api.md#getbarssymbolinfo-resolution-periodparams-onhistorycallback-onerrorcallback) 参数的数量和类型已更改 - `from`、`to` 和 `firstDataRequest` 参数已合并到 `periodParams` 对象中。
  要快速切换到新版本，需要替换如下代码:
  
    ```javascript
        // ...

        getBars(symbolInfo, resolution, from, to, onHistoryCallback, onErrorCallback, firstDataRequest) {
            // 你的代码
        }

        // ...
    ```

  改为以下代码:

    ```javascript
        // ...

        getBars(symbolInfo, resolution, periodParams, onHistoryCallback, onErrorCallback) {
            let { from, to, firstDataRequest } = periodParams;
            // 你的代码
        }

        // ...
    ```
- [getBars](JS-Api.md#getbarssymbolinfo-resolution-periodparams-onhistorycallback-onerrorcallback) 中的`to` 日期从现在开始将不包含在k线范围中。 `from` 日期仍然包含在内。这意味着您不应该在响应中包含带有 `time == to` 的k线。

- 自定义指标中`ctx.new_sym` 方法的参数已更改，现在您不需要传递第三个参数（它可能会破坏指标）。
  要快速解决此问题，请找到 `new_sym` 方法的所有用例，并确保仅将 2 个参数传递给它（而不是三个或更多）。
  例如，如果您之前有 `ctx.new_sym(newSym, PineJS.Std.period(this._context), PineJS.Std.period(this._context))`，则需要将其替换为 `ctx.new_sym(newSym, PineJS.Std.period(this._context))`。

- 移除了 [JS-Api](JS-Api) 中的 `calculateHistoryDepth` 方法。请改用 [`countBack`](JS-Api.md#note-about-periodparams)。
  
## Version 18

- [configurationData](JS-Api.md#onreadycallback) 中的字段`futures_regex` 已被删除，请改用[symbols_grouping](JS-Api.md#symbols_grouping)。

**交易终端**

- `AccountManagerInfo` 接口中`contextMenuActions` 中的`contextMenuEvent` 类型已从JQueryEventObject 更改为MouseEvent。

- `accountsList` 和 `account` 已从 Account Manager 信息中删除。他们已替换为方法： `currentAccount`, `setCurrentAccount` 和 `accountsMetainfo` 在 broker's API.

- 方法 `fullUpdate` 在Trading Host中已重命名为 `currentAccountUpdate`.

- 方法 `showClosePositionDialog` 已被删除。

- [Trading Host](Trading-Host.md) 方法 `floatingTradingPanelVisibility` 被重命名为 `sellBuyButtonsVisibility`.

- [Trading Host](Trading-Host.md) `defaultDropdownMenuActions` 选项已更改。选项 `showFloatingToolbar` 已重命名为 `showSellBuyButtons`。
  
- 标志`supportOrderPreview` 已重命名为`supportPlaceOrderPreview`。
  
- 方法 [setPoints](Shape-Api.md#setpointspoints) 的作用与 [createMultipointShape](Chart-Methods.md#createmultipointshapepoints-options) 方法相同。 以前，它可以更改其他一些属性，例如width，而不是将点移动到新位置。

## Version 17

- 订单返回值已区分为 [orders](Broker-API.md#orders-promiseorder) 和 [ordersHistory](Broker-API.md#ordershistory-promiseorder)。
- [Widget方法](Widget-Methods.md) `setLanguage(locale)` 已被删除。
- `onIntervalChanged` 事件的参数已被修改: `timeframe` 字段的类型已更改为 [TimeFrameValue](Chart-Methods.md#onIntervalChanged)。
- 功能集 `same_data_requery` 已被删除, 请使用 [resetData() 方法](Chart-Methods.md#resetdata) 刷新数据。
- `charting_library/charting_library.min.js` 和 `charting_library/charting_library.min.d.ts` 重命名为 `charting_library/charting_library.js` 和 `charting_library/charting_library.d.ts`。
- 现在，默认情况下，用户可以撤消图表方法 [removeEntity](Chart-Methods.md#removeentityentityid-options) 要禁用此功能，请在`options`使用 `disableUndo` 字段。

**交易终端**

- `supportBottomWidget` 标记已从Broker配置 `configFlags` 对象中删除。要删除 Account Manager 请使用功能集 `trading_account_manager`。

## Version 16（更改版本）

- 动作 `tmzProperties` 从 [executeActionById](Chart-Methods.md#executeactionbyidactionid) 和 [getCheckableActionState](Chart-Methods.md#getcheckableactionstateactionid) 方法中被删除。
- 图表方法 `createStudy` 的 `options`参数中的 `priceScale` 发生变化。 `left` 和 `right` 重命名为 `new-left` 和 `new-right`。 `options`参数中增加 `entityId`, 它将指标和具有相应 `id` 的指标锁定在同一价格轴上。
- 数据列API方法 `moveToOtherSourceScale` 重命名为 `changePriceScale`。`options`参数中 `new-left` 和 `new-right`。
- 指标API方法 `changePriceScale` 的 `options`参数中的 `priceScale` 发生变化。 `left` 和 `right` 重命名为 `new-left` 和 `new-right`。 `options`参数中增加 `entityId`, 它将指标和具有相应 `id` 的指标锁定在同一价格轴上。

- Widget的方法 `applyOverrides` 禁用于 "mainSeriesProperties.priceAxisProperties.*"。

- Widget的方法 `createStudy` 现在可以被用户撤销。您可以使用 `options` 中的 `disableUndo` 禁用。

## Version 1.15

- 功能集的 `show_logo_on_all_charts` 被删除。
- 功能集的 `cl_feed_return_all_data` 被删除。
- 动作 `magnetAction` 从 [executeActionById](Chart-Methods.md#executeactionbyidactionid) 和 [getCheckableActionState](Chart-Methods.md#getcheckableactionstateactionid) 中被删除。 使用 [magnetEnabled](Widget-Methods.md#magnetenabled) 代替。
- [createStudy](Chart-Methods.md#createstudyname-forceoverlay-lock-inputs-overrides-options) 的 `callback` 参数被删除。
- [createStudy](Chart-Methods.md#createstudyname-forceoverlay-lock-inputs-overrides-options) 返回值使用 [Promise](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) 代替 `entityId`。
- [Pane-Api](Pane-Api.md) 的方法 `getLeftPriceScale` 被替换为 `getLeftPriceScales` 返回 scale 数组。
- [Pane-Api](Pane-Api.md) 的方法 `getRightPriceScale` 被替换为 `getRightPriceScales` 返回 scale 数组。
- [setVisibleRange](Chart-Methods#setvisiblerangerange-applydefaultrightmargin) 现在返回Promise对象，且删除之前的参数: `callback`回调函数
- 已使 [symbol](Widget-Constructor#symbol-interval)选项**优先级**高于[saved_data](Widget-Constructor#saved_data)选项。如果不想覆盖[saved_data](Widget-Constructor#saved_data)中的**symbol**,则不要为 [symbol](Widget-Constructor#symbol-interval)选择分配值。

**交易终端**

我们改变了经纪商的互动流程。请仔细阅读以下内容，以了解应在代码中进行哪些更改来切换到新版本。

到目前为止，当用户点击`买入/卖出/修改`按钮时，交易终端会调用代理适配器的方法 (例如: `placeOrder`, `modifyOrder`)。在调用这些方法时，交易终端会传递 `silently` 参数。 当 `silently` 设置为 `true` 时, 代理适配器可以在不显示对话框的情况下发送订单。当它被设置为 `false` 时, 代理适配器必须从 `host` 调用一个方法来显示订单窗口 (或仓位变更对话框)。

从 1.15 开始，交易终端单独显示所有对话框，并调用代理适配器的方法向代理的服务器发送订单或头寸。这种变化的原因是我们添加了一个订单面板，可以随时用于下订单。
如果您使用自己的订单对话框，那么您仍然需要在代理适配器的方法中进行更改, 另外您需要使用 `metainfo` 参数将对话框构造函数传递给交易终端。

- 参数 `silently` 已从 [Broker API](Broker-API.md) 的这些方法: `placeOrder`, `modifyOrder`, `reversePosition`, `closePosition`, `closeTrade`, `cancelOrder`, `cancelOrders` 中删除。
- 参数 `handler` 和 `options` 从 [Trading Host](Trading-Host.md) 的 `showOrderDailog` 方法中被删除。
- 参数 `handler` 从 [Trading Host](Trading-Host.md) 的 `showPositionBracketsDailog` 方法中被删除。
- 标记 `supportCustomPlaceOrderTradableCheck` 不再被支持。
- 覆盖 `symbolWatermarkProperties` 不再被支持。 您可以使用 [settings_adapter](Widget-Constructor.md#settings_adapter) 的 `symbolWatermark` 。
- `indicators_file_name` 构造函数项目已被删除。 请改用 [custom_indicators_getter](Widget-Constructor#custom_indicators_getter) 。
  我们进行了此更改以加快图表库的加载速度，并消除在加载文件时可能发生的漏洞。
  您只需要将自定义指标的代码从JS文件移动到widget构造函数，将它们包装在函数和Promise对象中。

## Version 1.14

- [createButton](Widget-Methods.md#createButtonoptions) 返回 `HTMLElement` 以代替 `JQuery`.
- [createButton](Widget-Methods.md#createButtonoptions) 必须在 [headerReady()](Widget-Methods.md#headerready)返回的 `Promise` 为 resolved 之后使用.
- [getVisibleRange](Chart-Methods.md#getVisibleRange) 返回 UTC 时区的 `{from, to}` (之前返回的是图表选择的时区)。
- 方法 `onready` 被删除。 您可以使用 `window.addEventListener('DOMContentLoaded', callback, false)` 代替。
- [saveChartToServer](Widget-Methods.md#savecharttoserveroncompletecallback-onfailcallback-options)中 `saveAsSnapshot` 参数被删除。
- `indicators_file_name` 构造选项被删除。 请改用 [custom_indicators_getter](Widget-Constructor.md#custom_indicators_getter)。
  我们进行了此更改以加快图表库的加载并消除加载文件时可能发生的漏洞。
  您只需将自定义指标的代码从 JS 文件移动到 widget 构造函数，将它们包装在函数和 Promise 中。

**TypeScript 类型定义**

- `StudyInputValueType` 改名为 `StudyInputValue`.

**功能集**

- 从此版本开始，您将无法再使用`keep_left_toolbar_visible_on_small_screens`功能集。 此功能集已删除，左侧工具栏可见性不再取决于屏幕大小。

## Version 1.13

- 动作 `takeScreenshot` 从 [executeActionById](Chart-Methods.md#executeactionbyidactionid) 方法中被删除。 改用 [takeScreenshot](Widget-Methods.md#takescreenshot) 方法。
- 动作 `lockDrawingsAction` 从[executeActionById](Chart-Methods.md#executeactionbyidactionid) 和 [getCheckableActionState](Chart-Methods#getcheckableactionstateactionid) 方法中被删除。 改用[lockAllDrawingTools](Widget-Methods#lockalldrawingtools) 代替。
- 动作 `hideAllDrawingsAction` 从 [executeActionById](Chart-Methods.md#executeactionbyidactionid) 和 [getCheckableActionState](Chart-Methods#getcheckableactionstateactionid) 方法中被删除。 改用[hideAllDrawingTools](Widget-Methods#hidealldrawingtools) 代替。
- 功能集 `caption_buttons_text_if_possible` 默认开启。
- 修复一个[问题](https://github.com/tradingview/charting_library/issues/2652) 导致 K 线发生偏移。当日 K 线有一个负交易所时区偏移至 24x7 交易时段时，会出现 K 线的偏移。 如果您已通过变通方法解决此问题，请在更新此版本之前将其删除。

## Version 1.12

**图表库**

- `charting_library/charting_library.min.js` 现在为 [UMD](https://github.com/umdjs/umd) 通用模块规范。
  如果您只是将这个脚本嵌入到 HTML 中 - 没有任何改变。
  但是，如果将它作为模块导入，则应该直接导入它的`widget`，`version`和`onready`函数。

- `searchSymbolsByName` 从 `JS-API` 中移除, 使用 `searchSymbols` 代替。

指标覆盖:

- `Overlay` 的覆盖只能通过 `studies_overrides` (或运行时的 `applyStudiesOverrides` )。 在以前版本中您可以使用 `overrides` 和 `applyOverrides`). 参见 [指标覆盖](Studies-Overrides.md) 页.
- 从这个版本开始，您将不能再使用 `options` 关键字以覆盖 `showStudyArguments` 和 `showLastValue` 。

**交易终端**

- `hasHistory` flag 被删除。 使用 `historyColumns` 来显示账户管理器中的历史记录。

交易终端中仍然支持以下内容，但在未来的版本中将不再使用：:

- `subscribePL` 和 `unsubscribePL`。 每当损益变化时经纪商应该调用 `plUpdate` 方法。
- `supportDOM` 被删除。 DOM widget 的可见性可以使用 `dome_widget` 功能集。

**交易控制器被替换为[经纪商 API](Broker-API.md)**.

下列变更将让您的交易控制器实现迁移到新的经纪商 API:

- 方法 `setHost` 被删除。 主机将传递给经纪商 API 的构造函数。
- 方法 `buttonDropdownItems` 被删除。 经纪商 API 将使用 `setButtonDropdownActions` 更新[交易主机](Trading-Host.md)。
- 方法 `configFlags` 和 `durations` 被删除。 使用 [Widget 构造器](Widget-Constructor.md) 的字段代替。
- 全部方法返回 `$.Deferred` 的变为返回 Promise。
- 方法 `chartContextMenuItems` 重命名为 `chartContextMenuActions`。
- 方法 `isTradable` 变更为返回一个 Promise 的布尔值。
- 全部字符串常量 ("working", "buy" etc.) 被替换为数字常量
- 仓位的 `avg_price` 重命名为 `avgPrice`。
- `tradingController` 字段在 [Widget 构造器](Widget-Constructor.md) 被删除。 改用 `brokerFactory`。

## Version 1.11

**交易终端**

交易终端中仍然支持以下内容，但在未来的版本中将不再使用：

- `supportDOME` 重命名为 `supportDOM`
- 更改了 `showClosePositionDialog` 的签名
- `showEditBracketsDialog` 重命名为 `showPositionBracketsDialog`, 更改了签名。

## Version 1.10

- 更改成交量指标的默认特性。

先前的特性：在仪表或周期切换时，根据成交量支持选项来确定成交量指标的添加/删除。 您可以通过禁用`create_volume_indicator_by_default_once` 功能集来恢复到此特性。

新的特性：如果当前仪表支持成交量，则在空白图表的第一次加载时会添加成交量指标。

## Version 1.9

- 我们不再编译更多 Pine 脚本。您仍然可以使用以前编译过的脚本。

## Version 1.8 的交易终端

- 图表不可以只显示当前订单。适当的方法已被删除。
- `showOrderDialog` 输入参数时一个对象而不是列表
- `showSampleOrderDialog` 已被移除。 请使用 [showOrderDialog](Trading-Host.md#showorderdialogorder-handler) 代替。
- 在 [交易控制器](Trading-Controller.md) 中删除`showOrderDialog`, 使用 `placeOrder` 和 `modifyOrder` 接收 `silently` 参数。
- `reversePosition`, `closePosition`, `cancelOrder` 有一个额外的参数 `silently`. 从现在起他们有了自己的对话框。

## Version 1.7

- 从这个版本开始不能够用相同的商品代码调用 `setSymbol`。 您应该先从 `subscribeBars` 调用 `onResetCacheNeededCallback` 开始。 然后您才可以使用图表的 `setSymbol` 或 新的 `resetData` 方法。
- JSAPI 协议版本 1 不在被支持。必须提供 `nextTime` 和 `noData`。

## Version 1.5

- 添加 `source` 参数给 MACD. 您也可以通过创建代码传递 `source` 参数来改变 MACD 。
  `chartWidget.chart().createStudy('MACD', false, false, [12, 26, "close", 9])`

## Version 1.4

- 覆盖 `transparency` 不在被支持。 我们为每个颜色数据添加了透明度支持。 使用 `rgba` 来定义颜色的透明度。 例如:
  `"symbolWatermarkProperties.color" : "rgba(60, 70, 80, 0.05)"`

## Version 1.3

- 覆盖 `paneProperties.gridProperties.*` 不再被支持。
  请使用 `paneProperties.vertGridProperties.*` 和 `paneProperties.horzGridProperties.*`

- 覆盖 `mainSeriesProperties.candleStyle.wickColor` 不在被支持。
  请使用 `mainSeriesProperties.candleStyle.wickUpColor` 和 `mainSeriesProperties.candleStyle.wickDownColor`
  <!--stackedit_data:
  eyJoaXN0b3J5IjpbLTE2NjI1OTA2OTcsMTQwNTE3NDg5OSwtMT
  k3NjE4NjU5NSw1NDU2NDA0NjMsLTE1NTc2NzYzNTZdfQ==
  -->
