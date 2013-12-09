var tourPlanner = angular.module('tourPlanner', []);

tourPlanner.config(['$locationProvider', function($locationProvider) {
  $locationProvider.html5Mode(true);
}]);

window.app = tourPlanner;
