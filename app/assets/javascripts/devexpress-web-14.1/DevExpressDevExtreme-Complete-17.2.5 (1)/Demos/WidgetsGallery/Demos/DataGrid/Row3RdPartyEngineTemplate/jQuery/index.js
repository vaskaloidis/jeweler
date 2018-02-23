$(function(){
    DevExpress.ui.setTemplateEngine("underscore");
    
    $("#gridContainer").dxDataGrid({
        dataSource: employees,
        rowTemplate: $("#gridRow"),
        columnWidth: "auto",
        columns: [{
                dataField: "Photo",
                width: 100,
                allowFiltering: false,
                allowSorting: false
            }, {
                dataField: "Prefix",
                caption: "Title",
                width: 70
            },
            "FirstName",
            "LastName", 
            "Position", {
                dataField: "BirthDate",
                dataType: "date"
            }, {
                dataField: "HireDate",
                dataType: "date"
            }
        ]
    });
    
});