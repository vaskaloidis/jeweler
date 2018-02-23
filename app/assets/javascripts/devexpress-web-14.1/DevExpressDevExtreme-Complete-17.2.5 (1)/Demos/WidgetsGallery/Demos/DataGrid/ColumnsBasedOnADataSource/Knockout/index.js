window.onload = function() {
    var viewModel = {
    	gridOptions: {
    	    dataSource: orders
    	}
    };
    
    ko.applyBindings(viewModel, document.getElementById("grid"));
};