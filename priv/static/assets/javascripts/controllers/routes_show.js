tourPlanner.controller('RoutesShowCtrl',
  ['$scope', '$http', '$location', 'embeddedData', 'googleMaps', 'resourcesFilter',
  function RoutesShowCtrl($scope, $http, $location, embedded, gMaps, resourcesFilter) {
    window.scope = $scope;
    window.alocation = $location;
    window.gMaps = gMaps;
    var resourceMarkers = [];

    var route    = embedded.$get('route');
    var steps    = embedded.$get('steps');
    var types    = embedded.$get('types');
    var map      = gMaps.initialize("map-canvas", new google.maps.LatLng(steps[0].start_lat, steps[0].start_lon));
    gMaps.getDirections(route);

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
      var focusedStep = $scope.steps[index];
      $scope.stepIndex   = index;
      $scope.focusedStep = focusedStep;
      map.setCenter(new google.maps.LatLng(focusedStep.start_lat, focusedStep.start_lon));
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
      updateVisibleResources($scope.resources, $scope.visibleTypes)
    });

    $scope.$watch('resources', function(resources) {
      updateVisibleResources($scope.resources, $scope.visibleTypes)
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

    $scope.$watch('focusedStep', function(step) {
      getResources(step);
    });

    function getResources(step) {
      $http.get('/api/v1/steps/'+step.id+'/resources').success(function(resources) {
        $scope.resources = resources;
      });
    }

    function updateVisibleResources(resources, visibleTypes) {
      var filtered = resourcesFilter(resources, visibleTypes);
      gMaps.setMarkers("resources", filtered);
    }

    function putStepsOnMap() {
      gMaps.addLocations("steps", $.map(steps, function(step) {
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
