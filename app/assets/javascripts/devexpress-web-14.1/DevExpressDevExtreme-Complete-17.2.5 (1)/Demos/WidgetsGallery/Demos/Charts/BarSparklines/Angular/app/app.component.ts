import { NgModule, Component, Inject, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { Http, HttpModule } from '@angular/http';

import { DxSparklineModule, DxSelectBoxModule } from 'devextreme-angular';
import DataSource from 'devextreme/data/data_source';
import CustomStore from 'devextreme/data/custom_store';
import query from 'devextreme/data/query';
import 'rxjs/add/operator/toPromise';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    templateUrl: 'app/app.component.html',
    styleUrls: ['app/app.component.css']
})
export class AppComponent {
    source: any;
    filters: number[] = [12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1];

    constructor(@Inject(Http) http: Http) {
        this.source = new DataSource({
            store: new CustomStore({
                load: () => http.get('../../../../data/resourceData.json')
                    .toPromise()
                    .then(response => response.json())
                    .catch(error => { throw 'Data Loading Error' }),
                loadMode: 'raw'
            }),
            filter: ["month", "<=", "12"],
            paginate: false
        });
    }

    onValueChanged(e) {
        let count = e.value;
        this.source.filter(["month", "<=", count]);
        this.source.load();
    }
}

@NgModule({
    imports: [
        BrowserModule,
        HttpModule,
        DxSparklineModule,
        DxSelectBoxModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);