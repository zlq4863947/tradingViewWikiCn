One can set default style and inputs values for newly created indicators using `studies_overrides` parameter. Its value is expected to be an object where key is a path to property being changed and value is the new value for it. Example:
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

In the example above, in example, all created Bollinger Bands will have upper line width = 7 (unless you create it through API and have specified another value for this line).

### How to set study name

You should use studies names as-they-are in the Insert Study dialog, but in lower case. So if you want to override default EMA's length, try using `moving average exponential.length`. The same principle works for inputs names: use names as you can see them in Study Properties dialog (use lower case also). Example: `stochastic.smooth d`.

### Compare

You can customize new series added via `Compare`. Use `compare.plot` to customize the line and `compare.source` to change the price source:

```
"compare.plot.color": "#000000",
"compare.source": "high"
```


# Syntax

Property path is a set of lower-case identifiers splitted with dot (`.`). Path formats are described below.

**Remark**: If a plot/band/area/input name is the same you can get an error. In this case you can specify an exact destination that you want to change by adding `:plot`, `:band`, `:area` or `:input` to the path. (e.g. `short:plot.color`)

### Study input
Format: `indicator_name.input_name`

* **indicator_name**: use name as you can see it in `Indicators` dialog.
* **input_name**: use name as you can see it in indicator's properties dialog (for example, `show ma`)

Examples: `volume.show ma`, `bollinger bands.length`

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
