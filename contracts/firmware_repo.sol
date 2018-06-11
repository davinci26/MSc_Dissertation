pragma solidity^0.4.19;
pragma experimental ABIEncoderV2;


contract FirmwareRepo{

    struct Firmware{
        address developer;
        bytes32 firmware_hash;
        bytes32 firmware_signature;
        string IPFS_link;
        string description;
        string device_type;
    }

    // Mapping from device name to a list of firmware
    mapping(string => Firmware[]) device_firmwares;

    function verify_signature(address p, bytes32 firmware_hash, uint8 v, bytes32 r, bytes32 s)
             constant private returns (bool){
        return ecrecover(firmware_hash, v, r, s) == p;
    }

    function add_firmware(bytes32 firmware_hash_, bytes32 firmware_signature_, string IPFS_link_) public{
        //require(verify_signature(...));
        
    }

    function view_firmware(string device_type) public returns (Firmware[10]){

    }

}