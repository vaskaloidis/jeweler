import { NgModule, Component, enableProdMode } from '@angular/core';
import { DecimalPipe } from '@angular/common';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DxVectorMapModule, DxChartModule } from 'devextreme-angular';

import DxChart from 'devextreme/viz/chart';
import * as mapsData from 'vectormap-data/world.js';
import { GdpInfo, Service } from './app.service';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    providers: [ Service ],
    templateUrl: 'app/app.component.html',
    styleUrls: ['app/app.component.css']
})

export class AppComponent {
    worldMap: any = mapsData.world;
    gdpData: Object;
    toolTipData: Object;
    pipe: any = new DecimalPipe("en-US");

    constructor(private service: Service) {
        this.gdpData = service.getCountriesGDP();
        this.customizeTooltip = this.customizeTooltip.bind(this);
        this.customizeLayers = this.customizeLayers.bind(this);
        this.tooltipShown = this.tooltipShown.bind(this);
    }

    customizeTooltip(arg) {
        let countryGDPData = this.gdpData[arg.attribute("name")];
        let total = countryGDPData && countryGDPData.total;
        let totalMarkupString = total ? "<div id='nominal' >Nominal GDP: $" + total + "M</div>" : "";
        let node = "<div #gdp><h4>" + arg.attribute("name") + "</h4>" +
            totalMarkupString +
            "<div id='gdp-sectors'></div></div>";

        return {
            html: node
        };
    }

    customizeLayers(elements) {
        elements.forEach((element) => {
            let countryGDPData = this.gdpData[element.attribute("name")];
            element.attribute("total", countryGDPData && countryGDPData.total || 0);
        });
    }

    customizeText = (arg) => this.pipe.transform(arg.start, "1.0-0") + " to " + this.pipe.transform(arg.end, "1.0-0");

    tooltipShown(e) {
        let name = e.target.attribute("name"),
            gdpData: GdpInfo[] = this.gdpData[name] ? [{
                name: name,
                agriculture: this.gdpData[name].agriculture,
                industry: this.gdpData[name].industry,
                services: this.gdpData[name].services
            }] : [{ name: name }],
            container = (<any> document).getElementById("gdp-sectors");

        if (gdpData[0].services) {
            new DxChart(container, this.service.getChartConfig(gdpData));
        } else {
            container.textContent = "No economic development data";
        }
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxVectorMapModule,
        DxChartModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);
