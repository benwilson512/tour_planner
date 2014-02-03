tourPlanner.service('googleMaps', function() {
  var allMarkers = {steps: [], foo: []};
  var map;

  function initialize(elementId, center) {
    var mapOptions = {
      center: center,
      zoom: 12,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById(elementId), mapOptions);
    return map;
  }

  function getDirections(route) {
    var serviceOptions = {
      origin:        route.start,
      destination:   route.finish,
      travelMode:    google.maps.TravelMode.BICYCLING,
      waypoints:     [{location: route.waypoints}],
      avoidHighways: true
    }

    var rendererOptions = {
      preserveViewport: true,
      draggable: true
    }
    var directionsService = new google.maps.DirectionsService();
    var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);

    directionsDisplay.setMap(map);
    directionsService.route(serviceOptions, function(result, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(result);
      }
    });
  }

  function setMarkers(label, markers) {
    clearMarkers(label);
    return addLocations(label, markers);
  }

  function addMarkers(label, markers) {
    initLabel(label);
    return allMarkers[label] = allMarkers[label].concat(markers);;
  }

  function addLocations(label, data) {
    var markers = [];
    for(var i = 0; i < data.length; i++) {
      var point = data[i];
      markers.push(new google.maps.Marker({
        position: new google.maps.LatLng(point.lat, point.lon),
        map: map,
        title: point.title,
        data: point,
        index: i
      }));
    }
    return addMarkers(label, markers);
  }

  function initLabel(label) {
    if(!allMarkers[label] || !allMarkers[label].length) {
      allMarkers[label] = []
    }
  }

  function clearMarkers(label) {
    initLabel(label)
    for (var i = 0; i < allMarkers[label].length; i++ ) {
      allMarkers[label][i].setMap(null);
    }
    return allMarkers[label];
  }

  return {
    allMarkers: allMarkers,
    initialize: initialize,
    getDirections: getDirections,
    setMarkers: setMarkers,
    addMarkers: addMarkers,
    addLocations: addLocations,
    initLabel: initLabel,
    clearMarkers: clearMarkers
  }
});
