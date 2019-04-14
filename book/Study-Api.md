## 指标API

### isUserEditEnabled()

如果用户能够`删除/更改/隐藏`指标，则返回`true`。

### setUserEditEnabled(enabled)

1. `enabled` - `true` or `false`

启用或禁用用户的`删除/更改/隐藏`指标。

### getInputsInfo()

返回所有输入的信息 - [StudyInputInfo](#studyinputinfo)对象的数组。

### getInputValues()

返回指标输入的值 - [StudyInputValueItem](#studyinputvalueitem)对象。

### setInputValues(inputs)

1. `inputs` 应该是[StudyInputValueItem](#studyinputvalueitem)对象数组。

设置指标的输入值，它可以只包含您希望更改的输入。

### mergeUp()

指标向上合并（如果可能）

### mergeDown()

指标向下合并（如果可能）

### unmergeUp()

取消指标向上合并（如果可能）

### unmergeDown()

取消指标向下合并（如果可能）

### changePriceScale(priceScale)

1. `priceScale` 应该是一个具有下值之一的字符串:
    * `left` - 将指标附加到左边的价格坐标
    * `right` - 将指标附加到右边的价格坐标
    * `no-scale` - 不要将指标纳入任何价格坐标。该指标将以'No Scale'模式添加
    * `as-series` - 将指标附加到住系列的价格坐标（仅当指标和主系列位于同一窗格时才适用）

改变指标的价格坐标

### isVisible()

如果指标可见，将返回`true`

### setVisible(value)

1. `value` - `true` 或 `false`

显示/隐藏指标

### bringToFront()

将指标置于所有其他图表对象之上。

### sendToBack()

将指标放在所有其他图表对象后面。

### applyOverrides(overrides)

1. `overrides` - 指标的新[overrides](Studies-Overrides.md)

将 `overrides` 应用于指标。

注意: `overrides` 对象key不需要以指标名称开头。key应用于特定的指标。
例如，您应该使用`style`而不是`Overlay.style`来覆盖Overlay指标的当前样式。

## Primitive types

### StudyInputInfo

具有以下key的对象：

* `id` - 指标的输入id
* `name` - 输入的名称
* `type` - 输入的类型
* `localizedName` - 翻译为当前语言的输入名称

### StudyInputValueItem

具有以下key的对象：

* `id` - 指标的输入id
* `value` - 输入的值
