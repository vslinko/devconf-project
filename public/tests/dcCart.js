(function() {
  describe("module dcCart", function() {
    beforeEach(function() {
      return module("dcCart");
    });
    return describe("service dcCart", function() {
      var dcCart;

      dcCart = null;
      beforeEach(function() {
        return inject(function($injector) {
          return dcCart = $injector.get("dcCart");
        });
      });
      return describe("#getTotalPrice()", function() {
        return it("should return total price", function() {
          dcCart.addItem({
            price: 10
          });
          dcCart.addItem({
            price: 30
          });
          return expect(dcCart.getTotalPrice()).toBe(41);
        });
      });
    });
  });

}).call(this);
