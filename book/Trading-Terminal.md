# 交易终端

---

![](/images/trading.png)此页面上的所有内容仅与交易终端相关。

交易终端是一个即用型产品，为那些想要有一个全功能图表解决方案，以及从图表交易的能力。This 产品基于图表库，并包含其所有功能，而且还包含一大堆新功能。 交易终端资源[链接](https://github.com/tradingview/trading_platform)。

该产品正在开发中，因此一些功能还没有。 它们被标记为：

## 交易终端功能

#### 交易能力

你可以在图表上进行交易，而你所要做的就是实现你的目标， \[\[Trading Controller\]\] 并将其插入图表窗口小部件。

\[\[images/tt\_trading.png\]\]

#### 高级订单对话框

完全可定制的订单对话框允许设置市场/限价/止损/止损限价，输入止损和收益价格，  
选择到期并计算风险。

\[\[images/tt\_orderdialog.png\]\]

#### 账户管理器

您可以在底部的交互式表格中显示订单/头寸和帐户信息，也可以在其中嵌入任何其他小部件。

###### 详细了解此功能：

* \[\[如何启用账户管理器\|Account-Manager\]\]

#### DOM小部件

You can display orders/positions and Level 2 data in an interactive DOM.  
您可以在交互式DOM中显示订单/位置以及Level-2数据。

\[\[images/tt\_dom.png\]\]

#### 边栏报价（商品详情和观察列表）

在交易终端中，您可以拥有观察列表和商品详情窗口小部件（请参阅下面的快照）功能。

\[\[images/tt\_top.png\]\]

###### 详细了解此功能：

* \[\[如何启用侧边栏报价\|Widget-Constructor\#chart-widgetbar\]\]
* 如何提供报价数据：取决于您使用什么样的数据集成 --\[\[JS API\|JS-Api\#chart-trading-terminal-specific\]\] 或 \[\[UDF\|UDF\#quotes\]\]

#### 边栏市场新闻Feed

您可以在图表的侧栏中直接显示新闻提要。 我们对新闻Feed的支持是灵活的：例如，您可以为不同类型的商品提供不同的Feed，等等。

\[\[images/tt\_bottom.png\]\]

###### 详细了解此功能：

* \[\[如何启用侧边栏新闻\|Widget-Constructor\#chart-widgetbar\]\]
* \[\[如何设置要使用的Feed\|Widget-Constructor\#chart-rss\_news\_feed\]\]

#### 多重图表布局

在同一个小部件中，您可以有多个图表。 这使您的用户能够使用更广泛的策略，以及更广泛的市场观点的能力。 您不必做任何事情来启用或调整它：它可以开箱即用。

\[\[images/tt\_charts.png\]\]

#### 日本图表类型：卡吉图、砖形图、OX（点数）图、新价线

这些类型的图表将可以开箱即用，就像Heikin Ashi（平均K线图）在图表库中可用一样。

#### 量能分布图 :clock4:

这项研究将需要一些服务器端的支持。 准备好后，我们会提供更多的细节。

#### 绘图工具模板 :clock4:

此功能将需要您的后端支持。 我们将更新我们的开源数据后端以支持此功能，因此请考虑使用它来最大限度地减少您的工作。

## 如何使用文档

由于交易终端基于图表库，我们决定将文档合并到单个维基中。 所以所有的文档都在一个地方。 您唯一应该记住的是，特定于交易终端的功能标有这个可爱的绿色标记：图表：。

# See Also

* \[\[How to connect your trading to the charts\|Trading Controller\]\]
* \[\[Widget methods specific for Trading Terminal\|Widget-Methods\#chart-trading-terminal\]\]
* \[\[Widget constructor parameters specific for Trading Terminal\|Widget-Constructor\#chart-trading-terminal-only\]\]



