tourPlanner.controller('RoutesShowCtrl',
  ['$scope', 'embeddedData', 'googleMaps', 'urlService', 'resourcesService', '$anchorScroll',
  function RoutesShowCtrl($scope, embedded, gMaps, url, resourcesService, $anchorScroll) {
    window.scope = $scope;

    var route    = embedded.$get('route');
    var steps    = embedded.$get('steps');
    var types    = embedded.$get('types');
    var map      = gMaps.initialize("map-canvas", new google.maps.LatLng(steps[0].start_lat, steps[0].start_lon));

    $scope.route = route;
    $scope.steps = steps;
    $scope.types = types;
    $scope.map   = map;
    $scope.visibleTypes = {};

    gMaps.getDirections(route);
    addSteps(steps);


    $scope.$watch(function() {
      return url.search().types;
    }, function(types) {
      if (types) {
        $scope.visibleTypes = url.typesUrlToForm([].concat(types));
      }
    });

    $scope.$watch(function() {
      return url.search().step;
    }, function(stepIndex) {
      focusStep(stepIndex || 0);
    });

    $scope.$watchCollection('visibleTypes', function(formParams) {
      var params = url.typesFormToUrl(formParams);
      url.addParams(params);
      setupResourceMarkers(
        gMaps.setMarkers("resources", resourcesService.filter($scope.visibleTypes))
      );
    });

    $scope.$watch('resources', function(resources) {
      setupResourceMarkers(
        gMaps.setMarkers("resources", resourcesService.filter($scope.visibleTypes))
      );
    });

    function setupResourceMarkers(markers) {
      var previousWindow;
      $.each(markers, function(_, marker) {
        google.maps.event.addListener(marker, 'click', function(event) {
          url.hash("resource-" + marker.data.id);

          var infoWindow = new google.maps.InfoWindow({
            content: marker.data.name,
            size: new google.maps.Size(50,50)
          });

          if(previousWindow) {
            previousWindow.close();
          }

          infoWindow.open(map, marker);
          previousWindow = infoWindow;

          if (!event.noScroll) {
            $anchorScroll();
          }
          if(!$scope.$$phase) scope.$apply();
        });
      });
    }

    $scope.$watch(function(){
      return url.hash()
    }, function(resourceTag) {
      if(resourceTag.match("resource")) {
        var id = parseInt(resourceTag.replace("resource-", ""));
        focusResource(id);
      }
    });

    $scope.$watch('focusedStep', function(step) {
      resourcesService.get(step, function(resources) {
        $scope.resources = resources;
      });
    });

    $scope.focusStep = focusStep;
    function focusStep(index) {
      index = parseInt(index);
      url.addParams({step: index});
      var focusedStep = $scope.steps[index];
      $scope.stepIndex   = index;
      $scope.focusedStep = focusedStep;
      map.setCenter(new google.maps.LatLng(focusedStep.start_lat, focusedStep.start_lon));
    }

    $scope.focusResource = focusResource;
    function focusResource(resourceID) {
      url.hash("resource-" + resourceID);
      $scope.focusedResourceId = resourceID;
      var markers = gMaps.allMarkers["resources"];

      $.each(markers, function(_, marker) {
        if(resourceID == marker.data.id) {
          google.maps.event.trigger(marker, 'click', {noScroll: true});
        }
      });
    }

    $scope.submit = function() {
      var selected = [];
      $.each($scope.resources, function(_, resource) {
        if(resource.on_device) {
          selected.push(resource);
        }
      });
      resourcesService.writeToGps(selected)
    }

    $scope.priceLevel = function(n) {
      return Array(n + 1).join("$");
    }

    function addSteps(steps) {
      var markers = gMaps.addLocations("steps", $.map(steps, function(step) {
        return {
          lat: step.start_lat,
          lon: step.start_lon,
          title: step.instructions
        };
      }));

      $.each(markers, function(_, marker) {
        google.maps.event.addListener(marker, 'click', function() {
          $scope.focusStep(marker.index);
          if(!$scope.$$phase) scope.$apply();
        });
      });
    }
  }
]);
