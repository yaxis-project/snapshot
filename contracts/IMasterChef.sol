interface IMasterChef {
    function userInfo(uint256, address)
    external
    view
    returns (uint256, uint256);
}