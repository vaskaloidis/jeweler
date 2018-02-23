var DemoApp = angular.module('DemoApp', ['dx', 'ngSanitize']);

DemoApp.controller('DemoController', function DemoController($scope) {
    var updateContentTimer;

    function updateContent(args, eventName) {
        var updateContentText = "<br /><div>Content has been updated on the " + eventName + " event.</div><br />";
        if(updateContentTimer)
            clearTimeout(updateContentTimer);
        updateContentTimer = setTimeout(function() {            
            $scope.content = (eventName == "PullDown" ? updateContentText + $scope.content : $scope.content + updateContentText);
            args.component.release();    
        }, 500);        
    }
    
    function updateBottomContent(e) {
        updateContent(e, "ReachBottom");
    }
        
    $scope.updateTopContent = function(e) {
        updateContent(e, "PullDown");
    };
    
    $scope.showScrollbarModes = [{
        text: "On Scroll",
        value: "onScroll"
    }, {
        text: "On Hover",
        value: "onHover"
    }, {
        text: "Always",
        value: "always"
    }, {
        text: "Never",
        value: "never"
    }];
    
    $scope.content = longText;
    $scope.showScrollbarMode = "onScroll";
    $scope.scrollByContentValue = true;    
    $scope.scrollByThumbValue = true;
    $scope.reachBottomValue = true;
    $scope.pullDownValue = false;
    
    $scope.updateBottomContent = updateBottomContent;
    
    $scope.$watch("reachBottomValue", function (value) {
        if(value){
            $scope.updateBottomContent = updateBottomContent;  
        } else {
            $scope.updateBottomContent = null;  
        }
    });
          
       
});