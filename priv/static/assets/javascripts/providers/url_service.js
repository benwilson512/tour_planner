tourPlanner.service('urlService', ['$location', function($location) {
  function typesFormToUrl(hash) {
    var visible = [];
    for (var a in hash) {
      if (hash[a]) {
        visible.push(a)
      }
    }
    return {types: visible};
  }

  function typesUrlToForm(searchResult) {
    var hash = {};
    $.each(searchResult, function(_, type) {
      hash[type] = true;
    });
    return hash;
  }

  function addParams(params) {
    var newParams = $.extend($location.search(), params);
    $location.search(newParams);
  }

  function search(params) {
    if(params) {
      return $location.search(params);
    } else {
      return $location.search();
    }
  }
  return {
    typesFormToUrl: typesFormToUrl,
    typesUrlToForm: typesUrlToForm,
    addParams:      addParams,
    search:         search
  }
}]);
