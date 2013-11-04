tourPlanner.controller('RoutesShowCtrl', ['$scope', '$http',
  function RoutesIndexCtrl($scope, $http) {
  $http.get('routes.json').success(function(data) {
    console.log(data)
    $scope.routes = data;
  });
}]);
