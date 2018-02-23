$(function(){
    $("#gridContainer").dxDataGrid({
        dataSource: orders,
        columnChooser: {
            enabled: true
        },
        loadPanel: {
            enabled: true
        },    
        columns: [{
            dataField: "OrderNumber",
            caption: "Invoice Number"
        }, "OrderDate", "Employee", {
            caption: "City",
            dataField: "CustomerStoreCity"
        }, {
            caption: "State",
            groupIndex: 0,
            dataField: "CustomerStoreState",
        }, {
            dataField: "SaleAmount",
            alignment: "right",
            format: "currency"
        }],   
        onToolbarPreparing: function(e) {
            var dataGrid = e.component;
    
            e.toolbarOptions.items.unshift({
                location: "before",
                template: function(){
                    return $("<div/>")
                        .addClass("informer")
                        .append(
                           $("<h2 />")
                             .addClass("count")
                             .text(getGroupCount("CustomerStoreState")),
                           $("<span />")
                             .addClass("name")
                             .text("Total Count")
                        );
                }
            }, {
                location: "before",
                widget: "dxSelectBox",
                options: {
                    width: 200,
                    items: [{
                        value: "CustomerStoreState",
                        text: "Grouping by State"
                    }, {
                        value: "Employee",
                        text: "Grouping by Employee"
                    }],
                    displayExpr: "text",
                    valueExpr: "value",
                    value: "CustomerStoreState",
                    onValueChanged: function(e) {
                        dataGrid.clearGrouping();                    
                        dataGrid.columnOption(e.value, "groupIndex", 0);
                        $(".informer .count").text(getGroupCount(e.value));
                    }
                }
            }, {
                location: "before",
                widget: "dxButton",
                options: {
                    hint: "Collapse All",
                    icon: "chevrondown",
                    onClick: function(e) {
                        var expanding = e.component.option("icon") === "chevronnext";
                        dataGrid.option("grouping.autoExpandAll", expanding);
                        e.component.option({
                            icon: expanding ? "chevrondown": "chevronnext",
                            hint: expanding ? "Collapse All" : "Expand All"
                        });
                    }
                }
            }, {
                location: "after",
                widget: "dxButton",
                options: {
                    icon: "refresh",
                    onClick: function() {
                        dataGrid.refresh();
                    }
                }
            });
        }
    });
    
    function getGroupCount(groupField) {
        return DevExpress.data.query(orders)
            .groupBy(groupField)
            .toArray().length;
    }
});