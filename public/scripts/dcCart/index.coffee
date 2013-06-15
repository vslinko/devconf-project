dcCart = angular.module "dcCart", []

class Cart
  constructor: ->
    @items = []

  addItem: (item) ->
    @items.push item

  getItems: ->
    groupedItems = {}
    groupedItemsArray = []

    for item in @items
      if not groupedItems[item.title]
        groupedItems[item.title] = item
        groupedItems[item.title].countInCart = 1
      else
        groupedItems[item.title].countInCart += 1

    for item of groupedItems
      groupedItemsArray.push groupedItems[item]

    console.log groupedItemsArray
    groupedItemsArray

  getTotalPrice: ->
    price = 0

    for item in @items
      price += item.price

    price

  getLength: ->
    @items.length

dcCart.factory "dcCart", ->
  new Cart

dcCart.directive "dcCart", (dcCart) ->
  scope: {}
  link: (scope, element, attrs) ->
    scope.cart = dcCart

dcCart.controller "CartCtrl", ($scope, dcCart) ->
  $scope.cart = dcCart
