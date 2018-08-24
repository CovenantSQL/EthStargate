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

  it("should return dbID and seqID from create", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.create.call(5);
    }).then(function(id) {
      seqID = Number(id);
      console.log("first time to call createDB that return seqID: " + seqID);
      assert.equal(seqID, 0, "seqID should be 0")
    });
  });

  it("should return an id from drop", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.drop.call("aaa");
    }).then(function(seqID) {
      assert.equal(seqID, 0, "seqID should be 0")
      console.log("drop: " + seqID);
    });
  });

  it("should return an id from query", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.query.call("aaa", "select * from test");
    }).then(function(seqID) {
      assert.equal(seqID, 0, "seqID should be 0")
      console.log("query: " + seqID);
    });
  });

  it("should return an id from exec", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.exec.call("aaa", "select * from test");
    }).then(function(seqID) {
      assert.equal(seqID, 0, "seqID should be 0")
      console.log("exec: " + seqID);
    });
  });
});
