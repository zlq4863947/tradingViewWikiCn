## Light/dark 主题颜色更改（Alpha版本）

不再支持Internet Explorer 11浏览器。 使用此特定的Web浏览器时，本节中描述的功能不会影响界面。

重要提示：目前正在开发此功能。在以后的版本中，可能完全更改或删除任何变量和选择器名称。


*从版本1.16开始*.

You can change the colors of light/dark theme for certain UI elements by connecting your [CSS files](Widget-Constructor#custom_css_url). For your convenience, some elements have CSS Custom Properties that can be overridden.

您可以通过使用CSS文件来更改某些UI元素的light/dark主题的颜色。为了您的方便，某些元素具有可以覆盖的CSS自定义属性。

The following CSS will make the widget look pink when selecting the light/dark theme.
当选择light/dark主题时，以下CSS将使widget呈显出粉红色。

```css
:root:not(.theme-dark) {
    --tv-color-platform-background: #d1c4e9;
    --tv-color-pane-background: rgb(251, 223, 244);
    --tv-color-pane-background-secondary: rgb(249, 185, 233);
    --tv-color-toolbar-button-background-hover: rgb(244, 143, 177);
    --tv-color-toolbar-button-background-secondary-hover: red;
    --tv-color-toolbar-button-background-expanded: rgb(244, 143, 177);
    --tv-color-toolbar-button-text: rgb(136, 24, 79);
    --tv-color-toolbar-button-text-hover: rgb(74, 20, 140);
    --tv-color-toolbar-button-text-active: red;
    --tv-color-toolbar-button-text-active-hover: red;
    --tv-color-item-active-text: rgb(6, 6, 255);
    --tv-color-toolbar-toggle-button-background-active: red;
    --tv-color-toolbar-toggle-button-background-active-hover: magenta;
}

.theme-dark:root {
    --tv-color-platform-background: #d1c4e9;
    --tv-color-pane-background: rgb(251, 223, 244);
    --tv-color-pane-background-secondary: rgb(249, 185, 233);
    --tv-color-toolbar-button-background-hover: rgb(244, 143, 177);
    --tv-color-toolbar-button-background-secondary-hover: red;
    --tv-color-toolbar-button-background-expanded: rgb(244, 143, 177);
    --tv-color-toolbar-button-text: rgb(136, 24, 79);
    --tv-color-toolbar-button-text-hover: rgb(74, 20, 140);
    --tv-color-toolbar-button-text-active: red;
    --tv-color-toolbar-button-text-active-hover: red;
    --tv-color-item-active-text: rgb(6, 255, 6);
    --tv-color-toolbar-toggle-button-background-active: red;
    --tv-color-toolbar-toggle-button-background-active-hover: magenta;
}
```

- `: root: not (.theme-dark)` 选择器定义light主题的规则
- `.theme-dark: root` 选择器定义dark主题的规则

可用变量：

- `--tv-color-platform-background` - 设置所有元素的页面的主要颜色
- `--tv-color-pane-background` - 工具栏背景色
- `--tv-color-pane-background-secondary` - 工具栏的其他背景色（例如，右侧有打开的工具栏时）
- `--tv-color-toolbar-button-background-hover` - 工具栏按钮的悬停效果颜色
- `--tv-color-toolbar-button-background-secondary-hover` - 工具栏按钮的其他悬停颜色（例如，右侧有打开的工具栏时）
- `--tv-color-toolbar-button-background-expanded` - 右侧工具栏上活动按钮的悬停效果颜色
- `--tv-color-toolbar-button-text` - 工具栏按钮的文本和图标颜色
- `--tv-color-toolbar-button-text-hover` - 将鼠标悬停在工具栏按钮上时，文本和图标的颜色
- `--tv-color-toolbar-button-text-active` - 活动工具栏按钮的文本和图标颜色
- `--tv-color-toolbar-button-text-active-hover` - 将鼠标悬停在它们上方时，工具栏按钮的文本和图标颜色
- `--tv-color-item-active-text` - 切换工具栏按钮的文本颜色（例如，“磁铁模式”，“锁定所有图形”）
- `--tv-color-toolbar-toggle-button-background-active` - 填充切换工具栏按钮的颜色（例如，“磁铁模式”，“锁定所有图形”）
- `--tv-color-toolbar-toggle-button-background-active-hover` - 将切换工具栏按钮悬停在其上时填充颜色（例如，“磁铁模式”，“锁定所有图形”）
