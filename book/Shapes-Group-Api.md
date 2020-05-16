## 形状组 API

图表上的形状可以组合成组。 进行分组后，可以通过组ID将形状作为一个对象进行管理。

使用组时，必须考虑以下规则：

1. 每个形状可以但不一定必须是指定组的一部分，也可以不是任何组的一部分。形状不能同时属于多个组。
2. 只有同一窗格的形状可以分组。
3. 组不能为空。空组将自动删除。
4. 该组中的所有形状均具有顺序的z-indexes。因此，不能在组中的形状之间放置其他对象。
5. 组通过商品绑定。

通过形状组 API可用的所有操作都将通过撤消堆栈进行(可以被用户撤销)。

## Methods

* [Manipulating groups](#manipulating-groups)
  * [createGroupFromSelection()](#creategroupfromselection)
  * [removeGroup(groupId)](#removegroupgroupid)
  * [groups()](#groups)
  * [shapesInGroup(groupId)](#shapesingroupgroupid)
  * [excludeShapeFromGroup(groupId, shapeId)](#excludeshapefromgroupgroupid-shapeid)
* [Z-Order operations](#z-order-operations)
  * [availableZOrderOperations(groupId)](#availablezorderoperationsgroupid)
  * [bringToFront(groupId)](#bringtofrontgroupId)
  * [sendToBack(groupId)](#sendtobackgroupId)
  * [bringForward(groupId)](#bringforwardgroupid)
  * [sendBackward(groupId)](#sendbackwardgroupid)
  * [insertAfter(groupId, target)](#insertaftergroupid-target)
  * [insertBefore(groupId, target)](#insertbeforegroupid-target)
* [Batch shapes operations](#batch-shapes-operations)
  * [groupVisibility(groupId)](#groupvisibilitygroupId)
  * [setGroupVisibility(groupId, value)](#setgroupvisibilitygroupId-value)
  * [groupLock(groupId)](#grouplockgroupId)
  * [setGroupLock(groupId, value)](#setgrouplockgroupid-value)
* [Groups information methods](#groups-information-methods)
  * [getGroupName(groupId)](#getgroupnamegroupId)
  * [setGroupName(groupId, name)](#setgroupnamegroupid-name)
  * [canBeGroupped(entities)](#canBeGrouppedentities)

## Manipulating groups

### createGroupFromSelection()

根据选择的形状创建一个组。如果发生以下情况之一，则会引发错误：

* 选择为空
* 选择包含非形状的对象
* 选择包含多个窗格中的形状

此方法将所有形状移到顶部，同时保持其顺序。返回新创建的组的ID。

### removeGroup(groupId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。

从中删除指定的组以及所有形状。

### groups()

返回一个ID数组，该数组的ID为图表上当前所选商品的所有现有形状组的ID。

### shapesInGroup(groupId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。

返回指定组中的形状id数组。

### excludeShapeFromGroup(groupId, shapeId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。要从中排除形状的组。
2. `shapeId`: EntityID. 要从组中删除的形状。

从组中删除最后一个形状后，该组将自动删除。

## Z-Order operations

### availableZOrderOperations(groupId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。

返回具有可用于指定组的Z-order操作的对象。此结构具有以下字段：

* `bringForwardEnabled`: 如果可以将视觉次序设置为上移一层，则设置为true
* `bringToFrontEnabled`: 如果可以将视觉次序设置为置于顶层，则设置为true
* `sendBackwardEnabled`: 如果可以将视觉次序设置为下移一层，则设置为true
* `sendToBackEnabled`: 如果可以将视觉次序设置为置于底层，则设置为true

### bringToFront(groupId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。

此方法将组的所有形状移到Z-order的顶部，同时保持其顺序。

### sendToBack(groupId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。

此方法将组的所有形状移到Z-order的底部，并保留其顺序。

### bringForward(groupId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。

此方法将组的所有形状按Z-order上移一层。

### sendBackward(groupId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。

此方法将组的所有形状按Z-order下移一层。

### insertAfter(groupId, target)

1. `groupId`: string, 调用createGroupFromSelection的返回值。
2. `target`: 组Id 或 EntityId

此方法将组的所有形状（以及组本身）移到目标的下方。

### insertBefore(groupId, target)

1. `groupId`: string, 调用createGroupFromSelection的返回值。
2. `target`: 组Id 或 EntityId

此方法将组的所有形状（以及组本身）移到目标上方。

## Batch shapes operations

### groupVisibility(groupId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。

返回当前组可见性的值。 可能的结果是：

1. `Visible` - 该组中的所有形状均可见。
2. `Invisible` - 组中的所有形状都是不可见的。
3. `Partial` - 组中的某些形状是可见的，而有些则看不到。

### setGroupVisibility(groupId, value)

1. `groupId`: string, a 调用createGroupFromSelection的返回值。
2. `value`: boolean, true/false: 显示/隐藏 组中的所有形状

显示或隐藏组中的所有形状。

### groupLock(groupId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。

返回当前组锁定值。 可能的结果是：

1. `Locked` - 该组中的所有形状均被锁定。
2. `Unlocked` - 组中的所有形状均已解锁。
3. `Partial` - 组中的某些形状被锁定，而有些则没有。

### setGroupLock(groupId, value)

1. `groupId`: string, 调用createGroupFromSelection的返回值。
2. `value`: boolean, 设置为true表示锁定，设置为false表示解锁组中的所有形状

锁定或解锁组中的所有形状。

## Groups information methods

### getGroupName(groupId)

1. `groupId`: string, 调用createGroupFromSelection的返回值。

获取组名称。不执行唯一性检查。

### setGroupName(groupId, name)

1. `groupId`: string, 调用createGroupFromSelection的返回值。
2. `name`: string, 群组的新名称

为该组设置一个新名称。不执行唯一性检查。

### canBeGroupped(entities)

1. `entities`: EntityId数组

检查指定的实体集是否可以分组。
