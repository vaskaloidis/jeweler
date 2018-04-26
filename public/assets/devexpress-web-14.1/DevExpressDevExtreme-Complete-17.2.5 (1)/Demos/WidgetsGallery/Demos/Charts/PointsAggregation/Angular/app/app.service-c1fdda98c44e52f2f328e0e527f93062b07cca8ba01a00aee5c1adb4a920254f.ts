import { Injectable } from '@angular/core';

export class Coordinate  {
    arg: number;
    val: number;
}

let coordinates: Coordinate[] = []; 

@Injectable()
export class Service {
    getCoordinates(): Coordinate[] {
        var max = 5000,
            i;
        for (i = 0; i < max; i++) {
            coordinates.push({ arg: i, val: i + i * (Math.random() - 0.5) });
        }
        return coordinates;
    }
}