var DemoApp = angular.module('DemoApp', ['dx']);

DemoApp.controller('DemoController', function DemoController($scope) {
	$scope.okButtonOptions = {
        text: 'OK',
        type: 'normal',
	    onClick: function(e) { 
	    	DevExpress.ui.notify("The OK button was clicked");
	    }
    };

    $scope.applyButtonOptions = {
	    text: "Apply",
	    type: "success",
	    onClick: function(e) { 
	    	DevExpress.ui.notify("The Apply button was clicked");
	    }
	};

    $scope.doneButtonOptions = {
	    text: "Done",
	    type: "default",
	    onClick: function(e) { 
	    	DevExpress.ui.notify("The Done button was clicked");
	    }
	};

	$scope.deleteButtonOptions = {
	    text: "Delete",
	    type: "danger",
	    onClick: function(e) { 
	    	DevExpress.ui.notify("The Delete button was clicked");
	    }
	};

	$scope.backButtonOptions = {
	    type: "back",
	    onClick: function(e) { 
	    	DevExpress.ui.notify("The Back button was clicked");
	    }
	};
});