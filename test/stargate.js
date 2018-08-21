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

  it("should return dbID and seqID from createDB", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.createDB.call(5);
    }).then(function(ids) {
      dbID = ids[0];
      seqID = Number(ids[1]);
      console.log("first time to call createDB that return dbID: " + dbID + ", seqID: " + seqID);
      assert.isNotNull(dbID, "dbID should be returned");
      assert.equal(seqID, 0, "seqID should be 0")
    });
  });

  it("should return an id from deleteDB", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.deleteDB.call([
        39, 22, 174, 133, 128, 173, 82, 236,
        114, 110, 144, 242, 217, 218, 25, 129,
        223, 212, 173, 173, 82, 136, 84, 218,
        27, 224, 201, 189, 8, 219, 167, 71]);
    }).then(function(seqID) {
      assert.equal(seqID, 0, "seqID should be 0")
      console.log("deleteDB: " + seqID);
    });
  });

  it("should return an id from queryDB", function() {
    return Stargate.deployed().then(function(instance) {
      return instance.queryDB.call([
        39, 22, 174, 133, 128, 173, 82, 236,
        114, 110, 144, 242, 217, 218, 25, 129,
        223, 212, 173, 173, 82, 136, 84, 218,
        27, 224, 201, 189, 8, 219, 167, 71],
        "select * from test");
    }).then(function(seqID) {
      assert.equal(seqID, 0, "seqID should be 0")
      console.log("queryDB: " + seqID);
    });
  });
});
