import { NgModule, Component, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { DxSelectBoxModule } from 'devextreme-angular';

import { Product, Service } from './app.service';

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
    products: Product[];
    simpleProducts: string[];

    constructor(service: Service) { 
        this.products = service.getProducts();
        this.simpleProducts = service.getSimpleProducts();
    }

    addCustomItem(data) {
        var newItem = data.text;
        this.simpleProducts.push(newItem)
        return newItem;
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxSelectBoxModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);