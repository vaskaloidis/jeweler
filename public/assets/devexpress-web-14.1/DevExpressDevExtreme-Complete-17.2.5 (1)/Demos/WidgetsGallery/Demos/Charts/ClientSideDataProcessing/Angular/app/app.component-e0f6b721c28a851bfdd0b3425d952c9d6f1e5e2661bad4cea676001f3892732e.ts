import { NgModule, Component, ViewChild, Inject, AfterViewInit, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { Http, HttpModule } from '@angular/http';

import { DxChartModule, DxChartComponent, DxSelectBoxModule } from 'devextreme-angular';
import DataSource from 'devextreme/data/data_source';
import CustomStore from 'devextreme/data/custom_store';
import query from 'devextreme/data/query';
import 'rxjs/add/operator/toPromise';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    templateUrl: 'app/app.component.html',
    styleUrls: ['app/app.component.css']
})
export class AppComponent implements AfterViewInit {
    @ViewChild(DxChartComponent) chart: DxChartComponent

    temperature: number[] = [6, 7, 8, 9, 10, 11, 12];
    palette: string[] = ['#c3a2cc', '#b7b5e0', '#e48cba'];
    paletteIndex = 0;
    monthWeather: any = {};

    constructor(@Inject(Http) private http: Http) {}

    ngAfterViewInit() {
        this.monthWeather = new DataSource({
            store: new CustomStore({
                load: () => {
                    this.chart.instance.showLoadingIndicator();

                    return this.http.get('../../../../data/monthWeather.json')
                        .toPromise()
                        .then(response => response.json())
                        .catch(error => { throw 'Data Loading Error' });
                },
                loadMode: 'raw'
            }),
            filter: ['t', '>', '6'],
            paginate: false
        });
    }

    customizePoint = () => {
        let color = this.palette[this.paletteIndex];
        this.paletteIndex = this.paletteIndex === 2 ? 0 : this.paletteIndex + 1;

        return {
            color: color
        };
    }
    customizeText(arg) {
        return arg.valueText + '&#176C'
    }
    onValueChanged(data) {
        let t = data.value;
        this.monthWeather.filter(['t', '>', t]);
        this.monthWeather.load();
    }
}

@NgModule({
    imports: [
        BrowserModule,
        HttpModule,
        DxChartModule,
        DxSelectBoxModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);