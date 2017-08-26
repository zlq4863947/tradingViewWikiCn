The Charting Library expects to receive trading sessions descriptor in Symbol Info. Session is a time range when trades may appear. Each session should be assigned with left and right bounds. In the Charting Library, session time format is “HHMM-HHMM”. E.g., session starting at 9:30am and ending at 16:00 pm should look like `0930-1600`. There is a special case for symbols traded 24x7 (e.g., Bitcoin and other cryptocurrencies): the session string then should be `24x7`. Session time is expected to be in **exchange time zone**.

If session left border is greater than the right one (ie, `1700-0900`), this session is treated as an overnight one. Overnight session is always started in previous day: e.g., if the symbol is traded Monday-Friday `1700-0900`, the first session on week (#i) will be treated as started in Sunday 17:00 of previous week (#i-1) and ending at 09:00 on Monday of this week (#i).

There may be more than one session per trading day. If you have some, you should assign the whole day session as a sessions set separated with comma. E.g., assuming the day have trades open from 9:30 to 14:00 and then from 14:30 to 17:00, the day session string should be `0930-1400,1430-1700`.

Also, there may be a situation when trading hours differ from day to day. You can use the `:` specifier to assign the day the session should be applied to. E.g., if the symbol has 0900-1630 all days but the Monday (in Monday, the trades are 0900-1400), the session string should be `0900-1630|0900-1400:2`. Let's see this string in details.


Fragment | Meaning
---------|--------
0900-1630|A session 0900-1630. This session will be assigned by default to all non-weekend days because it's not followed by `:` specifier.
\||Sessions separator. This character divides different sessions descriptors.
0900-1400|A session 0900-1400. It's the session for a day #2 (see below)
:|Day specifier. This character follows the session hours description and is followed by day number.
2|The day number for the session above (0900-1400)


**Days numbers** are 1 for **Sunday** and 7 for **Saturday** (2 -- Monday, 3 -- Tuesday, e.t.c.). It's possible to override more than one day with a single session record. E.g., in `0900-1630|0900-1400:23` 0900-1400 sessions will be assigned to days #2 and #3 (Monday, Tuesday).

**version: 1.1**:

One can specify the first trading day of a week using semicolon. Examples:
```
"1;0900-1630|0900-1400:2" : first day of week is Sunday
"0900-1630|0900-1400:2;6" : first day of week is Saturday
"0900-1630|0900-1400:2"   : first day of week is Monday (default value)
```

**Remark**: By default, all non-`24x7` symbols are treated to be non-tradable in Saturday and Sunday. So if your symbol is traded on weekends, you should specify trading days explicitly. I.e., `1000-1600` symbol which is traded in Sunday...Friday , should have session `1000-1600:123456`

**Use this parser to check your session string**: http://tradingview.github.io/checksession.html