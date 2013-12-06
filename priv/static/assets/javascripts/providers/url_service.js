tourPlanner.service('urlService', ['$location', function($location) {
  function typesFormToUrl(formHash) {
    var visible = [];
    for (var a in formHash) {
      if (formHash[a]) {
        visible.push(a)
      }
    }
    return {types: visible};
  }

  function typesUrlToForm(searchResult) {
    var formHash = {};
    $.each(searchResult, function(_, type) {
      formHash[type] = true;
    });
    return formHash;
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

  function hash(params) {
    if(params) {
      return $location.hash(params);
    } else {
      return $location.hash();
    }
  }
  return {
    typesFormToUrl: typesFormToUrl,
    typesUrlToForm: typesUrlToForm,
    addParams:      addParams,
    search:         search,
    hash:           hash
  }
}]);
