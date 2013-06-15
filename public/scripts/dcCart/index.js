(function() {
  var Cart, dcCart;

  dcCart = angular.module("dcCart", []);

  Cart = (function() {
    function Cart() {
      this.items = [];
    }

    Cart.prototype.addItem = function(item) {
      return this.items.push(item);
    };

    Cart.prototype.getItems = function() {
      var groupedItems, groupedItemsArray, item, _i, _len, _ref;

      groupedItems = {};
      groupedItemsArray = [];
      _ref = this.items;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        if (!groupedItems[item.title]) {
          groupedItems[item.title] = item;
          groupedItems[item.title].countInCart = 1;
        } else {
          groupedItems[item.title].countInCart += 1;
        }
      }
      for (item in groupedItems) {
        groupedItemsArray.push(groupedItems[item]);
      }
      console.log(groupedItemsArray);
      return groupedItemsArray;
    };

    Cart.prototype.getTotalPrice = function() {
      var item, price, _i, _len, _ref;

      price = 0;
      _ref = this.items;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        price += item.price;
      }
      return price;
    };

    Cart.prototype.getLength = function() {
      return this.items.length;
    };

    return Cart;

  })();

  dcCart.factory("dcCart", function() {
    return new Cart;
  });

  dcCart.directive("dcCart", function(dcCart) {
    return {
      scope: {},
      link: function(scope, element, attrs) {
        return scope.cart = dcCart;
      }
    };
  });

  dcCart.controller("CartCtrl", function($scope, dcCart) {
    return $scope.cart = dcCart;
  });

}).call(this);
