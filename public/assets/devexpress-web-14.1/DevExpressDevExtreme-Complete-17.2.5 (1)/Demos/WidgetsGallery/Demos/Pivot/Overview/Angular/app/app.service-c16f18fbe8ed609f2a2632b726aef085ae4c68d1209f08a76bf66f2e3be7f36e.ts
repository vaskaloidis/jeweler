import { Injectable } from '@angular/core';

export class Contact {
    name: string;
    phone: string;
    image: string;
    email: string;
    category: string;
}

let contacts: Contact[] = [
    { name: "Barbara J. Coggins", phone: "512-964-2757", image: "../../../../images/employees/04.png", email: "BarbaraJCoggins@rhyta.com", category: "Family" },
    { name: "Leslie S. Alcantara", phone: "360-684-1334", image: "../../../../images/employees/01.png", email: "LeslieSAlcantara@teleworm.us", category: "Friends" },
    { name: "Chad S. Miles", phone: "520-573-7903", image: "../../../../images/employees/02.png", email: "ChadSMiles@rhyta.com", category: "Work" },
    { name: "Michael A. Blevins", phone: "530-480-1961", image: "../../../../images/employees/03.png", email: "MichaelABlevins@armyspy.com", category: "Work" },
    { name: "Jane K. Hernandez", phone: "404-781-0805", image: "../../../../images/employees/05.png", email: "JaneKHernandez@teleworm.us", category: "Friends" },
    { name: "Kim D. Thomas", phone: "603-583-9043", image: "../../../../images/employees/06.png", email: "KimDThomas@teleworm.us", category: "Work" },
    { name: "Donald L. Jordan", phone: "772-766-2842", image: "../../../../images/employees/07.png", email: "DonaldLJordan@dayrep.com", category: "Family" },
    { name: "Nicole A. Rios", phone: "213-812-8400", image: "../../../../images/employees/09.png", email: "NicoleARios@armyspy.com", category: "Friends" },
    { name: "Barbara M. Roberts", phone: "614-365-7945", image: "../../../../images/employees/08.png", email: "BarbaraMRoberts@armyspy.com", category: "Friends" }
];

@Injectable()
export class Service {
    getContacts(): Contact[] {
        return contacts;
    }
}
