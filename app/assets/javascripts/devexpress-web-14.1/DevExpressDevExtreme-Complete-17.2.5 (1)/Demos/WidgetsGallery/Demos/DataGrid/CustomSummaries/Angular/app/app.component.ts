import { NgModule, Component, ViewChild, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DxDataGridModule,
         DxDataGridComponent,
         DxButtonModule } from 'devextreme-angular';
import { Order, Service } from './app.service';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    templateUrl: 'app/app.component.html',
    styleUrls: ['app/app.component.css'],
    providers: [Service]
})
export class AppComponent {
    @ViewChild(DxDataGridComponent) dataGrid: DxDataGridComponent;

    orders: Order[];

    constructor(private service: Service) {
        this.orders = service.getOrders()
    }

    calculateSelectedRow(options) {
        if (options.name === "SelectedRowsSummary") {
            if (options.summaryProcess === "start") {
                options.totalValue = 0;
            } else if (options.summaryProcess === "calculate") {
                if (options.component.isRowSelected(options.value.ID)) {
                    options.totalValue = options.totalValue + options.value.SaleAmount;
                }
            }
        }
    }
    calculateSummary() {
        this.dataGrid.instance.refresh();
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxDataGridModule,
        DxButtonModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);