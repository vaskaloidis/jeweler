 

import { NgModule, Component, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { DxPivotModule, DxListModule, DxTemplateModule } from 'devextreme-angular';
import DataSource from 'devextreme/data/data_source';
import { alert } from 'devextreme/ui/dialog';

import { Contact, Service } from './app.service';

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
    dataSource: any;

    constructor(service: Service) {
        let contacts: Contact[] = service.getContacts();

        this.dataSource = [
            {
                title: 'All',
                listData: new DataSource({
                    store: contacts,
                    sort: 'name'
                })
            }, {
                title: 'Family',
                listData: new DataSource({
                    store: contacts,
                    sort: 'name',
                    filter: ['category', '=', 'Family']
                })
            }, {
                title: 'Friends',
                listData: new DataSource({
                    store: contacts,
                    sort: 'name',
                    filter: ['category', '=', 'Friends']
                })
            }, {
                title: 'Work',
                listData: new DataSource({
                    store: contacts,
                    sort: 'name',
                    filter: ['category', '=', 'Work']
                })
            }
        ];
    }
    itemClick(e) {
        alert('The current section: ' + e.itemData.title, 'Click Handler');
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxPivotModule,
        DxListModule,
        DxTemplateModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);