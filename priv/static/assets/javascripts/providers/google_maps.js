tourPlanner.service('googleMaps', function() {
  return {
    initialize: function(elementId, center) {
      var mapOptions = {
        center: center,
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      var map = new google.maps.Map(document.getElementById(elementId),
          mapOptions);
      return map;
    },
    getDirections: function(map, route) {
      var serviceOptions = {
        origin:        route.start,
        destination:   route.finish,
        travelMode:    google.maps.TravelMode.BICYCLING,
        waypoints:     [{location: route.waypoints}],
        avoidHighways: true
      }

      var rendererOptions   = {preserveViewport: true}
      var directionsService = new google.maps.DirectionsService();
      var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);

      directionsDisplay.setMap(map);
      directionsService.route(serviceOptions, function(result, status) {
        if (status == google.maps.DirectionsStatus.OK) {
          directionsDisplay.setDirections(result);
        }
      });
    },
    addLocations: function(map, data) {
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
  }
});
