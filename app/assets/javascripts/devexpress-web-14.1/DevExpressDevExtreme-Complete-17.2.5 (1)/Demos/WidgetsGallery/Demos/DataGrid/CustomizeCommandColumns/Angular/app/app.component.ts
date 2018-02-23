import { NgModule, Component, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DxDataGridModule } from 'devextreme-angular';
import { Service, Employee, State } from './app.service';

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
    states: State[];

    constructor(service: Service) {
        this.employees = service.getEmployees();
        this.states = service.getStates();
    }

    onContentReady(e) {
         e.component.columnOption("command:edit", {
            visibleIndex: -1,
            width: 80
        });
    }

    onCellPrepared(e) {
        if (e.rowType === "data" && e.column.command === "edit") {
            var isEditing = e.row.isEditing,
                cellElement = e.cellElement;

            if (isEditing) {
                let saveLink = cellElement.querySelector(".dx-link-save"),
                    cancelLink = cellElement.querySelector(".dx-link-cancel");

                saveLink.classList.add("dx-icon-save");
                cancelLink.classList.add("dx-icon-revert");

                saveLink.textContent = "";
                cancelLink.textContent = "";
            } else {
                let editLink = cellElement.querySelector(".dx-link-edit"),
                    deleteLink = cellElement.querySelector(".dx-link-delete");

                editLink.classList.add("dx-icon-edit");
                deleteLink.classList.add("dx-icon-trash");

                editLink.textContent = "";
                deleteLink.textContent = "";
            }
        }
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxDataGridModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);