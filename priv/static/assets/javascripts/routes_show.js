tourPlanner.controller('RoutesShowCtrl', ['$scope', '$http', 'embeddedData',
  function RoutesShowCtrl($scope, $http, embedded) {
    route = embedded.$get('route');
    console.log(route);
    $http.get('/api/v1/routes/'+route.id+'/steps').success(function(data) {
      console.log(data)
      $scope.steps = data;
    });
  }
]);
