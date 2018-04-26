import { NgModule, Component, ViewChild, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { NgForm } from '@angular/forms';

import { DxTextBoxModule, DxFileUploaderModule, DxButtonModule } from 'devextreme-angular';
import { alert } from 'devextreme/ui/dialog';

if(!/localhost/.test(document.location.host)) {
    enableProdMode();
}

@Component({
    selector: 'demo-app',
    templateUrl: 'app/app.component.html',
    styleUrls: ['app/app.component.css']
})
export class AppComponent {
    @ViewChild('form') form: NgForm;
    
    updateClick(e) {
        alert("Uncomment the line to enable sending a form to the server.", "Click Handler");
        //form.submit();
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxTextBoxModule,
        DxFileUploaderModule,
        DxButtonModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule);