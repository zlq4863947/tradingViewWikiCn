## 图形API

### isSelectionEnabled()

如果用户无法选择图形，则返回`true`。

### setSelectionEnabled(enable)

1. `enable` - `true` 或 `false`

启用或禁用图形选择（请参阅`createMultipointShape`的`disableSelection`选项）。

### isSavingEnabled()

如果图形未保存在图表上，则返回`true`。

### setSavingEnabled(enable)

1. `enable` - `true` or `false`

启用或禁用在图表布局中保存图形（请参阅`createMultipointShape`的`disableSave`选项）。

### isShowInObjectsTreeEnabled()

如果图形显示在`对象树`对话框中，则返回`true`。

### setShowInObjectsTreeEnabled(enabled)

1. `enabled` - `true` 或 `false`

启用或禁用“对象树”对话框中的图形显示。

### isUserEditEnabled()

如果用户可以删除/更改/隐藏图形，则返回`true`。

### setUserEditEnabled(enabled)

1. `enabled` - `true` 或 `false`

启用或禁用用户删除/更改/隐藏图形

### bringToFront()

将线条工具放在所有其他图表对象的顶部。

### sendToBack()

将线条工具放在所有其他图表对象后面。

### getProperties()

获取图形的所有属性。

### setProperties(properties)

1. `properties` - 具有新属性的对象。 它应该与[getProperties](#getproperties)中的对象具有相同的结构。
     它只能包含您要覆盖的属性。

设置图形的属性。

### getPoints()

Returns the points of the shape - an array of the [PricedPoint](#pricedpoint) objects.
返回图形的点 - [PricedPoint](#pricedpoint) 对象的数组。

### setPoints(points)

1. `points` - 一个带有图形新点的数组。 每个图形的格式与[createMultipointShape](Chart-Methods.md#createmultipointshapepoints-options)方法的`points`参数相同。

设置图形的新点。

## 原始类型

### PricedPoint

具有以下属性的对象：

* `price` - 点的价格
* `time` - 点的时间
