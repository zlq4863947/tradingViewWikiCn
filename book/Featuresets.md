# 功能集
`功能`或`功能集`是图表功能的一部分。有简单（原子）和复杂（复合）特征。 复杂特征由简单特征组成。 禁用复合功能会使得其所有简单的部件都被禁用。 支持的功能如下所示。

请注意，下表中的`-`字符不是功能集名称的一部分。

### 控件和其他视觉元素的可见性

[**互动地图的功能**](http://tradingview.github.io/featuresets.html)

| ID                                      | 默认状态 | 库版本 | 描述                                                |
|-----------------------------------------|---------------|-----------------|-------------|
| **header_widget**                       | on            |                 |                                                            |
| - header_widget_dom_node                | on            |                 | 禁用此功能会隐藏头部小部件DOM元素 |
| - header_symbol_search                  | on            |                 |                                                            |
| - symbol_search_hot_key                 | on            |       1.9       | 商品搜索按键                              |
| - header_resolutions                    | on            |                 |                                                            |
| - - header_interval_dialog_button       | on            |                 |                                                            |
| - - - show_interval_dialog_on_key_press | on            |                 |                                                            |
| - header_chart_type                     | on            |                 |                                                            |
| - header_settings                       | on            |                 | 涉及图表属性按钮                         |
| - header_indicators                     | on            |                 |                                                            |
| - header_compare                        | on            |                 |                                                            |
| - header_undo_redo                      | on            |                 |                                                            |
| - header_screenshot                     | on            |                 |                                                            |
| - header_fullscreen_button              | on            |                 |                                                            |
| compare_symbol                          | on            |       1.5       | 您可以使用此功能集从上下文菜单中删除“比较/覆盖”对话框 |
| border_around_the_chart                 | on            |                 |                                                            |
| header_saveload                         | on            |                 | 它不是`header_widget`的一部分                    |
| left_toolbar                            | on            |                 |                                                            |
| control_bar                             | on            |                 | 涉及底部的导航按钮            |
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
| show_chart_property_page                | on            | 1.6             | 关闭禁用属性        |
| chart_property_page_scales              | on            |                 |                                           |
| chart_property_page_background          | on            |                 |                                           |
| chart_property_page_timezone_sessions   | on            |                 |                                           |
| chart_property_page_trading             | on            |                 | 它只适用于交易终端          |
| countdown                               | on            | 1.4             | 倒计时标签价格规模        |
| caption_buttons_text_if_possible        | off           | 1.4             | 在可能的情况下，在标题中的“指标”和“比较”按钮上显示文字而不是图标|
| dont_show_boolean_study_arguments       | off           | 1.4             | 是否隐藏指标参数 |
| hide_last_na_study_output               | off           | 1.4             | 隐藏最后一次指标输出        |
| symbol_info                             | on            | 1.5             | 商品信息对话框                 |
| timezone_menu                           | on            | 1.5             | 商品信息对话框禁用时区上下文菜单   |
| snapshot_trading_drawings               | off           | 1.6             | 包含屏幕截图中的订单/位置/执行信号 |
| source_selection_markers                | on            | 1.11            | 禁用数据列和指标指示器的选择标记 |
| keep_left_toolbar_visible_on_small_screens | off            | 1.11            | 防止左侧工具栏在小屏幕上消失 |

### 元素放置

| ID                           | 默认状态 | 库版本 | 描述                                                        |
|------------------------------|---------------|-----------------|--------------------------------------------------------------------|
| move_logo_to_main_pane       | off           |                 | 将标志放在主数据列窗格上，而不是底部窗格 |
| header_saveload_to_the_right | off           |                 | 向右移动保存并加载按钮                           |

### 行为

| ID	| 默认状态	| 库版本 | 描述
|-------|---------------|-----------------|------------
| **use_localstorage_for_settings**	| on	|                 | 允许将用户设置保存到localstorage
| - items_favoriting	| on	|                 | 禁用此功能会隐藏所有“收藏此项目”按钮
| - save_chart_properties_to_local_storage	| on	|                 | 禁用此功能可防止将图表属性（颜色，样式，字体）保存到本地存储，但仍保存最喜欢的项目
| create_volume_indicator_by_default	| on	|                 |
| create_volume_indicator_by_default_once | on |                  |
| volume_force_overlay	| on	|                 | 在与主数据列相同的窗格中放置成交量指示器
| right_bar_stays_on_scroll	| on	|                 | determines zoom behavior: bar under cursor is kept if disabled
| constraint_dialogs_movement	| on	|                 | 阻止从图表中移动对话框
| charting_library_debug_mode	| off	|                 | 启用日志
| show_dialog_on_snapshot_ready	| on	|                 | 禁用此功能允许您以静默方式进行快照
| study_market_minimized	| on	|                 | 涉及“指标”对话框，确定它是否紧凑或包含搜索栏和类别
| study_dialog_search_control   | on    | 1.6             | 在指标对话框中显示搜索对话框
| side_toolbar_in_fullscreen_mode	| off	|                 | 使用此功能，您可以在全屏模式下启用绘图工具栏
| same_data_requery             | off   |                 | 允许您使用相同的商品调用`setSymbol`来刷新数据
| disable_resolution_rebuild    | off   |                 | 显示的时间与DataFeed提供的时间完全一致，而不进行对齐。 如果您希望图表构建一些分辨率，则不建议使用此方法。
| chart_scroll                  | on    |   1.10          | 允许滚动图表
| chart_zoom                    | on    |   1.10          | 允许缩放图表
| high_density_bars             | off   |   1.11          | 允许缩小在1个屏幕上显示超过60000条个K线
| cl_feed_return_all_data       | off   |   1.11          | 允许您从Feed中返回更多的条，并立即在图表上显示

### "大岩石"

| ID	| 默认状态	| 库版本 | 描述
|-------|---------------|-----------------|------------
| study_templates | off | |
| datasource_copypaste | on | | 允许复制图纸和研究
| seconds_resolution| off | 1.4 | 支持秒分辨率


## :chart: 交易终端

| ID	| Default State	| 终端版本 | 描述
|-------|---------------|------------------|------------
| support_multicharts | on | | 启用与多图表布局相关的上下文菜单操作（克隆，同步）
| header_layouttoggle | on | | 显示标题中的“选择布局”按钮
| show_logo_on_all_charts | off | |在多功能布局的每个图表上显示徽标
| chart_crosshair_menu    | on  | 1.7 |在价格范围内启用"加号"按钮进行快速交易
| add_to_watchlist | on | 1.9 | 在菜单中启用“添加商品到监视列表”项
| footer_screenshot | on | 1.11 | 显示页脚中的截图按钮（客户经理）
| open_account_manager | on | 1.11 | 默认情况下保留客户经理的打开
