import "./IVoteProxy.sol";
import "./IMasterChef.sol";
import "./IERC20.sol";
import "./IUniswapV2Pair.sol";

contract YaxUniVoteProxy is IVoteProxy {
    // ETH/YAX token
    IUniswapV2Pair public constant yaxEthUniswapV2Pair = IUniswapV2Pair(
        0x1107B6081231d7F256269aD014bF92E041cb08df
    );
    // YAX token
    IERC20 public constant yax = IERC20(
        0xb1dC9124c395c1e97773ab855d66E879f053A289
    );

    // YaxisChef contract
    IMasterChef public constant chef = IMasterChef(
        0xC330E7e73717cd13fb6bA068Ee871584Cf8A194F
    );

    // Using 9 decimals as we're square rooting the votes
    function decimals() public override virtual pure returns (uint8) {
        return uint8(9);
    }

    function totalSupply() public override virtual view returns (uint256) {
        (uint256 _yaxAmount,,) = yaxEthUniswapV2Pair.getReserves();
        return sqrt(yax.totalSupply()) + sqrt((2 * _yaxAmount * yaxEthUniswapV2Pair.balanceOf(address(chef))) / yaxEthUniswapV2Pair.totalSupply());
    }

    function balanceOf(address _voter) public override virtual view returns (uint256) {
        (uint256 _stakeAmount,) = chef.userInfo(6, _voter);
        (uint256 _yaxAmount,,) = yaxEthUniswapV2Pair.getReserves();
        return sqrt(yax.balanceOf(_voter)) + sqrt((2 * _yaxAmount * _stakeAmount) / yaxEthUniswapV2Pair.totalSupply());
    }

    function sqrt(uint256 x) public pure returns (uint256 y) {
        uint256 z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
    }
}