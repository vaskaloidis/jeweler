import { NgModule, Component, Inject, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { Http, HttpModule } from '@angular/http';

import { DxDataGridModule } from 'devextreme-angular';
import CustomStore from 'devextreme/data/custom_store';
import 'rxjs/add/operator/toPromise';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    templateUrl: 'app/app.component.html'
})
export class AppComponent {
    dataSource: any = {};

    constructor(@Inject(Http) http: Http) {
        this.dataSource.store = new CustomStore({
            load: function (loadOptions: any) {
                var params = '?';

                params += 'skip=' + loadOptions.skip || 0;
                params += '&take=' + loadOptions.take || 12;

                if(loadOptions.sort) {
                    params += '&orderby=' + loadOptions.sort[0].selector;
                    if(loadOptions.sort[0].desc) {
                        params += ' desc';
                    }
                }
                return http.get('https://js.devexpress.com/Demos/WidgetsGallery/data/orderItems' + params)
                    .toPromise()
                    .then(response => {
                        var json = response.json();

                        return {
                            data: json.items,
                            totalCount: json.totalCount
                        }
                    })
                    .catch(error => { throw 'Data Loading Error' });
            }
        });
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxDataGridModule,
        HttpModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);