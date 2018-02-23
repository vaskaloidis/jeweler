import { NgModule, Component, ViewChild, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DxDataGridComponent,
         DxDataGridModule,
         DxPopupModule,
         DxFilterBuilderModule,
         DxScrollViewModule, 
         DxCheckBoxModule } from 'devextreme-angular';

import DataSource from 'devextreme/data/data_source';
import { Order, Service } from './app.service';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    providers: [ Service ],
    templateUrl: 'app/app.component.html',
    styleUrls: ['app/app.component.css']
})

export class AppComponent {
    @ViewChild(DxDataGridComponent) dataGrid: DxDataGridComponent;
    dataSource: any;   
    columns: Array<any>;
    filterValue: any;
    applyFilterButtonOptions: any;
    cancelButtonOptions: any;
    clearFilterButton: any;
    filterButton: any;
    popupVisible: boolean;
    allowHierarchicalFields: boolean;

    onPopupShowing() {
        this.filterValue = this.dataSource.filter();
    }

    constructor(service: Service) {
        this.dataSource = new DataSource({
            store: service.getOrders(),
            filter: service.getFilter()
        });
        this.filterValue = service.getFilter();
        this.popupVisible = false;
        this.allowHierarchicalFields = false;
        this.columns = [{
            caption: "Invoice Number",
            dataField: "OrderNumber",
            dataType: "number"
        }, {
            dataField: "OrderDate",
            dataType: "date"
        }, {
            dataField: "SaleAmount",
            dataType: "number",
            format: "currency"
        }, {
            dataField: "Employee"
        }, {
            caption: "City",
            dataField: "CustomerInfo.StoreCity"
        }, {
            caption: "State",
            dataField: "CustomerInfo.StoreState"
        }];

        this.applyFilterButtonOptions = {
            text: "OK", 
            onClick: (e: any) => {
                this.dataSource.filter(this.filterValue);
                this.dataSource.load();
                this.filterButton.option("type", this.filterValue ? "success" : "default");
                this.clearFilterButton.option("disabled", !this.filterValue);
                this.popupVisible = false;
            }
        };

        this.cancelButtonOptions = {
            text: "Cancel", 
            onClick: (e: any) => {
                this.popupVisible = false;
            }
        };
    }

    onToolbarPreparing(e: any) {
        e.toolbarOptions.items.push({
            location: "before",
            widget: "dxButton",
            options: {
                text: "Filter Builder",
                type: "success",
                icon: "filter",
                onInitialized: (args: any) => {
                    this.filterButton = args.component;
                },
                onClick: (args: any) => {
                    this.popupVisible = true; 
                }
            }
        }, {
            location: "before",
            widget: "dxButton",
            options: {
                text: "Clear Filter",
                onInitialized: (args: any) => {
                    this.clearFilterButton = args.component;
                },
                onClick: (args: any) => {
                    e.component.clearFilter();
                    args.component.option("disabled", true);
                    this.filterButton.option("type", "default");
                    this.filterValue = null;
                }
            }
        });
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxDataGridModule,
        DxPopupModule,
        DxFilterBuilderModule,
        DxScrollViewModule,
        DxCheckBoxModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);
