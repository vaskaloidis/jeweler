import { NgModule, Component, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DxDataGridModule, DxTemplateModule } from 'devextreme-angular';
import { Employee, Service } from './app.service';

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
    employees: Employee[];

    constructor(private service: Service) {
        this.employees = service.getEmployees()
    }

    completedValue(rowData) {
        return rowData.Status == "Completed";
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxDataGridModule,
        DxTemplateModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);