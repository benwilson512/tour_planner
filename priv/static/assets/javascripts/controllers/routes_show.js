tourPlanner.controller('RoutesShowCtrl', ['$scope', '$http', '$location', 'embeddedData',
  function RoutesShowCtrl($scope, $http, $location, embedded) {
    window.scope = $scope;
    window.alocation = $location
    var resourceMarkers = [];
    var route    = embedded.$get('route');
    var map      = initializeMaps();
    getDirections(route, map)
    $scope.route = route;
    $scope.map   = map;
    
    $http.get('/api/v1/routes/'+route.id+'/steps?important=true').success(function(steps) {
      $scope.steps = steps;
      addLocationsToMap(map, $.map(steps, function(step) {
        return {
          lat: step.start_lat,
          lon: step.start_lon,
          title: step.instructions
        };
      }));

      if($location.search().step) {
        var step_id = parseInt($location.search().step);
        $.each(steps, function(_, step) {
          if(step.id == step_id) {
            getResources(step);
          }
        });
      }
    });

    function getResources(step) {
      $location.search({step: step.id});
      resourceMarkers = clearMarkers(resourceMarkers);
      map.setCenter(new google.maps.LatLng(step.start_lat, step.start_lon));
      map.setZoom(12);

      $http.get('/api/v1/steps/'+step.id+'/resources').success(function(resources) {
        $scope.resources = resources;
        resourceMarkers = addLocationsToMap(map, resources);
      });
    }
    $scope.getResources = getResources;

    function getDirections(route, map) {
      var serviceOptions = {
        origin:             route.start,
        destination:        route.finish,
        travelMode:         google.maps.TravelMode.BICYCLING,
        waypoints:          [{location: route.waypoints}],
        avoidHighways:      true
      }

      var rendererOptions = {preserveViewport: true}
      var directionsService = new google.maps.DirectionsService();
      var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);

      directionsDisplay.setMap(map);
      directionsService.route(serviceOptions, function(result, status) {
        if (status == google.maps.DirectionsStatus.OK) {
          directionsDisplay.setDirections(result);
        }
      });
    }

    function clearMarkers(markers) {
      for (var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
      }
      return [];
    }

    function addLocationsToMap(map, data) {
      var markers = [];
      $.map(data, function(point) {
        markers.push(new google.maps.Marker({
            position: new google.maps.LatLng(point.lat, point.lon),
            map: map,
            title: point.title
        }));
      });
      return markers;
    }

    function initializeMaps() {
      var mapOptions = {
        center: new google.maps.LatLng(40.7144172, -74.0061193),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      var map = new google.maps.Map(document.getElementById("map-canvas"),
          mapOptions);
      return map;
    }

  }
]);
