import { NgModule, ViewChild, Component, enableProdMode } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { Appointment, Service, MovieData } from './app.service';
import { DxSchedulerModule,
        DxSchedulerComponent,
        DxTemplateModule,
        DxSwitchModule,
        DxNumberBoxModule } from 'devextreme-angular';
import Query from 'devextreme/data/query';

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
    @ViewChild(DxSchedulerComponent) scheduler: DxSchedulerComponent;

    appointmentsData: Appointment[];
    moviesData: MovieData[];
    currentDate: Date = new Date();
    showCurrentTimeIndicator = true;
    shadeUntilCurrentTime = true;
    intervalValue = 10;

    constructor(service: Service) {
        this.appointmentsData = service.getAppointments();
        this.moviesData = service.getMoviesData();
    }

    onContentReady(e) {
        var currentHour = new Date().getHours() - 1;

        e.component.scrollToTime(currentHour, 30, new Date());
    }

    onAppointmentClick(e) {
        e.cancel = true;
    }

    onAppointmentDblClick(e) {
        e.cancel = true;
    }

    changeIndicatorUpdateInterval(e) {
        this.scheduler.instance.option("indicatorUpdateInterval", e.value * 1000);
    }

    getMovieById(id) {
        return Query(this.moviesData).filter(["id", "=", id]).toArray()[0];
    }
}

@NgModule({
    imports: [
        BrowserModule,
        DxSchedulerModule,
        DxSwitchModule,
        DxNumberBoxModule,
        DxTemplateModule
    ],
    declarations: [AppComponent],
    bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule)
