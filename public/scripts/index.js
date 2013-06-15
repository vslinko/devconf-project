(function() {
  var dcShop;

  dcShop = angular.module("dcShop", ["dcItems", "dcCart"]);

  dcShop.config(function($locationProvider) {
    return $locationProvider.hashPrefix("!");
  });

  dcShop.config(function($routeProvider) {
    $routeProvider.when("/", {
      templateUrl: "/views/mainpage.html",
      controller: "MainPageCtrl"
    });
    $routeProvider.when("/cart", {
      templateUrl: "/views/cart.html",
      controller: "CartCtrl"
    });
    return $routeProvider.otherwise({
      redirectTo: "/"
    });
  });

  dcShop.controller("MainPageCtrl", function($scope, Items) {
    $scope.items = Items.query();
    return $scope.sortAlgo = function(item) {
      return Math.random();
    };
  });

  dcShop.filter("plural", function() {
    return function(n, variants) {
      var plural = n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2;      return variants[plural];
    };
  });

  dcShop.filter("rub", function($filter) {
    return function(length) {
      return $filter("plural")(length, ["рубль", "рубля", "рублей"]);
    };
  });

  dcShop.filter("range", function() {
    return function(items, config) {
      var field, filteredItems, item, max, min, _i, _len;

      field = config[0], min = config[1], max = config[2];
      if (!min || !max) {
        return items;
      }
      filteredItems = [];
      for (_i = 0, _len = items.length; _i < _len; _i++) {
        item = items[_i];
        if (item[field] > Number(min) && item[field] < Number(max)) {
          filteredItems.push(item);
        }
      }
      return filteredItems;
    };
  });

}).call(this);
