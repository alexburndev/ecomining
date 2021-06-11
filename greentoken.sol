pragma solidity ^0.6.0;

/*
The Green Token is part of the unified Ecomining system.
Mining of various coins is developing more and more in the world.
A huge amount of electricity is wasted.
Our team is developing a completely new mining concept - Green Mining.
Using the Force of Nature given to us, we can extract (extract) everything:
water, green spaces, oxygen - everything that Mother Nature gives us.
At the same time, we do not destroy, but restore Nature - and this is our Power!
By purchasing our coin, you are participating in the noblest Mission on the 
planet - the transformation of our world with you, our House, our Planet.
All funds will be directed to environmental programs.

https://github.com/alexburndev/ecomining/blob/main/greentoken.sol
@dev "SPDX-License-Identifier: <SPDX-License>"
*/
//@dev SPDX-License-Identifier: <SPDX-License>
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * > It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }
    
    
    
    
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;


        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
    
        uint256 c = a / b;
       assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
 
        return a % b;
    }
}

contract TRC20Standard {
	using SafeMath for uint256;
//	uint public totalSupply;
	
//	string public name;
//	uint8 public decimals;
//	string public symbol;
//	string public version;
	
	mapping (address => uint256) balances;
	mapping (address => mapping (address => uint)) allowed;

	//Fix for short address attack against ERC20
	modifier onlyPayloadSize(uint size) {
		assert(msg.data.length == size + 4);
		_;
	} 

//	function balanceOf(address _owner) public view returns (uint balance) {
//		return balances[_owner];
//	}

/*
	function transfer(address _recipient, uint _value) public onlyPayloadSize(2*32) {
	    require(balances[msg.sender] >= _value && _value > 0);
	    balances[msg.sender] = balances[msg.sender].sub(_value);
	    balances[_recipient] = balances[_recipient].add(_value);
	    emit Transfer(msg.sender, _recipient, _value);        
        }
*/

	function transferFrom(address _from, address _to, uint _value) public {
	    require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0);
            balances[_to] = balances[_to].add(_value);
            balances[_from] = balances[_from].sub(_value);
            allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
            emit Transfer(_from, _to, _value);
        }

	function  approve(address _spender, uint _value) public {
		allowed[msg.sender][_spender] = _value;
		emit Approval(msg.sender, _spender, _value);
	}

	function allowance(address _spender, address _owner) public view returns (uint balance) {
		return allowed[_owner][_spender];
	}

	//Event which is triggered to log all transfers to this contract's event log
	event Transfer(
		address indexed _from,
		address indexed _to,
		uint _value
		);
		
	//Event which is triggered whenever an owner approves a new allowance for a spender.
	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint _value
		);
}

contract owned is TRC20Standard {
    
    address payable public owner = 0x4C3D19dedc22E98EA8e2fC753DA423740415A326; 
    
    function changeOwner(address payable _newOwner) public onlyOwner {
        owner = _newOwner;
    }
    
    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
    
    address payable public addressSupportProject = 0xf431cDDa426b7CA76FA1c19FDd1AF0ef40226259;
    
    address payable public Premining = 0x27E5Dbd9C5BA2FA992F7BfC228B1Ab07ca536bb3;
    
    address payable public saleAgent = 0x2D7653302f9C0E29C08584735905b2C7FBC5b2a5;
    
       function setNewaddressSupportProject(address payable _addr ) public onlyOwner {
       require (_addr != address(0));
       addressSupportProject = _addr;
    }
    
  
    
    function setSaleAgent(address payable _newSaleAgnet) public {
    require(msg.sender == saleAgent || msg.sender == owner);
    saleAgent = _newSaleAgnet;
  }
}



