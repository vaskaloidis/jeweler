import { Component, NgModule, enableProdMode } from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';
import {platformBrowserDynamic} from '@angular/platform-browser-dynamic';
import {DxButtonModule} from 'devextreme-angular';
import notify from 'devextreme/ui/notify';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    templateUrl: 'app/app.component.html',
    styleUrls: ['app/app.component.css']
})

export class AppComponent {
    okButtonOptions: any;
    applyButtonOptions: any;
    doneButtonOptions: any;
    deleteButtonOptions: any;
    backButtonOptions: any;

    constructor() {
        this.okButtonOptions = {
            text: 'OK',
            type: 'normal',
            onClick: function (e) {
                notify("The OK button was clicked");
            }
        };

        this.applyButtonOptions = {
            text: "Apply",
            type: "success",
            onClick: function (e) {
                notify("The Apply button was clicked");
            }
        };

        this.doneButtonOptions = {
            text: "Done",
            type: "default",
            onClick: function (e) {
                notify("The Done button was clicked");
            }
        };

        this.deleteButtonOptions = {
            text: "Delete",
            type: "danger",
            onClick: function (e) {
                notify("The Delete button was clicked");
            }
        };

        this.backButtonOptions = {
            type: "back",
            onClick: function (e) {
                notify("The Back button was clicked");
            }
        };
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxButtonModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})

export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);