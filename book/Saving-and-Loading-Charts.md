# 储存和载入图表

---

## 目录

- [概述](#概述)
    - [什么是图表布局](#什么是图表布局)
    - [什么是研究模板](#什么是研究模板)
- [图表布局和学习模板的保存](#saving-of-chart-layouts-and-study-templates)
- [预定义的 REST API](#predefined-rest-api)
    - [存储示例](#example-of-a-storage)
    - [开发自己的后端](#developing-your-own-backend)
    - [使用演示图表和研究模板存储](#using-demo-charts-and-study-templates-storage)
    - [管理对已保存图表的访问](#managing-access-to-saved-charts)
- [API 处理程序](#api-handlers)
    - [图表布局](#chart-layouts)
    - [学习模板](#study-templates)
- [低级API](#low-level-api)
- [其他用例](#additional-use-cases)
    - [自动保存图表](#saving-charts-automatically)
    - [恢复上次保存的图表](#restoreing-last-saved-chart)

## 概述

通过本文，您将了解如何保存用户的图表布局和研究模板，并在用户返回页面时恢复它们。

### 什么是图表布局

图表布局是一组图表（在交易终端中）或单个图表（在图表库中）的配置。图表布局内容包括绘图、指标和图表设置，如颜色、样式等。

### 什么是研究模板

研究模板是一组应用指标及其设置（输入参数和样式）。

## 保存图表布局和研究模板

通常，假设您的用例使用绘图，则需要考虑存储用户的图表布局。在图表上启用研究模板需要实现存储。
建议将图表布局存储在服务器上，除非您希望用户只拥有一种图表布局。
对于只拥有一种图表布局的情况，您可以考虑使用 LocalStorage。否则，您不应该使用 LocalStorage，因为它的大小是有限的。

为了简化图表布局和研究模板存储的开发，图表库库包括 3 个层：

1. 预定义的 REST API 和示例服务器端存储，以防您想在服务器上保存图表布局和研究模板，而您没有可用于此的通用存储
1. API 处理程序允许您添加来自 GUI 的保存/加载命令的自定义处理
1. 获取/设置当前图表布局/研究模板内容的低级API

## 预定义的 REST API

图表库支持预定义的 REST API，以在您的服务器上保存图表布局和研究模板。它以下面描述的特定格式发送请求。我们提供了一个服务器端存储示例，这是一个很好的起点。

### 存储示例

我们使用 Python 和 PostgreSQL 创建了一个小型存储示例，可以在 [我们的 GitHub](https://github.com/tradingview/saveload_backend) 中找到。
您可以使用它并在您自己的服务器上运行，以便您能够控制所有用户保存的数据。

对于那些想要拥有自己的图表存储的人，这里有几个步骤：

1. 将我们的存储库克隆到您的主机
1. 运行数据服务或使用我们的演示服务。对于不熟悉 Django 的人，这里有一个简短的待办事项列表。
    1. 安装 Python 3.x 和 Pip。
    1. 安装 PostgreSQL 或其他一些 Django 友好的数据库引擎。
    1. 转到您的图表存储文件夹并运行`pip install -r requirements.txt`
    1. 转到 charting_library_charts 文件夹并在 settings.py 中设置您的数据库连接（参见 `DATABASES` @ line #12）。请记住在您的 PostgreSQL 中创建适当的数据库。
    1. 运行`python manage.py migrate`。这将创建没有任何数据的数据库模式。
    1. 运行`python manage.py runserver` 来运行数据库的 TEST 实例。不要在生产环境中使用上面的命令。使用其他一些程序（即 Gunicorn）。
1. 设置您的图表库页面：在小部件构造方法中设置`charts_storage_url = url-of-your-charts-storage`，同时设置`client_id` 和`user_id`（详见下文）。
   1.玩的愉快！

**备注**：手动数据库填充/编辑不是预期用途。请避免这样做，因为您可能会损害 Django 基础设施。

**备注**：此示例不支持授权，因此我们不建议在不添加此安全布局的情况下在生产中使用它。

### 开发自己的后端

如果您决定开发自己的存储来接受预定义的 REST API 请求，这里是您需要实现的请求接口的描述。

- 图表库将 HTTP/HTTPS 命令发送到 `charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id` 用于图表和 `charts_storage_url/charts_storage_api_version/study_templates?client=client_id&user=user_id` 用于研究模板`charts_storage_url`、`charts_storage_api_version`、`client_id` 和 `user_id` 是 [widget 构造方法](Widget-Constructor.md) 的参数。
- 你应该实现4个请求的处理：保存/加载/删除/列表。

#### 列表图表

获取请求：`charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id`

响应：JSON 对象

1. `status`：`ok` 或 `error`
1. `data`：对象数组
    1. `timestamp`：保存图表的 UNIX 时间（例如，`1449084321`）
    1. `symbol`：图表的商品ID（例如，`AA`）
    1. `resolution`：图表的分辨率（例如，`1D`）
    1. `id`：图表的唯一整数标识符（例如，`9163`）
    1. `name`：图表名称（例如，`Test`）

#### 保存图表

POST 请求：`charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id`

1. `name`：图表名称
1. `content`：图表的内容
1. `symbol`：图表的商品ID（例如，`AA`）
1. `resolution`：图表分辨率（例如，`1D`）

响应：JSON 对象

1. `status`: `ok` 或 `error`
1. `id`：图表的唯一整数标识符（例如，`9163`）

####另存为图表

POST 请求：`charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id`

1. `name`：图表名称
1. `content`：图表的内容
1. `symbol`：图表的商品ID（例如，`AA`）
1. `resolution`：图表分辨率（例如，`1D`）

响应：JSON 对象

1. `status`：`ok` 或 `error`

#### 加载图表

获取请求：`charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id`

响应：JSON 对象

1. `status`：`ok` 或 `error`
   1.`数据`：对象
   1.`content`：图表保存的内容
    1. `timestamp`：保存图表的 UNIX 时间（例如，`1449084321`）
    1. `id`：图表的唯一整数标识符（例如，`9163`）
    1. `name`：图表名称

#### 删除图表

删除请求：`charts_storage_url/charts_storage_api_version/charts?client=client_id&user=user_id&chart=chart_id`

响应：JSON 对象

1. `status`：`ok` 或 `error`

#### 列出研究模板

获取请求：`charts_storage_url/charts_storage_api_version/study_tempates?client=client_id&user=user_id`

响应：JSON 对象

1. `status`：`ok` 或 `error`
1. `data`：对象数组
    1. `name`：模板名称（例如，`Test`）

#### 保存研究模板

POST 请求：`charts_storage_url/charts_storage_api_version/study_tempates?client=client_id&user=user_id`

1. `name`：模板名称
   1.`content`：模板的内容

响应：JSON 对象

1. `status`：`ok` 或 `error`

#### 加载研究模板

获取请求：`charts_storage_url/charts_storage_api_version/study_tempates?client=client_id&user=user_id&chart=chart_id&template=name`

1. `name`：模板名称

响应：JSON 对象

1. `status`：`ok` 或 `error`
   1.`数据`：对象
    1. `name`：模板名称
       1.`content`：模板保存的内容

#### 删除研究模板

删除请求：`charts_storage_url/charts_storage_api_version/study_tempates?client=client_id&user=user_id&template=name`

1. `name`：模板名称

响应：JSON 对象

1. `status`：`ok` 或 `error`

### 使用演示图表和研究模板存储

我们正在运行一个演示图表存储服务，让您在构建图表库后立即保存/加载图表。
这是链接 <http://saveload.tradingview.com>。请注意，它按原样提供，因为它是一个演示。

我们不保证其稳定性。另请注意，我们会定期删除存储中的数据。

### 管理对已保存图表的访问

您对用户能够查看和加载的图表负责。
用户可以查看/加载与用户具有相同 `client_id` 和 `user_id` 的图表。
`client_id` 是用户组的标识符。
预期用途是当您有几组用户或有几个站点使用相同的图表存储时。
所以通常的做法是设置`client_id = your-site's-URL`。由你来决定。

`user_id` 是用户的唯一标识符。用户 ID 属于特定的 `client_id` 组。
您可以为每个用户单独设置（每个用户的私人存储）或为所有用户或用户组设置（公共存储）。

这里有一些例子：

`client_id`|`user_id`|效果
---|---|---
您的站点 URL 或其他链接|唯一用户 ID|每个用户都有一个其他用户看不到的私人图表存储。
您的站点 URL 或其他链接|所有用户的相同值|每个用户都可以查看和加载任何已保存的图表。
您的站点 URL 或其他链接|注册用户的唯一用户 ID 以及匿名用户的单独设置|每个注册用户都有一个其他用户看不到的私人图表存储。所有匿名用户共享一个存储空间。

## API 处理程序

如果您有自己的后端服务可用于存储图表布局和研究模板，则更喜欢使用 API 处理程序。
[save_load_adapter](Widget-Constructor.md#save_load_adapter) 是一个包含保存/加载 API 处理程序的对象。使用 API 处理程序可防止图表库发送 REST 请求。当用户单击保存/加载 UI 元素时，图表库会调用这些方法。

###图表布局

1. `getAllCharts(): Promise<ChartMetaInfo[]>`

    获取所有已保存图表的方法。

    `ChartMetaInfo` 是一个具有以下字段的对象：
     - `id` - 图表的唯一 ID。
     - `name` - 图表的名称。
     - `symbol` - 图表的商品ID。
     - `resolution` - 图表的分辨率。
     - `timestamp` - 上次修改图表的 UNIX 时间。

1. `removeChart(chartId): Promise<void>`

     删除图表的方法。 `chartId` 是图表的唯一 ID（参见上面的 `getAllCharts`）。

1. `saveChart(chartData: ChartData): Promise<ChartId>`

   保存图表的功能。

   `ChartData` 是一个具有以下字段的对象：
    - `id` - 图表的唯一 ID（如果之前没有保存，可能是 `undefined`）。
    - `name` - 图表的名称。
    - `symbol` - 图表的商品ID。
    - `resolution` - 图表的分辨率。
    - `content` - 图表的内容。

   `ChartId` - 图表的唯一 ID（字符串）

1. `getChartContent(chartId): Promise<ChartContent>`

     从服务器加载图表的方法。

    `ChartContent` 是一个包含图表内容的字符串（参见 `saveChart` 方法中的 `ChartData::content` 字段）。

### 研究模板

1. `getAllStudyTemplates(): Promise<StudyTemplateMetaInfo[]>`

     获取所有保存的研究模板的方法。

    `StudyTemplateMetaInfo` 是一个具有以下字段的对象：
     - `name` - 研究模板的名称。

1. `removeStudyTemplate(studyTemplateInfo: StudyTemplateMetaInfo): Promise<void>`

     删除学习模板的方法。

1. `saveStudyTemplate(studyTemplateData: StudyTemplateData): Promise<void>`

   保存学习模板的方法。

   `StudyTemplateData` 是一个具有以下字段的对象：
    - `name` - 研究模板的名称。
    - `content` - 研究模板的内容。

1. `getStudyTemplateContent(studyTemplateInfo: StudyTemplateMetaInfo): Promise<string>`

     从服务器加载研究模板的方法。

如果`charts_storage_url` 和`save_load_adapter` 都可用，则将使用`save_load_adapter`。

**重要：** 所有方法都应该返回一个 `Promise`（或类似 `Promise` 的对象）。

[内存示例](Save-Load-Adapter-Example.md) 用于测试目的。

## 低级 API

可以使用小部件的 [save() / load() 方法](Widget-Methods.md#savecallback) 和 [createStudyTemplate() / applyStudyTemplate() 方法](Chart-Methods.md#createstudytemplateoptions) 直接访问图表和研究模板的内容。

您可以将 JSON 保存在您希望的位置。例如，您可以将它们嵌入到您保存的页面或用户的工作区等中。

如果您使用低级 API，通常您可能希望隐藏保存/加载 GUI 元素。您可以禁用 [header_saveload featuresset](Featuresets.md) 以隐藏标题工具栏中的保存/加载 GUI 元素。

## 其他用例

### 自动保存图表

您可能希望自动保存图表布局。以下是实现它的步骤：

1. 以秒为单位设置[阈值延迟](Widget-Constructor.md#auto_save_delay)，用于减少onAutoSaveNeeded 调用的次数。
   1.订阅[onAutoSaveNeeded](Widget-Methods.md#subscribeevent-callback)。
1. 调用 [saveChartToServer](Widget-Methods.md#savecharttoserveroncompletecallback-onfailcallback-saveassnapshot-options) 方法。

### 恢复上次保存的图表

通常用户打开一个空图表并使　"加载图表布局..."　对话框加载他们的图表布局。但是您可能希望在开始时打开上次保存的图表布局。如果使用 低级 API，则可以将图表布局内容设置到widget构造函数中的 [saved_data](Widget-Constructor.md#saved_data) 属性。否则，将 `true` 分配给 [load_last_chart](Widget-Constructor.md#load_last_chart) 属性就足够了。