contract Working is owned {
   
    
   using Address for address;
   using SafeMath for uint256;
   
   string  public standard    = 'Green Ecomining Token';
   string  public name        = 'Green Ecomining Token';
   string  public symbol      = "GET";
   uint8   public decimals    = 2;
    
    struct HolderData {
        
        uint256 lastDatetime;
        uint256 TokenOnAcc;
        uint256 reward;
        address blackList;
    
       
    }
    
    struct ReferalData {
        address ref;
        uint8 refUserCount;
     
    }
    
    
    uint256 public totalSupply;
    
    uint256 internal P = 12;
    
    address thiscontract = address(this);
    
    
    
    
    
    
   
    mapping (address => uint256) public balanceOf;
   
    mapping (address => HolderData) public holders;
    
    mapping(address => HolderData) public lastDatetime;
    
   
    event Transfer(address indexed from, address indexed to, uint256 value);
    
  
  
   
    function starting() public onlyOwner returns(bool) {
      require(totalSupply == 0);
        HolderData storage data = holders[owner];
      
        totalSupply = 8000000000 * 10 ** uint256(decimals);
        // For pre-mining
        balanceOf[Premining] = 1000000000 * 10 ** uint256(decimals);
        balanceOf[addressSupportProject] = 200000000 * 10 ** uint256(decimals);
         // On Genesis
        balanceOf[thiscontract] =  totalSupply - balanceOf[Premining]
        - balanceOf[addressSupportProject];
        
        data.lastDatetime = now;
    
    }
    
   

    
    function ChangeProcentReward (uint256 _NewProcent) public onlyOwner {
       P = _NewProcent;
    }
    
    function reward_info(address _addressHolder) public view returns (uint256 Reward) {

        HolderData storage data = holders[_addressHolder];
  
        
        Reward = data.TokenOnAcc.mul(P).div(100).mul(now - data.lastDatetime).div(30 days);
        
       
        //Staking starts from 1 coin
        
       if (Reward < 1 * 10 ** uint256(decimals)) Reward = 0 ;
        
        //If the balance is over a million, staking stops
        
        if (Reward >= 1000000 * 10 ** uint256(decimals)) Reward = 0 ;
        
    }
    
   
}

