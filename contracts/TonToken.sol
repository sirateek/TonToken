// SPDX-License-Identifier: MIT
pragma solidity >=0.8.4;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TonToken is ERC20 {
    address private tokenOwner;
    bool private allowTransfer;
    string private tonVersion;

    event AllowTransferUpdate(bool allowTransferStatus);

    constructor() ERC20("TON Token", "TON") {
        tokenOwner = msg.sender;
        allowTransfer = true;
        tonVersion = "0.1 (beta)";
    }

    /**
     *  mint function is used to mint the TON Token
     *  ONLY! tokenOwner can call this function
     */
    function mint(address _to, uint256 _amount) public returns (bool success) {
        require(
            msg.sender == tokenOwner,
            "TON: Only tokenOwner can call this function"
        );
        super._mint(_to, _amount);
        return true;
    }

    /**
     *  burn function is used to burn the TON Token
     *  ONLY! tokenOwner can call this function
     */
    function burn(address _account, uint256 _amount)
        public
        returns (bool success)
    {
        require(
            msg.sender == tokenOwner,
            "TON: Only tokenOwner can call this function"
        );
        super._burn(_account, _amount);
        return true;
    }

    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    function getTonVersion() public view returns (string memory tokenVersion) {
        return tonVersion;
    }

    function getAllowTransferStatus()
        public
        view
        returns (bool transferStatus)
    {
        return allowTransfer;
    }

    function toggleAllowTransferStatus() public returns (bool success) {
        require(
            msg.sender == tokenOwner,
            "TON: Only tokenOwner can call this function"
        );
        allowTransfer = !allowTransfer;
        emit AllowTransferUpdate(allowTransfer);
        return true;
    }

    function transfer(address recipient, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        require(
            allowTransfer,
            "TON: You can't transfer TON during this period. Check the token status on https://sirateek.dev/ton"
        );
        return super.transfer(recipient, amount);
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        require(
            allowTransfer,
            "TON: You can't transfer TON during this period. Check the token status on https://sirateek.dev/ton"
        );
        return super.transferFrom(sender, recipient, amount);
    }
}
