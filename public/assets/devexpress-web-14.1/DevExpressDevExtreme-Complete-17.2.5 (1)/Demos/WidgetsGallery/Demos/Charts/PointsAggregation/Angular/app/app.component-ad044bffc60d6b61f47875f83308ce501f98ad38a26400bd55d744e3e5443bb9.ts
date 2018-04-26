import { NgModule, Component, ViewChild, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DxChartModule, DxChartComponent, DxRangeSelectorModule } from 'devextreme-angular';

import { Service, Coordinate } from './app.service';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    providers: [Service],
    templateUrl: 'app/app.component.html',
    styleUrls: ['app/app.component.css']
})
export class AppComponent {
    @ViewChild(DxChartComponent) chart: DxChartComponent;
    coordinates: Coordinate[];

    constructor(service: Service) {
        this.coordinates = service.getCoordinates();
    }

    valueChanged(arg: any) {
        this.chart.instance.zoomArgument(arg.value[0], arg.value[1]);
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