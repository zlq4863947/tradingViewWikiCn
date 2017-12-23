# 订阅

Subscription对象由[Chart Methods](/book/Chart-Methods.md)返回。 使用此对象，您可以订阅图表事件并取消订阅。 所以有两种方法：

### subscribe(object, method, singleshot)

1. `object` 是一个上下文对象，用作 `method` 函数的 `this` 指针。 如果你不需要上下文，可以使用 `null`。
2. `method` 是事件发生时要调用的方法
3. `singleshot` 是一个可选的参数。 设置为 `true` ，当事件第一次发生时自动取消订阅。

### unsubscribe(object, method)

Use the same `object` and `method` which you used in `subscribe` function to unsubscribe from the event.

使用 `subscribe` 方法中使用的 `object` 和 `method` 来取消订阅事件。

### unsubscribeAll(object)

使用 `subscribe` 方法中使用的 `object` 和 `method` 来取消订阅所有事件。