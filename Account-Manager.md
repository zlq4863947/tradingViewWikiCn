:chart: All content on this page is relevant for [[Trading Terminal]] only.

Account Manager is an interactive table that displays trading information.
Usually it has 3 pages: orders/positions and account information.

To create an account manager you will need to describe columns of each page and provide data.

Remark 1. [[supportCustomBottomWidget|Trading-Controller#configFlags]] flag should be disabled to display an Account Manager.

Remark 2. [[Trading Controller]] should implement [[accountManagerInfo|Trading-Controller#accountmanagerinfo]]

## Account Manager Meta Information

This information should be returned by [[accountManagerInfo|Trading-Controller#accountManagerInfo]].

### Account Manager header

Account Manager's header consists of broker's title and an account name or a list of accounts.

##### accountTitle: String
##### accountsList: array of AccountInfo
##### account: [[WatchedValue]] of AccountInfo

`AccountInfo` is an object with the only `name` required key and corresponding value.

### Orders Page

##### orderColumns: array of [[Column|Account-Manager#columndescription]]

Description of columns that you want to be displayed in the Orders page. 
You can display any field of an [[order|Trading-Objects-and-Constants#order]] or add your own fields to an order object and display them.

##### possibleOrderStatuses: array of [[OrderStatus|Trading-Objects-and-Constants#orderstatus]]
Optional list of statuses to be used in the orders filter. If it is not set default list is used.

#### hasHistory
If it is `true` History page will be displayed. All orders from previous sessions will be shown in the History.

### Positions Page

##### positionColumns: array of [[Column|Account-Manager#columndescription]]

You can display any field of a [[position|Trading-Objects-and-Constants#position]] or add your own fields to a position object and display them.

### Additional Pages (e.g. Account Summary)

##### pages: array of [[Page|Account-Manager#page]]
 
Using `pages` you can add new tabs to the Account Manager. Each tab is a set of tables.

#### Page

`Page` is a desciption of an additional Account Manager tab. It is an object with the following fields:

1. `id`: String

Unique identifier of a page

2. `title`: String

Page title. It is displayed on a tab.

3. `tables`: Array of [[Table|Account-Manager#table]]. 

It is possible to display one or more table in this tab.

#### Table

You can add one or more table to a [[Page|Account-Manager#page]]. 
Account Summary table metainfo is an object with the following fields:

1. `id`: String

Unique identifier of a table.

2. `title`: String 

Optional title of a table.

3. `columns`: array of [[Column|Account-Manager#columndescription]]

4. `getData`: Promise

This function is used to request table data. It should return promise (or Deferred) and resolve it with an array of data rows.
Each row is an object. Keys of this object are column names with corresponding values.
There is a predefined field `isTotalRow` which can be used to mark a row that should be at the bottom of a table.

5. `changeDelegate` : [[Delegate]]

This delegate is used to watch data changes and update the table. Pass new account manager data to `fire` method of the delegate.

**NOTE**: if you have more than 1 row in a table and want to update a row using `changeDelegate` make sure that you have `id` field in each row to identify it.
It is not necessary if you have only 1 row in a table.

### Formatters

##### customFormatters: array of a column formatter description

Optional array to define custom formatters. Each description is an object with the following fields:

`name`: unique identifier of a formatter.
`format(options)`: function that is used for formatting of a cell value. `options` is an object with the following keys:
1. `value` - value to be formatted
2. `priceFormatter` - standard formatter for price. You can use method `format(price)` to prepare price value.
3. `prevValue` - optional field. It is a previous value so you can compare and format accordingly. It exists if current column has `highlightDiff: true` key.
4. `row` - object with all key/value pairs from current row

### Column description

Most valuable part of Account Manager description is a description of its columns.

##### label

Column title. It will be displayed in the table's header row.

##### className

Optional `className` is added to the html tag of each value cell.
You can use it to customize table's style.

Here is a list of predefined classes:

| class name   |   description  |
|--------------|----------------|
| tv-data-table__cell--symbol-cell | Special formatter for a symbol field |
| tv-data-table__cell--right-align | It aligns cell value to the right |
| tv-data-table__cell--buttons-cell | Cell with a buttons |

##### formatter

Name of formatter to be used for formatting data. If `formatter` is not set the value is displayed as is.
Formatter can be default or custom.

Here is a list of default formatters:

| name | description |
| ---- | ----------- |
| symbol | It is used for a symbol field. It displays `brokerSymbol`, but when you click on a symbol it sets `symbol` field to the chart. `property` key is ignored.|
| side | It is used to display side: Sell or Buy. |
| type| It is used to display type: Limit/Stop/StopLimit/Market. |
| formatPrice | Formatting of a price using a price formatter for the symbol. |
| formatPriceForexSup | The same as `formatPrice`, but it makes the last character of the price superscripted. It works only if type of the instrument is `forex`.|
| status | Is is used to format `status`. |
| date | Displays date or time. |
| localDate | Displays date or time in local timezone. |
| fixed | Displays a number with 2 decimal places. |
| pips | Displays a number with 1 decimal place. |
| profit | Displays profit. It also adds `+`, separates thousands and colors the cell text in red or green. |

##### property

`property` is a key of the data object that is used to get data for displaying.

##### sortProp

Optional `sortProp` is a key of the data object that is used for sorting of data.

##### modificationProperty

Optional `modificationProperty` is a key of the data object that is used to be watched for modifications.

##### notSortable

Optional `notSortable` can be set to prevent sorting of the column.

##### help

`help` is a tooltip string for the column.

##### highlightDiff

`highlightDiff` can be set with `formatPrice` and `formatPriceForexSup` formatters only to hightling changes of the field.

##### fixedWidth
If it is `true` the column width will not be reduced when value digits amount is decreased.

### Context Menu

#### contextMenuActions(e, activePageItems)

`e`: context object passed by a broswer

`activePageItems`: array of `ActionMetainfo` items for the current page

Optional function to create a custom context menu.
It should return `Promise` that is resolved with an array of `ActionMetainfo`.
