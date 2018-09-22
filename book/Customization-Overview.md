# 定制概述

---

定制是一个相当模糊的概念，所以写几篇文章对它进行说明。

## [通过数据流定制](#通过数据流定制)

他们最关心的是数据相关的东西。定制的配置可以通过datafeed响应来实现。响应配置实例：

```javascript
{
    supports_search: true,
    supports_group_request: false,
    supports_marks: true,
    exchanges: [
        {value: "", name: "All Exchanges", desc: ""},
        {value: "XETRA", name: "XETRA", desc: "XETRA"},
        {value: "NSE", name: "NSE", desc: "NSE"}
    ],
    symbolsTypes: [
        {name: "All types", value: ""},
        {name: "Stock", value: "stock"},
        {name: "Index", value: "index"}
    ],
    supportedResolutions: [ "1", "15", "30", "60", "D", "2D", "3D", "W", "3W", "M", '6M' ]
};
```

在[JS API](/book/JS-Api.md#onreadycallback)可以找到更详细的说明。

## [在客户端进行定制](#在客户端进行定制)

允许您最大化的定制UI/UX。这些定制通过定义图表控件中的构造函数的参数完成。

图表控件构造函数调用的示例：

```javascript
var widget = new TradingView.widget({
    fullscreen: true,
    symbol: 'AA',
    interval: 'D',
    toolbar_bg: '#f4f7f9',
    allow_symbol_change: true,
    container_id: "tv_chart_container",
    datafeed: new Datafeeds.UDFCompatibleDatafeed("http://demo_feed.tradingview.com"),
    library_path: "charting_library/",
    locale: "en",
    drawings_access: { type: 'black', tools: [ { name: "Regression Trend" } ] },
    disabled_features: ["use_localstorage_for_settings", "volume_force_overlay"],
    enabled_features: ["move_logo_to_main_pane"],
    overrides: {
        "mainSeriesProperties.style": 0,
        "symbolWatermarkProperties.color" : "#944",
        "volumePaneSize": "tiny"
    },
    studies_overrides: {
        "bollinger bands.median.color": "#33FF88",
        "bollinger bands.upper.linewidth": 7
    },
    debug: true,
    time_frames: [
        { text: "50y", resolution: "6M" },
        { text: "1d", resolution: "5" },
    ],
    charts_storage_url: 'http://saveload.tradingview.com',
    client_id: 'tradingview.com',
    user_id: 'public_user',
    favorites: {
        intervals: ["1D", "3D", "3W", "W", "M"],
        chartTypes: ["Area", "Line"]
    }
});
```

详情参考：[Widget构造器](/book/Widget-Constructor.md)

# 也可以看看

* [Widget方法](/book/Widget-Methods.md)
* [定制的使用案例](/book/Customization-Use-Cases.md)



