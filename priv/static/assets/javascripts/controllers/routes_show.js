tourPlanner.controller('RoutesShowCtrl', ['$scope', '$http', 'embeddedData',
  function RoutesShowCtrl($scope, $http, embedded) {
    window.scope = $scope;
    route = embedded.$get('route');
    $scope.route = route;
    var map = initializeMaps();
    $scope.map = map;
    
    $http.get('/api/v1/routes/'+route.id+'/steps?important=true').success(function(steps) {
      $scope.steps = steps;
      addLocationsToMap(map, $.map(steps, function(step) {
        return {
          lat: step.start_lat,
          lon: step.start_lon,
          title: step.instructions
        };
      }));
    });

    function addLocationsToMap(map, data) {
      var markers = $.map(data, function(point) {
        new google.maps.Marker({
            position: new google.maps.LatLng(point.lat, point.lon),
            map: map,
            title: point.title
        })
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
