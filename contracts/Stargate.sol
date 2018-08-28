pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

import './StargateInterface.sol';

contract Stargate is StargateInterface, Ownable {
	using SafeMath for uint256;

	mapping(address => uint256) private pledges;
	mapping(address => uint32) private sequenceIDs;
	mapping(address => mapping(uint32 => function(string memory) external)) private requests;

	event Create(address from, uint32 sequenceID, uint16 nodeCnt, uint256 ethamount);
	event Drop(address from, uint32 sequenceID, string databaseID);
	event Query(address from, uint32 sequenceID, string databaseID, string query);
	event Exec(address from, uint32 sequenceID, string databaseID, string query);

	// create sends a signal to CovenantSQL to create a database with dbID as database id
	function create(uint16 nodeCnt, function(string memory) external callback) external payable returns (uint32 seqID) {
		pledges[msg.sender] = pledges[msg.sender].add(msg.value);
		seqID = sequenceIDs[msg.sender];
		sequenceIDs[msg.sender] = seqID + 1;
		mapping(uint32 => function(string memory) external) sequenceId2Callback = requests[msg.sender];
		sequenceId2Callback[seqID] = callback;
		emit Create(msg.sender, seqID, nodeCnt, pledges[msg.sender]);
	}

	// drop sends a signal to CovenantSQL to drop a database whose database id is dbID
	function drop(string dbID, function(string memory) external callback) external returns (uint32 seqID) {
		seqID = sequenceIDs[msg.sender];
		sequenceIDs[msg.sender] = seqID + 1;
		mapping(uint32 => function(string memory) external) sequenceId2Callback = requests[msg.sender];
		sequenceId2Callback[seqID] = callback;
		emit Drop(msg.sender, seqID, dbID);
	}

	// query sends a signal to CovenantSQL to query a query on the database whoes id is
	function query(string dbID, string _query, function(string memory) external callback) external payable returns (uint32 seqID) {
		seqID = sequenceIDs[msg.sender];
		sequenceIDs[msg.sender] = seqID + 1;
		mapping(uint32 => function(string memory) external) sequenceId2Callback = requests[msg.sender];
		sequenceId2Callback[seqID] = callback;
		emit Query(msg.sender, seqID, dbID, _query);
	}

	// exec sends a signal to CovenantSQL to exec a query on the database whoes id is
	function exec(string dbID, string _query, function(string memory) external callback) external payable returns (uint32 seqID) {
		seqID = sequenceIDs[msg.sender];
		sequenceIDs[msg.sender] = seqID + 1;
		mapping(uint32 => function(string memory) external) sequenceId2Callback = requests[msg.sender];
		sequenceId2Callback[seqID] = callback;
		emit Exec(msg.sender, seqID, dbID, _query);
	}

	// reply receives results from CovenantSQL
	function reply(address requester, uint32 sequenceID, string response) external onlyOwner {
		requests[requester][sequenceID](response);
		delete requests[requester][sequenceID];
	}
}
