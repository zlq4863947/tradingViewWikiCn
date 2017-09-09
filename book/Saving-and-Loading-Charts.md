#交易主机

---

Charting Library supports saving/loading charts and study templates (study templates are available in `unstable`) on 2 levels of abstraction:
图表库支持保存/加载图表和学习模板（研究模板在 `unstable`中提供）在两个抽象层次上：

1. **低级别**：小部件的`save()`/`load()`[[methods|Widget-Methods＃savecallback]]和`createStudyTemplate()`/`applyStudyTemplate()` [[methods|Widget-Methods#createstudytemplateoptions-callback]]。 使用它们的人需要维护自己物理存储。 但是您可以将这些JSON保存在您想要的位置 - 例如，您可以将其嵌入到您保存的页面或用户的工作区域等中。

2. **高级别**：图表库可以从您指向的存储中保存/加载图表和学习模板。 我们使用Python和PostgreSQL创建了一个小型存储示例，并将其放在[我们的GitHub](https://github.com/tradingview/saveload_backend)上。 您可以获取它并运行在您自己的服务器上，以便您可以控制所有用户的保存数据。

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

**备注**：手动填充/编辑数据库不是这个东西所需的用法。 请避免这个，因为你可能会伤害Django。

## 开发自己的后端
*图表库将HTTP / HTTPS命令发送到`charts_storage_url / charts_storage_api_version / charts？client = client_id＆user = user_id`。 `charts_storage_url`，`chart_storage_api_version`，`client_id`和`user_id`是[widget构造函数]（https://github.com/tradingview/charting_library/wiki/Widget-Constructor）的参数。
*您应该执行4个请求的处理：保存图表/加载图表/删除图表/列表。

#### 列出图表
GET REQUEST: charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id

RESPONSE: JSON Object

1. status: "ok" or "error"
2. data: Array of Objects
    1. "timestamp": UNIX time when the chart was saved (example, 1449084321)
    2. "symbol": base symbol of the chart (example, "AA")
    3. "resolution": resolution of the chart (example, "D")
    4. "id": unique integer identifier of the chart (example, 9163)
    5. "name": chart name (example, "Test")

#### 存储图表

POST REQUEST: charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id

1. "name": name of the chart
2. "content": content of the chart
3. "symbol": chart symbol (example, "AA")
4. "resolution: chart resolution (example, "D")

RESPONSE: JSON Object

1. "status": "ok" or "error"
2. "id": unique integer identifier of the chart (example, 9163)

#### 存储为图表

POST REQUEST: charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id

1. "name": name of the chart
2. "content": content of the chart
3. "symbol": chart symbol (example, "AA")
4. "resolution: chart resolution (example, "D")

RESPONSE: JSON Object

1. "status": "ok" or "error"

#### 加载图表
GET REQUEST: charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id

RESPONSE: JSON Object

1. "status": "ok" or "error"
2. "data": Object
    1. "content": saved content of the chart
    2. "timestamp": UNIX time when the chart was saved (example, 1449084321)
    3. "id": unique integer identifier of the chart (example, 9163)
    4. "name": name of the chart

#### 删除图表
DELETE REQUEST: charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id

RESPONSE: JSON Object

1. "status": "ok" or "error"

# 使用演示图和研究模板存储

我们正在运行演示图存储服务，让您尽可能快地保存/加载新的库的构建。 此存储网址为<http://saveload.tradingview.com>。 这只是一个演示，所以它是按原样提供的。 我们不保证其稳定性。 此外，我们一次又一次地从这个存储中删除所有的数据。

# 管理保存的图表访问
You should take care of which charts your users will be able to see and load. Basically, user can see/load charts having the same `client_id` and `user_id` the user has. `client_id` is an identifier of user's group. It is intended to cover the case when you have few groups of users (i.e, when you have few sites) using the same charts storage. So the common practice is to set `client_id = your-site's-URL`. It's up to you however.
您应该关心用户将能够查看和加载哪些图表。 基本上，用户可以看到/加载与用户具有相同的 `client_id` 和 `user_id` 的图表。 `client_id`是用户组的标识符。 当您使用相同的图表存储时，您的用户群体（即，当您有少量站点）时，可以覆盖这种情况。 所以常见的做法是设置'client_id = your-site'-URL'。 然而，这取决于你。

`user_id` 在您的 `client_id` 组的上下文中将是用户的id。 您可以单独设置每个用户（使每个用户拥有自己的私人图表存储），也可以将所有用户或任何用户组设置为相同，以创建一种公共存储。 以下是几个例子：

client_id|user_id|Effect
---|---|---
your site url or anything else|unique user id|Each user has his private charts storage other users can't see.
your site url or anything else|the same value for all users|Each user can see and load each of saved charts.
your site url or anything else|unique user id for registered users and some constant for all who's anonymous|Each registered user has his private charts storage other users can't see. All anonymous users have one shared storage.
