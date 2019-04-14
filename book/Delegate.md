# 委托(Delegate)

Delegate是[账户管理器](Account-Manager.md)中使用的对象，用于通知表中显示的订单，仓位和其他信息所发生的事件。

### subscribe(object, member)
订阅事件.
1. `object` 是`member`的所有者，对于一个函数可以为null
2. `member` 是对象的方法

订阅事件: `object::member`。

### unsubscribe(object, member)

取消订阅事件: `object::member`。

使用在`subscribe`函数中的相同对象和`member`取消订阅事件。
