tourPlanner.filter('resources', function() {
  return function(input, visibleTypes) {
    var types = [];
    for(var type in visibleTypes) {
      if(visibleTypes[type]) {
        types.push(type);
      }
    }
    var keep = [];
    if(input && (types.length > 0)) {
      $.each(input, function(_, resource) {
        var regex = new RegExp(types.join("|"), "i")
        if(resource.types.match(regex)) {
          keep.push(resource);
        }
      });
    }
    return keep;
  }
});