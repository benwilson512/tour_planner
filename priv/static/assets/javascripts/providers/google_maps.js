tourPlanner.service('googleMaps', function() {
  var allMarkers = {steps: [], foo: []};
  var map;
  return {
    allMarkers: allMarkers,
    initialize: function(elementId, center) {
      var mapOptions = {
        center: center,
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      map = new google.maps.Map(document.getElementById(elementId), mapOptions);
      return map;
    },
    getDirections: function(route) {
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
    setMarkers: function(label, markers) {
      this.clearMarkers(label);
      this.addLocations(label, markers);
    },
    addMarkers: function(label, markers) {
      this.initLabel(label);
      return allMarkers[label] = allMarkers[label].concat(markers);;
    },
    addLocations: function(label, data) {
      var markers = [];
      for(var i = 0; i < data.length; i++) {
        var point = data[i];
        markers.push(new google.maps.Marker({
          position: new google.maps.LatLng(point.lat, point.lon),
          map: map,
          title: point.title,
          data: data,
          index: i
        }));
      }
      return this.addMarkers(label, markers);
    },
    initLabel: function(label) {
      if(!allMarkers[label] || !allMarkers[label].length) {
        allMarkers[label] = []
      }
    },
    clearMarkers: function(label) {
      this.initLabel(label)
      for (var i = 0; i < allMarkers[label].length; i++ ) {
        allMarkers[label][i].setMap(null);
      }
      return allMarkers[label];
    }
  }
});
