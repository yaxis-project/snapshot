import "./IERC20.sol";

interface IBalancerPool is IERC20 {
    function getBalance(address token)
    external view
    returns (uint);

    function getNormalizedWeight(address token)
    external view
    returns (uint);

    function getTotalDenormalizedWeight()
    external view
    returns (uint);

}