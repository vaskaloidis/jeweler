$(function(){
    $("#normal").dxButton({
        text: "OK",
        type: "normal",
        onClick: function(e) { 
        	DevExpress.ui.notify("The OK button was clicked");
        }
    });
    
    $("#success").dxButton({
        text: "Apply",
        type: "success",
        onClick: function(e) { 
        	DevExpress.ui.notify("The Apply button was clicked");
        }
    });
    
    $("#default").dxButton({
        text: "Done",
        type: "default",
        onClick: function(e) { 
        	DevExpress.ui.notify("The Done button was clicked");
        }
    });
    
    $("#danger").dxButton({
        text: "Delete",
        type: "danger",
        onClick: function(e) { 
        	DevExpress.ui.notify("The Delete button was clicked");
        }
    });
    
    $("#back").dxButton({
        type: "back",
        onClick: function(e) { 
        	DevExpress.ui.notify("The Back button was clicked");
        }
    });
});