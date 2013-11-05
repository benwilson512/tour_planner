tourPlanner.controller('RoutesIndexCtrl', ['$scope', '$http',
  function RoutesIndexCtrl($scope, $http) {
  $http.get('/api/v1/routes').success(function(data) {
    console.log(data)
    $scope.routes = data;
  });
}]);
