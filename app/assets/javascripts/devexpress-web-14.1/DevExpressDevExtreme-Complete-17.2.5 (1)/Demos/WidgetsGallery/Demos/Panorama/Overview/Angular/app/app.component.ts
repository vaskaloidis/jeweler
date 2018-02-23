import { NgModule, Component, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { DxPanoramaModule, DxTemplateModule } from 'devextreme-angular';
import { alert } from 'devextreme/ui/dialog';

import { PanoramaData, Service } from './app.service';

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
    panoramaData: PanoramaData[];

    constructor(service: Service) { 
        this.panoramaData = service.getPanoramaData();
    }
    itemClick(e) {
        alert('The "' + e.itemData.header +  '" item is selected.', 'Click Handler');
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxPanoramaModule,
        DxTemplateModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);