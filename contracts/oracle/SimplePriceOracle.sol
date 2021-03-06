// COPIED FROM https://github.com/compound-finance/compound-protocol/blob/master/contracts/SimplePriceOracle.sol
//Copyright 2020 Compound Labs, Inc.
//Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
//3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../token/PERC20.sol";
import "./IPriceOracle.sol";
import "../token/PToken.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract SimplePriceOracle is IPriceOracle, OwnableUpgradeable {

    struct Datum {
        uint timestamp;
        uint price;
    }

    mapping(address => Datum) private data;

    address private _pETHUnderlying;

    event PricePosted(address asset, uint previousPriceMantissa, uint requestedPriceMantissa, uint newPriceMantissa, uint timestamp);

    function initialize() public initializer {
        _pETHUnderlying = address(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);
        super.__Ownable_init();
    }


    function getUnderlyingPrice(PToken pToken) public override view returns (uint) {
        if (compareStrings(pToken.symbol(), "pETH")) {
            return data[_pETHUnderlying].price;
        } else {
            return data[address(PERC20(address(pToken)).underlying())].price;
        }
    }

    function setUnderlyingPrice(PToken pToken, uint price) public onlyOwner {
        address asset = _pETHUnderlying;
        if (!compareStrings(pToken.symbol(), "pETH")) {
            asset = address(PERC20(address(pToken)).underlying());
        }
        uint bt = block.timestamp;
        data[asset] = Datum(bt, price);
        emit PricePosted(asset, data[asset].price, price, price, bt);
    }

    function setPrice(address asset, uint price) public onlyOwner {
        uint bt = block.timestamp;
        emit PricePosted(asset, data[asset].price, price, price, bt);
        data[asset] = Datum(bt, price);
    }

    function getPrice(address asset) external view returns (uint) {
        return data[asset].price;
    }

    function get(address asset) external view returns (uint256, uint)  {
        return (data[asset].timestamp, data[asset].price);
    }

    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
}
