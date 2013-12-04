tourPlanner.controller('RoutesShowCtrl',
  ['$scope', '$http', '$location', 'embeddedData', 'googleMaps',
  function RoutesShowCtrl($scope, $http, $location, embedded, gMaps) {
    var resourceMarkers = [];

    var route    = embedded.$get('route');
    var steps    = embedded.$get('steps');
    var types    = embedded.$get('types');
    var map      = gMaps.initialize("map-canvas", new google.maps.LatLng(steps[0].start_lat, steps[0].start_lon));
    gMaps.getDirections(map, route);

    $scope.route = route;
    $scope.steps = steps;
    $scope.types = types;
    $scope.map   = map;
    $scope.visibleTypes = {};

    gMaps.addLocations(map, $.map(steps, function(step) {
      return {
        lat: step.start_lat,
        lon: step.start_lon,
        title: step.instructions
      };
    }));

    if($location.search().step) {
      focusStep(parseInt($location.search().step));
    } else {
      focusStep(0);
    }

    function focusStep(index) {
      $location.search({step: index})
      $scope.step_index   = parseInt(index);
      $scope.focused_step = $scope.steps[$scope.step_index];
      $scope.resources    = getResources($scope.focused_step);
    }
    $scope.focusStep = focusStep;

    function updateTypes(type) {
      console.log(type);
      $scope.visibleTypes = angular.copy(type);
    }
    $scope.updateTypes = updateTypes; 

    function getResources(step) {
      resourceMarkers = clearMarkers(resourceMarkers);
      map.setCenter(new google.maps.LatLng(step.start_lat, step.start_lon));
      map.setZoom(12);

      $http.get('/api/v1/steps/'+step.id+'/resources').success(function(resources) {
        $scope.resources = resources;
        resourceMarkers  = gMaps.addLocations(map, resources);
      });
    }
    $scope.getResources = getResources;

    function clearMarkers(markers) {
      for (var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
      }
      return [];
    }

  }
]);
