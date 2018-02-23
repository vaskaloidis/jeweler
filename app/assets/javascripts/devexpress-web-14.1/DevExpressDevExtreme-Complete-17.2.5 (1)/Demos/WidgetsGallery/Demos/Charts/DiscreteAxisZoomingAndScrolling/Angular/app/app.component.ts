import { NgModule, Component, ViewChild, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DxChartModule, DxChartComponent, DxRangeSelectorModule } from 'devextreme-angular';

import { Service, ChemicalComposition, SerieDescription } from './app.service';

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
    chemicalComposition: ChemicalComposition[];
    seriesSource: SerieDescription[];

    constructor(service: Service) {
        this.chemicalComposition = service.getChemicalComposition();
        this.seriesSource = service.getSeries();
    }

    valueChanged(e: any) {
        this.chart.instance.zoomArgument(e.value[0], e.value[1]);
    }

    customizeText(arg: any) {
        return arg.valueText + "%"; 
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