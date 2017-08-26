One may see the toolbar in the bottom of the chart. Each of those buttons on its left side switches time frame of the chart. Switching time frame means:

1. switch the chart resolution
2. force the chart bars to scale horizontally to have the whole requested range visible

I.e., clicking `1Y` will make the chart to switch resolution to `1D` and to scale to show all bars for 1 year back. Each time frame has its own chart resolution. Here it the list of default time frames:

Time Frame|Chart Resolution
---|---
5Y|W
1Y|D
6M|120
3M|60
1M|30
5D|5
1D|1

One may customize default time frames list using respective widget [[.ctor argument|Widget-Constructor#time_frames]].

**Remark**: Time frames requiring resolutions which are not available for current chart's symbol will be hidden.
