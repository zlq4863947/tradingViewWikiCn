# 覆盖

本主题包含图表属性说明。 这些属性被处理作为可定制的。 其他属性的自定义则不被支持。

文件的格式:

`<属性路径>: <图表库的默认值>`

```javascript
// 支持的值: large, medium, small, tiny
volumePaneSize: "large"

// 在文本编辑器中可用的字体（即，在`文本`绘图工具属性对话框中）
editorFontsList: ['Verdana', 'Courier New', 'Times New Roman', 'Arial']

paneProperties.backgroundType: 'solid' // or 'gradient'
paneProperties.background: "#ffffff"
paneProperties.backgroundGradientStartColor: "#ffffff"
paneProperties.backgroundGradientEndColor: "#ffffff"
paneProperties.vertGridProperties.color: "#E6E6E6"
paneProperties.vertGridProperties.style: LINESTYLE_SOLID
paneProperties.horzGridProperties.color: "#E6E6E6"
paneProperties.horzGridProperties.style: LINESTYLE_SOLID
paneProperties.crossHairProperties.color: "#989898"
paneProperties.crossHairProperties.width: 1
paneProperties.crossHairProperties.style: LINESTYLE_DASHED

// 边际（百分比）。 用于自动缩放。
paneProperties.topMargin: 5
paneProperties.bottomMargin: 5

paneProperties.axisProperties.autoScale: true
paneProperties.axisProperties.lockScale: false
paneProperties.axisProperties.percentage: false
paneProperties.axisProperties.indexedTo100: false
paneProperties.axisProperties.log: false
paneProperties.axisProperties.alignLabels: true
paneProperties.axisProperties.isInverted: false

paneProperties.legendProperties.showStudyArguments: true
paneProperties.legendProperties.showStudyTitles: true
paneProperties.legendProperties.showStudyValues: true
paneProperties.legendProperties.showSeriesTitle: true
paneProperties.legendProperties.showSeriesOHLC: true
paneProperties.legendProperties.showLegend: true
paneProperties.legendProperties.showBarChange: true
paneProperties.legendProperties.showOnlyPriceSource: true

scalesProperties.backgroundColor : "#ffffff"
scalesProperties.fontSize: 11
scalesProperties.lineColor : "#555"
scalesProperties.textColor : "#555"
scalesProperties.scaleSeriesOnly : false
scalesProperties.showSeriesLastValue: true
scalesProperties.showSeriesPrevCloseValue: false
scalesProperties.showStudyLastValue: false
scalesProperties.showStudyPlotLabels: false
scalesProperties.showSymbolLabels: false
scalesProperties.showCurrency: true
scalesProperties.showUnit: true

timeScale.rightOffset: 5

timezone: "Etc/UTC" #查看支持的时区列表（在Symbology页面中的timezone）的可用值

// 数据列风格。 请参阅下面的支持的值
//  Bars = 0            #美国线
//  Candles = 1         #K线图
//  Line = 2            #线形图
//  Area = 3            #面积图
//  Heiken Ashi = 8     #平均K线图
//  Hollow Candles = 9  #空心K线图
//  Renko = 4           #转形图
//  Kagi = 5            #卡吉图
//  Point&Figure = 6    #点数图
//  Line Break = 7      #新价图
mainSeriesProperties.style: 1

mainSeriesProperties.showCountdown: true
mainSeriesProperties.visible:true
mainSeriesProperties.showPriceLine: true
mainSeriesProperties.priceLineWidth: 1
mainSeriesProperties.priceLineColor: ''
mainSeriesProperties.showPrevClosePriceLine: false
mainSeriesProperties.prevClosePriceLineWidth: 1
mainSeriesProperties.prevClosePriceLineColor: 'rgba( 85, 85, 85, 1)'
mainSeriesProperties.lockScale: false
mainSeriesProperties.minTick: "default"

mainSeriesProperties.minTick: minTick 值是 3 个值的字符串表示: pricescale, minmove, fractional (见下文)
mainSeriesProperties.priceAxisProperties.autoScale:true             (see #749)
mainSeriesProperties.priceAxisProperties.autoScaleDisabled:false    (see #749)
mainSeriesProperties.priceAxisProperties.percentage:false
mainSeriesProperties.priceAxisProperties.percentageDisabled:false
mainSeriesProperties.priceAxisProperties.log:false
mainSeriesProperties.priceAxisProperties.logDisabled:false

// 可能的值包括: description, ticker, ticker-and-description
mainSeriesProperties.statusViewStyle.symbolTextSource: 'description'

symbolWatermarkProperties.color : "rgba(0, 0, 0, 0.00)"

// 不同的图表类型默认值

// K线图样式
mainSeriesProperties.candleStyle.upColor: "#6ba583"
mainSeriesProperties.candleStyle.downColor: "#d75442"
mainSeriesProperties.candleStyle.drawWick: true
mainSeriesProperties.candleStyle.drawBorder: true
mainSeriesProperties.candleStyle.borderColor: "#378658"
mainSeriesProperties.candleStyle.borderUpColor: "#225437"
mainSeriesProperties.candleStyle.borderDownColor: "#5b1a13"
mainSeriesProperties.candleStyle.wickUpColor: 'rgba( 115, 115, 117, 1)'
mainSeriesProperties.candleStyle.wickDownColor: 'rgba( 115, 115, 117, 1)'
mainSeriesProperties.candleStyle.barColorsOnPrevClose: false

// 空心K线图样式
mainSeriesProperties.hollowCandleStyle.upColor: "#6ba583"
mainSeriesProperties.hollowCandleStyle.downColor: "#d75442"
mainSeriesProperties.hollowCandleStyle.drawWick: true
mainSeriesProperties.hollowCandleStyle.drawBorder: true
mainSeriesProperties.hollowCandleStyle.borderColor: "#378658"
mainSeriesProperties.hollowCandleStyle.borderUpColor: "#225437"
mainSeriesProperties.hollowCandleStyle.borderDownColor: "#5b1a13"
mainSeriesProperties.hollowCandleStyle.wickColor: "#737375"

// 平均K线图样式
mainSeriesProperties.haStyle.upColor: "#6ba583"
mainSeriesProperties.haStyle.downColor: "#d75442"
mainSeriesProperties.haStyle.drawWick: true
mainSeriesProperties.haStyle.drawBorder: true
mainSeriesProperties.haStyle.borderColor: "#378658"
mainSeriesProperties.haStyle.borderUpColor: "#225437"
mainSeriesProperties.haStyle.borderDownColor: "#5b1a13"
mainSeriesProperties.haStyle.wickColor: "#737375"
mainSeriesProperties.haStyle.barColorsOnPrevClose: false

// 美国线样式
mainSeriesProperties.barStyle.upColor: "#6ba583"
mainSeriesProperties.barStyle.downColor: "#d75442"
mainSeriesProperties.barStyle.barColorsOnPrevClose: false
mainSeriesProperties.barStyle.dontDrawOpen: false

// 线形图样式
mainSeriesProperties.lineStyle.color: "#2962FF"
mainSeriesProperties.lineStyle.linestyle: LINESTYLE_SOLID
mainSeriesProperties.lineStyle.linewidth: 1
mainSeriesProperties.lineStyle.priceSource: "close"

// 面积图样式
mainSeriesProperties.areaStyle.color1: "#606090"
mainSeriesProperties.areaStyle.color2: "#2962FF"
mainSeriesProperties.areaStyle.linecolor: "#2962FF"
mainSeriesProperties.areaStyle.linestyle: LINESTYLE_SOLID
mainSeriesProperties.areaStyle.linewidth: 1
mainSeriesProperties.areaStyle.priceSource: "close"

// 基准线样式
mainSeriesProperties.baselineStyle.baselineColor: "rgba( 117, 134, 150, 1)"
mainSeriesProperties.baselineStyle.topFillColor1: "rgba( 83, 185, 135, 0.1)"
mainSeriesProperties.baselineStyle.topFillColor2: "rgba( 83, 185, 135, 0.1)"
mainSeriesProperties.baselineStyle.bottomFillColor1: "rgba( 235, 77, 92, 0.1)"
mainSeriesProperties.baselineStyle.bottomFillColor2: "rgba( 235, 77, 92, 0.1)"
mainSeriesProperties.baselineStyle.topLineColor: "rgba( 83, 185, 135, 1)"
mainSeriesProperties.baselineStyle.bottomLineColor: "rgba( 235, 77, 92, 1)"
mainSeriesProperties.baselineStyle.topLineWidth: 1
mainSeriesProperties.baselineStyle.bottomLineWidth: 1
mainSeriesProperties.baselineStyle.priceSource: "close"
mainSeriesProperties.baselineStyle.transparency: 50
mainSeriesProperties.baselineStyle.baseLevelPercentage: 50

// Hi-Lo style
mainSeriesProperties.hiloStyle.color: "#2962FF"
mainSeriesProperties.hiloStyle.showBorders: true
mainSeriesProperties.hiloStyle.borderColor: "#2962FF"
mainSeriesProperties.hiloStyle.showLabels: true
mainSeriesProperties.hiloStyle.labelColor: "#2962FF"
mainSeriesProperties.hiloStyle.fontFamily: 'Trebuchet MS'
mainSeriesProperties.hiloStyle.fontSize: 7

```

