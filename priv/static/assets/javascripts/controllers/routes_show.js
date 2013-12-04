tourPlanner.controller('RoutesShowCtrl',
  ['$scope', '$http', '$location', 'embeddedData', 'googleMaps',
  function RoutesShowCtrl($scope, $http, $location, embedded, gMaps) {
    window.scope = $scope;
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

    putStepsOnMap();
    initURL();

    $scope.focusStep = focusStep;
    function focusStep(index) {
      index = parseInt(index);
      $location.search({step: index})
      $scope.stepIndex   = index
      $scope.focusedStep = $scope.steps[index];
      $scope.resources   = getResources($scope.focusedStep);
    }

    $scope.updateTypes = updateTypes; 
    function updateTypes(visibleTypes) {
      $scope.visibleTypes = angular.copy(visibleTypes);
    }

    $scope.getResources = getResources;
    function getResources(step) {
      map.setCenter(new google.maps.LatLng(step.start_lat, step.start_lon));
      map.setZoom(12);

      $http.get('/api/v1/steps/'+step.id+'/resources').success(function(resources) {
        $scope.resources = resources;
      });
    }

    $scope.isStepActive = isStepActive;
    function isStepActive(index) {
      return(index == $scope.stepIndex);
    }

    function clearMarkers(markers) {
      for (var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
      }
      return [];
    }

    function putStepsOnMap() {
      gMaps.addLocations(map, $.map(steps, function(step) {
        return {
          lat: step.start_lat,
          lon: step.start_lon,
          title: step.instructions
        };
      }));
    }

    function initURL() {
      if($location.search().step) {
        focusStep(parseInt($location.search().step));
      } else {
        focusStep(0);
      }
    }

  }
]);
