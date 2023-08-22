//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Ownable.sol';

contract DigitalPokemanCardTracker is Ownable{

    mapping(address => uint) pokemonCardBalance;
    event PokemonCardTransfered(address indexed _from, address indexed _to, uint indexed amount);

    constructor(){
        pokemonCardBalance[msg.sender] = 100000;
    }

    function sendCards(address _to, uint amount) public{
        require(pokemonCardBalance[msg.sender] >= amount, "Balance not sufficient");
        require(amount <= 20000, "Exceeded max transfer amount");
        
        pokemonCardBalance[msg.sender] -= amount;
        pokemonCardBalance[_to] += amount;
        emit PokemonCardTransfered(msg.sender, _to, amount);
    }

    function checkCardsBalance() public view returns(uint){
        return pokemonCardBalance[msg.sender];
    }

    function showMySkillLevel() public view returns(string memory){
        require(pokemonCardBalance[msg.sender] != 0, "Not a player");

        if (pokemonCardBalance[msg.sender] < 1000){
            return "Beginner";
        }else if(1000 <= pokemonCardBalance[msg.sender]  && pokemonCardBalance[msg.sender] < 20000){
            return "Intermediate";
        }else{
            return "Advanced";
        }

    }

    function sendCardsInBatch(address[] calldata players, uint amount) public {

        require(pokemonCardBalance[msg.sender] >= amount, "Balance not sufficient");
        require(amount <= 20000, "Exceeds max transfer amount");
        require(players.length <= 5, "Cannot do batch transfers to more than 5 players");
        require(amount % players.length == 0 , "Amount for each player is not a uint");
        pokemonCardBalance[msg.sender] -= amount;
        uint value = amount/(players.length);
        for(uint i=0; i < players.length; i++){
            pokemonCardBalance[players[i]] += value;
            emit PokemonCardTransfered(msg.sender, players[i], value);
        }
    }

    function checkCardsBalanceForOtherPlayer(address _of) public view OnlyOwner returns(uint, string memory){
        
        if (pokemonCardBalance[_of] < 1000){
            return (pokemonCardBalance[_of], "Beginner");
        }else if(1000 <= pokemonCardBalance[_of]  && pokemonCardBalance[_of] < 20000){
            return (pokemonCardBalance[_of],"Intermediate");
        }else{
            return (pokemonCardBalance[_of], "Advanced");
        }

    }
}
