var Stargate = artifacts.require("./Stargate.sol");

contract('Stargate', function(accounts) {
  it("should be owned by creator", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.owner.call();
    }).then(function(addr) {
      assert.isString(addr, "onwer's address is a string");
      assert.strictEqual(addr.length, 42, "address' length is 42");
      console.log("owner's address is " + addr);
    });
  });

  it("should return an id from createDB", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.createDB.call();
    }).then(function(id) {
      assert.isNotNull(id, "id should be returned");
      console.log("createDB: " + id);
    });
  });

  it("should return an id from deleteDB", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.deleteDB.call([
        39, 22, 174, 133, 128, 173, 82, 236,
        114, 110, 144, 242, 217, 218, 25, 129,
        223, 212, 173, 173, 82, 136, 84, 218,
        27, 224, 201, 189, 8, 219, 167, 71]);
    }).then(function(id) {
      assert.isNotNull(id, "id should be returned");
      console.log("deleteDB: " + id);
    });
  });

  it("should return an id from queryDB", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.queryDB.call("select * from test");
    }).then(function(id) {
      assert.isNotNull(id, "id should be returned");
      console.log("queryDB: " + id);
    });
  });
});
