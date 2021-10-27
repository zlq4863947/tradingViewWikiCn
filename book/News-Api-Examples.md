# 新闻API使用示例

在这里您将找到一些关于如何使用 [`news_provider` 小部件构造函数选项](Widget-Constructor.md#news_provider) 的示例。

## 设置小部件标题

要设置新闻小部件标题，请使用可选的 `title` 属性。

```javascript
new TradingView.widget({
    /* 为简单起见隐藏其他小部件选项 */
    news_provider: function getNews(symbol, callback) {
        callback({
            title: 'This is the title!',
            newsItems: [/* ... */]
        })
    }
});
```

## 获取非 RSS 新闻

假设我们有一个 API 端点，它返回与 `NewsItem` 接口匹配的新闻项的 JSON 表示。

```javascript
const jsonNewsApiUrl = 'https://www.example.com';

new TradingView.widget({
    /* 为简单起见隐藏其他小部件选项 */,
    news_provider: function getNews(symbol, callback) {
        fetch(jsonNewsApiUrl)
            .then(res => res.json())
            .then(json => {
                callback({
                    newsItems: json,
                });
            });
    }
});
```

## 按需更新新闻

假设我们想按需刷新新闻，例如在一些用户事件之后。 我们可以使用 `INewsApi` 的`update` 方法。

```javascript
const widget = new TradingView.widget({
    /* widget options hidden for simplicity */
});

function someEventHandler() {
    widget.news().then(newsApi => newsApi.refresh());
}
```
