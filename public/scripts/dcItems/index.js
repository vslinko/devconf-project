(function() {
  var dcItems;

  dcItems = angular.module("dcItems", ["ngResource", "dcCart"]);

  dcItems.factory("Items", function($resource) {
    return $resource("/items.json");
  });

  dcItems.directive("dcItem", function(dcCart) {
    return {
      scope: {
        item: "="
      },
      restrict: "E",
      templateUrl: "/views/item.html",
      replace: true,
      link: function(scope, element, attrs) {
        scope.showCart = attrs.hasOwnProperty("showCountInCart");
        return scope.addToCart = function() {
          return dcCart.addItem(scope.item);
        };
      }
    };
  });

}).call(this);
