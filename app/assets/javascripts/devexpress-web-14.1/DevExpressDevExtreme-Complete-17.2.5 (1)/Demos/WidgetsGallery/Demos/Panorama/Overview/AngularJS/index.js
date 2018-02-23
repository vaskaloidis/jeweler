var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
    $scope.panoramaOptions = {
    	title: 'Pictures',
        dataSource: panoramaData,
        backgroundImage: {
            width: 800,
            height: 600,
            url: "../../../../images/cities/28.jpg"
        },
        onItemClick: function (e) {
            DevExpress.ui.dialog.alert("The \"" + 
                e.itemData.header + 
                "\" item is selected.", "Click Handler");
        }
    };
});