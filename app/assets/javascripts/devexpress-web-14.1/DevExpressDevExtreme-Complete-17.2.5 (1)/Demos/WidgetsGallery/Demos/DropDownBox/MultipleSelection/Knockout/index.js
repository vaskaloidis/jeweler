window.onload = function() {
    var treeView;
    
    var syncTreeViewSelection = function(treeView, value){
        if (!treeView) return;
        
        if (!value) {
            treeView.unselectAll();
            return;
        }
        
        value.forEach(function(key){
            treeView.selectItem(key);
        });
    };
    
    var makeAsyncDataSource = function(jsonFile){
        return new DevExpress.data.CustomStore({
            loadMode: "raw",
            key: "ID",
            load: function() {
                return $.getJSON("../../../../data/" + jsonFile);
            }
        });
    };
    
    var treeDataSource = makeAsyncDataSource("treeProducts.json"),
        gridDataSource = makeAsyncDataSource("customers.json");
    
    var treeBoxOptions = {
        value: ko.observable(["1_1"]),
        valueExpr: "ID",
        displayExpr: "name",
        placeholder: "Select a value...",
        showClearButton: true,
        dataSource: treeDataSource,
        treeView: {
            dataSource: treeDataSource,
            dataStructure: "plain",
            keyExpr: "ID",
            parentIdExpr: "categoryId",
            selectionMode: "multiple",
            onContentReady: function(e) {
                treeView = e.component;
                syncTreeViewSelection(treeView, treeBoxOptions.value());
            },
            onItemSelectionChanged: function(args){
                treeBoxOptions.value(args.component.getSelectedNodesKeys());
            },
            displayExpr: "name",
            selectByClick: true,
            selectNodesRecursive: false,
            showCheckBoxesMode: "normal"
        }
    };
    
    var gridBoxValue = ko.observable([3]);
    
    var gridBoxOptions = {
        value: gridBoxValue,
        valueExpr: "ID",
        placeholder: "Select a value...",
        displayExpr: "CompanyName",
        showClearButton: true,
        dataSource: gridDataSource,
        dataGrid: {
            dataSource: gridDataSource,
            columns: ["CompanyName", "City", "Phone"],
            hoverStateEnabled: true,
            paging: { enabled: true, pageSize: 10 },
            filterRow: { visible: true },
            scrolling: { mode: "infinite" },
            height: 265,
            selection: { mode: "multiple" },
            selectedRowKeys: ko.computed(function(){
                return gridBoxValue() || [];
            }),
            onSelectionChanged: function(selectedItems){
                gridBoxValue(selectedItems.selectedRowKeys);
            }
        }
    };
    
    ko.computed(function(){
        syncTreeViewSelection(treeView, treeBoxOptions.value());
    });
    
    var viewModel = {
        treeBoxOptions: treeBoxOptions,
        gridBoxOptions: gridBoxOptions
    };
    
    ko.applyBindings(viewModel, document.getElementById("dropdown-box-demo"));
};