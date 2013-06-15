dcShop = angular.module "dcShop", [
  "dcItems"
  "dcCart"
]

dcShop.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"

dcShop.config ($routeProvider) ->
  $routeProvider.when "/",
    templateUrl: "/views/mainpage.html"
    controller: "MainPageCtrl"

  $routeProvider.when "/cart",
    templateUrl: "/views/cart.html"
    controller: "CartCtrl"

  $routeProvider.otherwise
    redirectTo: "/"

dcShop.controller "MainPageCtrl", ($scope, Items) ->
  $scope.items = Items.query()

  $scope.sortAlgo = (item) ->
    Math.random()

dcShop.filter "plural", ->
  (n, variants) ->
    `var plural = n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2`
    variants[plural]

dcShop.filter "rub", ($filter) ->
  (length) ->
    $filter("plural")(length, ["рубль", "рубля", "рублей"])

dcShop.filter "range", ->
  (items, config) ->
    [field, min, max] = config

    if not min or not max
      return items

    filteredItems = []

    for item in items
      if item[field] > Number(min) and item[field] < Number(max)
        filteredItems.push item

    filteredItems
