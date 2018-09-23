# 储存和载入图表

---

图表库支持使用2个级别的API，用以保存/加载图表和指标模板：

1. **低级**：保存/加载功能由`save()` / `load()` [方法](/book/Widget-Methods.md#savecallback)和`createStudyTemplate()` / `applyStudyTemplate()`[方法](Chart-Methods.md#createstudytemplateoptions)提供实现。
     应该考虑服务器上的存储数据。
     您可以将JSON保存在您希望的位置。 例如，您可以将它们嵌入到已保存的页面或用

1. **高级**：图表库能够从您指向的存储中保存/加载图表和指标模板。
     我们使用Python和PostgreSQL创建了一个小型存储示例，可以在 [我们的GitHub](https://github.com/tradingview/saveload_backend)中找到。
     您可以使用它并在自己的服务器上运行，这样您就可以控制所有用户的已保存数据。

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
*图表库将HTTP/HTTPS命令发送到`charts_storage_url / charts_storage_api_version / charts？client = client_id＆user = user_id`。 `charts_storage_url`，`chart_storage_api_version`，`client_id`和`user_id`是[widget构造函数](/book/Widget-Constructor.md)的参数。
*您应该执行4个请求的处理：保存图表/加载图表/删除图表/列出图表。

#### 列出图表
GET REQUEST: `charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id`

响应：JSON对象

1. `status`: `ok` 或 `error`
1. `data`: 对象数组
    1. `timestamp`: 保存图表时的UNIX时间（例如，1449084321）
    1. `symbol`: 图表的商品（例如，`AA`）
    1. `resolution`: 周期（例如，`D`）
    1. `id`: 图表的唯一整数标识符（例如，`9163`）
    1. `name`: 图表名称（例如，`Test`）

#### 存储图表

POST REQUEST: `charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id`

1. `name`: 图表名称
1. `content`: 图表内容
1. `symbol`: 图表商品(例如, `AA`)
1. `resolution`: 图表周期 (例如, `D`)

响应：JSON对象

1. `status`: `ok` 或 `error`
1. `id`: 图表的唯一整数标识符（例如，`9163`)

#### 存储为图表

POST REQUEST: `charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id`

1. `name`: 图表名称
1. `content`: 图表内容
1. `symbol`: 图表商品(例如, `AA`)
1. `resolution`: 图表周期 (例如, `D`)

响应：JSON对象

1. `status`: `ok` 或 `error`

#### 加载图表
GET REQUEST: `charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id`

响应：JSON对象

1. `status`: `ok` 或 `error`
1. `data`: 对象数组
    1. `timestamp`: 保存图表时的UNIX时间（例如，1449084321）
    1. `symbol`: 图表的商品（例如，`AA`）
    1. `resolution`: 周期（例如，`D`）
    1. `id`: 图表的唯一整数标识符（例如，`9163`）
    1. `name`: 图表名称（例如，`Test`）

#### 删除图表

DELETE REQUEST: `charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id`

响应：JSON对象

1. `status`: `ok` 或 `error`

# 使用演示图表和指标模板存储

我们正在运行演示图存储服务，以便在构建图表库时立即保存/加载图表。
这是链接<http://saveload.tradingview.com>。 请注意，它是按原样提供的，因为它是一个演示。

我们不保证其稳定性。 另请注意，我们会定期删除存储中的数据。

# 管理对已保存图表的访问

您负责用户能够查看和加载的图表。
用户可以查看/加载和用户相同的`client_id`和`user_id`的图表。
`client_id`是用户组的标识符。
预期用途是当您有几组用户或有少数几个使用相同图表存储的网站时。
所以通常的做法是设置`client_id = your-site's-URL`。 这由你来决定。

`user_id`是用户的唯一标识符。 用户ID属于特定的`client_id`组。
您可以单独为每个用户设置它（每个用户的私有存储），也可以为所有用户或用户组（公共存储）设置它。

这里有一些例子：

client_id|user_id|作用
---|---|---
您的站点URL或其他链接|唯一用户ID |每个用户都有一个其他用户看不到的私有图表存储。
您的站点URL或其他链接|所有用户都为相同值|每个用户都可以查看和加载任何已保存的图表。
您的站点URL或其他链接|注册用户的唯一用户ID以及匿名用户的单独设置|每个注册用户都有一个其他用户看不到的私有图表存储。 所有匿名用户共享一个存储。