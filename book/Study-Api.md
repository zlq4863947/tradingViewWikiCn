## 指标API

### isUserEditEnabled()

如果用户能够删除/更改/隐藏研究，则返回`true`。

### setUserEditEnabled(enabled)

1. `enabled` - `true` or `false`

Enables or disables removing/changing/hiding a study by the user.

### getInputsInfo()

Returns the information about all the inputs - an array of [StudyInputInfo](#studyinputinfo) objects.

### getInputValues()

Returns values of study inputs - an array of [StudyInputValueItem](#studyinputvalueitem) objects.

### setInputValues(inputs)

1. `inputs` should be an array of [StudyInputValueItem](#studyinputvalueitem) objects.

Sets input values for a study. It may contain only some of the inputs that you wish to change.

### mergeUp()

Merges the study up (if possible).

### mergeDown()

Merges the study down (if possible).

### unmergeUp()

Unmerges the study up (if possible).

### unmergeDown()

Unmerges the study down (if possible).

### changePriceScale(priceScale)

1. `priceScale` should be a string with one of the following values:
    * `left` - attach the study to the left price scale
    * `right` - attach the study to the right price scale
    * `no-scale` - do not attach the study to any price scale. The study will be added in 'No Scale' mode
    * `as-series` - attach the study to the price scale where the main series is attached (it is only applicable if the study and the main series are located on the same pane)

Changes the price scale of the study

### isVisible()

Returns `true` if the study is visible.

### setVisible(value)

1. `value` - `true` or `false`

Shows/hides the study.

### bringToFront()

Places the study on top of all other chart objects.

### sendToBack()

Places the study behind all other chart objects.

### applyOverrides(overrides)

1. `overrides` - new [overrides](Studies-Overrides) for the study

Applies `overrides` to the study.

Note: `overrides` object keys don’t need to start with the study name. The key is applied to a particular study.
For example, you should use `style` instead of `Overlay.style` to override the current style of the Overlay study.

## Primitive types

### StudyInputInfo

An object with the following keys:

* `id` - input ID of the study
* `name` - name of the input
* `type` - type of the input
* `localizedName` - name of the input translated to the current language

### StudyInputValueItem

An object with the following keys:

* `id` - input ID of the study
* `value` - value of the input
