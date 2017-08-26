Charting Library allows you to customize its appearance, the way it displays data, default properties and lots of other things.

Customizations are client-side and server-side. Some of them are made through the constructor, other ones can be made using widget/chart methods.

Here is the single place where you can find most used customizations and links to their descriptions.

#### Default instrument and resolution

Change default symbol (instrument) and resolution (interval).

Minimum supported resolution is 1 second.

[[documentation|Widget-Constructor#symbol-interval-mandatory]]

#### Default visible range (time frame)

Change time range of bars for the default resolution

[[documentation|Widget-Constructor#timeframe]]

#### Default visible range for resolutions

Change time range of bars when the resolution is changed by a user. Look at the sample here:

[[documentation|Chart-Methods#onintervalchanged]]

#### Initial timezone

You can set what time zone is used by default. It can be changed by the user in the menu.

[[documentation|Widget-Constructor#timezone-]]

#### Size of the chart

You can place the chart as en element on your web page or use fullscreen mode.

[[Width and Height|Widget-Constructor#width-height]]

[[Fullscreen|Widget-Constructor#fullscreen-]]

[[Autosize|Widget-Constructor#autosize-]]

#### Chart colors

Customize colors of the chart so it perfectly fits in your site.

1. Color of toolbars - [[documentation|Widget-Constructor#toolbar_bg]]
2. Color of the chart - [[documentation|Widget-Constructor#overrides]]

#### Indicators

1. Limit amount of indicators for 1 chart layout - [[documentation|Widget-Constructor#study_count_limit]]
2. Limit what indicators are displayed and can be added - [[documentation|Widget-Constructor#studies_access]]
3. Add your own indicators calculated on a server - [[documentation|Creating-Custom-Studies]]
4. Change default properties of indicators - [[documentation|Widget-Constructor#studies_overrides]]
5. Change default properties on the fly - [[documentation|Widget-Methods#applystudiesoverridesoverrides]]

#### Drawings

1. Limit what drawings are displayed and can be added - [[documentation|Widget-Constructor#drawings_access]]
2. Change default properties of drawings - [[documentation|Widget-Constructor#overrides]]
3. Change default properties on the fly - [[documentation|Widget-Methods#applyoverridesoverrides]]

#### Language

Choose one of more than 20 translations of the library

[[documentation|Widget-Constructor#locale]]

Note: Language is set when the chart is created. It cannot be changed without recreating of a chart.

#### Formatting of numbers and dates

1. Change decimal sign of numbers - [[documentation|Widget-Constructor#numeric_formatting]]
2. Set custom formatters for data and time - [[documentation|Widget-Constructor#customformatters]]
3. Prices are formatted according to the symbol information - [[documentation|Symbology#pricescale-minmov]]

#### Default properties of a chart

You can change any properties that present in the properties dialog.

1. Initially - [[documentation|Widget-Constructor#overrides]]
2. On the fly - [[documentation|Widget-Methods#applyoverridesoverrides]]

#### Server for snapshots

TradingView allows you to save snapshot on its servers, but if you wish you can change it.

[[documentation|Widget-Constructor#snapshot_url]]

#### Show/hide elements of the chart

If you don't need some elements of the chart (toolbars, buttons, other controls), you can hide them:

1. Most of the chart elements can be shown/hidden by using [[Featuresets]]
2. You can add your own CSS - [[documentation|Widget-Constructor#custom_css_url-since-14]]

#### Time frames at the bottom of the chart

Time frame is a time period of bars and a resolution preferred for displaying of the period. You can customize the list.

[[documentation|Widget-Constructor#time_frames]]

#### Initial list of favorite intervals / chart styles

You can select what intervals and chart styles should be shown on the top toolbar by default. A user can change it if `items_favoriting` is enabled in the [[Featuresets]].

[[documentation|Widget-Constructor#favorites]]

#### Resolutions displayed in the menu

1. Full list of resolution is provided in the configuration of the datafeed - [[documentation|JS-Api#supported_resolutions]]
2. Resolutions are enabled or disabled in the list basing on the symbol information - [[documentation|Symbology#supported_resolutions]]
3. Initial list of favorite resolutions can be set - [[documentation|Widget-Constructor#favorites]]

#### Volume indicator

In spite of other indicators Volume is added by default if the instrument supports it ([[documentation|Symbology#has_no_volume-]]).
You can disable this behaviour using [[documentation|Featuresets]].

#### Context menu

You can add new elements to the context menu or hide existing items.

[[documentation|Widget-Methods#oncontextmenucallback]]

#### Custom buttons on the toolbar

You can add your own buttons to the top toolbar of the chart.

[[documentation|Widget-Methods#createbuttonoptions]]

#### :chart: Watch list

It is possible to choose default symbols for the watch list and set read-only state if needed.

[[documentation|Widget-Constructor#chart-widgetbar]]

#### :chart: News feed

You can attach to any RSS feed and even select the feed depending on the instrument type.

[[documentation|Widget-Constructor#chart-rss_news_feed]]
