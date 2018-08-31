#经常被问到的问题

---

## 数据问题

<details>
<summary><b>1. 如何连接我的数据？ 如何添加新的商品代码?</b></summary>
<p>

图表库应由技术专家使用。 它需要JavaScript的高级技能和对WEB协议的深入了解。 您应该了解自己，或者雇用知道这个的人。另外，如果您没有WEB API，则至少需要服务器语言程序员和系统管理员才能在服务器端实现WEB API。
<p>

我们做了很多工作，使连接数据的过程简单明了。
<p>

首先，您需要阅读并理解本文: [[How to connect my data|https://github.com/tradingview/charting_library/wiki/How-To-Connect-My-Data]]
<p>

如果还有问题，请打开 [[Demo Chart|https://demo_chart.tradingview.com]], 然后打开Debugger-Network，并通过`demo_feed'过滤请求。您将在[[UDF]]格式中看到所有请求和相应的响应。
</details>

<details>
<summary><b>2. 是否有JS API实现的例子?</b></summary>
<p>

<p>
    如果您看下图，您将看到UDF适配器作为JS API实现的示例。 它的代码没有被缩小，它的写法使我们的客户能够理解它的工作原理。
<p>
    [[Scheme|https://github.com/tradingview/charting_library/wiki/How-To-Connect-My-Data#udf-scheme]]
</details>

<details>
<summary><b>3. 是否有WebSocket数据传输的例子?</b></summary>
<p>

<p>
    我们没有这样的一体化的例子，但我们仍然希望在将来做出这个例子。

</details>
<details>
<summary><b>4. 是否有ASP.NET，Python，PHP等后端数据源的例子。?</b></summary>
<p>

<p>
    我们所用的后端Feed的唯一示例是用于NodeJS的JavaScript。 你可以在这里找到它：[[yahoo_datafeed|https://github.com/tradingview/yahoo_datafeed]]

</details>
<details>
<summary><b>5. 如何显示存储在TXT/CSV/Excel文件中的数据?</b></summary>

<p>

<p>
首先，图表库并不用于显示文件中的数据。它用于显示来自服务器的K线数据。其次，您应该记住，根据协议，您只能在公共网站上使用图表库。如果您仍然想使用文件作为数据源，则需要执行以下步骤：

1. 使用任何服务器语言编写应用程序（.NET，PHP，NodeJS，Python等）。该应用程序应读取该文件，并通过HTTP(S)以[[UDF]]格式提供数据。
注意：您可以以另一种格式提供数据，或使用websocket来传输数据，但在这种情况下，您将需要在客户端上实现[[JS-Api]]适配器。
2. 您应该具有静态IP或注册域，以便浏览器可以向您的服务器发送请求。
3. 打开`index.html`，将`demo_feed.tradingview.com`替换成你的服务器的URL。

</details>
<details>
<summary><b>6. 为什么我的数据没有显示/显示不正确/从服务器提取错误?</b></summary>
<p>

<p>

您应该做的第一件事是打开`index.html`或你创建库widget的脚本，并在widget的初始化选项中加入：`debug: true,`。完成之后，您将在浏览器控制台中看到很多有用的信息。图表库中发生的大部分重要操作都在控制台中进行了说明。
<p>

请仔细阅读[[Symbology]]。 大部分数据错误发生在商品设置不正确。

</details>
<details>
<summary><b>7. 图表库不断要求数据。 如何判断数据是否完成?</b></summary>
<p>

<p>

具体而言，有一个标志可以添加到服务器的响应中，它告诉库服务器上没有更多的数据。它被称为 `no_data` 为[[UDF|https://github.com/tradingview/charting_library/wiki/UDF#bars]] 和`noData`为[[JS API|https://github.com/tradingview/charting_library/wiki/JS-Api#getbarssymbolinfo-resolution-from-to-onhistorycallback-onerrorcallback-firstdatarequest]]

</details>
<details>
<summary><b>8. 如何在图表上更改小数位数?</b></summary>
<p>

<p>

请仔细阅读[[Symbology]]。小数位数是根据 `minmov` 和 `pricescale` 值计算的。

</details>
<details>
<summary><b>9. 如果每个时间戳都有一个单一的价格怎么办？?</b></summary>
<p>

<p>

如果每个时间戳只有一个价格，您仍然可以显示数据，但显然您将无法将数据显示为K线/蜡烛线。由于图表库旨在显示不同风格的数据：蜡烛线，K线，直方图，您应该为每个时间戳提供Open, High, Low, Close和可选的Volume(成交量)。如果您只有一个价格，你可以通过`Open = High = Low = Close = price`。为了更好地查看此数据，您可以将默认图表样式更改为“Line”（请参阅GUI问题）。
</details>

## GUI问题

<details>
<summary><b>1. 如何订阅图表事件？?</b></summary>
<p>

<p>
我们有几种方式来订阅这些事件：
<p>
1. 订阅与整个图表布局相关的一般事件，而不是特定图表。
[[Open article|https://github.com/tradingview/charting_library/wiki/Widget-Methods#subscribing-to-chart-events]]
<p>
2. 订阅与单个图表相关的事件
[[Open article|https://github.com/tradingview/charting_library/wiki/Chart-Methods#subscribing-to-chart-events]]
<p>

检查订阅方法的结果值。 其中一些返回 [[Subscription|https://github.com/tradingview/charting_library/wiki/Subscription]] 对象拥有 `subscribe`/`unsubscribe`方法。其他接受一个回调函数。

</details>
<details>
<summary><b>2. 如何将默认K线风格从蜡烛更改为另一种?</b></summary>
<p>

<p>

您可以使用[[overrides|https://github.com/tradingview/charting_library/wiki/Widget-Constructor#overrides]] 的小部件构造函数。 添加`mainSeriesProperties.style`键。 您可以找到允许的值 [[this article|https://github.com/tradingview/charting_library/wiki/Overrides]]

</details>
<details>
<summary><b>3. 如何更改图表上的周期列表（时间周期），使其变灰?</b></summary>

* 在图表弹出窗口中显示的周期列表由data feed配置中的[[supported_resolutions|https://github.com/tradingview/charting_library/wiki/JS-Api#supported_resolutions]] 定义。

* 某些仪器的周期由仪器/商品信息中的 [[supported_resolutions|https://github.com/tradingview/charting_library/wiki/Symbology#supported_resolutions]] 定义。

* 如果您支持日内周期，则需要设置[[has_intraday|https://github.com/tradingview/charting_library/wiki/Symbology#has_intraday-]]

* 另外，如果您支持秒，你需要设置 [[has_seconds|https://github.com/tradingview/charting_library/wiki/Symbology#has_seconds-]]

* 如果您支持日周期，你应该设置[[has_daily|https://github.com/tradingview/charting_library/wiki/Symbology#has_daily-]]

* 如果您支持周和月，你应该设置 [[has_weekly_and_monthly|https://github.com/tradingview/charting_library/wiki/Symbology#has_weekly_and_monthly-]]

* 此外，您应该设置的周期，这是由您的服务器[[[intraday resolutions|https://github.com/tradingview/charting_library/wiki/Symbology#intraday_multipliers-]]和[[seconds|https://github.com/tradingview/charting_library/wiki/Symbology#seconds_multipliers-]]。

* 如果仪器支持（`supported_resolutions`）更多的周期，可以由服务器提供（`intraday_multipliers`），其他周期由图表构建。

</details>
<details>
<summary><b>4. 如何隐藏GUI元素(商品、周期、按钮等)?</b></summary>

* 大多数GUI元素可以使用[[Featureets]]隐藏。 请查看[Interactive map of featuresets](http://tradingview.github.io/featuresets.html)，找到您需要的内容。

* 有不可隐藏的基本元素，但如果您仍然想要摆脱这些元素，您可以使用[CSS自定义](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#custom_css_url-since-14)。 请注意，DOM产品的名称，类别和标识符可能会在将来版本的产品中更改，而不会有任何通知。
</details>

## 其他问题

<details>
<summary><b>1. [[Widget|http://tradingview.com/widget/]], [[Charting Library|https://www.tradingview.com/HTML5-stock-forex-bitcoin-charting-library/]] 和 [[Trading Terminal|https://www.tradingview.com/trading-terminal/]] 都有什么区别?</b></summary>
<p>

<p>
    [[Widget|http://tradingview.com/widget/]] 连接到tradingview数据。完美的网站，博客和论坛，你需要一个快速和免费的解决方案。集成只是简单地剪切和粘贴预制的iframe代码。它有很多显示模式。
<p>
    [[Charting Library|https://www.tradingview.com/HTML5-stock-forex-bitcoin-charting-library/]] 是使用您自己的数据的图表。这是一个独立的解决方案，您可以下载，托管在您的服务器上，连接自己的数据，并在您的网站/应用程序中免费使用。
<p>
    [[Trading Terminal|https://www.tradingview.com/trading-terminal/]] 是一个独立的产品，授权给经纪商。它包括所有功能的图表库可用，但它也有交易功能，多种图表布局名单，详情，新闻插件和其他先进的工具。它有它自己的许可费与它相关联的费用。

</details>

<details>
<summary><b>2. 如何添加自定义指标?</b></summary>
<p>

<p>
    目前只有一种方法来添加自定义指标。 它在[[dedicated article|https://github.com/tradingview/charting_library/wiki/Creating-Custom-Studies]]中有描述。
</details>