$(function(){
    var dataGrid = $("#gridContainer").dxDataGrid({
        dataSource: orders,
        keyExpr: "ID",
        paging: {
            enabled: false
        },
        selection: {
            mode: "multiple"
        },
        columns: [{
                dataField: "OrderNumber",
                width: 130,
                caption: "Invoice Number"
            }, {
                width: 160,
                dataField: "OrderDate",
                dataType: "date",
            }, 
            "Employee", {
                caption: "City",
                dataField: "CustomerStoreCity"
            }, {
                caption: "State",
                dataField: "CustomerStoreState",
            }, {
                dataField: "SaleAmount",
                alignment: "right",
                format: "currency"
            }
        ],
        selectedRowKeys: [1, 4, 7],
        summary: {
            totalItems: [{
                    name: "SelectedRowsSummary",
                    showInColumn: "SaleAmount",
                    displayFormat: "Sum: {0}",
                    valueFormat: "currency",
                    summaryType: "custom"
                }
            ],
            calculateCustomSummary: function (options) {
                if (options.name === "SelectedRowsSummary") {
                    if (options.summaryProcess === "start") {
                        options.totalValue = 0;
                    }
                    if (options.summaryProcess === "calculate") {
                        if (options.component.isRowSelected(options.value.ID)) {
                            options.totalValue = options.totalValue + options.value.SaleAmount;
                        }
                    }
                }
            }
        }
    
    }).dxDataGrid("instance");
    
    $("#applyCustomFilter").dxButton({
        text: "Calculate summary for selected rows", 
        onClick: function() {
            dataGrid.refresh();
        }
    });
});