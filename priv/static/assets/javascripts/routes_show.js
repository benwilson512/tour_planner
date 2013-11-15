tourPlanner.controller('RoutesShowCtrl', ['$scope', '$http', 'embeddedData',
  function RoutesShowCtrl($scope, $http, embedded) {
    window.scope = $scope;
    route = embedded.$get('route');
    $scope.route = route
    $http.get('/api/v1/routes/'+route.id+'/steps?important=true').success(function(steps) {
      $scope.steps = steps;
      var map = initializeMaps(steps[0].start_lat, steps[0].start_lon);
      $scope.map = map;
      var markers = [];

      for(var i = 0; i < steps.length; i++) {
        var step = steps[i];
        markers.push(new google.maps.Marker({
            position: new google.maps.LatLng(step.start_lat, step.start_lon),
            map: map,
            title: step.instructions
        }));
      }
    });

    function initializeMaps(lat, lon) {
      var mapOptions = {
        center: new google.maps.LatLng(lat, lon),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      var map = new google.maps.Map(document.getElementById("map-canvas"),
          mapOptions);
      return map;
    }
  }
]);
