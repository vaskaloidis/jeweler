window.onload = function() {
    var pivotGridDataSource = new DevExpress.data.PivotGridDataSource({
            fields: [{
                caption: "Region",
                width: 120,
                dataField: "region",
                area: "row",
                headerFilter: {
                    allowSearch: true
                } 
            }, {
                caption: "City",
                dataField: "city",
                width: 150,
                area: "row",
                headerFilter: {
                    allowSearch: true
                },
                selector: function(data) {
                    return  data.city + " (" + data.country + ")";
                }
            }, {
                dataField: "date",
                dataType: "date",
                area: "column"
            }, {
                caption: "Sales",
                dataField: "amount",
                dataType: "number",
                summaryType: "sum",
                format: "currency",
                area: "data"
            }],
            store: sales
        }),
        layout = ko.observable(0);
    
    var viewModel = {
        pivotGridOptions: {
            allowSortingBySummary: true,
            allowSorting: true,
            allowFiltering: true,
            showBorders: true,
            dataSource: pivotGridDataSource,
            fieldChooser: {
                enabled: false
            }
        },
        fieldChooserOptions: {
            dataSource: pivotGridDataSource,
            texts: {
                allFields: "All",
                columnFields: "Columns",
                dataFields: "Data",
                rowFields: "Rows",
                filterFields: "Filter"
            },
            width: 400,
            height: 400,
            layout: layout
        },
        layoutsOptions: {
            items: layouts,
            layout: "vertical",
            valueExpr: "key",
            displayExpr: "name",
            value: layout
        }
    };
    
    ko.applyBindings(viewModel, document.getElementById("pivotgrid"));
};