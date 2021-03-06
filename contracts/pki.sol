contract SCPKI {

    struct Attribute {
        address owner;
        string attributeType;
        bool has_proof;
        bytes32 identifier;
        string data;
        string datahash;
    }
    struct Signature {
        address signer;
        uint attributeID;
        uint expiry;
    }
    struct Revocation {
        uint signatureID;
    }
    Attribute[] public attributes;
    Signature[] public signatures;
    Revocation[] public revocations;
    
    event AttributeAdded ( uint indexed attributeID, address indexed owner, string attributeType,
    bool has_proof, bytes32 indexedidentifier , string data , string datahash);
    
    event AttributeSigned ( uint indexed signatureID , address indexed signer , uint indexed attributeID,
    uint expiry);
    
    event SignatureRevoked ( uint indexed revocationID , uint indexed signatureID);

    function addAttribute (string attributeType, bool has_proof,
        bytes32 identifier, string data,
        string datahash) public returns ( uint attributeID ) {

        attributeID = attributes . length ++;
        Attribute attribute = attributes[attributeID];
        attribute.owner = msg.sender;
        attribute.attributeType = attributeType;
        attribute.has_proof = has_proof;
        attribute.identifier = identifier;
        attribute.data = data;
        attribute.datahash = datahash;
        emit AttributeAdded (attributeID, msg.sender, attributeType, has_proof, identifier, data, datahash);
    }
    function signAttribute (uint attributeID, uint expiry)
             public returns ( uint signatureID) {
        signatureID = signatures.length ++;
        Signature signature = signatures [signatureID];
        signature.signer = msg . sender;
        signature.attributeID = attributeID;
        signature.expiry = expiry;
        emit AttributeSigned(signatureID, msg.sender, attributeID, expiry );
    }
    function revokeSignature ( uint signatureID )
        public returns ( uint revocationID ) {
        if ( attributes[signatureID].owner == msg.sender ) {
            revocationID = revocations.length++;
            Revocation revocation = revocations[revocationID];
            revocation.signatureID = signatureID;
            emit SignatureRevoked (revocationID, signatureID);
        }
    }
}