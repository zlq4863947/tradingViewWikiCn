# 订阅

订阅对象由[图表方法](Chart-Methods.md)返回。此对象允许您订阅和取消订阅图表事件。它有两种方法：

### subscribe(object, method, singleshot)

1. `object` 是一个用作`method`函数的`this`指针的上下文对象。如果您不需要上下文，请使用`null`。
2. `method` 是事件发生时要调用的方法
3. `singleshot` 是一个可选的参数。如果您希望在事件第一次发生时自动取消订阅，请将其设置为“true”。

### unsubscribe(object, method)

使用在`subscribe`函数中相同的`object`和`method`取消订阅事件。

### unsubscribeAll(object)

使用在`subscribe`函数中相同的`object`来取消全部订阅。
