'use strict';


// Declare app level module which depends on filters, and services
angular.module('demoApp', [
        'ngRoute',
        'demoApp.services',
        'demoApp.controllers',
	    'dx'
    ])
    .config(['$routeProvider', function($routeProvider) {
        $routeProvider
            .when('/home', {
                templateUrl: 'partials/home.html',
                controller: 'HomeCtrl',
                controllerAs: 'home'
            })
            .when('/about', {
                templateUrl: 'partials/about.html',
                controller: 'AboutCtrl',
                controllerAs: 'about'
            })
            .otherwise({ redirectTo: '/home' });
    }]);
