# 图表库内容

---

图表库包可在GitHub上获得（必须获得授权才能访问GitHub上的这个私有资源）. 您可以检出最新的稳定版本\(`master`branch\)或最新的开发版本\(`unstable`branch\) 。如果想要访问此资源请联系我们。

您可以通过在浏览器控制台中执行 TradingView.version\(\) 来查看图表库版本。

### [图表库内容](#图表库内容)
  
<!-- markdownlint-disable fenced-code-language -->

```
    +/charting_library
        + /bundles
        - charting_library.js
        - charting_library.d.ts
        - charting_library.cjs.js
        - charting_library.esm.js
        - charting_library.standalone.js
        - charting_library.js
        - datafeed-api.d.ts
        - package.json
    + /datafeeds
        + /udf
    - index.html
    - mobile_black.html
    - mobile_white.html
    - test.html
```
* `/charting\_library` 包含全部的图表库文件。
* `/charting\_library/charting\_library*` 包含外部图表库widget接口。此文件不应该被修改。
  * `.js` 是 [UMD](https://github.com/umdjs/umd) 模块规范 (用于向后兼容)。
  * `.esm.js` 是原生JavaScript模块规范, 请参见[import](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/import)。
  * `.cjs.js` 是 [CommonJS](https://zh.wikipedia.org/wiki/CommonJS) 模块规范。
  * `.standalone.js` 是 [iife](https://zh.wikipedia.org/wiki/%E7%AB%8B%E5%8D%B3%E8%B0%83%E7%94%A8%E5%87%BD%E6%95%B0%E8%A1%A8%E8%BE%BE%E5%BC%8F) 模块规范。
  * `.d.ts` 包含TypeScript定义的widget接口。
* `/charting_library/datafeed-api.d.ts` 包含TypeScript定义的datafeed接口。
* `/charting\_library/bundles` 包含图表库的内部文件，且不用作其他目的。它对你来说就像是黑匣子，因此它可以随时更改，恕不另行通知。
* `/charting_library/datafeeds/udf/` 包含[UDF-compatible](/book/UDF.md) 的datafeed包装类（用于实现[JS API](/book/JS-Api.md)通过UDF传输数据给图表库）。例子中的datafeed包装器类实现了脉冲实时仿真数据。您可以自由编辑此文件。
* `/charting\_library/static` 文件夹中存储图表库内部资源，不适用于其他目的。
* `/index.html` 是在网页上使用图表库的实例。
* `/test.html` 为不同的图表库自定义功能的使用的示例。
* `/mobile\*.html` 也是Widget自定义的示例。

所有内部的JS和CSS代码都被内联和缩小，以减少页面加载时间。 需要由您编辑的文件不会被缩小。
