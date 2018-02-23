import { NgModule, Component, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DxPivotGridModule,
         DxPivotGridFieldChooserModule,
         DxRadioGroupModule } from 'devextreme-angular';
import { Service, Layout, Sale } from './app.service';

import PivotGridDataSource from 'devextreme/ui/pivot_grid/data_source';

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
    pivotGridDataSource: any;
    layouts: Layout[];
    layout = 0;

    constructor(service: Service) {
        this.pivotGridDataSource = new PivotGridDataSource({
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
                selector: function(data: Sale) {
                    return data.city + " (" + data.country + ")";
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
            store: service.getSales()
        });

        this.layouts = service.getLayouts();
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxPivotGridModule,
        DxRadioGroupModule,
        DxPivotGridFieldChooserModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);