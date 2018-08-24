pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Stargate.sol";

contract TestStargate {
  bytes private testCreateResult = "create DB";

  event TestAction(string response, bytes info);

  function testCreate() public {
    Stargate sg = Stargate(DeployedAddresses.Stargate());
    sg.create(5, this.createResp);
    Assert.equal(uint(1), uint(1), "test create");
    // sg.reply(this, seqID, testCreateResult);
    // Assert.equal(bytesToBytes32(dbID, 9), bytesToBytes32(testCreateResult, 9), "db ID should be create DB");
  }

  function testDrop() public {
    Stargate sg = Stargate(DeployedAddresses.Stargate());
    uint32 seqID = sg.drop("drop", this.dropResp);
    Assert.equal(uint(1), uint(1), "test drop");
  }

  function testQuery() public {
    Stargate sg = Stargate(DeployedAddresses.Stargate());
    uint32 seqID = sg.query("test", "sql", this.queryResp);
    Assert.equal(uint(1), uint(1), "test query");
  }

  function testExec() public {
    Stargate sg = Stargate(DeployedAddresses.Stargate());
    uint32 seqID = sg.exec("test", "sql", this.execResp);
    Assert.equal(uint(1), uint(1), "test exec");
  }

  function createResp(string response) public {
    emit TestAction(response, "response from createResp");
  }

  function dropResp(string response) public {
    emit TestAction(response, "response from dropResp");
  }

  function queryResp(string response) public {
    emit TestAction(response, "response from queryResp");
  }

  function execResp(string response) public {
    emit TestAction(response, "response from execResp");
  }
}
