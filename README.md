# com.wepiggy.contract

## Installation

> yarn

## Compile

> yarn compile

## Deploy

### Development

#### ganache-cli

	yarn cli

#### new terminal

	yarn deploy -k upgradeable -n development

> Select SimplePriceOracle
>
> Select function * initialize()

	yarn deploy -k upgradeable -n development

> Select Comptroller
>
>Select function * initialize()

	yarn deploy -k regular -n development

> Select JumpRateModel
>
> Input params
>
> eg.
>
> baseRatePerYear **_0.05e18_**
>
> multiplierPerYear **_0.45e18_**
>
> jumpMultiplierPerYear **_0.25e18_**
>
> kink_ **_0.95e18_**

	yarn deploy -k upgradeable -n development

> Select PETH
>
> Select function initialize(comptroller_: address, interestRateModel_: address, initialExchangeRateMantissa_: uint256, name_: string, symbol_: string, deci
mals_: uint8, admin_: address)
>
> Input params
>
> eg.
>
> initialExchangeRateMantissa_ **_0.2e27_**

	yarn deploy -k upgradeable -n development

> Select PERC20
>
> Select function initialize(underlying_: address, comptroller_: address, interestRateModel_: address, initialExchangeRateMantissa_: uint256, name_: string, symbol_: string, deci
mals_: uint8)
>
> Input params

#### Config

	yarn send

> Select SimplePriceOracle
>
> Select function _**_setPrice(address asset, uint price)**_
>
> Input params
>
> eg.
>
> asset_ **_0x0000000000000000000000000000000000000000_**
>
>price **_1e18_**

	yarn send

> Select Comptroller
>
> Select function _**_setPriceOracle(newOracle: address)**_
>
> Input params

	yarn send

> Select Comptroller
>
> Select function **__supportMarket(PToken pToken)_**
>
> Input params

	yarn send

> Select Comptroller
>
> Select function **__setMaxAssets(uint newMaxAssets)_**
>
> Input params

	yarn send

> Select Comptroller
>
> Select function **___setCollateralFactor(PToken pToken, uint newCollateralFactorMantissa)_**
>
> Input params
>
> eg.
>
> newCollateralFactorMantissa_ **_0.75e18_**

	yarn send

> Select Comptroller
>
> Select function **____setCloseFactor(uint newCloseFactorMantissa)_**
>
> Input params
>
> eg.
>
> newCloseFactorMantissa_ **_0.5e18_**

	yarn send

> Select PEther
>
> Select function **_____setReserveFactor(uint newReserveFactorMantissa)_**
>
> Input params
>
> eg.
>
> newReserveFactorMantissa_ **_0.1e18_**

### Rinkeby

	yarn deploy -k upgradeable -n rinkeby

> Select SimplePriceOracle
>
> Select function * initialize()

	yarn deploy -k upgradeable -n rinkeby

> Select Comptroller
>
> Select function _setPriceOracle(newOracle: address)
>
> Input params

	yarn deploy -k regular -n rinkeby

> Select JumpRateModel
>
> Input params

	yarn deploy -k upgradeable -n rinkeby

> Select PETH
>
> Select function initialize(comptroller_: address, interestRateModel_: address, initialExchangeRateMantissa_: uint256, name_: string, symbol_: string, deci
mals_: uint8, admin_: address)
>
> Input params

	yarn deploy -k upgradeable -n rinkeby

> Select PERC20
>
> Select function initialize(underlying_: address, comptroller_: address, interestRateModel_: address, initialExchangeRateMantissa_: uint256, name_: string, symbol_: string, deci
mals_: uint8)
>
> Input params


## 挖矿测试

```text
1. 部署MockErc20。
    1. 部署代币mcETH，参数:  MockCompoundETH mcETH 
    2. 部署代币mcUSDT，参数:  MockCompoundUSDT mcUSDT    
2. 部署WePiggyToken。   
3. 部署DevFundingManager。传入参数： WePiggyToken的地址
    分5次调用setFunding，参数：
        0 InsurancePayment 30
        1 ResourceExpansion 25
        2 TeamVote 20
        3 TeamSpending 18
        4 CommunityRewards 7 
4. 部署PiggyPiggyBreeder。
    Select which function initialize(_piggy: address, _devAddr: address, _piggyPerBlock: uint256, _startBlock: uint256, _reduceIntervalBlock: uint256)
        ? _piggy: address: WePiggyToken合约地址
        ? _devAddr: address: DevFundingManager合约地址
        ? _piggyPerBlock: uint256: 1000e18
        ? _startBlock: uint256: 开始挖矿的区块
        ? _reduceIntervalBlock: uint256: 5760
5. 给WePiggyToken赋权。
    Select which function grantRole(role: bytes32, account: address)
        ? role: bytes32: 0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6
        ? account: address: PiggyPiggyBreeder合约地址
6. PiggyPiggyBreeder添加池子。
    Select which function add(_allocPoint: uint256, _lpToken: address, _withUpdate: bool)
        ? _allocPoint: uint256: 1000
        ? _lpToken: address: mcETH合约地址
        ? _withUpdate: bool: true

    Select which function add(_allocPoint: uint256, _lpToken: address, _withUpdate: bool)
        ? _allocPoint: uint256: 1000
        ? _lpToken: address: mcUSDT
        ? _withUpdate: bool: true
7. 用户在mcETH和mcUSDT上授权给PiggyPiggyBreeder合约，然后调用stake方法。
```