## 选择API

### clear()

清除选择。

### add(id)

1. `id` : `entityId`

通过`id`将指定的对象添加到选择中。`id`是绘图或指标的ID。 如果该对象不存在，则抛出错误。

### add(ids)

1. `ids` : `entityId`数组

通过`ids`将指定的对象数组添加到选择中。`ids`是绘图或指标ID的数组。如果其中某个id不存在，则抛出错误。

### set(id)

1. `id` : `entityId`

清除当前的选择并通过`id`将指定的对象添加到选择中。`set(id)`与`clear();add(id)`相同。如果该对象不存在，则抛出错误。

### set(ids)

1. `ids` : `entityId`数组

清除当前选择并选择由`ids`指定的对象。`ids`是绘图或指标ID的数组。`set(ids)`与`clear();add(ids)`相同。如果其中任何一个对象不存在，则抛出错误。

### remove(id)

1. `id` : `entityId`

从选择中删除指定的对象。`id`是绘图或指标ID。如果该对象未被选择，则此方法不执行任何操作。如果该对象不存在，则抛出错误。

### remove(ids)

1. `ids` : `entityId`数组

通过`ids`将指定的对象数组清除选择。`ids`是绘图或指标ID的数组。如果某个id不存在，则抛出错误。

### contains(id)

1. `id` : `entityId`数组

检查指定的对象是否被选择。`id`是绘图或指标ID。如果该对象未被选择，则返回`false`。如果该对象不存在，则抛出错误。

### allSources()

返回所有已被选择对象的id数组。

### isEmpty()

检查选择是否为空。如果图表上没有选择的对象，则返回`true`。

### onChanged()

返回可用于订阅选择更改的[订阅对象](Subscription.md)。

**多项选择:**

多个选择仅适用于使用以下规则的形状:

* 如果您在选择中添加指标，则清空选择并选择该指标。
* 如果在当前所选对象为指标时，向选区添加形状，则会清空选择并选择该形状。
* 如果向选择中添加对象数组，则其工作方式就像逐个添加这些对象一样。

**例:**

```javascript
var chart = tvWidget.activeChart();
// 将所有选择更改打印到控制台
chart.selection().onChanged().subscribe(
  null, 
  s => console.log(chart.selection().allSources())
);
// 创建指标
var studyId = chart.createStudy("Moving Average", false, false, [10]);
// 将指标添加到选择中（[<id>]打印到控制台）
chart.selection().add(studyId);
// 清空选择（[]打印到控制台）
chart.selection().clear();
```
