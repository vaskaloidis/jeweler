$(function(){
    var treeView = $("#treeview").dxTreeView({ 
        items: products,
        width: 500,
        searchEnabled: true
    }).dxTreeView("instance");

    $("#searchMode").dxSelectBox({
        dataSource: ["contains", "startswith"],
        value: "contains",
        onValueChanged: function(data) {
            treeView.option("searchMode", data.value);
        }
    });
});