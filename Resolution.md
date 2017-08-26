Resolution or interval is a time period of one bar. Charting Library supports intraday resolutions (seconds, minutes, hours) and DWM resolutions (daily, weekly, monthly).
Charting Library API has lots of methods that accepts and returns Resolutions.

### Intraday

#### Seconds

Format: `xS`, where `x` is a number of seconds.
Example: 1S - one second, 2S - two seconds, 100S - one hundred seconds.

#### Minutes

Format: `x`, where `x` is a number of minutes.
Example: 1 - one minute, 2 - two minutes, 100 - one hundred minutes.

#### Hours

**Important:** while user interface allows a user to enter a number of hours as `xh` or `xH`, it is never passed to the API. Hours are always set using minutes in the Charting Library API.

Example: 60 - one hour, 120 - two hours, 240 - four hours.

### DWM

#### Days

Format: `xD`, where `x` is a number of days.
Example: 1D - one day, 2D - two days, 100D - one hundred days.

#### Weeks

Format: `xW`, where `x` is a number of weeks.
Example: 1W - one week, 2W - two weeks, 100W - one hundred weeks.

#### Months

Format: `xM`, where `x` is a number of months.
Example: 1M - one month, 2M - two months, 100M - one hundred months.

#### Years

Years are set using months.
Example: 12M - one year, 24M - two year, 48 - four years.

#### See also

[[How to set a list of available resolutions on a chart|JS-Api#supported_resolutions]]

[[How to set a list of resolutions supported by an instrument|Symbology#supported_resolutions]]

[[Set initial resolution on a chart|Widget-Constructor#interval|]]

[[Get current chart resolution|Chart-Methods#resolution]]

[[Change resolution on a chart|Chart-Methods#setresolutionresolution-callback]]