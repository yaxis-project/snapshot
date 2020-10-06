import "./IVoteProxy.sol";
import "./IMasterChef.sol";
import "./IERC20.sol";
import "./IUniswapV2Pair.sol";
import "./YaxUniVoteProxy.sol";
import "./IBalancerPool.sol";

contract YaxUniBalVoteProxy is YaxUniVoteProxy {

    IBalancerPool public constant yaxBalancerPool = IBalancerPool(
        0x7134263ef1e6a04f1A49AA03F8b939b97dbcba62
    );

    function totalSupply() public override view returns (uint256) {
        uint _yaxAmount = yaxBalancerPool.getBalance(address(yax));
        return  super.totalSupply() + sqrt(( _yaxAmount * yaxBalancerPool.balanceOf(address(chef))) / yaxBalancerPool.totalSupply());
    }

    function balanceOf(address _voter) public override view returns (uint256) {
        (uint256 _stakeAmount,) = chef.userInfo(9, _voter);
        uint _yaxAmount = yaxBalancerPool.getBalance(address(yax));
        return super.balanceOf(_voter) + sqrt(( _yaxAmount * _stakeAmount) / yaxBalancerPool.totalSupply());
    }
}