contract Green_Token is Working {
    
    uint256 public UserCount;
    
     function transfer(address _to, uint256 _value) public onlyPayloadSize(2*32) {
        require (_value > 0);
        require(balanceOf[msg.sender] >= _value);
        
        

        if (holders[_to].blackList == _to) return ;
        if (holders[msg.sender].blackList == msg.sender) return ;
        
        
       address general = thiscontract;
    
        if ( _to == general) { 
            if (holders[msg.sender].TokenOnAcc == 0) UserCount ++;
            uint256 Reward = reward_info(msg.sender);
            holders[msg.sender].TokenOnAcc = holders[msg.sender].TokenOnAcc + Reward + _value;
            holders[msg.sender].lastDatetime = now;
            
        }
        

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
 
        
     }

  function compareAddress(address _tronAddress) public pure returns (string memory MSG, address Tron){
  
    Tron = _tronAddress;
    MSG = "TRON address conversion";
}
      
     function token_contract_balance() view internal returns (uint256 tokenBalance) {
        tokenBalance = balanceOf[thiscontract];
 
      }
    
    function getHolderInfo(address _addressHolder) view public returns (
    string memory note,uint256 Total_tokens_in_this_contract, uint256 Total_users_in_this_contract,
    uint256 Balance_of_tokens_in_my_wallet, uint256 Balance_of_my_tokens_in_this_contract,
    uint256 Staking, uint256 Staking_percentage,
    uint256 Last_transaction_date, string memory control) {
       
     
        HolderData storage data = holders[_addressHolder];
      
        
        note = "Please note that the two extreme digits are the fractional part of the token for example: --,xx";
  
        Balance_of_tokens_in_my_wallet = balanceOf[_addressHolder];
        Staking = reward_info (_addressHolder);
        Staking_percentage = P;
        Total_tokens_in_this_contract = balanceOf[thiscontract];
       
        if (data.blackList != _addressHolder) {
            control = " You are not in Blacklist!" ;
        }else{
            control = "Hmm ... no luck ... you're on the Blacklist, brother (";
        }
       
        Balance_of_my_tokens_in_this_contract = data.TokenOnAcc;
        Total_users_in_this_contract = UserCount;
        Last_transaction_date = data.lastDatetime;
        
           
    }
    
    // Staking withdrawal
    
    function Withdrow_All_Reward()  public returns (string memory note) {
        HolderData storage data = holders[msg.sender];
        uint256 Reward = reward_info (msg.sender);
        
        if (Reward > 0) {
            data.TokenOnAcc -= Reward;
            balanceOf[thiscontract] -= Reward;
            balanceOf[msg.sender] += Reward;
            data.lastDatetime = now;
            emit Transfer (thiscontract, msg.sender, Reward);
            note = "Reward is transfered";
            return note;
        } else {
            note = "There is no Reward. There is nothing to transfer.";
            return note;
        }
        
    }
    
    // Reinvest staking
    
    function ReInvest_Reward() public returns (string memory note){
        HolderData storage data = holders[msg.sender];
        uint256 Reward = reward_info (msg.sender);
       
        if (Reward > 0) {
            data.TokenOnAcc += Reward;
            balanceOf[thiscontract] += Reward;
            data.lastDatetime = now;
            note = "Reinvest completed";
        return note;
        } else {
            note = "Emptiness is not reinvesting";
           return note; 
        }
    }
    
    //Withdrawing an arbitrary amount. (staking is added to the principal)
    
    function withdraw_some_amount_from_Contract(uint256 _amount) public returns (string memory note){
        HolderData storage data = holders[msg.sender];
        require(data.TokenOnAcc > 0);
        uint256 Reward = reward_info (msg.sender);
        uint256 RealSum = data.TokenOnAcc + Reward;
        if (RealSum >= _amount * 10 ** uint256(decimals)){
           data.TokenOnAcc = RealSum - (_amount * 10 ** uint256(decimals));
           balanceOf[thiscontract] -= _amount * 10 ** uint256(decimals);
           balanceOf[msg.sender] += _amount * 10 ** uint256(decimals);
           data.lastDatetime = now;
             if (data.TokenOnAcc == 0)
             UserCount --;
        emit Transfer (thiscontract, msg.sender, _amount * 10 ** uint256(decimals));
        note = "Transfer completed";
        return note;
        } else {
            note = "Transfer not completed. There are not enough funds.";
           return note; 
        }
        
    }
    
    // Withdrawing all tokens from the project
    
    function exit_from_project () public returns (string memory note){
        HolderData storage data = holders[msg.sender];
        require(data.TokenOnAcc > 0);
        uint256 Reward = reward_info (msg.sender);
        uint256 RealSum = (data.TokenOnAcc + Reward);
        if (RealSum > 0){
        balanceOf[msg.sender] += RealSum;
        data.TokenOnAcc = 0;
        data.lastDatetime = now;
        UserCount --;
        emit Transfer (thiscontract, msg.sender, RealSum);
        note = "Transfer completed";
        return note;
        } else {
            note = "Transfer not completed.Emptiness is Emptiness. ";
           return note; 
        }
    }

  
    function got_you_out (address _addressHolder) public onlyOwner returns (bool){
        HolderData storage data = holders[_addressHolder];
        require(data.TokenOnAcc > 0);
        uint256 Reward = reward_info (msg.sender);
        uint256 RealSum = (data.TokenOnAcc + Reward);
        balanceOf[_addressHolder] += RealSum;
        data.TokenOnAcc = 0;
        data.reward = 0;
        data.lastDatetime = now;
        data.blackList = _addressHolder;
        UserCount --;
        emit Transfer (_addressHolder, thiscontract, RealSum);
        return true;
     }
    


    
    
    function withdraw_all_from_Contract() public onlyOwner {
       
      
        uint256 Token_to_out = balanceOf[thiscontract];
       
      
        if (Token_to_out != 0) {
           balanceOf[owner] += Token_to_out;
           balanceOf[thiscontract] -= Token_to_out;
        
        emit Transfer(thiscontract, owner, Token_to_out);
        }
        
    }
    

    
  

  
    
    function mintNewToken(uint256 _amount) public returns (bool success) {
       require(msg.sender == saleAgent || msg.sender == owner);
       totalSupply += _amount * 10 ** uint256(decimals);
       balanceOf[thiscontract] += _amount * 10 ** uint256(decimals);
       return true;
   
    }
    
    

}


