Quote is a short set of data describing trades briefly. Charting Library supports watch-lists (in **Trading Terminal** configuration) and uses quotes to show some info about symbols.

Charting Library uses the same data structures for quotes in both [[JS API|JS Api]] and [[UDF]]. Here is the description of response object:

# Symbol Quote Data

* `s`: Status code for symbol. Expected values: `ok` | `error`
* `n`: Symbol name. This value must be **exactly the same** as in the request
* `v`: object, symbol quotes itself
  * `ch`: price change (usually counts from day's open price)
  * `chp`: price change percent
  * `short_name`: symbol's short name
  * `exchange`: exchange name.
  * `description`: short description of symbol.
  * `lp`: last deal price
  * `ask`: ask price
  * `bid`: bid price
  * `spread`: spread
  * `open_price`: today's open
  * `high_price`: today's high
  * `low_price`: today's low
  * `prev_close_price`: yesterday's close
  * `volume`: today's volume
