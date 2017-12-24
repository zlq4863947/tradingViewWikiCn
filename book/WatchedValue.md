# WatchedValue

WatchedValue对象由一些[Trading Terminal](book/Trading-Terminal.md)方法返回。 使用这个对象，你可以获得/设置值，并在值改变时得到通知。

### value()
返回当前值。

### setValue(value)
设置新价值。

### subscribe(callback, options)
1. `callback` 值被改变时被调用的函数
2. `options` 具有以下属性的对象：
    1. `once` - 如果是true，回调将只执行一次
    2. `callWithLast` - 如果它是true，回调将被执行以前的值（如果可用）

### unsubscribe(callback)

使用您在`subscribe`函数中使用的相同函数来取消订阅更新。