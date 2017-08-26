## Data Questions

<details>
<summary><b>1. How do I connect my data? How to add new ticker symbols?</b></summary>
<p>

The Charting Library should to be used by technical specialists. It requires advanced skills in JavaScript and deep knowledge of WEB protocols. You should know it yourself or have/hire people who know this. Additionally, if you don't have a WEB API, you will need at least a server language programmer and a system administrator to implement a WEB API on the server side.
<p>

We’ve done lot of work to make the process of connecting data simple and clear.
<p>

First, you need to read and understand this article: [[How to connect my data|https://github.com/tradingview/charting_library/wiki/How-To-Connect-My-Data]]
<p>

If you still have questions, open [[Demo Chart|https://demo_chart.tradingview.com]], then open Debugger-Network and filter requests by `demo_feed`. You will see all requests and corresponding responses in the [[UDF]] format.
</details>

<details>
<summary><b>2. Do you have an example of JS API implementation?</b></summary>
<p>

<p>
    If you look at the picture below, you will see the UDF Adapter as an example of the JS API implementation. Its code is not minified and it is written in such a way that our clients can understand how it works.
<p>
    [[Scheme|https://github.com/tradingview/charting_library/wiki/How-To-Connect-My-Data#udf-scheme]]
</details>

<details>
<summary><b>3. Do you have an example of a WebSocket data transport?</b></summary>
<p>

<p>
    We don’t have an example of such integration, but we still hope to make this example in the future.

</details>
<details>
<summary><b>4. Do you have an example of a back-end data feed on ASP.NET, Python, PHP etc. ?</b></summary>
<p>

<p>
    The only example of a back-end feed that we have is written on Javascript for NodeJS. You can find it here: [[yahoo_datafeed|https://github.com/tradingview/yahoo_datafeed]]

</details>
<details>
<summary><b>5. How can I display my data stored in a TXT/CSV/Excel file?</b></summary>

<p>

<p>
First of all, the Charting Library is not intended to display data from files. It is used to display bars data from a server. Secondly, you should keep in mind that according to the agreement you should use Charting Library on public websites only. If you still want to use a file as the source of data you will need to do the following steps:

1. Write an application using any server language (.NET, PHP, NodeJS, Python etc.). This application should read the file and provide the data from it in [[UDF]] format over HTTP(S).
Note: You can provide data in another format or use websocket to transfer it, but in this case you will need to implement a [[JS-Api]] adapter on a client.
2. You should either have a static IP or register a domain so a browser can send requests to your server.
3. Open `index.html` and replace `demo_feed.tradingview.com` with the URL to your server.

</details>
<details>
<summary><b>6. Why my data is not displayed / displayed incorrectly / incorrectly fetched from a server?</b></summary>
<p>

<p>

The first thing you should do is open `index.html` or your script where you create the library widget and put the following line in the initialization options of the widget: `debug: true,`. Once you have done that, you will see lot of helpful information in your browser console. Most of important actions that happen in the library are explained in the console.
<p>

Please read [[Symbology]] thoroughly. Most of errors with data happen because of incorrect symbol settings.

</details>
<details>
<summary><b>7. Charting Library is constantly asking for data. How to tell it that data is finished?</b></summary>
<p>

<p>

Specifically for this purpose there is a flag that can be added to the responses from your server that tells the library that there is no more data on the server. It is called `no_data` for [[UDF|https://github.com/tradingview/charting_library/wiki/UDF#bars]] and `noData` for [[JS API|https://github.com/tradingview/charting_library/wiki/JS-Api#getbarssymbolinfo-resolution-from-to-onhistorycallback-onerrorcallback-firstdatarequest]]

</details>
<details>
<summary><b>8. How to change the number of decimal places of prices on a chart?</b></summary>
<p>

<p>

Please read [[Symbology]] thoroughly. Number of decimal places is calculated based on `minmov` and `pricescale` values.

</details>
<details>
<summary><b>9. What if I have a single price for each timestamp?</b></summary>
<p>

<p>

You still can display your data if you have only one price for each timestamp, but obviously you will not be able to display the data as bars/candles. Since the library is intended to display different styles of data: candles, bars, histogram, you are supposed to provide Open, High, Low, Close and optional Volume for each timestamp. If you have only one price, you can pass `Open = High = Low = Close = price`. For better view of this data, you can change default chart style to “Line” (see GUI Questions).
</details>

## GUI Questions

<details>
<summary><b>1. How can I subscribe to chart events?</b></summary>
<p>

<p>
We have a few ways to subscribe to the events:
<p>
1. Subscribing to general events that are related to a whole chart layout, not a specific chart.
[[Open article|https://github.com/tradingview/charting_library/wiki/Widget-Methods#subscribing-to-chart-events]]
<p>
2. Subscribing to events that are related to a single chart
[[Open article|https://github.com/tradingview/charting_library/wiki/Chart-Methods#subscribing-to-chart-events]]
<p>

Check the result value of subscription methods. Some of them return a [[Subscription|https://github.com/tradingview/charting_library/wiki/Subscription]] object that has methods `subscribe`/`unsubscribe`. The others accept a callback function.

</details>
<details>
<summary><b>2. How to change default bars style from Candles to another one?</b></summary>
<p>

<p>

You need to use [[overrides|https://github.com/tradingview/charting_library/wiki/Widget-Constructor#overrides]] of the Widget Constructor. Add `mainSeriesProperties.style` key. You can find allowed values in [[this article|https://github.com/tradingview/charting_library/wiki/Overrides]]

</details>
<details>
<summary><b>3. How can I change the list of resolutions (time intervals) on a chart / make them grayed?</b></summary>

* List of the resolutions displayed in a pop-up on a chart is defined by [[supported_resolutions|https://github.com/tradingview/charting_library/wiki/JS-Api#supported_resolutions]] from the data feed configuration.

* Resolutions available for a certain instrument are defined by [[supported_resolutions|https://github.com/tradingview/charting_library/wiki/Symbology#supported_resolutions]] from the instrument/symbol information.

* If you support intraday resolutions, you need to set [[has_intraday|https://github.com/tradingview/charting_library/wiki/Symbology#has_intraday-]]

* Additionally, if you support seconds, you need to set [[has_seconds|https://github.com/tradingview/charting_library/wiki/Symbology#has_seconds-]]

* If you support daily resolutions, you should set [[has_daily|https://github.com/tradingview/charting_library/wiki/Symbology#has_daily-]]

* If you support weeks and months, you should set [[has_weekly_and_monthly|https://github.com/tradingview/charting_library/wiki/Symbology#has_weekly_and_monthly-]]

* Additionally, you should set the resolutions, which are provided by your server for [[intraday resolutions|https://github.com/tradingview/charting_library/wiki/Symbology#intraday_multipliers-]] and separately for [[seconds|https://github.com/tradingview/charting_library/wiki/Symbology#seconds_multipliers-]].

* If an instrument supports (`supported_resolutions`) more resolutions that can be provided by the server (`intraday_multipliers`), the other resolutions are constructed by the chart.

</details>
<details>
<summary><b>4. How to hide a GUI Element (symbol, interval, button etc.)?</b></summary>

* Most of GUI elements can be hidden using [[Featuresets]]. Please look at the [Interactive map of featuresets](http://tradingview.github.io/featuresets.html) to find what you need.

* There are base elements that cannot be hidden, but if you still want to get rid of them you can use [CSS customization](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#custom_css_url-since-14). Please note that the names, classes and identifiers of DOM elements may be changed in future versions of the product without any notifications.
</details>

## Other Questions

<details>
<summary><b>1. What is the the difference between [[Widget|http://tradingview.com/widget/]], [[Charting Library|https://www.tradingview.com/HTML5-stock-forex-bitcoin-charting-library/]] and [[Trading Terminal|https://www.tradingview.com/trading-terminal/]] ?</b></summary>
<p>

<p>
    [[Widget|http://tradingview.com/widget/]] is connected to TradingView data. Perfect for websites, blogs and forums where you need a fast & free solution. Integration is simply cutting & pasting pre-made iframe code. It has lots of display modes.
<p>
    [[Charting Library|https://www.tradingview.com/HTML5-stock-forex-bitcoin-charting-library/]] is a chart with your own data. This is a standalone solution that you download, host on your servers, connect your own data & use in your site/app for free.
<p>
    [[Trading Terminal|https://www.tradingview.com/trading-terminal/]] is a standalone product that is licensed to brokers. It includes all features available in the Charting Library, but it also has trading functionality, multiple chart layouts, watchlists, details, news widgets and other advanced tools. It has its own licensing fees associated with it.

</details>

<details>
<summary><b>2. How do I add a custom indicator?</b></summary>
<p>

<p>
    At the moment there is only one way to add custom indicators. It is described in a [[dedicated article|https://github.com/tradingview/charting_library/wiki/Creating-Custom-Studies]].
</details>