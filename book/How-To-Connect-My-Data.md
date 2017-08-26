# 如何连接我的数据

---

**图表库并不包含市场数据**，你必须提供所需格式的数据。示例数据引擎集成了雅虎金融API的历史数据。图表可以用两种方式接收数据：

1. 使用服务器推送技术实时更新，例如通过WebSocket。这样你的图表将会自动更新价格。为了达到这个目的，你必须使用JavaScript API并且准备好自己的传输方法。

2. 在PULL /脉冲\(pulse\)/刷新的基础上进行更新（如今天的大多数基于Web的图表），其中图表数据每X秒更新一次（图表客户端将要求服务器模拟PUSH更新），或者被用户手动重新加载。 为此，请使用UDF协议并编写自己的datafeed包装器。

### JavaScript API 或者 UDF?

![](https://github.com/tradingview/charting_library/wiki/images/udf_or_jsapi.png)

## UDF scheme

![](https://github.com/tradingview/charting_library/wiki/images/udf.png)

## JSAPI scheme

![](https://github.com/tradingview/charting_library/wiki/images/jsapi.png)

上图显示了UDF和JSAPI之间的区别。 必要的图表库部分是蓝色的。 红色部分（默认数据传输）包含在默认包中（具有非最小化的源代码），并可以被替换。 您可能会看到默认数据传输实现JS API与图表交互。 也可以使用默认传输实现UDF协议与服务器通信。

1. **如果您已经准备好了数据传输**（websocket流式传输，轮询或任何其他传输），或者如果您不需要流式传输数据 - 请使用我们的JavaScript API，这是非常紧凑和简单的实现。 您必须创建一个小型客户端数据适配器来传输数据到我们的图表。

2. **如果您没有任何传输**，并且不需要数据流传输数据（例如，您所需要的数据脉冲），那么您将必须创建（或使用）至少一个服务器端的datafeed包装器。 您可以使用任何语言和技术来实现这一目的：您的包装器只需要支持我们的数据交换协议（我们称之为UDF），以便能够为您的图表提供数据。 您将必须使用您最喜欢的语言在后端和我们的图表之间创建一个小型服务器端数据适配器。

### 想要例子 ?

github上可以获得UDF-compatible\(case \#2 described above\) 服务器端包装器的实现示例。 它使用Yahoo!数据。

A sample of**JS API**implementation \(and UDF client-side at the same time\) is a part of Charting Library package \(see\_datafeed.js\_file\).

If you use Ruby on Rails you can see the gem for Charting Library kindly provided by our user[bobstar6](https://github.com/bobstar6)[here](https://github.com/tradingview/tv_chart_rails).

