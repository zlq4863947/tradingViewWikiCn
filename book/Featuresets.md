# 功能集

---

`功能`或`功能集`是图表功能的一部分。有简单（原子）和复杂（复合）特征。 复杂特征由简单特征组成。 禁用复合功能会使得其所有简单的部件都被禁用。 支持的功能如下所示。

请注意，下表中的`-`字符不是功能集名称的一部分。

### 控件和其他视觉元素的可见性

[**功能集互动地图**](http://tradingview.gitee.io/featuresets)


| ID                                      | 默认状态 | 版本 | 描述                                                |
|-----------------------------------------|---------------|-----------------|-------------|
| **header_widget**                       | on            |                 |                                                            |
| - header_widget_dom_node                | on            |                 | 隐藏头部小部件DOM元素 |
| - header_symbol_search                  | on            |                 |                                                            |
| - symbol_search_hot_key                 | on            |       1.9       | 按任意键进行商品搜索                             |
| - header_resolutions                    | on            |                 |                                                            |
| - - header_interval_dialog_button       | on            |                 |                                                            |
| - - - show_interval_dialog_on_key_press | on            |                 |                                                            |
| - header_chart_type                     | on            |                 |                                                            |
| - header_settings                       | on            |                 | 与图表属性按钮相关                         |
| - header_indicators                     | on            |                 |                                                            |
| - header_compare                        | on            |                 |                                                            |
| - header_undo_redo                      | on            |                 |                                                            |
| - header_screenshot                     | on            |                 |                                                            |
| - header_fullscreen_button              | on            |                 |                                                            |
| compare_symbol                          | on            |       1.5       | 您可以使用此功能集从上下文菜单中删除`比较/叠加`对话框 |
| border_around_the_chart                 | on            |                 |                                                            |
| header_saveload                         | on            |                 | 隐藏保存/加载按钮（该功能不是`header_widget`功能集的一部分）                    |
| left_toolbar                            | on            |                 |                                                            |
| control_bar                             | on            |                 | 与图表底部的导航按钮相关联            |
| timeframes_toolbar                      | on            |                 |                                                            |
| **edit_buttons_in_legend**              | on            |                 |                                                            |
| - show_hide_button_in_legend            | on            |       1.7       |                                                            |
| - format_button_in_legend               | on            |       1.7       |                                                            |
| - study_buttons_in_legend               | on            |       1.7       |                                                            |
| - delete_button_in_legend               | on            |       1.7       |                                                            |
| **context_menus**                       | on            |                 |                                                            |
| - pane_context_menu                     | on            |                 |                                                            |
| - scales_context_menu                   | on            |                 |                                                            |
| - legend_context_menu                   | on            |                 |                                                            |
| main_series_scale_menu                  | on            |       1.7       | 显示图表右下角的设置按钮 |
| display_market_status                   | on            |                 |                                                            |
| remove_library_container_border         | on            |                 |                                           |
| chart_property_page_style               | on            |                 |                                           |
| property_pages                          | on            | 1.11            | 禁用所有属性页                |
| show_chart_property_page                | on            | 1.6             | 关闭此功能会禁用`属性`        |
| chart_property_page_scales              | on            |                 |                                           |
| chart_property_page_background          | on            |                 |                                           |
| chart_property_page_timezone_sessions   | on            |                 |                                           |
| chart_property_page_trading             | on            |                 | 此功能仅适用于交易终端           |
| countdown                               | on            | 1.4             | 在价格标尺上显示倒计时标签         |
| caption_buttons_text_if_possible        | off           | 1.4             | 尽可能在标题和比较按钮上显示文本而不是图标|
| dont_show_boolean_study_arguments       | off           | 1.4             | 隐藏 true/false 指标参数 |
| hide_last_na_study_output               | off           | 1.4             | 隐藏最后的 n/a 指标输出数据        |
| symbol_info                             | on            | 1.5             | 启用商品信息对话框                 |
| timezone_menu                           | on            | 1.5             | 禁用时区上下文菜单   |
| snapshot_trading_drawings               | off           | 1.6             | 在截图中包括订单/头寸/成交 |
| source_selection_markers                | on            | 1.11            | 禁用数据列和指标的选择标记 |
| go_to_date | on            | 1.11            | 允许您使用`转到`对话框跳转到特定栏 |
| adaptive_logo | on            | 1.11            | 允许您在小屏幕设备上隐藏logo的`TradingView`文字 |
| show_dom_first_time                      | off           | 1.12            | 当用户第一次打开图表时显示DOM面板 |
| hide_left_toolbar_by_default             | off           | 1.12            | 当用户第一次打开图表时，隐藏左侧工具栏 |

### 元素放置

| ID                           | 默认状态 | 版本 | 描述                                                        |
|------------------------------|---------------|-----------------|--------------------------------------------------------------------|
| move_logo_to_main_pane       | off           |                 | 将logo放在主数据列窗格上而不是底部窗格 |

### 特性

| ID  | 默认状态 | 版本 | 描述
|-------|---------------|-----------------|------------
| **use_localstorage_for_settings** | on |                 | 允许将所有属性（包括收藏夹）存储到localstorage
| - items_favoriting | on |                 | 禁用此功能会隐藏所有“收藏此项目”按钮
| - save_chart_properties_to_local_storage | on |                 |  可以禁用以禁止将图表属性存储到localstorage，同时允许保存其他属性。 其他属性是收藏在图表库和Watchlist的商品，以及交易终端中的一些面板状态。
| create_volume_indicator_by_default | on |                 |
| create_volume_indicator_by_default_once | on |                  |
| volume_force_overlay | on |                 | 在主数据量列的窗格上放置成交量指标
| right_bar_stays_on_scroll | on |                 | 确定缩放功能的特性：如果禁用此功能，鼠标光标下的K线将保持在同一位置
| constraint_dialogs_movement | on |                 | 将对话框保留在图表中
| charting_library_debug_mode | off |                 | 启用日志
| show_dialog_on_snapshot_ready | on |                 | 禁用此功能允许您以静默方式创建快照
| study_market_minimized | on |                 | 与“指标”对话框相关，并确定它是否紧凑或包含搜索栏以及类别
| study_dialog_search_control   | on    | 1.6             | 在指标对话框中显示搜索控件
| side_toolbar_in_fullscreen_mode | off |                 | 可以在全屏模式下启用绘图工具栏
| same_data_requery             | off   |                 | 允许您使用相同的商品调用`setSymbol`来刷新数据
| disable_resolution_rebuild    | off   |                 | 显示完全由datafeed提供的K线时间而不进行任何调整。
| chart_scroll                  | on    |   1.10          | 允许图表滚动
| chart_zoom                    | on    |   1.10          | 允许图表缩放
| high_density_bars             | off   |   1.11          | 允许缩小以在单个屏幕上显示超过60000根K线
| cl_feed_return_all_data       | off   |   1.11          | 允许您从datafeed返回多于请求的K线，并同时在图表上显示
| uppercase_instrument_names    | on    | 1.12            | 禁用此功能允许用户输入区分大小写的商品
| no_min_chart_width            | off   | 1.14            | 禁用最小图表宽度限制
| fix_left_edge                 | off   | 1.14            | 阻止滚动到第一个历史K线的左侧
| lock_visible_time_range_on_resize | off   | 1.14        | 防止在图表调整大小时更改可见时区

### 重要功能

| ID | 默认状态 | 库版本 | 描述 |
| --- | --- | --- | --- |
| study\_templates | off |  |  |
| datasource\_copypaste | on |  | 允许复制绘图和指标 |
| seconds\_resolution | off | 1.4 | 支持秒的周期 |

## ![](/images/trading.png)交易终端

| ID | 默认状态 | 终端版本 | 描述
|-------|---------------|------------------|------------
| support_multicharts | on | | 启用与多图表布局相关的上下文菜单操作（克隆，同步）
| header_layouttoggle | on | | 显示标题中的“选择布局”按钮
| show_logo_on_all_charts | off | |在多功能布局的每个图表上显示logo
| chart_crosshair_menu    | on  | 1.7 |在价格范围内启用“加号”按钮以进行快速交易
| add_to_watchlist | on | 1.9 | 在菜单中启用“添加商品到观察列表”项
| footer_screenshot | on | 1.11 | 显示页脚中的截图按钮（账户管理器）
| open_account_manager | on | 1.11 | 默认打开账户管理器
| trading_notifications | on | 1.11 | 在图表上显示交易通知
| multiple_watchlists | on | 1.12 | 启用创建多个监视列表
| show_trading_notifications_history | on | 1.13 | 启用底部面板中的 "通知日志" 选项卡


<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzMzQxMDU1MzIsMTQ3ODk5OTM4NywtMT
IyNzY0MTc5NV19
-->