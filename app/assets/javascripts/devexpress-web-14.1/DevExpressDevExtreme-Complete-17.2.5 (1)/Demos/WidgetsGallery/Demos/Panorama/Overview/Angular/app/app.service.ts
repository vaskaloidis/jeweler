import { Injectable } from '@angular/core';

export class Image {
    src: string;
    text: string;
}

export class Images {
    albums: Image[];
    allPictures: Image[];
    favorites: Image[];
}

export class PanoramaData {
    header: string;
    text: string;
    images: Image[];
}

let images: Images = {
    albums: [
        { src: "../../../../images/cities/03.jpg", text: "Architecture" },
        { src: "../../../../images/cities/04.jpg", text: "Sea" }
    ],
    allPictures: [
        { src: "../../../../images/cities/01.jpg", text: "" },
        { src: "../../../../images/cities/02.jpg", text: "" },
        { src: "../../../../images/cities/05.jpg", text: "" },
        { src: "../../../../images/cities/04.jpg", text: "" },
        { src: "../../../../images/cities/03.jpg", text: "" },
        { src: "../../../../images/cities/08.jpg", text: "" },
        { src: "../../../../images/cities/09.jpg", text: "" }
    ],
    favorites: [
        { src: "../../../../images/cities/08.jpg", text: "" },
        { src: "../../../../images/cities/09.jpg", text: "" },
        { src: "../../../../images/cities/05.jpg", text: "" }
    ]
};

let panoramaData: PanoramaData[] = [
    {
        header: "Albums",
        text: "Albums",
        images: images.albums
    },
    {
        header: "All Pictures",
        text: "All Pictures",
        images: images.allPictures
    },
    {
        header: "Favorites",
        text: "Favorites",
        images: images.favorites
    }
];

@Injectable()
export class Service {
    getPanoramaData(): PanoramaData[] {
        return panoramaData;
    }
}
