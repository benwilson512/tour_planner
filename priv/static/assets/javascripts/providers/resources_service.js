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
    return {
      get:    get,
      filter: filter
    }
  }
]);
