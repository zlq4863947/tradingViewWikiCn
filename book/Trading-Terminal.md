:chart: All content on this page is relevant for Trading Terminal only.

Trading Terminal is a ready-to-use product for those who want to have a great charting solution along with the ability to trade right from the chart. This product is based on Charting Library and includes all its functionality, but also contains a bunch of new features. Trading Terminal repo is [[here|https://github.com/tradingview/trading_platform]].

The product is under development so some features are not there yet. They are marked with :clock4:.

## Trading Terminal Features

#### Trading Capabilities
You can trade right from the chart, and all you have to do to make this work is to implement your [[Trading Controller]] and plug it into the chart widget.

[[images/tt_trading.png]]

#### Advanced Order Dialog
Fully customizable order dialog allows to place Market/Limit/Stop/Stop Limit orders, enter Stop Loss and Take Profit prices,
choose expiration and calculate risks.

[[images/tt_orderdialog.png]]

#### Account Manager
You can display orders/positions and account information in an interactive table at the bottom or embed any other widget there.

###### Read more about this feature:
  * [[How to enable Account Manager|Account-Manager]]

#### DOM Widget
You can display orders/positions and Level 2 data in an interactive DOM.

[[images/tt_dom.png]]

#### Sidebar Quotes (Symbols Details & Watchlist)
In Trading Terminal, you can have the Watchilsts and Details widget (see the snapshot below) functionality.

[[images/tt_top.png]]

###### Read more about this feature:
  * [[How to enable sidebar quotes|Widget-Constructor#chart-widgetbar]]
  * How to provide the data for quotes: depends on what kind of data integration do you use --[[JS API|JS-Api#chart-trading-terminal-specific]] or [[UDF|UDF#quotes]]

#### Sidebar Market News Feed
You can have the news feed right in the side bar of the chart. Our support for the news feeds is flexible: so, in example, you can have different feeds for different kinds of symbols and so on.

[[images/tt_bottom.png]]

###### Read more about this feature:
  * [[How to enable sidebar news|Widget-Constructor#chart-widgetbar]]
  * [[How to set up which feeds to use|Widget-Constructor#chart-rss_news_feed]]

#### Miltiple charts layout
You can have multiple charts inside if the same widget. This gives your user the ability to use wide range of the strategies, as well as the ability to have a broad view of the market. You don't have to do anythng to enable or tweak it: it works out-of-the-box.

[[images/tt_charts.png]]

#### Japanese charts types: Kagi, Renko, Point & Figure, Line Break
These types of charts will be available out-of-the-box, just like Heikin Ashi is available in Charting Library.

#### Volume Profile :clock4:
This study will require some server-side support. We'll provide more detals when it's ready.

#### Drawing Tools Templates :clock4:
This functionality will require the support from your backend. We'll update our open-source data backend to support this feature also, so consider using it to minimize the efforts from your side.

## How To Work With The Docs
Since Trading Terminal is based on Charting Library, we decided to merge the documentation into the single Wiki. So all the docs are in one place. The only thing you should remember is that features which are specific to Trading Terminal are marked with this cute green mark :chart:.


# See Also
  * [[How to connect your trading to the charts|Trading Controller]]
  * [[Widget methods specific for Trading Terminal|Widget-Methods#chart-trading-terminal]]
  * [[Widget constructor parameters specific for Trading Terminal|Widget-Constructor#chart-trading-terminal-only]]
