$(function(){    
    $("#scheduler").dxScheduler({
        dataSource: data,
        views: ["day", "week", "workWeek", "month"],
        currentView: "workWeek",
        currentDate: new Date(2015, 4, 25),
        firstDayOfWeek: 0,
        startDayHour: 8,
        endDayHour: 19,
        groups: ["priorityId"],
        resources: [
            { 
                 fieldExpr: "priorityId", 
                 allowMultiple: false, 
                 dataSource: priorityData,
                 label: "Priority"
            }
        ],
        height: 600
    });
});