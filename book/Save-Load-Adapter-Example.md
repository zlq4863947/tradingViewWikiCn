用于测试目的的 `save_load_adapter` 的内存示例。

```javascript
save_load_adapter: {
    charts: [],
    studyTemplates: [],
    drawingTemplates: [],
    getAllCharts: function() {
        return Promise.resolve(this.charts);
    },

    removeChart: function(id) {
        for (var i = 0; i < this.charts.length; ++i) {
            if (this.charts[i].id === id) {
                this.charts.splice(i, 1);
                return Promise.resolve();
            }
        }

        return Promise.reject();
    },

    saveChart: function(chartData) {
        if (!chartData.id) {
            chartData.id = Math.random().toString();
        } else {
            this.removeChart(chartData.id);
        }

        chartData.timestamp = new Date().valueOf();

        this.charts.push(chartData);

        return Promise.resolve(chartData.id);
    },

    getChartContent: function(id) {
        for (var i = 0; i < this.charts.length; ++i) {
            if (this.charts[i].id === id) {
                return Promise.resolve(this.charts[i].content);
            }
        }

        console.error('error');

        return Promise.reject();
    },

    removeStudyTemplate: function(studyTemplateData) {
        for (var i = 0; i < this.studyTemplates.length; ++i) {
            if (this.studyTemplates[i].name === studyTemplateData.name) {
                this.studyTemplates.splice(i, 1);
                return Promise.resolve();
            }
        }

        return Promise.reject();
    },

    getStudyTemplateContent: function(studyTemplateData) {
        for (var i = 0; i < this.studyTemplates.length; ++i) {
            if (this.studyTemplates[i].name === studyTemplateData.name) {
                return Promise.resolve(this.studyTemplates[i]);
            }
        }

        console.error('st: error');

        return Promise.reject();
    },

    saveStudyTemplate: function(studyTemplateData) {
        for (var i = 0; i < this.studyTemplates.length; ++i) {
            if (this.studyTemplates[i].name === studyTemplateData.name) {
                this.studyTemplates.splice(i, 1);
                break;
            }
        }

        this.studyTemplates.push(studyTemplateData);
        return Promise.resolve();
    },

    getAllStudyTemplates: function() {
        return Promise.resolve(this.studyTemplates);
    },

    removeDrawingTemplate: function (toolName, templateName) {
        for (var i = 0; i < this.drawingTemplates.length; ++i) {
            if (this.drawingTemplates[i].name === templateName) {
                this.drawingTemplates.splice(i, 1);
                return Promise.resolve();
            }
        }

        return Promise.reject();
    },

    loadDrawingTemplate: function (toolName, templateName) {
        for (var i = 0; i < this.drawingTemplates.length; ++i) {
            if (this.drawingTemplates[i].name === templateName) {
                return Promise.resolve(this.drawingTemplates[i].content);
            }
        }

        console.error('drawing: error');

        return Promise.reject();
    },

    saveDrawingTemplate: function (toolName, templateName, content) {
        for (var i = 0; i < this.drawingTemplates.length; ++i) {
            if (this.drawingTemplates[i].name === templateName) {
                this.drawingTemplates.splice(i, 1);
                break;
            }
        }

        this.drawingTemplates.push({ name: templateName, content: content });
        return Promise.resolve();
    },

    getDrawingTemplates: function () {
        return Promise.resolve(this.drawingTemplates.map(function(template) {
            return template.name;
        }));
    },
}
```
