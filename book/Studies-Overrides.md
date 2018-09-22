# 指标覆盖

可以使用`studies_overrides`参数为新创建的指标设置默认样式和输入值。 它的值应该是一个对象，其中key是一个属性被改变的路径，value是它的新值。 例：
```javascript
studies_overrides: {
    "volume.volume.color.0": "#00FFFF",
    "volume.volume.color.1": "#0000FF",
    "volume.volume.transparency": 70,
    "volume.volume ma.color": "#FF0000",
    "volume.volume ma.transparency": 30,
    "volume.volume ma.linewidth": 5,
    "volume.show ma": true,
    "volume.options.showStudyArguments": false,
    "bollinger bands.median.color": "#33FF88",
    "bollinger bands.upper.linewidth": 7
}
```

在上面的例子中，所有创建的布林带将具有上边线宽度 = 7（除非您通过API创建并为此线指定了另一个值）。

### 如何设置指标名称

您应该在新建指标对话框中使用指标名称，但采用小写形式。 所以，如果你想覆盖默认的EMA长度，尝试使用`moving average exponential.length`。 同样的原则适用于输入名称：使用名称，您可以在“指标属性”对话框中看到它们（也使用小写字母）。 例如：`stochastic.smooth d`。

### 比较

您可以通过`比较`自定义新的系列。 使用`compare.plot`自定义行和`compare.source`来更改价格来源：

```javascript
"compare.plot.color": "#000000",
"compare.source": "high"
```

### 覆盖

从V1.12开始，您可以使用以下属性来自定义`Overlay`：

```javascript
Overlay.style: (bars = 0, candles = 1, line = 2, area = 3, heiken ashi = 8, hollow candles = 9)
Overlay.showPriceLine: boolean

Overlay.candleStyle.upColor: color
Overlay.candleStyle.downColor: color
Overlay.candleStyle.drawWick: boolean
Overlay.candleStyle.drawBorder: boolean
Overlay.candleStyle.borderColor: color
Overlay.candleStyle.borderUpColor: color
Overlay.candleStyle.borderDownColor: color
Overlay.candleStyle.wickColor: color
Overlay.candleStyle.barColorsOnPrevClose: boolean

Overlay.hollowCandleStyle.upColor: color
Overlay.hollowCandleStyle.downColor: color
Overlay.hollowCandleStyle.drawWick: boolean
Overlay.hollowCandleStyle.drawBorder: boolean
Overlay.hollowCandleStyle.borderColor: color
Overlay.hollowCandleStyle.borderUpColor: color
Overlay.hollowCandleStyle.borderDownColor: color
Overlay.hollowCandleStyle.wickColor: color
Overlay.hollowCandleStyle.barColorsOnPrevClose: boolean

Overlay.barStyle.upColor: color
Overlay.barStyle.downColor: color
Overlay.barStyle.barColorsOnPrevClose: boolean
Overlay.barStyle.dontDrawOpen: boolean

Overlay.lineStyle.color: color
Overlay.lineStyle.linewidth: integer
Overlay.lineStyle.priceSource: open/high/low/close
Overlay.lineStyle.styleType: (bars = 0, candles = 1, line = 2, area = 3, heiken ashi = 8, hollow candles = 9)

Overlay.areaStyle.color1: color
Overlay.areaStyle.color2: color
Overlay.areaStyle.linecolor: color
Overlay.areaStyle.linestyle: (solid = 0; dotted = 1; dashed = 2; large dashed = 3)
Overlay.areaStyle.linewidth: integer
Overlay.areaStyle.priceSource: open/high/low/close
```

# 语法

属性路径是用点（`.`）分割的一组小写标识符。 路径格式如下所述。

**备注**：如果一个plot/band/area/input名称是相同的，则您会得到一个错误。 在这种情况下，您可以通过在路径中添加`：plot`，`：band`，`：area`或`：input`来指定一个确切的目的地。 （例如`short：plot.color`）

### Study input
格式: `indicator_name.input_name`

* **indicator_name**: 使用名称，您可以在“指标器”对话框中看到它。
* **input_name**: 使用名称，你可以在指标的属性对话框中看到它（例如`show ma`）

例如: `volume.show ma`, `bollinger bands.length`

### 绘图属性
Format: `indicator_name.plot_name.property_name`

* **indicator_name**:  < ... >
* **plot_name**: 你可以在指标的属性对话框中看到它（例如`Volume`或`Plot`）
* **property_name**: 下列之一:
  * **transparency**
  * **linewidth**
  * **plottype**. 支持的绘图类型有:
    * line（线形图）
    * histogram（直方图）
    * cross（十字指针）
    * area（山形图）
    * columns（柱状图）
    * circles（圆圈图）
    * line_with_breaks（中断线）
    * area_with_breaks（中断区块）


例子: `volume.volume.transparency`, `bollinger bands.median.linewidth`

### 绘图颜色
格式: `indicator_name.plot_name.color<.color_index>`

* **indicator_name**:  < ... >
* **plot_name**:  < ... >
* **color**. 这只是一个关键字。
* **color_index** （可选）：颜色索引（如果有的话）。 这只是一个颜色索引。 也就是说，要取代成交量默认为绿色的颜色，应该使用`color_index = 1`。

**备注1**: `color.0` 是`color`的同义词。因此路径 `volume.volume.color.0` 和 `volume.volume.color` 被视为相同。

**备注2**: 现在，不支持自定义区域填充颜色和透明度。

**限制**:
* 颜色只支持`＃RRGGBB`格式。 不要使用短格式的“＃RGB”。
* 透明度在[0..100]范围内变化。 100意味着完全不透明的。
* 厚度是一个整数。

### 指标选项
格式: `indicator_name.options.option_name`

* **indicator_name**:  < ... >
* **options**:  关键字
* **option_name**: 你想分配的选项名称。 支持的值是：
  * **showStudyArguments**: boolean, 控制标题中的参数可见性
  * **showLastValue**: boolean, 控制价格标签的可见性

例子: `volume.options.showStudyArguments`, `volume.options.showLastValue`

### 默认精度
1.6版本开始，您可以使用`name.precision`格式更改指标的默认精度。 例：
`"average true range.precision": 8`
