$(function(){
    var filterBuilder,
        filterButton,
        clearFilterButton;

    var dataGrid = $("#gridContainer").dxDataGrid({
        dataSource: {
            store: orders,
            filter: filterValue
        },
        columns: columns,
        onToolbarPreparing: function(e) {
            e.toolbarOptions.items.push({
                location: "before",
                widget: "dxButton",
                options: {
                    text: "Filter Builder",
                    type: "success",
                    icon: "filter",
                    onClick: function(e) {
                        popup.show(); 
                    },
                    onInitialized: function(e) {
                        filterButton = e.component;
                    }
                }
            }, {
                location: "before",
                widget: "dxButton",
                options: {
                    text: "Clear Filter",
                    onInitialized: function(e) {
                        clearFilterButton = e.component;
                    },
                    onClick: function(e) {
                        dataGrid.clearFilter();
                        filterBuilder.option("value", null);
                        e.component.option("disabled", true);
                        filterButton.option("type", "default");
                    }
                }
            });
        }
    }).dxDataGrid('instance');
    
    var popup = $("#popupContainer").dxPopup({
        title: "Filter Builder",
        deferRendering: false,
        contentTemplate: function($contentElement) {
            filterBuilder = $("<div/>").dxFilterBuilder({
                fields: columns
            }).appendTo($contentElement).dxFilterBuilder("instance");

            $contentElement.dxScrollView({ direction: "both" });
        },
        onShowing: function() {
            filterBuilder.option("value", dataGrid.filter());
        },
        toolbarItems: [
            {
                toolbar: "bottom", 
                location: "after", 
                widget: "dxButton", 
                options: {
                    text: "OK", 
                    onClick: function(e) {
                        var filter = filterBuilder.option("value");

                        dataGrid.filter(filter);
                        filterButton.option("type", filter ? "success" : "default");
                        clearFilterButton.option("disabled", !filter);
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
    }).dxPopup("instance");

    $("#allowHierarchicalFields").dxCheckBox({
        text: "Allow hierarchical fields",
        value: false,
        onValueChanged: function(e) {
            filterBuilder.option("allowHierarchicalFields", e.value);
        }
    });
});