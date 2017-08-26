You may specify Charting library widget parameters when calling its constructor. E.g., your call may look like

```javascript
new TradingView.widget({
    symbol: 'A',
    interval: 'D',
    timezone: "America/New_York",
    container_id: "tv_chart_container",
    locale: "ru",
    datafeed: new Datafeeds.UDFCompatibleDatafeed("https://demo_feed.tradingview.com")
});
```

Find full supported parameters list below. Please remember that changing those parameters after chart is initialized **does not work**. If you want to change the state of a chart after it was initialized, use [[Widget methods|Widget-Methods]] instead.

Properties marked :chart: are available in [[Trading Terminal]] only.

#### symbol, interval [mandatory]
Initial symbol & interval of your chart. Format of `interval` is described in another [[article|Resolution]].

#### timeframe
Sets initial timeframe for the chart. Timeframe is period of bars that will be loaded and shown on a screen.
Valid timeframe is a number with letter D for days and M for months.

#### container_id [mandatory]
`id` attribute of a DOM element you want to contain the widget.

#### datafeed [mandatory]
JavaScript object implementing appropriate interface ([[JS API|JS-Api]]) to feed the chart width data.

#### timezone <UTC>
Initial timezone of the chart. Numbers on time scale depend on this timezone.
See [[supported timezones list|Symbology#timezone]] for available values. Set it to `exchange` to use the exchange timezone. For overriding default value you should use [[overrides|Widget-Constructor#overrides]] section

#### debug
Setting this property to `true` makes the chart to write detailed API logs to console. Feature `charting_library_debug_mode` is a synonym for this field usage.

#### library_path
A path to `static` folder

#### width, height
The desired size of a widget. Please make sure the widget has enough space to look smart.

**Remark**: if you want the chart to occupy all the available space, do not use '100%' in those field. Use `fullscreen` parameter instead (see below). It's because of issues with DOM nodes resizing in different browsers.

#### fullscreen <false>
Boolean value showing whether chart should occupy all the available space in the window.

#### autosize <false>
Boolean value showing whether chart should occupy all the available space in the container and resize with it is resized. This parameter is introduced in version 1.3.

#### symbol_search_request_delay
Delay in milliseconds to wait after key is pressed before making a symbol search request.

#### auto_save_delay
Delay in seconds to wait before onAutoSaveNeeded can be called again.
This parameter is introduced in version 1.5.

#### toolbar_bg
Toolbars background color

#### study_count_limit
**Since 1.5 version.**

Maximum amount of studies on a chart or multichart layout. Minimum value is 2.

#### studies_access
*version: 1.1*
An object with following structure:
```javascript
{
    type: "black" | "white",
    tools: [
        {
            name: "<study name>",
            grayed: true
        },
        < ... >
    ]
}
```
* `type` is a type of list. Supported values: `black` (all the listed items should be disabled), `white` (only the listed items should be enabled).
* `tools` is an array of objects. Each object could have following properties:
  * `name` (mandatory) is the name of a study. Use the same names as you can see them in Indicators widget
  * `grayed` is a boolean showing whether this study should be visible but look like it's disabled. If the study is grayed and user clicks it, then `onGrayedObjectClicked` is called.

#### drawings_access
*version: 1.1*
This property has the same structure as the `studies_access` described above. Use the same names as you see them in UI.
**Remark**: There is a special case for font-based drawings. Use "Font Icons" name for them. This group is a special case and its drawings cannot be enabled or disabled particularly -- one can either enable or disable the whole group.

#### saved_data
JS object containing saved chart content (JSON, see save/load calls below). Use this parameter if you already have chart's JSON when creating chart. If you want to load chart content to chart that is already initialized then use `loadData()` widget method.

#### locale
Locale to be used by Charting Library. See [[Localization]] section for details.

#### numeric_formatting
The object containing formatting options for numbers. The only possible options is `decimal_sign` for now.
Example: `numeric_formatting: { decimal_sign: "," }`

#### customFormatters
It is an object that contains the following fields:

1. timeFormatter
2. dateFormatter

You can use these formatters to customize displaying of date and time values.
Both values are objects with functions `format` and `formatLocal`:

```javascript
function format(date)
function formatLocal(date)
```

These functions should return text representing date or time. `formatLocal` should convert date and time to local timezone.

Example:

```javascript
customFormatters: {
  timeFormatter: {
    format: function(date) { var _format_str = '%h:%m'; return _format_str.replace('%h', date.getUTCHours(), 2). replace('%m', date.getUTCMinutes(), 2). replace('%s', date.getUTCSeconds(), 2); }
  },
  dateFormatter: {
    format: function(date) { return date.getUTCFullYear() + '/' + date.getUTCMonth() + '/' + date.getUTCDate(); }
  }
}
```

#### overrides
The object containing default Widget properties overrides. Overriding a property means assigning a default value to it.
You can override most of Charting Library properties (which also may be edited by user through UI) using `overrides` parameter of Widget constructor. `overrides` supposed to be an object having range of fields. Each field name is a name of overridden property and the field value is the desired value for those property. Example:

```javascript
overrides: {
    "symbolWatermarkProperties.color": "rgba(0, 0, 0, 0)"
}
```

This override will make the watermark 100% opaque (invisible). All customizable properties are listed in [[separate article|Overrides]]. Since 1.5 you can use [[Drawings-Overrides]].


#### disabled_features, enabled_features
The array containing names of features which should be enabled/disabled by default. `Feature` means a part of chart's functionality (more likely a part of UI/UX). Supported features are listed [[here|Featuresets]].
Example:
```javascript
TradingView.onready(function()
{
	var widget = new TradingView.widget({
		/* .... */
		disabled_features: ["header_widget", "left_toolbar"],
	});
});
```

#### snapshot_url
*experimental feature*
URL for POST request with base64-encoded chart snapshots which will been sent when user press snapshot button. The service should return full URL to saved image in its response.

#### indicators_file_name
Path to file containing your compiled indicators. See more details [[here|Creating-Custom-Studies]].

#### preset
`preset` is a name of a set of pre-defined widget settings. All settings used by preset also may be used directly by you in widget's constructor. For now, the only `mobile` preset is supported. The example of this preset is available online.

#### studies_overrides
Use this option to customize default indicators' style or inputs. You can also customize `Compare` series' styles and inputs using this argument. See more details [[here|Studies-Overrides]]

#### time_frames
List of time frames visible in timeframes picker at the bottom of the chart. Example:
```javascript
time_frames: [
    { text: "50y", resolution: "6M", description: "50 Years" },
    { text: "3y", resolution: "W", description: "3 Years", title: "3yr" },
    { text: "8m", resolution: "D", description: "8 Month" },
    { text: "3d", resolution: "5", description: "3 Days" },
    { text: "1000y", resolution: "W", description: "All", title: "All" },
]
```
Time frame is an object containing `text` and `resolution` property. Text must have following format: `<integer><y|m|d>` ( \d+(y|m|d) as Regex ). Resolution is a string having the common resolutions format. See [[this topic|Time-Frames]] to learn more about time frames.
The `description` property was added in 1.7 and it is displayed in the popup menu. This parameter is optional (if the time frame descriptor does not contain this property: `title` (if it is specified) or `text` is used).
The `title` property was added in 1.9 and this value will override default title generated from `text` property. This parameter is optional.

#### charts_storage_url, client_id, user_id
Those arguments are regarding high-level charts save/load. See more details [[here|Saving-and-Loading-Charts]].

#### charts_storage_api_version
A version of your backend. Supported values: `"1.0"` | `"1.1"`. Study Templates are supported starting from `1.1`

#### load_last_chart
Set this param to `true` if you want the library to load the last chart for a user (you also should have [save/load|Saving-and-Loading-Charts])

#### custom_css_url (since 1.4)
Adds your custom css to the chart. `url` should be absolute or relative path to 'static` folder

#### favorites
Items which should be favored by default. This option requires disabling localstorage usage(see [[featuresets |Featuresets]] list to know more). `favorites` property expects to be an object. Following properties are supported:

* **intervals**: an array of favored intervals. Example: `["D", "2D"]`
* **chartTypes**: an array of favored chart types. Chart types names are the same as you can see in chart's UI in english version. Example: `["Area", "Candles"]`.

## :chart: Trading Terminal only

#### :chart: widgetbar
The object containing settings for widget bar on the right side of chart. Data window, watchlist and details tabs in right-side widget bar could be enabled using widgetbar field in Widget constructor:
```javascript
widgetbar: {
    details: true,
    watchlist: true,
    watchlist_settings: {
        default_symbols: ["NYSE:AA", "NYSE:AAL", "NASDAQ:AAPL"],
        readonly: false
    }
}
```
* **details <false>**: Enables details widget in right-side widget bar.
* **watchlist <false>**: Enables watchlist widget in right-side widget bar.
* **watchlist_settings.default_symbols <[]>**: Sets default symbols list for watchlist.
* **watchlist_settings.readonly: Enables read-only mode for the watchlist.

#### :chart: rss_news_feed

Use this property to change rss feed for news. You can set a different rss for each symbol type or use one rss for every symbols. The object should have `default` property, the other properties are optional; their names are equal to symbol types. Each property is an object (or array of objects) with the following properties:

1. `url` - is an url to be requested. It can contain tags in curly braces which will be changed by the terminal: `{SYMBOL}`, `{TYPE}`, `{EXCHANGE}`.
2. `name` of a feed is displayed at the bottom of every news

Here is an example:

```javascript
{
    "default": [ {
        url: "https://articlefeeds.nasdaq.com/nasdaq/symbols?symbol={SYMBOL}",
        name: "NASDAQ"
      }, {
        url: "http://feeds.finance.yahoo.com/rss/2.0/headline?s={SYMBOL}&region=US&lang=en-US",
        name: "Yahoo Finance"
      } ]
}
```

Another example:

```javascript
{
    "default": {
        url: "https://articlefeeds.nasdaq.com/nasdaq/symbols?symbol={SYMBOL}",
        name: "NASDAQ"
    }
}
```

One more example:

```javascript
{
    "default": {
        url: "https://articlefeeds.nasdaq.com/nasdaq/symbols?symbol={SYMBOL}",
        name: "NASDAQ"
     },
    "stock": {
        url: "http://feeds.finance.yahoo.com/rss/2.0/headline?s={SYMBOL}&region=US&lang=en-US",
        name: "Yahoo Finance"
    }
}
```

#### :chart: news_provider

The object which represent a news provider. It may contain the following properties:
1. `is_news_generic` - if `true` the title of the news widget will no have a symbol name (just `Headlines`). Otherwise `for SYMBOL_NAME` will be added.
2. `get_news` - use this property to set own news getter function. `symbol` and `callback` will be passed to the function.

    The callback function should be called with an array of news objects with the following structure:

    1. `title` (required) - News item title.
    1. `published` (required) - News item time in ms (UTC).
    1. `source` (optional) - Title of news item source.
    1. `shortDescription` (optional) - Short description of a news item that will be displayed under the title.
    1. `link` (optional) - URL to the news story
    1. `fullDescription` (optional) - Full description (body) of a news item

    **NOTE:** When a user clicks on a news item a new tab with `link` URL will be opened. If `link` is not specified a dialog popup with `fullDescription` will be shown.

    **NOTE 2:** If it is set `rss_news_feed` will be ignored.

Example:
```javascript
news_provider: {
	is_news_generic: true,
	get_news: function(symbol, callback) {
		callback([
			{
				title: 'It is news for symbol ' + symbol,
				shortDescription: 'Short description of the news item',
				fullDescription: 'Full description of the news item',
				published: new Date().valueOf(),
				source: 'My own news source',
				link: 'https://www.tradingview.com/'
			},
			{
				title: 'Another news for symbol ' + symbol,
				shortDescription: 'Short description of the news item',
				fullDescription: 'Full description of the news item. Very long long long long long long long long text.',
				published: new Date().valueOf(),
				source: 'My own news source',
			}
		]);
	}
}

```

#### :chart: trading_controller
Trading Controller is a thing which will make your trading live. [[Read more|Trading-Controller]].

```javascript
new TradingView.widget({
    /* ... */
    trading_controller: new MyTradingController()
});
```

# See Also
* [[Customization Overview]]
* [[Widget Methods]]
* [[Featuresets]]
* [[Saving and Loading Charts|Saving-and-Loading-Charts]]
* [[Overriding Studies' Defaults|Studies-Overrides]]
* [[Overriding Chart's Defaults|Overrides]]
