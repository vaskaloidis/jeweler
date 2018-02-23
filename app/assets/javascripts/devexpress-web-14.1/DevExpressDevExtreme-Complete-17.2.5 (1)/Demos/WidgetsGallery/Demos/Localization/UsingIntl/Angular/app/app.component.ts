import { NgModule, Component, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import {
    DxSelectBoxModule,
    DxDataGridModule } from 'devextreme-angular';
import { Locale, Payment, Service } from './app.service';

import { locale, loadMessages } from 'devextreme/localization';
import 'devextreme-intl';

import deMessages from 'npm:devextreme/localization/messages/de.json!json';
import ruMessages from 'npm:devextreme/localization/messages/ru.json!json';

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
    locale: string;
    locales: Locale[];
    payments: Payment[];

    constructor(service: Service) {
        this.locale = this.getLocale();
        this.payments = service.getPayments();
        this.locales = service.getLocales();

        this.initGlobalize();
        locale(this.locale);
    }

    initGlobalize() {
        loadMessages(deMessages);
        loadMessages(ruMessages);
    }

    changeLocale(data) {
        this.setLocale(data.value);
        parent.document.location.reload();
    }

    getLocale() {
        var locale = sessionStorage.getItem("locale");
        return locale != null ? locale : "en";
    }

    setLocale(locale) {
        sessionStorage.setItem("locale", locale);
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxSelectBoxModule,
        DxDataGridModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);