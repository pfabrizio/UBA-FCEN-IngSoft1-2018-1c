!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:22:46'!
test03_01WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	self assert: (Withdraw register: withdrawValue on: account) value equals: withdrawValue 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	 	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
		
	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:36'!
test06ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:30'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf 

	| account1 |
	account1 := ReceptiveAccount new.
		
	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios 

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on:account1.
		
	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions 

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.
		
	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts 

	| account1 account2 account3 complexPortfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self 
		should: [ complexPortfolio transactionsOf:account3 ] 
		raise: Error 
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:24:31'!
test19CanNotCreatePortfoliosWithRepeatedAccount 

	| account1 |

	account1 := ReceptiveAccount new.
	self 
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio 

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self 
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:11:42'!
test20_01CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolioTwo

    | account1 account2 account3 complexPortfolio1 complexPortfolio2 |
    
    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    account3 := ReceptiveAccount new.    
    complexPortfolio1 := Portfolio with: account1 with: account2.
    complexPortfolio2 := Portfolio with: account3 with: account1.

    self 
        should: [ Portfolio with: complexPortfolio1 with: complexPortfolio2 ]
        raise: Error
        withExceptionDo: [ :invalidPortfolio |
            self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:30:52'!
test21_01TransferIsReachedFromTransacctions

	| fromAccount toAccount transfer |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	transfer := Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert:  100 = transfer value.
	self assert: fromAccount transactions first transfer equals: transfer.
	self assert: toAccount transactions first transfer equals: transfer.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:27:01'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount fromAccountLines toAccountLines|

	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	
	fromAccountLines := self accountSummaryLinesOf: fromAccount.
	toAccountLines := self accountSummaryLinesOf: toAccount.
	
	self assert: 3 = fromAccountLines size.
	self assert: 'Deposito por 100' = (fromAccountLines at: 1).
	self assert: 'Extraccion por 50' = (fromAccountLines at: 2).
	self assert: 'Transferencia por -100' = (fromAccountLines at: 3).
	
	self assert: 1 = toAccountLines size.
	self assert: 'Transferencia por 100' = (toAccountLines at: 1).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
		
	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new. 
		
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings := 
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).
		
	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:29'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self portofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:30'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self reversePortofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).
	! !


!PortfolioTest methodsFor: 'test support' stamp: 'GAA 5/14/2018 18:13:58'!
accountSummaryLinesOf: aReceptiveAccount 
	
	^(AccountSummary of:aReceptiveAccount ) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'GAA 5/14/2018 18:14:27'!
