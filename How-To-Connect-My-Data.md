**The Charting Library does NOT include market data.** You must provide your own data in the required format. A sample data engine integrates Yahoo Finance API historical data. The charts can receive data in two ways:

1. Update in real-time with a PUSH type connection, for example through WebSocket. This way your charts will autoupdate with new prices when they arrive. To achieve this, you have to use the [[JavaScript API|JS-Api]] and have your own transport method ready.

2. Update on a PULL/pulse/refresh basis (like most web-based charts today), where the chart data is updating every X number of seconds (the chart client will ask the server emulating PUSH updates), or only get reloaded manually by the user. For this, use the [[UDF protocol|UDF]] and write your own datafeed wrapper.

### JavaScript API or UDF?

[[images/udf_or_jsapi.png]]

## UDF scheme

[[images/udf.png]]

## JSAPI scheme

[[images/jsapi.png]]

The pictures above illustrate the difference between UDF and JSAPI. Mandatory Charting Library parts are colored blue. Red parts (default data transport) are included in default package (having non-minimized source code) and may be replaced. You may see the default data transport implements JS API to interact with the chart. Also, default transport implements UDF protocol to communicate with a server.

1. **If you already have a data transport ready** (websocket streaming, polling, or any other transport), or if you don’t but need streaming data - use our [[JavaScript API|JS-Api]], which is extremely compact and simple to implement. You will have to create a small **client-side data adapter** between your data transport and our charts using JavaScript.

2. **If you don’t have any transports** and do not need streaming data (e.g., data pulsing is all you need), then you will have to create (or use) at least a thin server-side datafeed wrapper. You may use any language and technology for this purpose: it’s just necessary for your wrapper to support our data exchange protocol (we call it [[UDF|UDF]]) to be able to feed your Charting Library with data. You will have to create a small **server-side data adapter** between your back-end and our charts using you favorite language.


### Want Examples ?

A sample implementation of **UDF-compatible** (case #2 described below) server-side wrapper is available [on github](https://github.com/tradingview/yahoo_datafeed). It uses Yahoo! data.

A sample of **JS API** implementation (and UDF client-side at the same time) is a part of Charting Library package (see *datafeed.js* file).

If you use Ruby on Rails you can see the gem for Charting Library kindly provided by our user [[bobstar6|https://github.com/bobstar6]] [[here|https://github.com/tradingview/tv_chart_rails]].
