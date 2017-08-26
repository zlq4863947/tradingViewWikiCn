Subscription object is returned by [[Chart Methods|Chart-Methods#Chart-Methods]]. Using this object you can subscribe to a chart event and unsubscribe from it. So it has two methods:

### subscribe(object, method, singleshot)
1. `object` is a context to be used as `this` pointer for `method` function. Use `null` if you don't need the context.
2. `method` is a function to be called when the event happens
3. `singleshot` is an optional argument. Set it to `true` to be automatically unsubscribed when the event happens first time.

### unsubscribe(object, method)

Use the same `object` and `method` which you used in `subscribe` function to unsubscribe from the event.

### unsubscribeAll(object)

Use the same `object` which you used in `subscribe` function to unsubscribe `object` from all events.
