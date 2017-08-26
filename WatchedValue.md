WatchedValue object is returned by some [[Trading Terminal]] methods. Using this object you can get/set value and be notified when the value is changed.

### value()
Returns current value.

### setValue(value)
Sets new value.

### subscribe(callback, options)
1. `callback` is a function to be called when the value is changed
2. `options` is an object with the following properties:
    1. `once` - if it is true the callback will be executed only once
    2. `callWithLast` - if it is true the callback will be executed with the previous value (if available)

### unsubscribe(callback)

Use the same function which you used in `subscribe` function to unsubscribe from the updates.
