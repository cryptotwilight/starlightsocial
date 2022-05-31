# starlightsocial
The Starlight Social project has been designed to support incentivised decentralized social media sharing that leverages protocol staking on the Moonbeam blockchain.
The project uses the unique Moonbeam pre-compile features that enable direct protocol level staking of community funds. 


Deployed versions of the project can be found here: <br/>
Starlight Social : 0x8070951c4D4d514D934Ad090cbBa592D12ad14bf <br/>
Dashboard Factory : 0xdcdCF4Cb6864c2DDc5464713F3Ec248CBB788F0c <br/>
Staking Interface : 0x0000000000000000000000000000000000000800 <br/>

The user interface for the project can be found here:

## How it works
The Starlight Social project works by enabling users to charge their accounts with funds. These funds are then placed into protocol level staking using the <a href="https://github.com/PureStake/moonbeam/blob/master/precompiles/parachain-staking/StakingInterface.sol">Moonbeam Staking Interface</a>
This process also triggers the start of a new sharing Season. The Season lasts for approximately one month during which time whenever users share media with their friends they pay a share fee. If friends reshare the media they also pay a share fee however the initial sharer recieves a reward fee. 
Once the balance of deposited funds has reached the the minimum required by the Moonbeam Staking Interface the funds are then staked for the remainder of the season. 
At the end of the season, the funds are released as per the Moonbeam Staking Interface and a release period where users can withdraw their funds is opened. 
