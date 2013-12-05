tourPlanner.controller('RoutesShowCtrl',
  ['$scope', '$http', '$location', 'embeddedData', 'googleMaps',
  function RoutesShowCtrl($scope, $http, $location, embedded, gMaps) {
    window.scope = $scope;
    window.alocation = $location;
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

    $scope.focusStep = focusStep;
    function focusStep(index) {
      index = parseInt(index);
      addParams({step: index});
      $scope.stepIndex   = index
      $scope.focusedStep = $scope.steps[index];
      $scope.resources   = getResources($scope.focusedStep);
    }

    $scope.$watch(function() {
      return $location.search().types;
    }, function(types) {
      if (types) {
        typesUrlToForm(types);
      }
    });

    $scope.$watchCollection('visibleTypes', function(formParams) {
      typesFormToUrl(formParams);
    });

    $scope.$watch(function() {
      return $location.search().step;
    }, function(stepIndex) {
      if(stepIndex) {
        focusStep(stepIndex);
      } else {
        focusStep(0);
      }
    });

    function typesFormToUrl(hash) {
      var visible = [];
      for (var a in hash) {
        if (hash[a]) {
          visible.push(a)
        }
      }
      addParams({types: visible});
    }

    function typesUrlToForm(searchResult) {
      var hash = {};
      $.each(searchResult, function(_, type) {
        hash[type] = true;
      });
      $scope.visibleTypes = hash;
    }

    $scope.getResources = getResources;
    function getResources(step) {
      map.setCenter(new google.maps.LatLng(step.start_lat, step.start_lon));
      map.setZoom(12);

      $http.get('/api/v1/steps/'+step.id+'/resources').success(function(resources) {
        $scope.resources = resources;
      });
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

    function addParams(params) {
      var newParams = $.extend($location.search(), params);
      $location.search(newParams);
    }

  }
]);
