dcItems = angular.module "dcItems", [
  "ngResource"
  "dcCart"
]

dcItems.factory "Items", ($resource) ->
  $resource("/items.json")

dcItems.directive "dcItem", (dcCart) ->
  scope: {
    item: "="
  }
  restrict: "E"
  templateUrl: "/views/item.html"
  replace: true
  link: (scope, element, attrs) ->
    scope.showCart = attrs.hasOwnProperty "showCountInCart"

    scope.addToCart = ->
      dcCart.addItem scope.item
