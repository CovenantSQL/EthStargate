pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

contract Stargate is Ownable {
	using SafeMath for uint256;

	mapping (address => uint256) private pledges;
	mapping (address => uint32) private sequenceIDs;

	event Create(address indexed from, uint32 indexed sequenceID, bytes32 indexed databaseID, uint32 nodeCnt, uint256 ethamount);
	event Delete(address indexed from, uint32 indexed sequenceID, bytes32 indexed databaseID);
	event Query(address indexed from, uint32 indexed sequenceID, bytes32 indexed databaseID, bytes query);

	// createDB sends a signal to CovenantSQL to create a database with dbID as database id
	function createDB(uint32 nodeCnt) external payable returns (bytes32 dbID, uint32 seqID) {
		seqID = sequenceIDs[msg.sender];
		sequenceIDs[msg.sender] = seqID + 1;
		dbID = keccak256(this, msg.sender, seqID, nodeCnt);
		pledges[msg.sender] = pledges[msg.sender].add(msg.value);
		emit Create(msg.sender, seqID, dbID, nodeCnt, pledges[msg.sender]);
	}

	// deleteDB sends a signal to CovenantSQL to delete a database whose database id is dbID
	function deleteDB(bytes32 dbID) external returns (uint32 seqID) {
		seqID = sequenceIDs[msg.sender];
		sequenceIDs[msg.sender] = seqID + 1;
		emit Delete(msg.sender, seqID, dbID);
	}

	// queryDB sends a signal to CovenantSQL to query on the database whoes id is
	function queryDB(bytes32 dbID, bytes query) external payable returns (uint32 seqID) {
		seqID = sequenceIDs[msg.sender];
		sequenceIDs[msg.sender] = seqID + 1;
		emit Query(msg.sender, seqID, dbID, query);
	}
}
