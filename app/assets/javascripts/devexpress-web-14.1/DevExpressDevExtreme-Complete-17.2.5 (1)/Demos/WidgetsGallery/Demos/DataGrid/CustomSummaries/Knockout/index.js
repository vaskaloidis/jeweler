window.onload = function() {
    var viewModel = {
        dataGridOptions: {
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
                    dataField: "OrderDate",
                    width: 160,
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
        },
        buttonOptions: {
            text: "Calculate summary for selected rows", 
            onClick: function() {
                $("#gridContainer").dxDataGrid("instance").refresh();
            }
        }
    };
    
    ko.applyBindings(viewModel, document.getElementById("data-grid-demo"));
};