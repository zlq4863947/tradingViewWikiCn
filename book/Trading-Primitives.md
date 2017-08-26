Trading Primitives is a low-level mechanic designed to give you the most detailed control over trading primitives behavior.

# Generic data
### Properties
You can use special value `inherit` for some properties of Trading Lines objects. Thiw will make the Library to use its factory defaults for this property. You can enable `trading_options` feature to show Trading GUI controls in chart properties window.

You can’t control visibility of specific object - generic properties for positions, orders and executions are available for user in Trading tab of Chart Properties window.

### Colors and Fonts
You can use following string formats for setting colors:

1. "#RGB"
2. "#RRGGBB"
3. "rgb(red, green, blue)"
4. "rgba(red, green, blue, alpha)"

You can use following string format for setting fonts: `<bold> <italic> <size>pt <family>`. Colors and fonts strings will be automatically parsed to determine GUI controls values.

### Line Styles

Following line styles are supported:

Style|Value
---|---
Solid|0
Dotted|1
Dashed|2

### Callbacks
1. You can use `this` keyword to access API-object from within callback function
2. You can pass two arguments to callback registration function - in this case first argument is an object which will be passed as first argument to callback function (see examples).
3. If callback isn’t set, then respective button will be hidden (affects `onReverse`, `onClose` and `onCancel` callbacks).
