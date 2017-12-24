# 委托

委托对象由一些[Trading Terminal](book/Trading-Terminal.md)方法返回，并且需要使用[Account Manager](book/Account-Manager.md)。 使用这个对象，你可以更新和更新一个事件。

### subscribe(object, member)
订阅事件.
1. `object` 是`member`的所有者，它可以为null
2. `member` 是对象的一种方法

### unsubscribe(object, member)
取消订阅事件
使用与`subscribe`函数中使用的相同的对象和成员来取消订阅事件。
