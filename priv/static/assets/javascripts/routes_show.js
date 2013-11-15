tourPlanner.controller('RoutesShowCtrl', ['$scope', '$http', 'embeddedData',
  function RoutesShowCtrl($scope, $http, embedded) {
    route = embedded.$get('route');
    $http.get('/api/v1/routes/'+route.id+'/steps').success(function(data) {
      $scope.steps = data;
    });
  }
]);
