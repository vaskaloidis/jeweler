window.onload = function() {
    var viewModel = {
        okButtonOptions: {
            text: 'OK',
            type: 'normal',
    	    onClick: function(e) { 
    	    	DevExpress.ui.notify("The OK button was clicked");
    	    }
        },
    
        applyButtonOptions: {
    	    text: "Apply",
    	    type: "success",
    	    onClick: function(e) { 
    	    	DevExpress.ui.notify("The Apply button was clicked");
    	    }
    	},
    
        doneButtonOptions: {
    	    text: "Done",
    	    type: "default",
    	    onClick: function(e) { 
    	    	DevExpress.ui.notify("The Done button was clicked");
    	    }
    	},
    
    	deleteButtonOptions: {
    	    text: "Delete",
    	    type: "danger",
    	    onClick: function(e) { 
    	    	DevExpress.ui.notify("The Delete button was clicked");
    	    }
    	},
    
    	backButtonOptions: {
    	    type: "back",
    	    onClick: function(e) { 
    	    	DevExpress.ui.notify("The Back button was clicked");
    	    }
    	}
    };
    
    ko.applyBindings(viewModel, document.getElementById("demo"));
};