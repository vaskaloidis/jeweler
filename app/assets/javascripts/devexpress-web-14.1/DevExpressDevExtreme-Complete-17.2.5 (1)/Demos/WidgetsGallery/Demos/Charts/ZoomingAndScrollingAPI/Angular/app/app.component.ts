import { NgModule, Component, ViewChild, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DxChartModule, DxChartComponent, DxRangeSelectorModule } from 'devextreme-angular';

import { Service, ZoomingData } from './app.service';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    providers: [Service],
    templateUrl: 'app/app.component.html'
})
export class AppComponent {
    @ViewChild("zoomedChart") zoomedChart: DxChartComponent;
    zoomingData: ZoomingData[];

    constructor(service: Service) {
        this.zoomingData = service.getZoomingData();
    }

    onValueChanged(e: any) {
        this.zoomedChart.instance.zoomArgument(e.value[0], e.value[1]);
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxChartModule,
        DxRangeSelectorModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);