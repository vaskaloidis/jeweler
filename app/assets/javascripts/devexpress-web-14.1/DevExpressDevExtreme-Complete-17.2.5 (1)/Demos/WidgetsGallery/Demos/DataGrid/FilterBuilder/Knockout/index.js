window.onload = function() {    
    var popup,
        dataGridFilter = ko.observable(filterValue),
        filter = ko.observable(filterValue),
        allowHierarchicalFields = ko.observable(false),
        clearButtonDisabled = ko.observable(false),
        filterButtonType = ko.observable("success");
    
    var viewModel = {
        gridOptions: {
            dataSource: {
                store: orders,
                filter: dataGridFilter
            },
            columns: columns,
            onToolbarPreparing: function(e) {
                e.toolbarOptions.items.push({
                    location: "before",
                    widget: "dxButton",
                    options: {
                        text: "Filter Builder",
                        type: filterButtonType,
                        icon: "filter",
                        onClick: function(e) {
                            popup.show(); 
                        }
                    }
                }, {
                    location: "before",
                    widget: "dxButton",
                    options: {
                        text: "Clear Filter",
                        disabled: clearButtonDisabled,
                        onClick: function(e) {
                            dataGridFilter(null);
                            filter(null);
                            clearButtonDisabled(true);
                            filterButtonType("default");
                        }
                    }
                });
            }
        },

        popupOptions: {
            title: "Filter Builder",
            deferRendering: false,
            contentTemplate: "popupContent",
            onInitialized: function(e) {
                popup = e.component;
            },
            onShowing: function() {
                filter(dataGridFilter());
            },
            toolbarItems: [
                {
                    toolbar: "bottom", 
                    location: "after", 
                    widget: "dxButton", 
                    options: {
                        text: "OK", 
                        onClick: function(e) {
                            var filterValue = filter();
                            dataGridFilter(filterValue);
                            filterButtonType(filterValue ? "success" : "default");
                            clearButtonDisabled(!filterValue);
                            popup.hide();
                        }
                    }
                },
                {
                    toolbar: "bottom", 
                    location: "after", 
                    widget: "dxButton", 
                    options: {
                        text: "Cancel", 
                        onClick: function(e) {
                            popup.hide();
                        }
                    }
                }
            ]
        },

        filterBuilderOptions: {
            value: filter,
            fields: columns,
            allowHierarchicalFields: allowHierarchicalFields
        },

        scrollViewOptions: {
            direction: 'both'
        },
        
        allowHierarchicalFieldsOptions: {
            text: "Allow hierarchical fields",
            value: allowHierarchicalFields
        }
    };
    
    ko.applyBindings(viewModel, document.getElementById("grid"));
};