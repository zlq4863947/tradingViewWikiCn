Here is a list of supported widget's methods. You can call them using widget object returned to you by widget's constructor.

**Remark**: Please note that it's safe to call any method only **after** onChartReady callback is fired. So the common practice is to do smth like

```javascript
widget.onChartReady(function() {
    // now it's safe to call any other widget's methods
});
```

# Methods

**Before 1.5 [[Chart Methods]] belonged to the Widget. Please see the full list of actions [[here|Chart-Methods]]**

* Subscribing To Chart Events
  * [[onChartReady(callback)|Widget-Methods#onchartreadycallback]]
  * [[onSymbolChange(callback)|Widget-Methods#onsymbolchangecallback]] [obsolete]
  * [[onIntervalChange(callback)|Widget-Methods#onintervalchangecallback]] [obsolete]
  * [[onAutoSaveNeeded(callback)|Widget-Methods#onautosaveneededcallback]] [obsolete]
  * [[onBarMarkClicked(callback)|Widget-Methods#onbarmarkclickedcallback]] [obsolete]
  * [[onTimescaleMarkClicked(callback)|Widget-Methods#ontimescalemarkclickedcallback]] [obsolete]
  * [[onGrayedObjectClicked(callback)|Widget-Methods#ongrayedobjectclickedcallback]]
  * [[onScreenshotReady(callback)|Widget-Methods#onscreenshotreadycallback]] [obsolete]
  * [[onTick(callback)|Widget-Methods#ontickcallback]] [obsolete]
  * [[onShortcut(shortcut, callback)|Widget-Methods#onshortcutshortcut-callback]]
  * [[subscribe(event, callback)|Widget-Methods#subscribeevent-callback]]
* Chart Actions
  * [[chart()|Widget-Methods#chart]]
  * [[setLanguage(locale)|Widget-Methods#setlanguagelocale]]
  * [[setSymbol(symbol, interval, callback)|Widget-Methods#setsymbolsymbol-interval-callback]]
  * [[remove()|Widget-Methods#remove]]
  * [[closePopupsAndDialogs()|Widget-Methods#closepopupsanddialogs]]
  * [[selectLineTool(drawingId)|Widget-Methods#selectlinetooldrawingid]]
  * [[selectedLineTool()|Widget-Methods#selectedlinetool]]
* Saving/Loading Charts
  * [[save(callback)|Widget-Methods#savecallback]]
  * [[load(state)|Widget-Methods#loadstate]]
  * [[getSavedCharts(callback)|Widget-Methods#getsavedchartscallback]]
  * [[loadChartFromServer(chartRecord)|Widget-Methods#loadchartfromserverchartrecord]]
  * [[saveChartToServer(onCompleteCallback, onFailCallback, saveAsSnapshot, options)|Widget-Methods#savecharttoserveroncompletecallback-onfailcallback-saveassnapshot-options]]
  * [[removeChartFromServer(chartId, onCompleteCallback)|Widget-Methods#removechartfromserverchartid-oncompletecallback]]
* Custom UI Controls
  * [[onContextMenu(callback)|Widget-Methods#oncontextmenucallback]]
  * [[createButton(options)|Widget-Methods#createbuttonoptions]]
* Dialogs
  * [[showNoticeDialog(params)|Widget-Methods#shownoticedialogparams]]
  * [[showConfirmDialog(params)|Widget-Methods#showconfirmdialogparams]]
  * [[showLoadChartDialog()|Widget-Methods#showloadchartdialog]]
  * [[showSaveAsChartDialog()|Widget-Methods#showsaveaschartdialog]]
* Getters
  * [[symbolInterval(callback)|Widget-Methods#symbolintervalcallback]]
  * [[mainSeriesPriceFormatter()|Widget-Methods#mainseriespriceformatter]]
  * [[getIntervals()|Widget-Methods#getintervals]]
  * [[getStudiesList()|Widget-Methods#getstudieslist]]
* Customization
  * [[addCustomCSSFile(url)|Widget-Methods#addcustomcssfileurl]]
  * [[applyOverrides(overrides)|Widget-Methods#applyoverridesoverrides]]
  * [[applyStudiesOverrides(overrides)|Widget-Methods#applystudiesoverridesoverrides]]
* :chart: [[Trading Terminal]] specific
  * [[showSampleOrderDialog(order)|Widget-Methods#chart-showsampleorderdialogorder]]
  * [[watchList()|Widget-Methods#chart-watchlist]]
* :chart: Multiple Charts Layout
  * [[chart(index)|Widget-Methods#chart-chartindex]]
  * [[activeChart()|Widget-Methods#chart-activechart]]
  * [[chartsCount()|Widget-Methods#chart-chartscount]]
  * [[layout()|Widget-Methods#chart-layout]]
  * [[setLayout(layout)|Widget-Methods#chart-setlayoutlayout]]

# Subscribing To Chart Events

#### onChartReady(callback)
1. `callback`: function()

The Charting Library will call the callback provided once when chart is initialized and ready. You can safely call all other methods from this moment.

#### onSymbolChange(callback)
1. `callback`: function(symbolData)
    1. `symbolData`: object `{name, exchange, description, type, interval}`

The Charting Library will call the callback provided every time the main series symbol changes. New symbol info will be passed as argument.

**Obsolete. Will be removed in 1.8.** Use [[onSymbolChanged|Chart-Methods#onsymbolchanged]] subscription method of `chart` instead.

#### onIntervalChange(callback)
1. `callback`: function(interval)
    1. `interval`: string

The Charting Library will call the callback provided every time the main series interval changes. New interval will be passed as argument.

**Obsolete. Will be removed in 1.8.** Use [[onIntervalChanged|Chart-Methods#onintervalchanged]] subscription method of `chart` instead.

#### onAutoSaveNeeded(callback)
1. `callback`: function()

The Library will call the callback provided every time when user changes the chart. `Chart change` means any user action that can be undone. The callback will not be called more than once in five seconds.
See also [auto_save_delay](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#auto_save_delay).

**Obsolete. Will be removed in 1.8.** Use [[subscribe|Widget-Methods#subscribeevent-callback]] method with `onAutoSaveNeeded` event instead.

#### onBarMarkClicked(callback)
1. `callback`: function(markId)

The Library will call the callback provided every time when user clicks a [[mark on bar|Marks-On-Bars]]. Mark ID will be passed as an argument.

**Obsolete. Will be removed in 1.8.** Use [[subscribe|Widget-Methods#subscribeevent-callback]] method with `onMarkClick` event instead.

#### onTimescaleMarkClicked(callback)
1. `callback`: function(markId)

The Library will call the callback provided every time when user clicks a timescale mark. Mark ID will be passed as an argument.

**Obsolete. Will be removed in 1.8.** Use [[subscribe|Widget-Methods#subscribeevent-callback]] method with `onTimescaleMarkClick` event instead.

#### onGrayedObjectClicked(callback)
1. `callback`: function(subject)
    1. `subject`: object `{type, name}`
        1. `type`: `drawing` | `study`
        2. `name`: string, name of a subject which was clicked

The Library will call the callback provided every time when user clicks on grayed out object. Example:

```javascript
new TradingView.widget({
    drawings_access: {
        type: "black",
        tools: [
            { name: "Regression Trend" },
            { name: "Trend Angle", grayed: true },
        ]
    },
    studies_access: {
        type: "black",
        tools: [
            { name: "Aroon" },
            { name: "Balance of Power", grayed: true },
        ]
    },
    <...> // other widget settings
});

widget.onChartReady(function() {
    widget.onGrayedObjectClicked(function(data) {
        // this function will be called when one tries to
        // create Balance Of Power study or Trend Angle shape

        alert(data.name + " is grayed out!");
    })
});

```

#### onScreenshotReady(callback)
1. `callback`: function(imageName)

The Library will call the callback provided every time when user creates a screenshot and server returns the created image name.

**Obsolete. Will be removed in 1.8.** Use [[subscribe|Widget-Methods#subscribeevent-callback]] method with `onScreenshotReady` event instead.

#### onTick(callback)
1. `callback`: function(data)

The Library will call the callback provided every time when recent bar updates.

**Obsolete. Will be removed in 1.8.** Use [[subscribe|Widget-Methods#subscribeevent-callback]] method with `onTick` event instead.

#### onShortcut(shortcut, callback)
1. `shortcut`
2. `callback`: function(data)

The Library will call the callback provided every time when shortcut is pressed.

Example:

```javascript
widget.onShortcut("alt+s", function() {
  widget.executeActionById("symbolSearch");
});
```

#### subscribe(event, callback)
1. `event`: can be

 | Event name | Library Version | Description |
 |------------|-----------------|-------------|
 | toggle_sidebar | | drawing toolbar is shown/hidden |
 | indicators_dialog | | Indicators dialog is shown |
 | toggle_header | | chart heder is shown/hidden |
 | edit_object_dialog | | Chart/Study Properties dialog is shown |
 | chart_load_requested | | new chart about to be loaded |
 | chart_loaded | | |
 | mouse_down | | |
 | mouse_up | | |
 | drawing | 1.7 | a drawing is added to a chart. Arguments contains an object with  `value` field that is the name of the drawing. |
 | study | 1.7 | an indicator is added to a chart. Arguments contains an object with  `value` field that is the name of the indicator. |
 | undo | 1.7 | |
 | redo | 1.7 | |
 | reset_scales | 1.7 | reset scales button is clicked |
 | compare_add | 1.7 | Compare dialog is shown |
 | add_compare | 1.7 | Compare instrument is added |
 | load_study template | 1.7 | A study template is loaded |
 | onTick | | callback will be called every time when recent bar updates |
 | onAutoSaveNeeded | | callback will be called every time when user changes the chart.  `Chart change` means any user action that can be undone. The callback will not be called more than once in five seconds. See also [auto_save_delay](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#auto_save_delay) |
 | onScreenshotReady | | callback will be called every time when user creates a screenshot and server returns the created image name |
 | onMarkClick | | callback will be called every time when user clicks a [[mark on bar|Marks-On-Bars]]. Mark ID will be passed as an argument |
 | onTimescaleMarkClick | | callback will be called every time when user clicks a timescale mark. Mark ID will be passed as an argument |
 | onSelectedLineToolChanged | | callback will be called every time when selected line tool changes |
 | :chart: layout_about_to_be_changed | | amount or placement of charts about to be changed |
 | :chart: layout_changed | | amount or placement of charts is changed |
 | :chart: activeChartChanged | | active chart is changed |

2. `callback`: function(arguments)

The library will call `callback` when GUI `event` is happened. Every event can have different set of arguments.

# Chart Actions

#### chart()

Returns a chart object that you can use to call [[Chart-Methods]]

#### setLanguage(locale)
1. `locale`: [[language code|Localization]]

Sets the Widget's language. For now, this call reloads the chart. **Please avoid using it**.

#### setSymbol(symbol, interval, callback)
1. `symbol`: string
2. `interval`: string
3. `callback`: function()

Makes the chart to change its symbol and resolution. Callback is called after new symbol's data arrived.

#### remove()
Removes chart widget from your page.

#### closePopupsAndDialogs()

Calling this method closes a context menu or a dialog if it is shown.

#### selectLineTool(drawingId)
1. `drawingId`: may be one of the [[identifiers|Shapes and Overrides]] or
    1. `cursor`
    2. `dot`
    3. `arrow_cursor`
    4. `eraser`
    5. `measure`
    6. `zoom`
    7. `brush`

Selection of a drawing or cursor which is identical to a single click on a drawing button.

#### selectedLineTool()

Returns an [[identifier|Shapes and Overrides]] of the selected drawing or cursor (see above).


# Saving/Loading Charts


#### save(callback)
1. `callback`: function(object)

Saves the chart state to JS object. Charting Library will call your callback and pass the state object as argument. This call is a part of low-level [[save/load API|Saving-and-Loading-Charts]].

#### load(state)
1. `state`: object

Loads the chart from state object. This call is a part of low-level [[save/load API|Saving-and-Loading-Charts]].

#### getSavedCharts(callback)
1. `callback`: function(objects)

`objects` is an array of:
1. `id`
2. `name`
3. `image_url`
4. `modified_iso`
5. `short_symbol`
6. `interval`

Returns a list of chart descriptions saved on a server for current user.

#### loadChartFromServer(chartRecord)
1. `chartRecord` is an object that you get using [[getSavedCharts(callback)|Widget-Methods#getsavedchartscallback]]

Loads and displays a chart from a server.

#### saveChartToServer(onCompleteCallback, onFailCallback, saveAsSnapshot, options)
1. `onCompleteCallback`: function()
2. `onFailCallback`: function()
3. `saveAsSnapshot`: should be always `false`
4. `options`: object `{ chartName }`
    1. `chartName`: name of a chart. Should be specified for new charts and renaming.
    2. `defaultChartName`: default name of a chart. It will be used if current chart has no name.

Saves current chart to the server.

#### removeChartFromServer(chartId, onCompleteCallback)
1. `chartId`: `id` should be got from a record received using [[getSavedCharts(callback)|Widget-Methods#getsavedchartscallback]]
2. `onCompleteCallback`: function()

Removes chart from the server.

# Custom UI Controls

#### onContextMenu(callback)
1. `callback`: function(unixtime, price). This callback is expected to return a value (see below).

The Library will call the callback provided every time when user opens context menu on the chart. Unix time and price of context menu point will be provided as arguments. To customize context menu items you have to return array of items descriptors. Item descriptor has following structure:
```javascript
{
    position: 'top' | 'bottom',
    text: 'Menu item text',
    click: <onItemClicked callback>
}
```
* `position`: position of item in context menu
* `text`: text of menu item
* `click`: callback which will be called when user select your menu item

To add a separator use minus sign. Example: `{ text: "-", position: "top" }`.

To remove an existing item from a menu use minus sign in front of the item text.
Example: `{ text: "-Objects Tree..." }`

Example:
```javascript
widget.onChartReady(function() {
    widget.onContextMenu(function(unixtime, price) {
        return [{
            position: "top",
            text: "First top menu item, time: " + unixtime + ", price: " + price,
            click: function() { alert("First clicked."); }
        },
        { text: "-", position: "top" },
        { text: "-Objects Tree..." },
        {
            position: "top",
            text: "Second top menu item 2",
            click: function() { alert("Second clicked."); }
        }, {
            position: "bottom",
            text: "Bottom menu item",
            click: function() { alert("Third clicked."); }
        }];
    });
```

#### createButton(options)
1. `options`: object `{ align: "left" }`
    1. `align`: "right" | "left". default: "left"

Creates a new DOM element in chart top toolbar and returns **jQuery object** for this button. You can use it to append custom controls right on the chart. Example:

```javascript
widget.onChartReady(function() {
    widget.createButton()
        .attr('title', "My custom button tooltip")
        .on('click', function (e) { alert("My custom button pressed!"); })
        .append($('<span>My custom button caption</span>'));
});
```

# Dialogs

**Since 1.6 version**

#### showNoticeDialog(params)
1. `params`: object:
    1. `title`: text to be shown in the title
    2. `body`: text to be shown in the body
    3. `callback`: function to be called when ok button is pressed

This method shows a dialog with custom title and text and "OK" button.

#### showConfirmDialog(params)
1. `params`: object:
    1. `title`: text to be shown in the title
    2. `body`: text to be shown in the body
    3. `callback(result)`: function to be called when ok button is pressed. `result` is `true` if `OK` is pressed, otherwise it is `false`.

This method shows a dialog with custom title and text and "OK", "CANCEL" buttons.

#### showLoadChartDialog()

Displays Load chart dialog.

#### showSaveAsChartDialog()

Displays Save As... chart dialog.

# Getters

#### symbolInterval(callback)
1. `callback`: function(result)
    1. `result`: object `{symbol, interval}`

**Since 1.4 the function returns the result immediately. Callback is kept for compatability.**

Charting Library will call your callback with an object containing chart's symbol and interval.

#### mainSeriesPriceFormatter()

Returns object with method `format` that you can use to format prices. Introduced in 1.5.

#### getIntervals()

Returns an array of supported resolutions. Introduced in 1.7.

#### getStudiesList()

Returns an array of all studies ids. They can be used to create a study.

# Customization


#### addCustomCSSFile(url)
1. `url` should be absolute or relative path to 'static` folder

This method was introduced in version `1.3`. Starting from `1.4` use [custom_css_url](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#custom_css_url) instead.

#### applyOverrides(overrides)
*Introduced in Charting Library 1.5*

1. `overrides` is an object. It is the same as [overrides](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#overrides) in Widget Constructor.

This method applies overrides to properties without reloading the chart.

#### applyStudiesOverrides(overrides)
*Introduced in Charting Library 1.9*

1. `overrides` is an object. It is the same as [studies_overrides](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#studies_overrides) in Widget Constructor.

This method applies studies overrides to indicators' style or inputs without reloading the chart.

# :chart: Trading Terminal

The following methods are available in [[Trading Terminal]] only.

#### :chart: showSampleOrderDialog(order)
1. `order`: object

Displays a sample order dialog. This dialog looks like Trading View Paper Trading one. Usually you don't need to use the sample dialog. This method is used in the trading sample.

#### :chart: watchList()
*Introduced in Charting Library 1.9*

Returns an object to manipulate the watchlist. The object has the following methods:

1. `getList()` - allows you to get current list of the symbols.

2. `setList(symbols)` - allows you to set a list of symbols into the watchlist. It will replace the whole list.

3. `onListChanged()` - you can subscribe using [[Subscription]] object returned by this function to be notified when the watchlist is changed and unsubscribe from the event. If there is no WatchList `null` will be returned.

# :chart: Multiple Charts Layout

#### :chart: chart(index)
1. `index`: index of a chart starting from 0. `index` is 0 by default.

Returns a chart object that you can use to call [[Chart-Methods]]

#### :chart: activeChart()

Returns current active chart object that you can use to call [[Chart-Methods]]

#### :chart: chartsCount()

Returns amount of charts in the current layout

#### :chart: layout()

Returns current layout mode. Possible values: `4`, `6`, `8`, `s`, `2h`, `2-1`, `2v`, `3h`, `3v`, `3s`.

#### :chart: setLayout(layout)
1. `layout`: Possible values: `4`, `6`, `8`, `s`, `2h`, `2-1`, `2v`, `3h`, `3v`, `3s`.

Changes current chart layout.

# See Also
* [[Chart-Methods]]
* [[Customization Overview]]
* [[Widget Constructor]]
* [[Saving and Loading Charts|Saving-and-Loading-Charts]]
* [[Overriding Studies' Defaults|Studies-Overrides]]
* [[Overriding Chart's Defaults|Overrides]]
