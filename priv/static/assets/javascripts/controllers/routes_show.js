tourPlanner.controller('RoutesShowCtrl',
  ['$scope', 'embeddedData', 'googleMaps', 'urlService', 'resourcesService',
  function RoutesShowCtrl($scope, embedded, gMaps, url, resourcesService) {
    window.scope = $scope;
    window.gMaps = gMaps;
    var resourceMarkers = [];

    var route    = embedded.$get('route');
    var steps    = embedded.$get('steps');
    var types    = embedded.$get('types');
    var map      = gMaps.initialize("map-canvas", new google.maps.LatLng(steps[0].start_lat, steps[0].start_lon));
    gMaps.getDirections(route);
    gMaps.addLocations("steps", $.map(steps, function(step) {
      return {
        lat: step.start_lat,
        lon: step.start_lon,
        title: step.instructions
      };
    }));

    $scope.route = route;
    $scope.steps = steps;
    $scope.types = types;
    $scope.map   = map;
    $scope.visibleTypes = {};

    // ===========
    $scope.$watch(function() {
      return url.search().types;
    }, function(types) {
      if (types) {
        $scope.visibleTypes = url.typesUrlToForm(types);
      }
    });

    $scope.$watch(function() {
      return url.search().step;
    }, function(stepIndex) {
      if(stepIndex) {
        focusStep(stepIndex);
      } else {
        focusStep(0);
      }
    });
    // ===========

    $scope.focusStep = focusStep;
    function focusStep(index) {
      index = parseInt(index);
      url.addParams({step: index});
      var focusedStep = $scope.steps[index];
      $scope.stepIndex   = index;
      $scope.focusedStep = focusedStep;
      map.setCenter(new google.maps.LatLng(focusedStep.start_lat, focusedStep.start_lon));
    }

    $scope.$watchCollection('visibleTypes', function(formParams) {
      var params = url.typesFormToUrl(formParams);
      url.addParams(params);
      gMaps.setMarkers("resources", resourcesService.filter($scope.visibleTypes));
    });

    $scope.$watch('resources', function(resources) {
      gMaps.setMarkers("resources", resourcesService.filter($scope.visibleTypes));
    });

    $scope.$watch('focusedStep', function(step) {
      resourcesService.get(step, function(resources) {
        $scope.resources = resources;
      });
    });
  }
]);