accountTransferNetOf: aReceptiveAccount 
	
	^(TransferNet of:aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'GAA 5/14/2018 18:52:12'!
investmentEarningsOf: aReceptiveAccount 
	
	^(InvestmentEarnings of:aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'GAA 5/14/2018 19:05:49'!
investmentNetOf: aReceptiveAccount 
	
	^(InvestmentNet of: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'GAA 5/16/2018 13:22:07'!
portofolioTreeOf: aPortfolio namingAccountWith: aDictionary
	^(PortfolioTreePrinter of: aPortfolio namingAccountWith: aDictionary ) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'GAA 5/16/2018 13:23:01'!
reversePortofolioTreeOf: aPortfolio namingAccountWith: aDictionary
	^(PortfolioTreePrinter of: aPortfolio namingAccountWith: aDictionary ) value reversed.! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'private' stamp: 'PGF 5/10/2018 20:36:31'!
initializeFor: anAmount during: aDuration at:anInterest onAccount: anAccount.
	value _ anAmount .
	numberOfDays _ aDuration .
	tna _ anInterest .
	account _ anAccount .! !

!CertificateOfDeposit methodsFor: 'private' stamp: 'PGF 5/10/2018 20:40:43'!
value
	^value.! !


!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:42:31'!
annualInterest
	^tna.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'PGF 5/10/2018 20:58:47'!
modifyBalance: aBalance
	^aBalance - value .! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:41:57'!
numberOfDays
	^numberOfDays! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:52:08'!
sendIdentityMessage: aMethodObject
	aMethodObject certificateOfDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'PGF 5/10/2018 20:34:02'!
register: anAmount during: aDuration at: anInterest on: anAccount
	|deposito|
	deposito _ (self new) initializeFor: anAmount 
			during: aDuration 
			at:anInterest
			onAccount: anAccount.
	anAccount register: deposito .
	^deposito.! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'PGF 5/10/2018 19:44:07'!
modifyBalance: aBalance
	^aBalance + value .! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:52:09'!
sendIdentityMessage: aMethodObject
	aMethodObject transactionDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'transfer' stamp: 'GAA 5/11/2018 15:09:37'!
creditor
	^transfer creditor.! !

!TransferDeposit methodsFor: 'transfer' stamp: 'GAA 5/11/2018 15:10:05'!
debtor
	^transfer debtor.! !

!TransferDeposit methodsFor: 'transfer' stamp: 'GAA 5/11/2018 14:39:18'!
transfer
	^transfer.! !


!TransferDeposit methodsFor: 'value' stamp: 'GAA 5/11/2018 14:42:38'!
modifyBalance: aBalance
	^aBalance + self value.! !

!TransferDeposit methodsFor: 'value' stamp: 'GAA 5/11/2018 14:40:55'!
value
	^transfer value.! !


!TransferDeposit methodsFor: 'private' stamp: 'GAA 5/11/2018 14:46:13'!
initializeWith: aTransfer
	transfer _ aTransfer.! !


!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:52:08'!
sendIdentityMessage: aMethodObject
	aMethodObject transactionTransferDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'instance creation' stamp: 'GAA 5/11/2018 14:45:37'!
fromTransfer: aTransfer
	^(self new) initializeWith: aTransfer.! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'value' stamp: 'GAA 5/11/2018 14:43:42'!
modifyBalance: aBalance
	^aBalance - self value.! !

!TransferWithdraw methodsFor: 'value' stamp: 'GAA 5/11/2018 14:43:29'!
value
	^transfer value.! !


!TransferWithdraw methodsFor: 'private' stamp: 'GAA 5/11/2018 14:46:51'!
initializeWith: aTransfer
	transfer _ aTransfer.! !


!TransferWithdraw methodsFor: 'transfer' stamp: 'GAA 5/11/2018 15:10:30'!
creditor
	^transfer creditor.! !

!TransferWithdraw methodsFor: 'transfer' stamp: 'GAA 5/11/2018 15:10:18'!
debtor
	^transfer debtor.! !

!TransferWithdraw methodsFor: 'transfer' stamp: 'GAA 5/11/2018 14:47:51'!
transfer
	^transfer.! !


!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:52:09'!
sendIdentityMessage: aMethodObject
	aMethodObject transactionTransferWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'instance creation' stamp: 'GAA 5/11/2018 14:47:09'!
fromTransfer: aTransfer
	^(self new) initializeWith: aTransfer.! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'PGF 5/10/2018 19:43:56'!
modifyBalance: aBalance
	^aBalance - value .! !

!Withdraw methodsFor: 'value' stamp: 'PGF 5/10/2018 19:35:12'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:52:08'!
sendIdentityMessage: aMethodObject
	aMethodObject transactionWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:26'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount manages: anAccount) or: [ anAccount manages: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:01'!
manages: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount 

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'PGF 5/7/2018 21:50:00'!
initializeWith: accountsCollection
	accounts _ accountsCollection.! !

!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 12:48:07'!
accountsDo: aBlockClosure 
	|cuentas|
	cuentas _ accounts copy.
	cuentas do:aBlockClosure.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:53:43'!
sendIdentityMessage: aPortfolioMethod
	aPortfolioMethod portfolioAccount: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'GAA 5/11/2018 14:56:49'!
balance
	^ transactions inject: 0 into: [ :balance :transaction |transaction modifyBalance:balance.].! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'GAA 5/11/2018 14:57:42'!
register: aTransaction
	transactions add: aTransaction
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'GAA 5/16/2018 13:12:09'!
transactions
	^transactions copy.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'GAA 5/16/2018 12:47:48'!
transactionsDo:aBlockClousure
	|transacciones|
	transacciones _ transactions copy.
	transacciones do:aBlockClousure.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'GAA 5/11/2018 15:03:57'!
registers: aTtransaction
	^ transactions includes: aTtransaction.! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:53:58'!
sendIdentityMessage: aPortfolioMethod
	aPortfolioMethod receptiveAccount: self.! !


!classDefinition: #SummarizingAccountMethod category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccountMethod
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccountMethod methodsFor: 'value' stamp: 'GAA 5/16/2018 14:40:45'!
value
	self subclassResponsibility.! !


!classDefinition: #PortfolioMethod category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccountMethod subclass: #PortfolioMethod
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioMethod methodsFor: 'value' stamp: 'GAA 5/16/2018 13:35:26'!
value
	self subclassResponsibility.! !


!PortfolioMethod methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:14:17'!
portfolioAccount: aPortfolio! !

!PortfolioMethod methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:14:49'!
receptiveAccount: aReceptiveAccount! !


!classDefinition: #PortfolioTreePrinter category: #'PortfolioTreePrinter-Ejercicio'!
PortfolioMethod subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio dictionary depth tree'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTreePrinter methodsFor: 'value' stamp: 'GAA 5/16/2018 13:19:25'!
value
	tree _ OrderedCollection new.
	depth _ 0.
	self portfolioAccount: portfolio.
	^tree.! !


!PortfolioTreePrinter methodsFor: 'private' stamp: 'GAA 5/16/2018 13:21:35'!
of: aPortfolio namingAccountWIth: aDictionary
	portfolio _ aPortfolio.
	dictionary _ aDictionary.! !


!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:52:09'!
portfolioAccount: aPortfolio
	self printInTree: aPortfolio.
	depth _ depth + 1.
	aPortfolio accountsDo: [ :account |
		account sendIdentityMessage: self ].
	depth _ depth - 1.! !

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 12:32:03'!
printInTree: anAccount
	|depthRepresentation|
	depthRepresentation _ ''.
	depth timesRepeat: [depthRepresentation _ depthRepresentation , ' '].
	tree add: (depthRepresentation , (dictionary at: anAccount) ).! !

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 12:33:33'!
receptiveAccount: aReceptiveAccount 
	self printInTree: aReceptiveAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: #'PortfolioTreePrinter-Ejercicio'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'class initialization' stamp: 'GAA 5/16/2018 13:20:52'!
of: aPortfolio namingAccountWith: aDictionary
	^self new of: aPortfolio namingAccountWIth: aDictionary.! !


!classDefinition: #ReceptiveAccountMethod category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccountMethod subclass: #ReceptiveAccountMethod
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccountMethod methodsFor: 'value' stamp: 'GAA 5/14/2018 19:12:48'!
value
	self subclassResponsibility! !


!ReceptiveAccountMethod methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 19:13:51'!
certificateOfDeposit: aCertificateOfDeposit! !

!ReceptiveAccountMethod methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 19:14:26'!
transactionDeposit: aDepositTransaction
! !

!ReceptiveAccountMethod methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 19:14:56'!
transactionTransferDeposit: aTransferDepositTransaction! !

!ReceptiveAccountMethod methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 19:15:06'!
transactionTransferWithdraw: aTransferWithdrawTransaction! !

!ReceptiveAccountMethod methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 19:15:21'!
transactionWithdraw: aWithdrawTransaction! !


!classDefinition: #AccountSummary category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountMethod subclass: #AccountSummary
	instanceVariableNames: 'account lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:40:36'!
certificateOfDeposit: aCertificateOfDeposit 
	^lines
		add:'Plazo fijo por ', 
			aCertificateOfDeposit value printString, 
			' durante ', 
			aCertificateOfDeposit numberOfDays printString , 
			' dias a una tna de ',
			 ((aCertificateOfDeposit annualInterest )*100) printString, '%'.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:01:09'!
initializeWith:anAccount
	account _ anAccount.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:19:45'!
transactionDeposit: aDepositTransaction
	^lines add: 'Deposito por ', aDepositTransaction value printString.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:27:28'!
transactionTransferDeposit: aTransferDepositTransaction
	^lines add:'Transferencia por ', aTransferDepositTransaction value printString.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:25:16'!
transactionTransferWithdraw: aTransferWithdrawTransaction
	^lines add:'Transferencia por ', aTransferWithdrawTransaction value negated printString.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:22:55'!
transactionWithdraw: aWithdrawTransaction
	^lines add:'Extraccion por ', aWithdrawTransaction value printString.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'GAA 5/16/2018 14:52:09'!
value
	lines _ OrderedCollection new.
	account transactionsDo: [ :aTransaction |
		aTransaction sendIdentityMessage: self ].
	^ lines.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'class initialization' stamp: 'GAA 5/14/2018 18:13:18'!
of: anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #InvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountMethod subclass: #InvestmentEarnings
	instanceVariableNames: 'account value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarnings methodsFor: 'private' stamp: 'GAA 5/14/2018 18:51:43'!
initializeWith: anAccount
	account _ anAccount.! !


!InvestmentEarnings methodsFor: 'value' stamp: 'GAA 5/16/2018 14:52:09'!
value
	value _ 0.
	account transactionsDo: [ :aTransaction |
		aTransaction sendIdentityMessage: self ].
	^ value.! !


!InvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:54:32'!
certificateOfDeposit: aCertificateOfDeposit 
	value _ value + ( (aCertificateOfDeposit value)*(aCertificateOfDeposit annualInterest /360)* (aCertificateOfDeposit numberOfDays) ).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentEarnings class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentEarnings class
	instanceVariableNames: ''!

!InvestmentEarnings class methodsFor: 'class initialization' stamp: 'GAA 5/14/2018 18:51:14'!
of: anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #InvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountMethod subclass: #InvestmentNet
	instanceVariableNames: 'account value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNet methodsFor: 'private' stamp: 'GAA 5/14/2018 19:05:21'!
initializeWith: anAccount
	account _ anAccount.! !


!InvestmentNet methodsFor: 'value' stamp: 'GAA 5/16/2018 14:52:09'!
value
	value _ 0.
	account transactionsDo: [ :aTransaction |
		aTransaction sendIdentityMessage: self ].
	^ value.! !


!InvestmentNet methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 19:08:08'!
certificateOfDeposit: aCertificateOfDeposit 
	value _ value + aCertificateOfDeposit value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentNet class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentNet class
	instanceVariableNames: ''!

!InvestmentNet class methodsFor: 'class initialization' stamp: 'GAA 5/14/2018 19:05:00'!
of: anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #TransferNet category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountMethod subclass: #TransferNet
	instanceVariableNames: 'account value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferNet methodsFor: 'value' stamp: 'GAA 5/16/2018 14:52:09'!
value
	value _ 0.
	account transactionsDo: [ :aTransaction |
		aTransaction sendIdentityMessage: self ].
	^ value.! !


!TransferNet methodsFor: 'private' stamp: 'GAA 5/14/2018 18:03:20'!
initializeWith:anAccount
	account _ anAccount.! !


!TransferNet methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:32:46'!
transactionTransferDeposit: aTransferDepositTransaction
	value _ value + aTransferDepositTransaction value.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'GAA 5/14/2018 18:32:11'!
transactionTransferWithdraw: aTransferWithdrawTransaction
	value _ value - aTransferWithdrawTransaction value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'class initialization' stamp: 'GAA 5/14/2018 18:13:29'!
of:anAccount
	^self new initializeWith: anAccount.! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value debtor creditor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'PGF 5/10/2018 19:27:49'!
initializeFor: aValue fromAccount: aDebtor toAccount: aCreditor
	value _ aValue.
	debtor _ aDebtor.
	creditor _ aCreditor.! !


!Transfer methodsFor: 'transfer' stamp: 'GAA 5/11/2018 15:07:47'!
creditor
	^creditor.! !

!Transfer methodsFor: 'transfer' stamp: 'GAA 5/11/2018 15:07:35'!
debtor
	^debtor.! !

!Transfer methodsFor: 'transfer' stamp: 'PGF 5/10/2018 19:07:51'!
transfer
	"Me devuelvo"! !


!Transfer methodsFor: 'value' stamp: 'PGF 5/10/2018 19:04:33'!
value

	^ value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'transfering' stamp: 'GAA 5/11/2018 14:55:01'!
register: anAmount from: aReceptiveAccountFrom to: aReceptiveAccountTo
	|transfer transferDeposit transferWithdraw|
	transfer _ (self new) initializeFor: anAmount 
			fromAccount: aReceptiveAccountFrom 
			toAccount: aReceptiveAccountTo.
	transferDeposit _ TransferDeposit fromTransfer: transfer.
	transferWithdraw _ TransferWithdraw fromTransfer: transfer.
	aReceptiveAccountFrom register: transferWithdraw .
	aReceptiveAccountTo register: transferDeposit.
	^transfer.! !


!Transfer class methodsFor: 'as yet unclassified' stamp: 'PGF 5/10/2018 19:03:22'!
for: aValue

	^ self new initializeFor: aValue ! !
