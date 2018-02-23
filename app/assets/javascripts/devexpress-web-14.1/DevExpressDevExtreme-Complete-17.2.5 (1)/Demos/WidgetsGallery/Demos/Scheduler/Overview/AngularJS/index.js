var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
    var dataSource = new DevExpress.data.DataSource({
        store: data
    });
        
    $scope.schedulerOptions = {
        dataSource: dataSource,
        views: ["month"],
        currentView: "month",
        currentDate: new Date(2016, 7, 2, 11, 30),
        firstDayOfWeek: 1,
        startDayHour: 8,
        endDayHour: 18,
        showAllDayPanel: false,
        height: 600,
        groups: ['employeeID'],
        resources: [
            {
                fieldExpr: 'employeeID',
                allowMultiple: false,
                dataSource: employees,
                label: 'Employee'
            }
        ],
        resourceCellTemplate: 'resourceCellTemplate',
        dataCellTemplate: function(cellData, index, container) {
            var employeeID = cellData.groups.employeeID,
                currentTraining = getCurrentTraining(index, employeeID);

            if(isWeekEnd(cellData.startDate)) {
                container.addClass("employee-weekend-" + employeeID);
            }

            return $("<div>")
                    .addClass("day-cell")
                    .addClass(currentTraining)
                    .addClass("employee-" + employeeID)
                    .text(cellData.text);
        }
    };

    function getCurrentTraining(index, employeeID) {
        var currentTraining,
            result = (index + employeeID) % 3;

        switch(result) {
            case 0:
                currentTraining = "abs-background";
                break;
            case 1:
                currentTraining = "step-background";
                break;
            case 2:
                currentTraining = "fitball-background";
                break;
            default:
                currentTraining = "";
        }

        return currentTraining;
    }

    function isWeekEnd (date) {
        var day = date.getDay();
        return day === 0 || day === 6;
    }

});