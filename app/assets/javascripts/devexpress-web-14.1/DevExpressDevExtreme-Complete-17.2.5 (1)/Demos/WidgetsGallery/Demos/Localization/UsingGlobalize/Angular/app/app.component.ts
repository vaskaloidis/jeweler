import { NgModule, Component, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import {
    DxSelectBoxModule,
    DxDataGridModule } from 'devextreme-angular';
import { Locale, Payment, Service } from './app.service';

import 'devextreme/localization/globalize/number';
import 'devextreme/localization/globalize/date';
import 'devextreme/localization/globalize/currency';
import 'devextreme/localization/globalize/message';

import deMessages from 'npm:devextreme/localization/messages/de.json!json';
import ruMessages from 'npm:devextreme/localization/messages/ru.json!json';

import deCaGregorian from 'npm:cldr-dates-full/main/de/ca-gregorian.json!json';
import deNumbers from 'npm:cldr-numbers-full/main/de/numbers.json!json';
import deCurrencies from 'npm:cldr-numbers-full/main/de/currencies.json!json';
import ruCaGregorian from 'npm:cldr-dates-full/main/ru/ca-gregorian.json!json';
import ruNumbers from 'npm:cldr-numbers-full/main/ru/numbers.json!json';
import ruCurrencies from 'npm:cldr-numbers-full/main/ru/currencies.json!json';
import likelySubtags from 'npm:cldr-core/supplemental/likelySubtags.json!json';
import timeData from 'npm:cldr-core/supplemental/timeData.json!json';
import weekData from 'npm:cldr-core/supplemental/weekData.json!json';
import currencyData from 'npm:cldr-core/supplemental/currencyData.json!json';
import numberingSystems from 'npm:cldr-core/supplemental/numberingSystems.json!json';

import Globalize from 'globalize';


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
        Globalize.locale(this.locale);
    }

    initGlobalize() {
        Globalize.load(
            deCaGregorian,
            deNumbers,
            deCurrencies,

            ruCaGregorian,
            ruNumbers,
            ruCurrencies,

            likelySubtags,
            timeData,
            weekData,
            currencyData,
            numberingSystems
        );
        Globalize.loadMessages(deMessages);
        Globalize.loadMessages(ruMessages);
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