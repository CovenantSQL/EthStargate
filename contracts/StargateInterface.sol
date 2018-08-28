pragma solidity ^0.4.24;

interface StargateInterface {
	function create(uint16 nodeCnt, function(string memory) external callback) external payable returns (uint32 seqID);

	function drop(string dbID, function(string memory) external callback) external returns (uint32 seqID);

	function query(string dbID, string q, function(string memory) external callback) external payable returns (uint32 seqID);

	function exec(string dbID, string q, function(string memory) external callback) external payable returns (uint32 seqID);

	function reply(address requester, uint32 sequenceID, string response) external;
}
