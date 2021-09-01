pragma solidity 0.6.12;

import "../flashloan/IFlashLoanReceiver.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

contract MockFlashLoanReceiver is IFlashLoanReceiver {

    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    event Msg(address _reserve, uint256 _amount, uint256 _fee, bytes _params);

    function executeOperation(address _reserve, uint256 _amount, uint256 _fee, bytes calldata _params) external override {

        uint amount = _amount.add(_fee);

        address sender = msg.sender;
        IERC20 erc20 = IERC20(_reserve);

        erc20.safeTransfer(sender, amount);

        emit Msg(_reserve, _amount, _fee, _params);

    }


}
