# 创建自定义指标

---

## 如何显示您的数据作为一个指标

如果您想要在图表上显示一些数据，例如指标，则此处为食用说明。

请遵循以下几个步骤:

1. 为您的数据创建一个新的ticker，并设置您的服务器返回此ticker有效的SymbolInfo。
1. 设置服务器以返回此ticker的有效历史数据。
1. 使用以下指标模板并填写所有占位符(placeholder)的值：名称，说明和代码。 如果需要，还可以修改绘图的默认样式。

```javascript
{
	// 将<study name>替换为您的指标名称
	// 它将由图表库内部使用
	name: "<study name>",
	metainfo: {
		"_metainfoVersion": 40,
		"id": "<study name>@tv-basicstudies-1",
		"scriptIdPart": "",
		"name": "<study name>",
		// 此说明将显示在指标窗口中
		// 当调用createStudy方法时，它也被用作“name”参数
		"description": "<study description>",
		// 该描述将显示在图表上
		"shortDescription": "<short study description>",

		"is_hidden_study": true,
		"is_price_study": true,
		"isCustomIndicator": true,

		"plots": [{"id": "plot_0", "type": "line"}],
		"defaults": {
			"styles": {
				"plot_0": {
					"linestyle": 0,
					"visible": true,

					// 绘图线宽度
					"linewidth": 2,

					// 绘制类型:
					//	1 - 直方图
					//	2 - 线形图
					//	3 - 十字指针
					//	4 - 山形图
					//	5 - 柱状图
					//	6 - 圆圈图
					//	7 - 中断线
					//	8 - 中断区块
					"plottype": 2,

					// 显示价格线?
					"trackPrice": false,

					// 绘制透明度，百分比。
					"transparency": 40,

					// 以#RRGGBB格式绘制颜色
					"color": "#0000FF"
				}
			},

			// 指标输出值的精度
			// (小数点后的位数)。
			"precision": 2,

			"inputs": {}
		},
		"styles": {
			"plot_0": {
				// 输出的名字将在样式窗口显示
				"title": "-- output name --",
				"histogramBase": 0,
			}
		},
		"inputs": [],
	},

	constructor: function() {
		this.init = function(context, inputCallback) {
			this._context = context;
			this._input = inputCallback;

			// 定义要绘制的商品。
			// 商品应该是一个字符串。
			// 您可以使用PineJS.Std.ticker（this._context）获取所选商品的代码。
			// 例,
			//	var symbol = "AAPL";
			//	var symbol = "#EQUITY";
			//	var symbol = PineJS.Std.ticker(this._context) + "#TEST";
			var symbol = "<TICKER>";
			this._context.new_sym(symbol, PineJS.Std.period(this._context), PineJS.Std.period(this._context));
		};

		this.main = function(context, inputCallback) {
			this._context = context;
			this._input = inputCallback;

			this._context.select_sym(1);

			// 您可以在PineJS.Std对象中使用以下内置函数：
			// 	open, high, low, close
			//	hl2, hlc3, ohlc4
			var v = PineJS.Std.close(this._context);
			return [v];
		}
	}
}
```

1. 将指标保存到具有以下结构的自定义指标文件中:

```javascript
__customIndicators = [
	*** 您的指标对象，由模板创建 ***
];
```

请注意，该指标文件是一个JavaScript源文件，它定义了一个指标对象数组。因此，您可以在其中放置多个指标，或者将它们与我们为您编译的指标组合起来。

