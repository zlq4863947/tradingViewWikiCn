# 研究覆盖

可以使用`studies_overrides`参数为新创建的指标设置默认样式和输入值。 它的值应该是一个对象，其中key是一个属性被改变的路径，value是它的新值。 例：
```
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

### 如何设置研究名称

您应该在新建研究对话框中使用研究名称，但采用小写形式。 所以，如果你想覆盖默认的EMA长度，尝试使用`moving average exponential.lengt`h。 同样的原则适用于输入名称：使用名称，您可以在“研究属性”对话框中看到它们（也使用小写字母）。 例如：`stochastic.smooth d`。

### 比较

您可以通过`比较`自定义新的系列。 使用`compare.plot`自定义行和`compare.source`来更改价格来源：

```
"compare.plot.color": "#000000",
"compare.source": "high"
```


# 语法

属性路径是用点（`.`）分割的一组小写标识符。 路径格式如下所述。

**备注**：如果一个plot/band/area/input名称是相同的，则您会得到一个错误。 在这种情况下，您可以通过在路径中添加`：plot`，`：band`，`：area`或`：input`来指定一个确切的目的地。 （例如`short：plot.color`）

### Study input
格式: `indicator_name.input_name`

* **indicator_name**: 使用名称，您可以在“指标器”对话框中看到它。
* **input_name**: 使用名称，你可以在指标的属性对话框中看到它（例如`show ma`）

例如: `volume.show ma`, `bollinger bands.length`

### Plot property
Format: `indicator_name.plot_name.property_name`

* **indicator_name**:  < ... >
* **plot_name**: as you can see it in indicator's properties dialog (for example, `Volume` or `Plot`)
* **property_name**: one of the following:
  * **transparency**
  * **linewidth**
  * **plottype**. Supported plot types are:
    * line
    * histogram
    * cross
    * area
    * columns
    * circles
    * line_with_breaks
    * area_with_breaks


Examples: `volume.volume.transparency`, `bollinger bands.median.linewidth`

### Plot colors
Format: `indicator_name.plot_name.color<.color_index>`

* **indicator_name**:  < ... >
* **plot_name**:  < ... >
* **color**. It is just a keyword.
* **color_index** (optional): color index (if any). It's just an ordinal number of a color for this plot. I.e., to replace the color which is green by default for Volume, one should use `color_index = 1`.

**Remark 1**: `color.0` is a synonym of `color` .So paths `volume.volume.color.0` and `volume.volume.color` are treated to be the same.

**Remark 2**: For now, customizing area fill color and transparency is not supported.

**Limitations**:
* Only `#RRGGBB` format is supported for colors. Do not use short format `#RGB`.
* Transparency varies in [0..100] range. 100 means plot is fully opaque.
* Thickness is an integer.

### Study options
Format: `indicator_name.options.option_name`

* **indicator_name**:  < ... >
* **options**:  Keyword
* **option_name**: name of option you want to assign. Supported values are:
  * **showStudyArguments**: boolean, controls arguments visibility in header
  * **showLastValue**: boolean, controls visibility of price scale labels

Examples: `volume.options.showStudyArguments`, `volume.options.showLastValue`

### Default precision
Since 1.6 you can change default precision of studies using `name.precision` format. Example:
`"average true range.precision": 8`
