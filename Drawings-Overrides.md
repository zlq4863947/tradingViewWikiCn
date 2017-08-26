Here is a full list of drawings overrides with default values. You can change default values using `overrides` argument of the [widget constructor](https://github.com/tradingview/charting_library/wiki/Widget-Constructor#overrides). At the bottom of the list you will find a list of constants and abbreviations used in the values.

```
linetoolicon: {
	singleChartOnly: true,
	color: 'rgba( 61, 133, 198, 1)',
	snapTo45Degrees:true,
	size: 40,
	icon: 0x263A,
	angle: Math.PI * 0.5,
	scale: 1.0
},
linetoolbezierquadro: {
	linecolor: 'rgba( 21, 153, 128, 1)',
	linewidth: 1.0,
	fillBackground: false,
	backgroundColor: 'rgba( 21, 56, 153, 0.5)',
	transparency: 50,
	linestyle: LINESTYLE_SOLID,
	extendLeft: false,
	extendRight: false,
	leftEnd: LINEEND_NORMAL,
	rightEnd: LINEEND_NORMAL
},
linetoolbeziercubic: {
	linecolor: 'rgba( 21, 153, 128, 1)',
	linewidth: 1.0,
	fillBackground: false,
	backgroundColor: 'rgba( 21, 56, 153, 0.5)',
	transparency: 50,
	linestyle: LINESTYLE_SOLID,
	extendLeft: false,
	extendRight: false,
	leftEnd: LINEEND_NORMAL,
	rightEnd: LINEEND_NORMAL
},
linetooltrendline: {
	linecolor: 'rgba( 21, 153, 128, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	extendLeft: false,
	extendRight: false,
	leftEnd: LINEEND_NORMAL,
	rightEnd: LINEEND_NORMAL,
	font: 'Verdana',
	textcolor: 'rgba( 21, 119, 96, 1)',
	fontsize: 12,
	bold:false,
	italic:false,
	snapTo45Degrees:true,
	alwaysShowStats: false,
	showPriceRange: false,
	showBarsRange: false,
	showDateTimeRange: false,
	showDistance:false,
	showAngle: false
},
linetooltimecycles: {
	linecolor: 'rgba(21, 153, 128, 1)',
	linewidth: 1.0,
	fillBackground: true,
	backgroundColor: 'rgba(106, 168, 79, 0.5)',
	transparency: 50,
	linestyle: LINESTYLE_SOLID
},
linetoolsineline: {
	linecolor: 'rgba( 21, 153, 128, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID
},
linetooltrendangle: {
	singleChartOnly: true,
	linecolor: 'rgba( 21, 153, 128, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	snapTo45Degrees:true,
	font: 'Verdana',
	textcolor: 'rgba( 21, 119, 96, 1)',
	fontsize: 12,
	bold:true,
	italic:false,
	alwaysShowStats: false,
	showPriceRange: false,
	showBarsRange: false,
	extendRight: false,
	extendLeft: false
},
linetooldisjointangle: {
	linecolor: 'rgba( 18, 159, 92, 1)',
	linewidth: 2.0,
	linestyle: LINESTYLE_SOLID,
	fillBackground: true,
	backgroundColor: 'rgba( 106, 168, 79, 0.5)',
	transparency: 50,
	extendLeft: false,
	extendRight: false,
	leftEnd: LINEEND_NORMAL,
	rightEnd: LINEEND_NORMAL,
	font: 'Verdana',
	textcolor: 'rgba( 18, 159, 92, 1)',
	fontsize: 12,
	bold:false,
	italic:false,
	showPrices: false,
	showPriceRange: false,
	showDateTimeRange: false,
	showBarsRange: false
},
linetoolflatbottom: {
	linecolor: 'rgba( 73, 133, 231, 1)',
	linewidth: 2.0,
	linestyle: LINESTYLE_SOLID,
	fillBackground: true,
	backgroundColor: 'rgba( 21, 56, 153, 0.5)',
	transparency: 50,
	extendLeft: false,
	extendRight: false,
	leftEnd: LINEEND_NORMAL,
	rightEnd: LINEEND_NORMAL,
	font: 'Verdana',
	textcolor: 'rgba( 73, 133, 231, 1)',
	fontsize: 12,
	bold:false,
	italic:false,
	showPrices: false,
	showPriceRange: false,
	showDateTimeRange: false,
	showBarsRange: false
},
linetoolfibspiral: {
	linecolor: 'rgba( 21, 153, 128, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID
},
linetooldaterange: {
	linecolor: 'rgba( 88, 88, 88, 1)',
	linewidth: 1.0,
	font: 'Verdana',
	textcolor: 'rgba( 255, 255, 255, 1)',
	fontsize: 12,
	fillLabelBackground: true,
	labelBackgroundColor: 'rgba( 91, 133, 191, 0.9)',
	labelBackgroundTransparency: 30,
	fillBackground: true,
	backgroundColor: 'rgba( 186, 218, 255, 0.4)',
	backgroundTransparency: 60,
	drawBorder: false,
	borderColor: 'rgba( 102, 123, 139, 1)'
},
linetoolpricerange: {
	linecolor: 'rgba( 88, 88, 88, 1)',
	linewidth: 1.0,
	font: 'Verdana',
	textcolor: 'rgba( 255, 255, 255, 1)',
	fontsize: 12,
	fillLabelBackground: true,
	labelBackgroundColor: 'rgba( 91, 133, 191, 0.9)',
	labelBackgroundTransparency: 30,
	fillBackground: true,
	backgroundColor: 'rgba( 186, 218, 255, 0.4)',
	backgroundTransparency: 60,
	drawBorder: false,
	borderColor: 'rgba( 102, 123, 139, 1)'
},
linetooldateandpricerange: {
	linecolor: 'rgba( 88, 88, 88, 1)',
	linewidth: 1.0,
	font: 'Verdana',
	textcolor: 'rgba( 255, 255, 255, 1)',
	fontsize: 12,
	fillLabelBackground: true,
	labelBackgroundColor: 'rgba( 91, 133, 191, 0.9)',
	labelBackgroundTransparency: 30,
	fillBackground: true,
	backgroundColor: 'rgba( 186, 218, 255, 0.4)',
	backgroundTransparency: 60,
	drawBorder: false,
	borderColor: 'rgba( 102, 123, 139, 1)'
},
linetoolriskrewardshort: {
	isShort:true,
	linecolor: 'rgba( 88, 88, 88, 1)',
	linewidth: 1.0,
	font: 'Verdana',
	textcolor: 'rgba(255, 255, 255, 1)',
	fontsize: 12,
	fillLabelBackground: true,
	labelBackgroundColor: 'rgba( 88, 88, 88, 1)',
	labelBackgroundTransparency: 0,
	fillBackground: true,
	stopBackground: 'rgba( 255, 0, 0, 0.2)',
	profitBackground: 'rgba( 0, 160, 0, 0.2)',
	stopBackgroundTransparency: 80,
	profitBackgroundTransparency: 80,
	drawBorder: false,
	borderColor: 'rgba( 102, 123, 139, 1)'
},
linetoolriskrewardlong: {
	isShort:false,
	linecolor: 'rgba( 88, 88, 88, 1)',
	linewidth: 1.0,
	font: 'Verdana',
	textcolor: 'rgba(255, 255, 255, 1)',
	fontsize: 12,
	fillLabelBackground: true,
	labelBackgroundColor: 'rgba( 88, 88, 88, 1)',
	labelBackgroundTransparency: 0,
	fillBackground: true,
	stopBackground: 'rgba( 255, 0, 0, 0.2)',
	profitBackground: 'rgba( 0, 160, 0, 0.2)',
	stopBackgroundTransparency: 80,
	profitBackgroundTransparency: 80,
	drawBorder: false,
	borderColor: 'rgba( 102, 123, 139, 1)'
},
linetoolarrow: {
	linecolor: 'rgba( 111, 136, 198, 1)',
	linewidth: 2.0,
	linestyle: LINESTYLE_SOLID,
	extendLeft: false,
	extendRight: false,
	leftEnd: LINEEND_NORMAL,
	rightEnd: LINEEND_ARROW,
	font: 'Verdana',
	textcolor: 'rgba( 21, 119, 96, 1)',
	fontsize: 12,
	bold:false,
	italic:false,
	alwaysShowStats: false,
	showPriceRange: false,
	showBarsRange: false,
	showDateTimeRange: false,
	showDistance:false,
	showAngle: false
},
linetoolray: {
	linecolor: 'rgba( 21, 153, 128, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	extendLeft: false,
	extendRight: true,
	leftEnd: LINEEND_NORMAL,
	rightEnd: LINEEND_NORMAL,
	font: 'Verdana',
	textcolor: 'rgba( 21, 119, 96, 1)',
	fontsize: 12,
	bold:false,
	italic:false,
	alwaysShowStats: false,
	showPriceRange: false,
	showBarsRange: false,
	showDateTimeRange: false,
	showDistance:false,
	showAngle: false
},
linetoolextended: {
	linecolor: 'rgba( 21, 153, 128, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	extendLeft: true,
	extendRight: true,
	leftEnd: LINEEND_NORMAL,
	rightEnd: LINEEND_NORMAL,
	font: 'Verdana',
	textcolor: 'rgba( 21, 119, 96, 1)',
	fontsize: 12,
	bold:false,
	italic:false,
	alwaysShowStats: false,
	showPriceRange: false,
	showBarsRange: false,
	showDateTimeRange: false,
	showDistance:false,
	showAngle: false
},
linetoolhorzline: {
	linecolor: 'rgba( 128, 204, 219, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	showPrice: true,
	showLabel: false,
	text: '',
	font: 'Verdana',
	textcolor: 'rgba( 21, 119, 96, 1)',
	fontsize: 12,
	bold:false,
	italic:false,
	horzLabelsAlign: 'center',
	vertLabelsAlign: 'top'
},
linetoolhorzray: {
	linecolor: 'rgba( 128, 204, 219, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	showPrice: true,
	showLabel: false,
	text: '',
	font: 'Verdana',
	textcolor: 'rgba( 21, 119, 96, 1)',
	fontsize: 12,
	bold:false,
	italic:false,
	horzLabelsAlign: 'center',
	vertLabelsAlign: 'top'
},
linetoolvertline: {
	linecolor: 'rgba( 128, 204, 219, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	showTime: true
},
linetoolcirclelines: {
	trendline: {
		visible: true,
		color: 'rgba( 128, 128, 128, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_DASHED
	},
	linecolor: 'rgba( 128, 204, 219, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID
},
linetoolfibtimezone: {
	horzLabelsAlign: 'right',
	vertLabelsAlign: 'bottom',
	baselinecolor: 'rgba( 128, 128, 128, 1)',
	linecolor: 'rgba( 0, 85, 219, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	showLabels: true,
	font: 'Verdana',
	fillBackground:false,
	transparency:80,
	trendline: {
		visible: true,
		color: 'rgba( 128, 128, 128, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_DASHED
	},
	level1-11: LEVELS_TYPE_C
},
linetooltext: {
	color: 'rgba( 102, 123, 139, 1)',
	text: $.t('Text'),
	font: 'Verdana',
	fontsize: 20,
	fillBackground: false,
	backgroundColor: 'rgba( 91, 133, 191, 0.9)',
	backgroundTransparency: 70,
	drawBorder: false,
	borderColor: 'rgba( 102, 123, 139, 1)',
	bold:false,
	italic:false,
	locked: false,
	fixedSize: true,
	wordWrap: false,
	wordWrapWidth: 400
},
linetooltextabsolute: {
	singleChartOnly: true,
	color: 'rgba( 102, 123, 139, 1)',
	text: $.t('Text'),
	font: 'Verdana',
	fontsize: 20,
	fillBackground: false,
	backgroundColor: 'rgba( 155, 190, 213, 0.3)',
	backgroundTransparency: 70,
	drawBorder: false,
	borderColor: 'rgba( 102, 123, 139, 1)',
	bold: false,
	italic: false,
	locked: true,
	wordWrap: false,
	wordWrapWidth: 400
},
linetoolballoon: {
	color: 'rgba( 102, 123, 139, 1)',
	backgroundColor: 'rgba( 255, 254, 206, 0.7)',
	borderColor: 'rgba( 140, 140, 140, 1)',
	fontWeight: 'bold',
	fontsize: 12,
	font: 'Arial',
	transparency: 30,
	text: $.t('Comment')
},
linetoolbrush: {
	linecolor: 'rgba( 53, 53, 53, 1)',
	linewidth: 2.0,
	smooth:5,
	fillBackground: false,
	backgroundColor: 'rgba( 21, 56, 153, 0.5)',
	transparency: 50,
	leftEnd: LINEEND_NORMAL,
	rightEnd: LINEEND_NORMAL
},
linetoolpolyline: {
	linecolor: 'rgba( 53, 53, 53, 1)',
	linewidth: 2.0,
	linestyle: LINESTYLE_SOLID,
	fillBackground: true,
	backgroundColor: 'rgba( 21, 56, 153, 0.5)',
	transparency: 50,
	filled: false
},
linetoolarrowmark: {
	color: 'rgba( 120, 120, 120, 1)',
	text: '',
	fontsize: 20,
	font: 'Verdana'
},
linetoolarrowmarkleft: {
	color: 'rgba( 120, 120, 120, 1)',
	text: '',
	fontsize: 20,
	font: 'Verdana'
},
linetoolarrowmarkup: {
	color: 'rgba( 120, 120, 120, 1)',
	text: '',
	fontsize: 20,
	font: 'Verdana'
},
linetoolarrowmarkright: {
	color: 'rgba( 120, 120, 120, 1)',
	text: '',
	fontsize: 20,
	font: 'Verdana'
},
linetoolarrowmarkdown: {
	color: 'rgba( 120, 120, 120, 1)',
	text: '',
	fontsize: 20,
	font: 'Verdana'
},
linetoolflagmark: {
	color: 'rgba( 255, 0, 0, 1)'
},

linetoolnote: {
	markerColor: 'rgba( 46, 102, 255, 1)',
	textColor: 'rgba( 0, 0, 0, 1)',
	backgroundColor: 'rgba( 255, 255, 255, 1)',
	backgroundTransparency: 0,
	text: 'Text',
	font: 'Arial',
	fontSize: 12,
	bold: false,
	italic: false,
	locked: false,
	fixedSize: true
},

linetoolnoteabsolute: {
	singleChartOnly: true,
	markerColor: 'rgba( 46, 102, 255, 1)',
	textColor: 'rgba( 0, 0, 0, 1)',
	backgroundColor: 'rgba( 255, 255, 255, 1)',
	backgroundTransparency: 0,
	text: 'Text',
	font: 'Arial',
	fontSize: 12,
	bold: false,
	italic: false,
	locked: true,
	fixedSize: true
},

linetoolthumbup: {
	color: 'rgba( 0, 128, 0, 1)'
},
linetoolthumbdown: {
	color: 'rgba( 255, 0, 0, 1)'
},
linetoolpricelabel: {
	color: 'rgba( 102, 123, 139, 1)',
	backgroundColor: 'rgba( 255, 255, 255, 0.7)',
	borderColor: 'rgba( 140, 140, 140, 1)',
	fontWeight: 'bold',
	fontsize: 11,
	font: 'Arial',
	transparency: 30
},
linetoolrectangle: {
	color: 'rgba( 21, 56, 153, 1)',
	fillBackground: true,
	backgroundColor: 'rgba( 21, 56, 153, 0.5)',
	linewidth: 1.0,
	snapTo45Degrees:true,
	transparency: 50
},
linetoolrotatedrectangle: {
	color: 'rgba( 152, 0, 255, 1)',
	fillBackground: true,
	backgroundColor: 'rgba( 142, 124, 195, 0.5)',
	transparency: 50,
	linewidth: 1.0,
	snapTo45Degrees:true
},
linetoolellipse: {
	color: 'rgba( 153, 153, 21, 1)',
	fillBackground: true,
	backgroundColor: 'rgba( 153, 153, 21, 0.5)',
	transparency: 50,
	linewidth: 1.0
},
linetoolarc: {
	color: 'rgba( 153, 153, 21, 1)',
	fillBackground: true,
	backgroundColor: 'rgba( 153, 153, 21, 0.5)',
	transparency: 50,
	linewidth: 1.0
},
linetoolprediction: {
	singleChartOnly: true,
	linecolor: 'rgba( 28, 115, 219, 1)',
	linewidth: 2.0,

	sourceBackColor: 'rgba( 241, 241, 241, 1)',
	sourceTextColor: 'rgba( 110, 110, 110, 1)',
	sourceStrokeColor: 'rgba( 110, 110, 110, 1)',

	targetStrokeColor:'rgba( 47, 168, 255, 1)',
	targetBackColor:'rgba( 11, 111, 222, 1)',
	targetTextColor: 'rgba( 255, 255, 255, 1)',

	successBackground: 'rgba( 54, 160, 42, 0.9)',
	successTextColor: 'rgba( 255, 255, 255, 1)',

	failureBackground: 'rgba( 231, 69, 69, 0.5)',
	failureTextColor: 'rgba( 255, 255, 255, 1)',

	intermediateBackColor: 'rgba( 234, 210, 137, 1)',
	intermediateTextColor: 'rgba( 109, 77, 34, 1)',

	transparency: 10,
	centersColor: 'rgba( 32, 32, 32, 1)'
},
linetooltriangle: {
	color: 'rgba( 153, 21, 21, 1)',
	fillBackground: true,
	backgroundColor: 'rgba( 153, 21, 21, 0.5)',
	transparency: 50,
	linewidth: 1.0
},
linetoolcallout: {
	color: 'rgba( 255, 255, 255, 1)',
	backgroundColor: 'rgba( 153, 21, 21, 0.5)',
	transparency: 50,
	linewidth: 2.0,
	fontsize: 12,
	font:'Verdana',
	text: 'Text',
	bordercolor: 'rgba( 153, 21, 21, 1)',
	bold: false,
	italic: false,
	wordWrap: false,
	wordWrapWidth: 400
},
linetoolparallelchannel: {
	linecolor: 'rgba( 119, 52, 153, 1)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	extendLeft: false,
	extendRight: false,
	fillBackground: true,
	backgroundColor: 'rgba( 180, 167, 214, 0.5)',
	transparency: 50,
	showMidline: false,
	midlinecolor: 'rgba( 119, 52, 153, 1)',
	midlinewidth: 1.0,
	midlinestyle: LINESTYLE_DASHED
},
linetoolelliottimpulse: {
	degree: 7,
	showWave:true,
	color: 'rgba( 61, 133, 198, 1)',
	linewidth: 1
},
linetoolelliotttriangle: {
	degree: 7,
	showWave:true,
	color: 'rgba( 255, 152, 0, 1)',
	linewidth: 1
},
linetoolelliotttriplecombo: {
	degree: 7,
	showWave:true,
	color: 'rgba( 106, 168, 79, 1)',
	linewidth: 1
},
linetoolelliottcorrection: {
	degree: 7,
	showWave:true,
	color: 'rgba( 61, 133, 198, 1)',
	linewidth: 1
},
linetoolelliottdoublecombo: {
	degree: 7,
	showWave:true,
	color: 'rgba( 106, 168, 79, 1)',
	linewidth: 1
},
linetoolbarspattern: {
	singleChartOnly: true,
	color:'rgba( 80, 145, 204, 1)',
	mode:BARS_MODE,
	mirrored:false,
	flipped:false
},
linetoolghostfeed: {
	singleChartOnly: true,
	averageHL: 20,
	variance: 50,
	candleStyle: {
		upColor: '#6ba583',
		downColor: '#d75442',
		drawWick: true,
		drawBorder: true,
		borderColor: '#378658',
		borderUpColor: '#225437',
		borderDownColor: '#5b1a13',
		wickColor: '#737375'
	},
	transparency: 50
},
linetoolpitchfork: {
	fillBackground:true,
	transparency:80,
	style:PITCHFORK_STYLE_ORIGINAL,
	median: {
		visible: true,
		color: 'rgba( 165, 0, 0, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_SOLID
	},
	level0-8: LEVELS_TYPE_C
},
linetoolpitchfan: {
	fillBackground:true,
	transparency:80,
	median: {
		visible: true,
		color: 'rgba( 165, 0, 0, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_SOLID
	},
	level0-8: LEVELS_TYPE_C
},
linetoolgannfan: {
	showLabels: true,
	font: 'Verdana',
	fillBackground:true,
	transparency:80,
	level1-9: LEVELS_TYPE_F
},
linetoolganncomplex: {
	fillBackground:false,
	arcsBackground: {
		fillBackground: true,
		transparency: 80
	},
	levels: [/* 6 LEVELS_TYPE_D */],
	fanlines: [/* 11 LEVELS_TYPE_E */],
	arcs: [/* 11 LEVELS_TYPE_E */]
},
linetoolgannsquare: {
	color: 'rgba( 21, 56, 153, 0.8)',
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	font: 'Verdana',
	showTopLabels:true,
	showBottomLabels:true,
	showLeftLabels:true,
	showRightLabels:true,
	fillHorzBackground:true,
	horzTransparency:80,
	fillVertBackground:true,
	vertTransparency:80,
	hlevel1-7: LEVELS_TYPE_B,
	vlevel1-7: LEVELS_TYPE_B
},
linetoolfibspeedresistancefan: {
	fillBackground:true,
	transparency:80,
	grid: {
		color: 'rgba( 128, 128, 128, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_SOLID,
		visible:true
	},
	linewidth: 1.0,
	linestyle: LINESTYLE_SOLID,
	font: 'Verdana',
	showTopLabels:true,
	showBottomLabels:true,
	showLeftLabels:true,
	showRightLabels:true,
	snapTo45Degrees:true,
	hlevel1-7: LEVELS_TYPE_B,
	vlevel1-7: LEVELS_TYPE_B
},
linetoolfibretracement: {
	showCoeffs: true,
	showPrices: true,
	font: 'Verdana',
	fillBackground:true,
	transparency:80,
	extendLines:false,
	horzLabelsAlign: 'left',
	vertLabelsAlign: 'middle',
	reverse:false,
	coeffsAsPercents:false,
	trendline: {
		visible: true,
		color: 'rgba( 128, 128, 128, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_DASHED
	},
	levelsStyle: {
		linewidth: 1.0,
		linestyle: LINESTYLE_SOLID
	},
	level1-24: LEVELS_TYPE_B
},
linetoolfibchannel: {
	showCoeffs: true,
	showPrices: true,
	font: 'Verdana',
	fillBackground:true,
	transparency:80,
	extendLeft:false,
	extendRight:false,
	horzLabelsAlign: 'left',
	vertLabelsAlign: 'middle',
	coeffsAsPercents:false,
	levelsStyle: {
		linewidth: 1.0,
		linestyle: LINESTYLE_SOLID
	},
	level1-24:  LEVELS_TYPE_B
},
linetoolprojection: {
	showCoeffs: true,
	font: 'Verdana',
	fillBackground:true,
	transparency:80,
	color1: 'rgba( 0, 128, 0, 0.2)',
	color2: 'rgba( 255, 0, 0, 0.2)',
	linewidth: 1.0,
	trendline: {
		visible: true,
		color: 'rgba( 128, 128, 128, 1)',
		linestyle: LINESTYLE_SOLID
	},
	level1: LEVELS_TYPE_C
},
linetool5pointspattern: {
	color: 'rgba( 204, 40, 149, 1)',
	textcolor: 'rgba( 255, 255, 255, 1)',
	fillBackground: true,
	backgroundColor: 'rgba( 204, 40, 149, 0.5)',
	font: 'Verdana',
	fontsize:12,
	bold:false,
	italic:false,
	transparency: 50,
	linewidth: 1.0
},
linetoolcypherpattern: {
	color: '#CC2895',
	textcolor: '#FFFFFF',
	fillBackground: true,
	backgroundColor: '#CC2895',
	font: 'Verdana',
	fontsize:12,
	bold:false,
	italic:false,
	transparency: 50,
	linewidth: 1.0
},
linetooltrianglepattern: {
	color: 'rgba( 149, 40, 255, 1)',
	textcolor: 'rgba( 255, 255, 255, 1)',
	fillBackground: true,
	backgroundColor: 'rgba( 149, 40, 204, 0.5)',
	font: 'Verdana',
	fontsize:12,
	bold:false,
	italic:false,
	transparency: 50,
	linewidth: 1.0
},
linetoolabcd: {
	color: 'rgba( 0, 155, 0, 1)',
	textcolor: 'rgba( 255, 255, 255, 1)',
	font: 'Verdana',
	fontsize:12,
	bold:false,
	italic:false,
	linewidth: 2.0
},
linetoolthreedrivers: {
	color: 'rgba( 149, 40, 255, 1)',
	textcolor: 'rgba( 255, 255, 255, 1)',
	fillBackground: true,
	backgroundColor: 'rgba( 149, 40, 204, 0.5)',
	font: 'Verdana',
	fontsize:12,
	bold:false,
	italic:false,
	transparency: 50,
	linewidth: 2.0
},
linetoolheadandshoulders: {
	color: 'rgba( 69, 104, 47, 1)',
	textcolor: 'rgba( 255, 255, 255, 1)',
	fillBackground: true,
	backgroundColor: 'rgba( 69, 168, 47, 0.5)',
	font: 'Verdana',
	fontsize:12,
	bold:false,
	italic:false,
	transparency: 50,
	linewidth: 2.0
},
linetoolfibwedge: {
	singleChartOnly: true,
	showCoeffs: true,
	font: 'Verdana',
	fillBackground:true,
	transparency:80,
	trendline: {
		visible: true,
		color: 'rgba( 128, 128, 128, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_SOLID
	},
	level1-11: LEVELS_TYPE_C
},
linetoolfibcircles: {
	showCoeffs: true,
	font: 'Verdana',
	fillBackground:true,
	transparency:80,
	snapTo45Degrees:true,
	coeffsAsPercents:false,
	trendline: {
		visible: true,
		color: 'rgba( 128, 128, 128, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_DASHED
	},
	level1-11: LEVELS_TYPE_C
},
linetoolfibspeedresistancearcs: {
	showCoeffs: true,
	font: 'Verdana',
	fillBackground:true,
	transparency:80,
	fullCircles: false,
	trendline: {
		visible: true,
		color: 'rgba( 128, 128, 128, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_DASHED
	},
	level1-11: LEVELS_TYPE_C
},
linetooltrendbasedfibextension: {
	showCoeffs: true,
	showPrices: true,
	font: 'Verdana',
	fillBackground:true,
	transparency:80,
	extendLines:false,
	horzLabelsAlign: 'left',
	vertLabelsAlign: 'middle',
	reverse:false,
	coeffsAsPercents:false,
	trendline: {
		visible: true,
		color: 'rgba( 128, 128, 128, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_DASHED
	},
	levelsStyle: {
		linewidth: 1.0,
		linestyle: LINESTYLE_SOLID
	},
	level1-24: LEVELS_TYPE_B
},
linetooltrendbasedfibtime: {
	showCoeffs: true,
	font: 'Verdana',
	fillBackground:true,
	transparency:80,
	horzLabelsAlign: 'right',
	vertLabelsAlign: 'bottom',
	trendline: {
		visible: true,
		color: 'rgba( 128, 128, 128, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_DASHED
	},
	level1-11: LEVELS_TYPE_C
},
linetoolschiffpitchfork: {
	fillBackground:true,
	transparency:80,
	style:PITCHFORK_STYLE_SCHIFF,
	median: {
		visible: true,
		color: 'rgba( 165, 0, 0, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_SOLID
	},
	level0-8: LEVELS_TYPE_C
},
linetoolschiffpitchfork2: {
	fillBackground:true,
	transparency:80,
	style:PITCHFORK_STYLE_SCHIFF2,
	median: {
		visible: true,
		color: 'rgba( 165, 0, 0, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_SOLID
	},
	level0-8: LEVELS_TYPE_C
},
linetoolinsidepitchfork: {
	fillBackground:true,
	transparency:80,
	style:PITCHFORK_STYLE_INSIDE,
	median: {
		visible: true,
		color: 'rgba( 165, 0, 0, 1)',
		linewidth: 1.0,
		linestyle: LINESTYLE_SOLID
	},
	level0-8: LEVELS_TYPE_C
},
linetoolvisibilities: {
	intervalsVisibilities: {
		seconds:true,
		secondsFrom:1,
		secondsTo:59,
		minutes:true,
		minutesFrom:1,
		minutesTo:59,
		hours:true,
		hoursFrom:1,
		hoursTo:24,
		days:true,
		daysFrom:1,
		daysTo:366,
		weeks:true,
		months:true
	}
}
```

### Constants

These constants are used in the drawings defaults. You cannot use their names directly. Use the values instead.

```
LINESTYLE_SOLID = 0;
LINESTYLE_DOTTED = 1;
LINESTYLE_DASHED = 2;
LINESTYLE_LARGE_DASHED = 3;

LINEEND_NORMAL = 0;
LINEEND_ARROW  = 1;
LINEEND_CIRCLE = 2;

BARS_MODE = 0;
LINE_MODE = 1;
OPENCLOSE_MODE = 2;
LINEOPEN_MODE = 3;
LINEHIGH_MODE = 4;
LINELOW_MODE = 5;
LINEHL2_MODE = 6;

PITCHFORK_STYLE_ORIGINAL = 0;
PITCHFORK_STYLE_SCHIFF = 1;
PITCHFORK_STYLE_SCHIFF2 = 2;
PITCHFORK_STYLE_INSIDE = 3;

LEVELS_TYPE_A = {
	color: color,
	visible: visible
};

LEVELS_TYPE_B = {
	coeff: coeff,
	color: color,
	visible: visible
};

LEVELS_TYPE_C = {
	coeff: coeff,
	color: color,
	visible: visible,
	linestyle: linestyle,
	linewidth: linewidth
};

LEVELS_TYPE_D = {
	color: color,
	width: width,
	visible: visible
};

LEVELS_TYPE_E = {
	color: color,
	visible: visible,
	width: width,
	x: x,
	y: y
};

LEVELS_TYPE_F = {
	coeff1: coeff1,
	coeff2: coeff2,
	color: color,
	visible: visible,
	linestyle: linestyle,
	linewidth: linewidth
};
```
