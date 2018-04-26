import { NgModule, Component, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DxSchedulerModule, DxTemplateModule } from 'devextreme-angular';
import { Service, Employee } from './app.service';

import DataSource from 'devextreme/data/data_source';

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
    currentDate: Date = new Date(2016, 7, 2, 11, 30);
    resourcesDataSource: Employee[];

    constructor(service: Service) {
        this.dataSource = new DataSource({
            store: service.getData()
        });

        this.resourcesDataSource = service.getEmployees();
    }

    static getCurrentTraining(index, employeeID) {
        var currentTraining,
            result = (index + employeeID) % 3;

        switch (result) {
            case 0:
                currentTraining = 'abs-background';
                break;
            case 1:
                currentTraining = 'step-background';
                break;
            case 2:
                currentTraining = 'fitball-background';
                break;
            default:
                currentTraining = '';
        }

        return currentTraining;
    }

    static isWeekEnd(date) {
        var day = date.getDay();
        return day === 0 || day === 6;
    }

    dataCellTemplate(cellData, index, container) {
        var employeeID = cellData.groups.employeeID,
            dataCellElement = container,
            currentTraining = AppComponent.getCurrentTraining(index, employeeID);

        if(AppComponent.isWeekEnd(cellData.startDate)) {
            dataCellElement.classList.add("employee-weekend-" + employeeID);
        }

        var element = document.createElement("div");
        
        element.classList.add("day-cell", currentTraining, "employee-" + employeeID);
        element.textContent = cellData.text;

        return element;
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxSchedulerModule,
        DxTemplateModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);