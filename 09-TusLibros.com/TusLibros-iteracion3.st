!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GAA 6/13/2018 15:11:24'!
setUp
	testObjectsFactory _ StoreTestObjectsFactory new.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GAA 6/13/2018 14:35:51'!
test01CanNotCheckoutAnEmptyCart

	| salesBook merchantProcesor|
	
	salesBook := OrderedCollection new.
	merchantProcesor _ MerchantInterfaceSimulator withBehavior:#checkOut.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			on: testObjectsFactory today
			registeringOn:  salesBook 
			merchantProcesor: merchantProcesor]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GAA 6/13/2018 14:40:55'!
test02CalculatedTotalIsCorrect

	| cart cashier merchantProcesor |
	
	merchantProcesor _ MerchantInterfaceSimulator withBehavior:#checkOut.
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier toCheckout: cart 
				charging: testObjectsFactory notExpiredCreditCard 
				on: testObjectsFactory today 
				registeringOn: OrderedCollection new
				merchantProcesor: merchantProcesor.
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GAA 6/13/2018 14:44:21'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook merchantProcesor |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	merchantProcesor _ MerchantInterfaceSimulator withBehavior:#checkOut.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				on: testObjectsFactory today
				registeringOn: salesBook 
				merchantProcesor: merchantProcesor]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GAA 6/13/2018 14:44:47'!
test04CheckoutRegistersASale

	| cart cashier salesBook total merchantProcesor |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	merchantProcesor _ MerchantInterfaceSimulator withBehavior:#checkOut.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook
		merchantProcesor: merchantProcesor.
	total := cashier checkOut.
					
	self assert: salesBook notEmpty.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GAA 6/13/2018 14:55:35'!
