`Feature` or `featureset` means a part of chart's functionality. There are simple (atomic) and complex (composite) features. Composite feature consists of simple features. Disabling composite feature makes all of its simple parts to be disabled. Supported features are listed below.

Please note that the leading `-` characters are not a part of featureset name in the table below.

### Visibility of controls and other visual elements

[**Interactive Map of Featuresets**](http://tradingview.github.io/featuresets.html)

| ID                                      | Default State | Library Version | Description                                                |
|-----------------------------------------|---------------|-----------------|-------------|
| **header_widget**                       | on            |                 |                                                            |
| - header_widget_dom_node                | on            |                 | disabling this feature hides the header widget DOM element |
| - header_symbol_search                  | on            |                 |                                                            |
| - symbol_search_hot_key                 | on            |       1.9       | symbol search by a key press                               |
| - header_resolutions                    | on            |                 |                                                            |
| - - header_interval_dialog_button       | on            |                 |                                                            |
| - - - show_interval_dialog_on_key_press | on            |                 |                                                            |
| - header_chart_type                     | on            |                 |                                                            |
| - header_settings                       | on            |                 | relates to Chart Properties button                         |
| - header_indicators                     | on            |                 |                                                            |
| - header_compare                        | on            |                 |                                                            |
| - header_undo_redo                      | on            |                 |                                                            |
| - header_screenshot                     | on            |                 |                                                            |
| - header_fullscreen_button              | on            |                 |                                                            |
| compare_symbol                          | on            |       1.5       | You can remove Compare/Overlay dialog from context menues using this featureset |
| border_around_the_chart                 | on            |                 |                                                            |
| header_saveload                         | on            |                 | yep, it's not a part of `header_widget`                    |
| left_toolbar                            | on            |                 |                                                            |
| control_bar                             | on            |                 | relates to the navigation buttons at the bottom            |
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
| main_series_scale_menu                  | on            |       1.7       | Displays settings button in the bottom right corner of the chart |
| display_market_status                   | on            |                 |                                                            |
| remove_library_container_border         | on            |                 |                                           |
| chart_property_page_style               | on            |                 |                                           |
| property_pages                          | on            | 1.11            | Disable all property pages                |
| show_chart_property_page                | on            | 1.6             | Turning it off disables Properties        |
| chart_property_page_scales              | on            |                 |                                           |
| chart_property_page_background          | on            |                 |                                           |
| chart_property_page_timezone_sessions   | on            |                 |                                           |
| chart_property_page_trading             | on            |                 | it is for trading terminal only           |
| countdown                               | on            | 1.4             | countdown label on a price scale         |
| caption_buttons_text_if_possible        | off           | 1.4             | shows text instead of icons on Indicators and Compare buttons in header when possible|
| dont_show_boolean_study_arguments       | off           | 1.4             | hides true/false studies arguments |
| hide_last_na_study_output               | off           | 1.4             | hides last n/a study output        |
| symbol_info                             | on            | 1.5             | Symbol Info dialog                 |
| timezone_menu                           | on            | 1.5             | Disables time zone context menu    |
| snapshot_trading_drawings               | off           | 1.6             | Includes orders/positions/executions in the screenshot |
| source_selection_markers                | on            | 1.11            | Disables selection markers for series and indicators |
| keep_left_toolbar_visible_on_small_screens | off            | 1.11            | Prevents left toolbar disappearing on small screens |

### Elements placement

| ID                           | Default State | Library Version | Description                                                        |
|------------------------------|---------------|-----------------|--------------------------------------------------------------------|
| move_logo_to_main_pane       | off           |                 | Places the logo on the main series pane instead of the bottom pane |
| header_saveload_to_the_right | off           |                 | Moves Save and Load buttons to the right                           |

### Behavior

| ID	| Default State	| Library Version | Description
|-------|---------------|-----------------|------------
| **use_localstorage_for_settings**	| on	|                 | allows to save user settings to the local storage
| - items_favoriting	| on	|                 | disabling this feature hides all "Favorite this item" buttons
| - save_chart_properties_to_local_storage	| on	|                 | disabling this feature prevents saving of chart properties (colors, styles, fonts) to the local storage, but still keeps saving of favorite items
| create_volume_indicator_by_default	| on	|                 |
| create_volume_indicator_by_default_once | on |                  |
| volume_force_overlay	| on	|                 | places Volume indicator on the same pane with the main series
| right_bar_stays_on_scroll	| on	|                 | determines zoom behavior: bar under cursor is kept if disabled
| constraint_dialogs_movement	| on	|                 | prevents moving dialogs out of the chart
| charting_library_debug_mode	| off	|                 | enables logs
| show_dialog_on_snapshot_ready	| on	|                 | disabling this feature allows you to make a snapshot silently
| study_market_minimized	| on	|                 | relates to Indicators dialog, determines whether it is compact or contains a search bar and categories
| study_dialog_search_control   | on    | 1.6             | displays search control in the indicators dialog
| side_toolbar_in_fullscreen_mode	| off	|                 | using this feature you can enable Drawings Toolbar in fullscreen mode
| same_data_requery             | off   |                 | allows you to call `setSymbol` with the same symbol to refresh the data
| disable_resolution_rebuild    | off   |                 | Shows bars time exactly as it is provided by a datafeed without aligning. Strictly not recommended if you expect the chart to build some resolutions.
| chart_scroll                  | on    |   1.10          | Allows scrolling of a chart
| chart_zoom                    | on    |   1.10          | Allows zooming of a chart
| high_density_bars             | off   |   1.11          | Allows zooming out to show more than 60000 bars on 1 screen
| cl_feed_return_all_data       | off   |   1.11          | Allows you to return more bars from the feed and display it on a chart at once

### "Big Rocks"

| ID	| Default State	| Library Version | Description
|-------|---------------|-----------------|------------
| study_templates | off | |
| datasource_copypaste | on | | enables copying of drawings and studies
| seconds_resolution| off | 1.4 | enables seconds resolution support


## :chart: Trading Terminal

| ID	| Default State	| Terminal Version | Description
|-------|---------------|------------------|------------
| support_multicharts | on | | enables context menu actions (Clone, Sync) related to Multiple Chart Layout
| header_layouttoggle | on | | shows Select Layout button in the header
| show_logo_on_all_charts | off | |shows logo on every chart of multichart layout
| chart_crosshair_menu    | on  | 1.7 |Enables "plus" button on the price scale for quick trading
| add_to_watchlist | on | 1.9 | Enabled "Add symbol to Watchlist" item in the menu
| footer_screenshot | on | 1.11 | Shows a screenshot button in the footer (account manager)
| open_account_manager | on | 1.11 | Keeps Account Manager opened by default