1. 使用 [indicators_file_name](/book/Widget-Constructor.md#indicatorsfilename) Widget构造函数的选项来从指标文件加载自定义指标。
1. 图表准备好后，更新您的Widget初始化代码以[创建](/book/Chart-Methods.md#createstudyname-forceoverlay-lock-inputs-callback-overrides-options) 此指标。

## 例子

1. 使用[indicators_file_name](Widget-Constructor.md#indicators_file_name)选项将指标添加到图表库。
1. 更改Widget的初始化代码。 这是一个例子。

    ```javascript
    widget = new TradingView.widget(/* ... */);

    widget.onChartReady(function() {
        widget.chart().createStudy('<indicator-name>', false, true);
		});
    ```
		
### 请求另一个商品代码的数据

假设您希望在图表上显示用户的权益曲线。你必须做以下事情：

* 为新的代码创建一个名称。 假设它为 `#EQUITY` 代码。 您可以使用您想像到的任何名字。
* 更改服务器的代码以将此代码作为有效商品。 为此返回最小的有效SymbolInfo。
* 使服务器返回有效的历史记录。 即，服务器可以询问您的数据库的股权历史记录，并返回此数据，就像返回普通商品的历史记录一样（例如 `AAPL`)。
* 采用上述指标模板，创建指标文件（或向现有指标文件添加新指标）。

例如：

```javascript
__customIndicators = [
{
	name: "Equity",
	metainfo: {
		"_metainfoVersion": 40,
		"id": "Equity@tv-basicstudies-1",
		"scriptIdPart": "",
		"name": "Equity",
		"description": "Equity",
		"shortDescription": "Equity",

		"is_hidden_study": true,
		"is_price_study": true,
		"isCustomIndicator": true,

		"plots": [{"id": "plot_0", "type": "line"}],
		"defaults": {
			"styles": {
				"plot_0": {
					"linestyle": 0,
					"visible": true,

					// 使线条变细
					"linewidth": 1,

					// 绘制类型为线性图
					"plottype": 2,

					// 显示价格线
					"trackPrice": true,

					"transparency": 40,

					// 为图线设置深红色。
					"color": "#880000"
				}
			},

			// 精度是一位数，如777.7
			"precision": 1,

			"inputs": {}
		},
		"styles": {
			"plot_0": {
				// 输出名字在样式窗口显示
				"title": "Equity value",
				"histogramBase": 0,
			}
		},
		"inputs": [],
	},

	constructor: function() {
		this.init = function(context, inputCallback) {
			this._context = context;
			this._input = inputCallback;

			var symbol = "#EQUITY";
			this._context.new_sym(symbol, PineJS.Std.period(this._context), PineJS.Std.period(this._context));
		};

		this.main = function(context, inputCallback) {
			this._context = context;
			this._input = inputCallback;

			this._context.select_sym(1);

			var v = PineJS.Std.close(this._context);
			return [v];
		}
	}
}
];
```

* 使用[indicators_file_name](/book/Widget-Constructor.md#indicatorsfilename) 选项将指标插入图表。
* 更改Widget的初始化代码。 添加如下内容：

```javascript
	widget = new TradingView.Widget(/* ... */);

	widget.onChartReady(function() {
		widget.chart().createStudy('Equity', false, true);
	});
```

### 着色K线

```javascript
__customIndicators = [
    {
        name: "Bar Colorer Demo",
        metainfo: {
            _metainfoVersion: 42,

            id: "BarColoring@tv-basicstudies-1",

            name: "BarColoring",
            description: "Bar Colorer Demo",
            shortDescription: "BarColoring",
            scriptIdPart: "",
            is_price_study: true,
            is_hidden_study: false,
            isCustomIndicator: true,

            isTVScript: false,
            isTVScriptStub: false,
            defaults: {
                precision: 4,
                palettes: {
                    palette_0: {
                        // 调色板颜色
                        // 将其更改为您喜欢的默认颜色，
                        // 但请注意，用户可以在“样式”选项卡中更改它们
                        // 指标属性
                        colors: [
                            { color: "#FFFF00" },
                            { color: "#0000FF" }
                        ]
                    }
                }
            },
            inputs: [],
            plots: [{
                id: "plot_0",

                // plot类型应设置为 'bar_colorer'
                type: "bar_colorer",

                // 这是定义的调色板的名称
                // 在 'palettes' 和 'defaults.palettes' 部分
                palette: "palette_0"
            }],
            palettes: {
                palette_0: {
                    colors: [
                        { name: "Color 0" },
                        { name: "Color 1" }
                    ],

                    // 值之间的映射
                    // 返回脚本和调色板颜色
                    valToIndex: {
                        100: 0,
                        200: 1
                    }
                }
            }
        },
        constructor: function() {
            this.main = function(context, input) {
                this._context = context;
                this._input = input;

                var valueForColor0 = 100;
                var valueForColor1 = 200;

                // 在这里执行计算并返回其中一个常量
                // 在'valToIndex'映射中指定为键
                var result =
                    Math.random() * 100 % 2 > 1 ? // we randomly select one of the color values
                        valueForColor0 : valueForColor1;

                return [result];
            }
        }
    }
];
```
