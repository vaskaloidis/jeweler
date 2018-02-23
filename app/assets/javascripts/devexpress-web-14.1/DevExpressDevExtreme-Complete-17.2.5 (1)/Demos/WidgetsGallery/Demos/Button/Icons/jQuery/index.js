$(function(){
    
    $("#icon-done").dxButton({
        icon: "check",
        type: "success",
        text: "Done",
        onClick: function(e) { 
            DevExpress.ui.notify("The Done button was clicked");
        }
    });
    
    $("#icon-weather").dxButton({
        icon: "../../../../images/icons/weather.png",
        text: "Weather",
        onClick: function(e) { 
            DevExpress.ui.notify("The Weather button was clicked");
        }
    });
    
    $("#icon-send").dxButton({
        icon: 'fa fa-envelope-o',
        text: "Send",
        onClick: function(e) { 
            DevExpress.ui.notify("The Send button was clicked");
        }
    });
    
    $("#icon-plus").dxButton({
        icon: "plus",
        onClick: function(e) { 
            DevExpress.ui.notify("The button was clicked");
        }
    });
    
});