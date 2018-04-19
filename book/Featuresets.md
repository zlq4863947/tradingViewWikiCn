# 功能集

---

`功能`或`功能集`是图表功能的一部分。有简单（原子）和复杂（复合）特征。 复杂特征由简单特征组成。 禁用复合功能会使得其所有简单的部件都被禁用。 支持的功能如下所示。

请注意，下表中的`-`字符不是功能集名称的一部分。

### 控件和其他视觉元素的可见性

[**互动地图的功能**](http://tradingview.gitee.io/featuresets)

| ID | 默认状态 | 库版本 | 描述 |
| --- | --- | --- | --- |
| **header\_widget** | on |  |  |
| - header\_widget\_dom\_node | on |  | 禁用此功能会隐藏头部小部件DOM元素 |
| - header\_symbol\_search | on |  |  |
| - symbol\_search\_hot\_key | on | 1.9 | 商品搜索热键 |
| - header\_resolutions | on |  |  |
| - - header\_interval\_dialog\_button | on |  |  |
| - - - show\_interval\_dialog\_on\_key\_press | on |  |  |
| - header\_chart\_type | on |  |  |
| - header\_settings | on |  | 涉及图表属性按钮 |
| - header\_indicators | on |  |  |
| - header\_compare | on |  |  |
| - header\_undo\_redo | on |  |  |
| - header\_screenshot | on |  |  |
| - header\_fullscreen\_button | on |  |  |
| compare\_symbol | on | 1.5 | 您可以使用此功能集从上下文菜单中删除“比较/覆盖”对话框 |
| border\_around\_the\_chart | on |  |  |
| header\_saveload | on |  | 它不是`header_widget`的一部分 |
| left\_toolbar | on |  |  |
| control\_bar | on |  | 涉及底部的导航按钮 |
| timeframes\_toolbar | on |  |  |
| **edit\_buttons\_in\_legend** | on |  |  |
| - show\_hide\_button\_in\_legend | on | 1.7 |  |
| - format\_button\_in\_legend | on | 1.7 |  |
| - study\_buttons\_in\_legend | on | 1.7 |  |
| - delete\_button\_in\_legend | on | 1.7 |  |
| **context\_menus** | on |  |  |
| - pane\_context\_menu | on |  |  |
| - scales\_context\_menu | on |  |  |
| - legend\_context\_menu | on |  |  |
| main\_series\_scale\_menu | on | 1.7 | 显示图表右下角的设置按钮 |
| display\_market\_status | on |  |  |
| remove\_library\_container\_border | on |  |  |
| chart\_property\_page\_style | on |  |  |
| property\_pages | on | 1.11 | 禁用所有属性页 |
| show\_chart\_property\_page | on | 1.6 | 关闭禁用属性 |
| chart\_property\_page\_scales | on |  |  |
| chart\_property\_page\_background | on |  |  |
| chart\_property\_page\_timezone\_sessions | on |  |  |
| chart\_property\_page\_trading | on |  | 它只适用于交易终端 |
| countdown | on | 1.4 | 倒计时标签价格规模 |
| caption\_buttons\_text\_if\_possible | off | 1.4 | 在可能的情况下，在标题中的“指标”和“比较”按钮上显示文字而不是图标 |
| dont\_show\_boolean\_study\_arguments | off | 1.4 | 是否隐藏指标参数 |
| hide\_last\_na\_study\_output | off | 1.4 | 隐藏最后一次指标输出 |
| symbol\_info | on | 1.5 | 商品信息对话框 |
| timezone\_menu | on | 1.5 | 商品信息对话框禁用时区上下文菜单 |
| snapshot\_trading\_drawings | off | 1.6 | 包含屏幕截图中的订单/位置/执行信号 |
| source\_selection\_markers | on | 1.11 | 禁用数据列和指标指示器的选择标记 |
| keep\_left\_toolbar\_visible\_on\_small\_screens | off | 1.11 | 防止左侧工具栏在小屏幕上消失 |
| go_to_date | on | 1.11 | 允许您使用'Go to'对话框跳转到任意K线|
| adaptive_logo | on | 1.11 | 允许您在小屏幕设备上通过 'charts by TradingView' text on small-screen devices |
| show_dom_first_time | off | 1.12 | Shows DOM panel when a user opens the Chart for the first time |
| hide_left_toolbar_by_default | off | 1.12 | Hides left toolbar when a user opens the Chart for the first time |

### 元素放置

| ID | 默认状态 | 库版本 | 描述 |
| --- | --- | --- | --- |
| move\_logo\_to\_main\_pane | off |  | 将标志放在主数据列窗格上，而不是底部窗格 |
| header\_saveload\_to\_the\_right | off |  | 向右移动保存并加载按钮 |

### 行为

| ID | 默认状态 | 库版本 | 描述 |
| --- | --- | --- | --- |
| **use\_localstorage\_for\_settings** | on |  | 允许将用户设置保存到localstorage |
| - items\_favoriting | on |  | 禁用此功能会隐藏所有“收藏此项目”按钮 |
| - save\_chart\_properties\_to\_local\_storage | on |  | 禁用此功能可防止将图表属性（颜色，样式，字体）保存到本地存储，但仍保存最喜欢的项目 |
| create\_volume\_indicator\_by\_default | on |  |
| create\_volume\_indicator\_by\_default\_once | on |  |
| volume\_force\_overlay | on |  | 在与主数据列相同的窗格中放置成交量指示器 |
| right\_bar\_stays\_on\_scroll | on |  | 确定缩放行为：禁用光标下的K现 |
| constraint\_dialogs\_movement | on |  | 阻止从图表中移动对话框 |
| charting\_library\_debug\_mode | off |  | 启用日志 |
| show\_dialog\_on\_snapshot\_ready | on |  | 禁用此功能允许您以静默方式进行快照 |
| study\_market\_minimized | on |  | 涉及“指标”对话框，确定它是否紧凑或包含搜索栏和类别 |
| study\_dialog\_search\_control | on | 1.6 | 在指标对话框中显示搜索对话框 |
| side\_toolbar\_in\_fullscreen\_mode | off |  | 使用此功能，您可以在全屏模式下启用绘图工具栏 |
| same\_data\_requery | off |  | 允许您使用相同的商品调用`setSymbol`来刷新数据 |
| disable\_resolution\_rebuild | off |  | 显示的时间与DataFeed提供的时间完全一致，而不进行对齐。 如果您希望图表构建一些分辨率，则不建议使用此方法。 |
| chart\_scroll | on | 1.10 | 允许滚动图表 |
| chart\_zoom | on | 1.10 | 允许缩放图表 |
| high\_density\_bars | off | 1.11 | 允许缩小在1个屏幕上显示超过60000条个K线 |
| cl\_feed\_return\_all\_data | off | 1.11 | 允许您从Feed中返回更多的条，并立即在图表上显示 |

### 大石块\(Big Rocks\)

| ID | 默认状态 | 库版本 | 描述 |
| --- | --- | --- | --- |
|  | study\_templates | off |  |
| datasource\_copypaste | on |  | 允许复制图纸和研究 |
| seconds\_resolution | off | 1.4 | 支持秒分辨率 |

## ![](/images/trading.png)交易终端

| ID | 默认状态 | 终端版本 | 描述 |
| --- | --- | --- | --- |
| support\_multicharts | on |  | 启用与多图表布局相关的上下文菜单操作（克隆，同步） |
| header\_layouttoggle | on |  | 显示标题中的“选择布局”按钮 |
| show\_logo\_on\_all\_charts | off |  | 在多功能布局的每个图表上显示徽标 |
| chart\_crosshair\_menu | on | 1.7 | 在价格范围内启用"加号"按钮进行快速交易 |
| add\_to\_watchlist | on | 1.9 | 在菜单中启用“添加商品到观察列表”项 |
| footer\_screenshot | on | 1.11 | 显示页脚中的截图按钮（客户经理） |
| open\_account\_manager | on | 1.11 | 默认情况下保留客户经理的打开 |



<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc3NDM0MDIyMSwtMTIyNzY0MTc5NV19
-->