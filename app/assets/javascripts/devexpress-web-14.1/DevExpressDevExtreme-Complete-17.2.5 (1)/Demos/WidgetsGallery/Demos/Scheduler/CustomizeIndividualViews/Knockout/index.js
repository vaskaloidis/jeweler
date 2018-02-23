window.onload = function() {
    var viewModel = {
        options: {
            height: 600,
            dataSource: data,
            showAllDayPanel: false,
            views: ["day",
                {
                    type: "week",
                    groups: ["typeId"],
                    dateCellTemplate: "dateCellTemplate"
                }, {
                    type: "workWeek",
                    startDayHour: 9,
                    endDayHour: 18,
                    groups: ["priorityId"],
                    dateCellTemplate: "dateCellTemplate"
                }, "month"],
            currentView: "workWeek",
            currentDate: new Date(2015, 4, 25),
            startDayHour: 7,
            endDayHour: 23,
            resources: [{
                fieldExpr: "priorityId",
                allowMultiple: false,
                dataSource: priorityData,
                label: "Priority"
            }, {
                fieldExpr: "typeId",
                allowMultiple: false,
                dataSource: typeData,
                label: "Type"
            }]
        }
    };
    
    ko.applyBindings(viewModel, document.getElementById("scheduler-demo"));
};