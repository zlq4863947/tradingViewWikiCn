# 运行图表库

---

# 让我们在您的本地计算机上启动图表库

## 1. 克隆图表库资源库

[克隆资源库方法介绍](https://help.github.com/articles/cloning-a-repository/)

## 2. 启动HTTP服务器

您可以设置任何HTTP服务器来侦听主机的任何空闲端口，并参考包含图表库的文件夹。 您将在下面找到有关如何启动多个最常见HTTP服务器的说明。

### Python 2.x

如果您的计算机上安装了Python，则可以使用它以快捷方式启动HTTP服务器。

在图表库文件夹中执行以下命令：

`python -m SimpleHTTPServer 9090`

### Python 3.x

`python -m http.server 9090`

### NodeJS

首先安装 `http-server`:

`npm install http-server -g`

在图表库文件夹中，通过以下命令启动`http-server`:

`http-server -p 9090`

### NGINX

- 安装 NGINX
- 打开配置文件`nginx.conf`并在文件的`http`部分改为以下内容：

    ```javascript
    server {
        listen       9090;
        server_name  localhost;

        location / {
            root ABSOLUTE_PATH_TO_THE_CHARTING_LIBRARY;
        }
    }
    ```

- 将`ABSOLUTE_PATH_TO_THE_CHARTING_LIBRARY`替换为图表库文件夹的绝对路径。
- 运行`nginx`

## 3. 在浏览器中打开图表库

运行HTTP服务器后，您将拥有一个已准备好的图表库。

在浏览器中打开 `http://127.0.0.1:9090`。

# 在线示例

您会看到图表库[此处](http://demo_chart.tradingview.com)的运行示例。 此示例基于我们的[示例datafeed](http://demo_feed.tradingview.com)。

**重要**：此数据源只是一个示例。 它包含十几个商品（来自Quandl）并仅提供DWM(日周月)。 但它支持报价。 请仅将其用于测试目的。

<!--stackedit_data:
eyJoaXN0b3J5IjpbNjEzMDY0NjA5LDE1OTMyODM3NDFdfQ==
-->