# 储存和载入图表

---

图表库支持保存/加载图表和指标模板（指标模板在 `unstable`中提供）在2级抽象上：

1. **低级别**：保存/加载功能通过widget的`save()`/`load()`[方法](/book/Widget-Methods.md#savecallback)和`createStudyTemplate()`/ `applyStudyTemplate（）`方法呈现。 使用它们的人应该自己处理物理存储。 因此，您可以将这些JSON保存到您想要的位置，例如，您可以将它们嵌入到已保存的页面或用户的工作区域等等。

2. **高级别**：图表库可以从您指向的存储中保存/加载图表和指标模板。 我们使用Python和PostgreSQL创建了一个小型存储示例，并将其放在[我们的GitHub](https://github.com/tradingview/saveload_backend)上。 您可以获取它并运行在您自己的服务器上，以便您可以控制所有用户的保存数据。

# 使用高级别保存/加载

下面是想拥有自己图表存储功能所需的步骤：

1. 克隆我们的资源到您的主机上
2. 运行数据服务或使用我们的演示服务。对于不熟悉Django的人来说，这是一个简短的待办事项列表。
    1. Install Python 3.x and Pip.
    2. Install PostgreSQL or some other Django-friendly database engine.
    3. 转到图表存储文件夹并运行 `pip install -r requirements.txt`
    4. 转到charting_library_charts文件夹，并在settings.py中设置数据库连接（参见 `DATABASES` @ line #12) 。请记住在PostgreSQL中创建适当的数据库。
    5. 运行 `python manage.py migrate` 。 这将创建没有任何数据的数据库schema。
    6. 运行 `python manage.py runserver` 运行您的数据库的TEST实例。 不要在生产环境中使用上面的命令。 使用一些其他的东西（例如Gunicorn）
3. 设置您的图表库页面: 设置 `charts_storage_url = url-of-your-charts-storage`,
并在widget的.ctor中设置`client_id`和`user_id`（见下文）。
4. 请享用 !

**备注**：手动填充/编辑数据库并不是理想做饭。 请避免这个，因为你可能会伤害Django。

## 开发自己的后端
*图表库将HTTP/HTTPS命令发送到`charts_storage_url / charts_storage_api_version / charts？client = client_id＆user = user_id`。 `charts_storage_url`，`chart_storage_api_version`，`client_id`和`user_id`是[widget构造函数](/book/Widget-Constructor)的参数。
*您应该执行4个请求的处理：保存图表/加载图表/删除图表/列出图表。

#### 列出图表
GET REQUEST: charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id

响应：JSON对象

1. status: "ok" or "error"
2. data: 对象数组
    1. "timestamp": 保存图表时的UNIX时间（例如，1449084321）
    2. "symbol": 图表的商品（例如，“AA”）
    3. "resolution": 周期（例如，“D”）
    4. "id": 图表的唯一整数标识符（例如，9163）
    5. "name": 图表名称（例如，“测试”）

#### 存储图表

POST REQUEST: charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id

1. "name": 图表名称
2. "content": 图表内容
3. "symbol": 图表商品(例如, "AA")
4. "resolution: 图表周期 (例如, "D")

响应：JSON对象

1. "status": "ok" or "error"
2. "id": 图表的唯一整数标识符（例如，9163）

#### 存储为图表

POST REQUEST: charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id

1. "name": 图表名称
2. "content": 图表内容
3. "symbol": 图表商品(例如, "AA")
4. "resolution: 图表周期 (例如, "D")

响应：JSON对象

1. "status": "ok" or "error"

#### 加载图表
GET REQUEST: charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id

响应：JSON对象

1. status: "ok" or "error"
2. data: 对象数组
    1. "timestamp": 保存图表时的UNIX时间（例如，1449084321）
    2. "symbol": 图表的商品（例如，“AA”）
    3. "resolution": 周期（例如，“D”）
    4. "id": 图表的唯一整数标识符（例如，9163）
    5. "name": 图表名称（例如，“测试”）

#### 删除图表
DELETE REQUEST: charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id

响应：JSON对象

1. "status": "ok" or "error"

# 使用演示图和指标模板存储

我们正在运行演示图存储服务，让您尽可能快地保存/加载新的库的构建。 此存储网址为<http://saveload.tradingview.com>。 这只是一个演示，所以它是按原样提供的。 我们不保证其稳定性。 此外，我们一次又一次地从这个存储中删除所有的数据。

# 管理保存的图表访问
您应该关心用户将能够查看和加载哪些图表。 基本上，用户可以看到/加载与用户具有相同的 `client_id` 和 `user_id` 的图表。 `client_id`是用户组的标识符。 当您使用相同的图表存储时，您的用户群体（即，当您有少量站点）时，可以覆盖这种情况。 所以常见的做法是设置`client_id = your-site's-URL`。 然而，这取决于你。

`user_id` 在您的 `client_id` 组的上下文中将是用户的id。 您可以单独设置每个用户（使每个用户拥有自己的私人图表存储），也可以将所有用户或任何用户组设置为相同，以创建一种公共存储。 以下是几个例子：

client_id|user_id|作用
---|---|---
您的网站网址或其他任何内容|唯一用户ID|每个用户都有他的私人图表存储其他用户看不到。
您的网站网址或其他任何内容|所有用户的相同值|每个用户都可以看到并加载每个保存的图表。
您的网站网址或其他任何信息|注册用户的唯一用户ID和所有匿名用户的常量|每个注册用户都有他的私有图表存储其他用户看不到。 所有匿名用户都有一个共享存储。