## How to show your data as an indicator

Here is an instruction for the case if you have some data which you want to show on the chart like an indicator.

Please follow these few steps:

  1. Contrive a new ticker for your data and set up your server to return valid SymbolInfo for this ticker.
  2. Also set up the server to return valid history data for this ticker.
  3. Use the following indicator template and fill in all placeholder values: name, descriptions, and the ticker. Also modify the default style of plot, if required.

```javascript
{
	// Replace the <study name> with your study name
	// It will be used internally by the Charting Library
	name: "<study name>",
	metainfo: {
		"_metainfoVersion": 40,
		"id": "<study name>@tv-basicstudies-1",
		"scriptIdPart": "",
		"name": "<study name>",
		// This description will be displayed in the Indicators window
		// It is also used as a "name" argument when calling createStudy method
		"description": "<study description>",
		// This description will be displayed on the chart
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

					// Plot line width.
					"linewidth": 2,

					// Plot type:
					//	1 - Histogramm
					//	2 - Line
					//	3 - Cross
					//	4 - Area
					//	5 - Columns
					//	6 - Circles
					//	7 - Line With Breaks
					//	8 - Area With Breaks
					"plottype": 2,

					// Show price line?
					"trackPrice": false,

					// Plot transparency, in percent.
					"transparency": 40,

					// Plot color in #RRGGBB format
					"color": "#0000FF"
				}
			},

			// Precision of the study's output values
			// (quantity of digits after the decimal separator).
			"precision": 2,

			"inputs": {}
		},
		"styles": {
			"plot_0": {
				// Output name will be displayed in the Style window
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

			// Define the symbol to be plotted.
			// Symbol should be a string.
			// You can use PineJS.Std.ticker(this._context) to get the selected symbol's ticker.
			// For example,
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

			// You can use following built-in functions in PineJS.Std object:
			// 	open, high, low, close
			//	hl2, hlc3, ohlc4
			var v = PineJS.Std.close(this._context);
			return [v];
		}
	}
}
```

  4. Save the indicator into the custom indicators file with the following structure:

```javascript
__customIndicators = [
	*** your indicator object, created from template ***
];
```

Note, that indicators file is a JavaScript source file that just defines an array of indicator objects. So, you can place several indicators in it, or combine them with the ones we compiled for you.

  5. Use [indicators_file_name](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#indicators_file_name) option of Widget's constructor to load custom indicators from the indicators file.
  6. Update your widget's initialization code to [create](https://github.com/tradingview/charting_library/wiki/Chart-Methods#createstudyname-forceoverlay-lock-inputs-callback-overrides) this indicator when chart is ready.

**Example**

Assume you want to show user's equity curve on his charts. You will have to do the following:

* Create a name for the new ticker. Assume it will be `#EQUITY` ticker. You can use any name you can imagine.
* Change your server's code to resolve this ticker as a valid symbol. Return the minimal valuable SymbolInfo for this case.
* Make the server to return valid history for this ticker. I.e., the server could ask your database for equity history and return this data just as you return the history for generic symbols (like, say, `AAPL`).
* Adopt the indicator template mentioned above and create the indicators file (or add a new indicator to the existing indicators file). This could be something like the following:

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

					// Make the line thinner
					"linewidth": 1,

					// Plot type is Line
					"plottype": 2,

					// Show price line
					"trackPrice": true,

					"transparency": 40,

					// Set the dark red color for the plot line
					"color": "#880000"
				}
			},

			// Precision is one digit, like 777.7
			"precision": 1,

			"inputs": {}
		},
		"styles": {
			"plot_0": {
				// Output name will be displayed in the Style window
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

* Plug the indicator into Charting Library using [indicators_file_name](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#indicators_file_name) option.
* Change your widget's initialization code. Add something like the following:

```javascript
	widget = new TradingView.Widget(/* ... */);

	widget.onChartReady(function() {
		widget.chart().createStudy('Equity', false, true);
	});
```
