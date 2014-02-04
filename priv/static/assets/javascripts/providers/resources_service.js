tourPlanner.service('resourcesService', ['$http', 'resourcesFilter',
  function($http, resourcesFilter) {
    var resources = [];
    function get(step, callback) {
      $http.get('/api/v1/steps/'+step.id+'/resources').success(function(data) {
        resources = data;
        callback(data);
      });
    }
    function filter(types) {
      return resourcesFilter(resources, types);
    }
    function writeToGps(resources) {
      console.log(resources)
      var ids = $.map(resources, function(resource) {
        return resource.id
      });
      $http.post('/api/v1/resources', ids)
    }
    function sync() {
      $http.post('/api/v1/resources/sync')
    }
    return {
      get:    get,
      filter: filter,
      writeToGps: writeToGps,
      sync: sync
    }
  }
]);