##### LineStyles

```javascript
LINESTYLE_SOLID = 0;
LINESTYLE_DOTTED = 1;
LINESTYLE_DASHED = 2;
LINESTYLE_LARGE_DASHED = 3;
```

### Mintick

查看[此处](Symbology.md#minmov-pricescale-minmove2-fractional) 了解有关 `minTick` 值的更多信息。

下面是所有可能值的列表，表示为一个对象以获得更好的可读性:

```text
{ priceScale: 1, minMove: 1, frac: false },
{ priceScale: 10, minMove: 1, frac: false },
{ priceScale: 100, minMove: 1, frac: false },
{ priceScale: 1000, minMove: 1, frac: false },
{ priceScale: 10000, minMove: 1, frac: false },
{ priceScale: 100000, minMove: 1, frac: false },
{ priceScale: 1000000, minMove: 1, frac: false },
{ priceScale: 10000000, minMove: 1, frac: false },
{ priceScale: 100000000, minMove: 1, frac: false },
{ priceScale: 2, minMove: 1, frac: true },
{ priceScale: 4, minMove: 1, frac: true },
{ priceScale: 8, minMove: 1, frac: true },
{ priceScale: 16, minMove: 1, frac: true },
{ priceScale: 32, minMove: 1, frac: true },
{ priceScale: 64, minMove: 1, frac: true },
{ priceScale: 128, minMove: 1, frac: true },
{ priceScale: 320, minMove: 1, frac: true },
```

除了上述值之外，默认 minTick 还有一个特殊值 - `'default'`.

例子:

```javascript
// reset minTick to default
tvWidget.applyOverrides({ 'mainSeriesProperties.minTick': 'default' });

// set series' minTick to { priceScale: 10000, minMove: 1, frac: false }
tvWidget.applyOverrides({ 'mainSeriesProperties.minTick': '10000,1,false' });

// set default minTick for overlay studies to { priceScale: 10000, minMove: 1, frac: false }
tvWidget.applyStudiesOverrides({ 'overlay.minTick': '10000,1,false' });
```
