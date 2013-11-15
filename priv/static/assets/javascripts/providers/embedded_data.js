var embeddedData;

embeddedData = function() {
  var _this = this;
  this.parse = function(element) {
    return JSON.parse(element.html());
  };
  return {
    $get: function(name) {
      var element;
      element = $("#embed_data_" + name);
      if (element.get(0)) {
        return _this.parse(element);
      } else {
        throw "No embedded data: " + name;
      }
    }
  };
};

app.factory('embeddedData', embeddedData);
