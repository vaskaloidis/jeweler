import { NgModule, Component, Inject, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { Http, HttpModule } from '@angular/http';
import 'rxjs/add/operator/toPromise';

import { DxTreeListModule } from 'devextreme-angular';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    templateUrl: 'app/app.component.html',
    styleUrls: ['app/app.component.css'],
})
export class AppComponent {
    dataSource: any;

    constructor(@Inject(Http) http: Http) {
        this.dataSource = {
            load: function(loadOptions) {
                return http.get("https://js.devexpress.com/Demos/Mvc/api/treeListData?parentIds=" + loadOptions.parentIds.join(","))
                           .toPromise()
                           .then(response => {
                               return response.json();
                           });
            }
        }
    }

    customizeSizeText(e) {
        if(e.value !== null) {
            return Math.ceil(e.value / 1024) + " KB";
        }
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxTreeListModule,
        HttpModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);