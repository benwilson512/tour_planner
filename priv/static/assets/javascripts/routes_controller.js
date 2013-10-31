tourPlanner.controller('RoutesListCtrl', ['$scope', '$http',
  function RoutesListCtrl($scope, $http) {
  $http.get('routes.json').success(function(data) {
    console.log(data)
    $scope.routes = data;
  });
}]);