test05CanNotCheckoutWithAnStolenCreditCart
	| cart cashier salesBook total merchantProcesor |
	
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook _ OrderedCollection new.
	merchantProcesor _ MerchantInterfaceSimulator withBehavior:#stolenCard.
	cashier _ Cashier
		toCheckout: cart
		charging: testObjectsFactory notExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook
		merchantProcesor: merchantProcesor.
	self
		should: [ total _ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: MerchantInterfaceSimulator stolenCardErrorMessage.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GAA 6/13/2018 15:11:14'!
test06CanNotCheckoutWithInsufficientFundsInCreditCart
	| cart cashier salesBook total merchantProcesor |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook _ OrderedCollection new.
	merchantProcesor _ MerchantInterfaceSimulator withBehavior: #insufficientFunds.
	cashier _ Cashier
		toCheckout: cart
		charging: testObjectsFactory notExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook
		merchantProcesor: merchantProcesor.
	self
		should: [ total _ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: MerchantInterfaceSimulator insufficientFundsErrorMessage.
			self assert: salesBook isEmpty ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GAA 6/13/2018 15:08:19'!
test07CanNotCallMerchantProcesorWithAnExpiredCreditCart
	| cart salesBook  merchantProcesor |
	
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook _ OrderedCollection new.
	merchantProcesor _ MerchantInterfaceSimulator withBehavior:#checkOut.
	self
		should: [
			Cashier
				toCheckout: cart
				charging: testObjectsFactory expiredCreditCard
				on: testObjectsFactory today
				registeringOn: salesBook
				merchantProcesor: merchantProcesor]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty.
			self assert: merchantProcesor numberOfCalls equals: 0].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'GAA 6/13/2018 15:10:11'!
test08CheckoutRegistersASaleAndCalledMerchantProcesorOnce
	| cart cashier salesBook total merchantProcesor |
	cart _ testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook _ OrderedCollection new.
	merchantProcesor _ MerchantInterfaceSimulator withBehavior: #checkOut.
	cashier _ Cashier
		toCheckout: cart
		charging: testObjectsFactory notExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook
		merchantProcesor: merchantProcesor.
	total _ cashier checkOut.
	self assert: salesBook notEmpty.
	self assert: salesBook first total = total.
	self
		assert: merchantProcesor numberOfCalls
		equals: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashierTest class' category: #TusLibros!
CashierTest class
	instanceVariableNames: ''!

!CashierTest class methodsFor: 'error handling' stamp: 'GAA 6/11/2018 20:44:26'!
stolenCardErrorMessage
	^'This Credit Card is stolen'.! !

!CashierTest class methodsFor: 'error handling' stamp: 'GAA 6/11/2018 20:44:03'!
withoutBalanceErrorMessage
	^'Saldo insuficiente para compra'.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:04'!
catalog
	
	^ catalog! !

!Cart methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:05'!
itemsDo: aBlock
	
	^items do: aBlock ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCart salesBook merchantProcesor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'GAA 6/11/2018 19:24:45'!
checkOut
	
	| priceList total |
	
	priceList := cart catalog.
	total := 0.
	cart itemsDo: [ :anItem | total := total + (priceList at: anItem)].
	self debitFromCreditCard: total.
	
	salesBook add: (Sale of: total).
	
	^total! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'GAA 6/11/2018 20:02:19'!
debitFromCreditCard: anAmount
	merchantProcesor
		debit: anAmount
		fromCreditCard: creditCart.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'GAA 6/11/2018 20:05:48'!
initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook merchantProcesor: aMerchantProcesor
	cart _ aCart.
	creditCart _ aCreditCard.
	salesBook _ aSalesBook.
	merchantProcesor _ aMerchantProcesor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'GAA 6/11/2018 20:05:48'!
toCheckout: aCart charging: aCreditCard on: aDate registeringOn: aSalesBook merchantProcesor: aMerchantProcesor
	self assertIsNotEmpty: aCart.
	self
		assertIsNotExpired: aCreditCard
		on: aDate.
	^ self new
		initializeToCheckout: aCart
		charging: aCreditCard
		registeringOn: aSalesBook
		merchantProcesor: aMerchantProcesor.! !


!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MerchantInterfaceSimulator category: #TusLibros!
Object subclass: #MerchantInterfaceSimulator
	instanceVariableNames: 'behavior numberOfCalls'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantInterfaceSimulator methodsFor: 'private' stamp: 'GAA 6/13/2018 15:06:00'!
initializeWithBehavior: aSymbolMessage
	numberOfCalls _ 0.
	behavior _ aSymbolMessage asMessage.! !


!MerchantInterfaceSimulator methodsFor: 'accessing' stamp: 'GAA 6/13/2018 14:59:38'!
debit: anAmount fromCreditCard: aCreditCard 
	numberOfCalls _ numberOfCalls + 1.
	behavior sendTo: self.! !

!MerchantInterfaceSimulator methodsFor: 'accessing' stamp: 'GAA 6/13/2018 15:08:34'!
numberOfCalls
	^numberOfCalls! !


!MerchantInterfaceSimulator methodsFor: 'behavior' stamp: 'GAA 6/13/2018 14:43:12'!
checkOut! !

!MerchantInterfaceSimulator methodsFor: 'behavior' stamp: 'GAA 6/13/2018 14:52:54'!
insufficientFunds
	self error: self class insufficientFundsErrorMessage.! !

!MerchantInterfaceSimulator methodsFor: 'behavior' stamp: 'GAA 6/13/2018 14:47:45'!
stolenCard
	self error: self class stolenCardErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantInterfaceSimulator class' category: #TusLibros!
MerchantInterfaceSimulator class
	instanceVariableNames: ''!

!MerchantInterfaceSimulator class methodsFor: 'instance creation' stamp: 'GAA 6/13/2018 15:04:30'!
withBehavior: aSymbolMessage
	^self new initializeWithBehavior: aSymbolMessage.! !


!MerchantInterfaceSimulator class methodsFor: 'error handling' stamp: 'GAA 6/13/2018 14:54:44'!
insufficientFundsErrorMessage
	^'This credit card funds are insufficient to make the purchase'.! !

!MerchantInterfaceSimulator class methodsFor: 'error handling' stamp: 'GAA 6/13/2018 14:48:38'!
stolenCardErrorMessage
	^'This Credit Card is stolen'.! !


!classDefinition: #MonthOfYear category: #TusLibros!
Object subclass: #MonthOfYear
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MonthOfYear class' category: #TusLibros!
MonthOfYear class
	instanceVariableNames: ''!

!MonthOfYear class methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:34'!
of: aDate 
	self shouldBeImplemented.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'GAA 6/11/2018 19:04:18'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !
