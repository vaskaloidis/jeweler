window.onload = function() {
    var viewModel = {
        doneButton: {
            icon: "check",
            type: "success",
            text: "Done",
            onClick: function(e) { 
                DevExpress.ui.notify("The Done button was clicked");
            }
        },
    
        weatherButton: {
            icon: "../../../../images/icons/weather.png",
            text: "Weather",
            onClick: function(e) { 
                DevExpress.ui.notify("The Weather button was clicked");
            }
        },
    
        sendButton: {
            icon: 'fa fa-envelope-o',
            text: "Send",
            onClick: function(e) { 
                DevExpress.ui.notify("The Send button was clicked");
            }
        },
        
        plusButton: {
            icon: "plus",
            onClick: function(e) { 
                DevExpress.ui.notify("The button was clicked");
            }
        }
    };
    
    ko.applyBindings(viewModel, document.getElementById("demo"));
};