pragma solidity ^0.4.24;

import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';
import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

contract Stargate is Ownable {
	using SafeMath for uint256;

	mapping (address => uint256) private pledges;

	event Create(address from, bytes32 id, uint timestamp, uint256 ethamount);
	event Delete(address from, bytes32 id, uint timestamp, bytes32 databaseID);
	event Query(address from, bytes32 id, uint timestamp, string query);

	// createDB sends a signal to CovenantSQL to create a database with _id as database id
	function createDB() external payable returns (bytes32 _id) {
		_id = keccak256(this, msg.sender, "create", now);
		pledges[msg.sender].add(msg.value);
		emit Create(msg.sender, _id, now, pledges[msg.sender]);
		return _id;
	}

	// deleteDB sends a signal to CovenantSQL to delete a database whose database id is databaseID
	function deleteDB(bytes32 databaseID) external returns (bytes32 _id) {
		_id = keccak256(this, msg.sender, "delete", now);
		emit Delete(msg.sender, _id, now, databaseID);
		return _id;
	}

	function queryDB(string q) external payable returns (bytes32 _id) {
		_id = keccak256(this, msg.sender, "query", q, now);
		emit Query(msg.sender, _id, now, q);
		return _id;
	}
}
