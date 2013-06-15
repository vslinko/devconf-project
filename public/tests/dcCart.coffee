describe "module dcCart", ->
  beforeEach ->
    module "dcCart"

  describe "service dcCart", ->
    dcCart = null

    beforeEach ->
      inject ($injector) ->
        dcCart = $injector.get("dcCart")

    describe "#getTotalPrice()", ->
      it "should return total price", ->
        dcCart.addItem price: 10
        dcCart.addItem price: 30

        expect(dcCart.getTotalPrice()).toBe 41
