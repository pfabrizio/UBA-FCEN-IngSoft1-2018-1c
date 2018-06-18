!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:16:19'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:16:35'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:16:46'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:17:00'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:17:13'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:17:23'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:17:32'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:17:42'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'PGF 6/18/2018 16:17:48'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:19:36'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:19:58'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:20:21'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:20:43'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:21:09'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'PGF 6/18/2018 16:21:36'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'PGF 6/18/2018 16:21:45'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'PGF 6/18/2018 16:21:52'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: #TusLibros!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory market'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:24:41'!
test01RestInterfaceWhenSuccessfullReturnsCartID
	| rest carritoId |
	rest _ RestInterface newFor: market.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	self assert: carritoId isInteger.! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:24:58'!
test02CanNotCreateCartIDWithInvalidUsername
	| rest carritoId |
	rest _ RestInterface newFor: market.
	self
		should: [
			carritoId _ rest
				createCartForId: testObjectsFactory invalidUserPasswordOfTheStore
				password: testObjectsFactory validUserPasswordOfTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Authentication invalidUserOrPasswordErrorMessage.
			self deny: carritoId isInteger ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:25:17'!
test03CanNotCreateCartIDWithInvalidUserPassword
	| rest carritoId |
	rest _ RestInterface newFor: market.
	self
		should: [
			carritoId _ rest
				createCartForId: testObjectsFactory validUserOfTheStore
				password: testObjectsFactory invalidUserPasswordOfTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Authentication invalidUserOrPasswordErrorMessage.
			self deny: carritoId isInteger ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:25:39'!
test04CanNotAddToCartWithInvalidCartId
	| rest carritoId |
	rest _ RestInterface newFor: market.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	self
		should: [
			rest
				addToCart: 999
				book: testObjectsFactory itemSellByTheStore
				withQuantity: 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Store invalidCartIdErrorMessage.
			self deny: carritoId = 999 ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:25:58'!
test05CanNotAddToCartWithAnItemNotInCatalog
	| rest carritoId |
	rest _ RestInterface newFor: market.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	self
		should: [
			rest
				addToCart: carritoId
				book: testObjectsFactory itemNotSellByTheStore
				withQuantity: 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Cart invalidItemErrorMessage ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:26:17'!
test06CanNotAddToCartWithInvalidItemQuantity
	| rest carritoId |
	rest _ RestInterface newFor: market.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	self
		should: [
			rest
				addToCart: carritoId
				book: testObjectsFactory itemSellByTheStore
				withQuantity: 0 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Cart invalidQuantityErrorMessage ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:26:43'!
test07CanNotAddToCartAfter30MinutesWithoutOperationsOnCart
	| rest carritoId reloj |
	rest _ RestInterface newFor: market.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	reloj _ Time now.
	market
		setTimestamp:
			(Time
				hour: reloj hour - 1
				minute: 0
				second: 0)
		forCart: carritoId.
	self
		should: [
			rest
				addToCart: carritoId
				book: testObjectsFactory itemSellByTheStore
				withQuantity: 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Store cartTimeOutErrorMessage ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:32:27'!
test08WhenConsultItemsForInvalidCartIdShouldRiseError
	| rest carritoId |
	rest _ RestInterface newFor: market.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	self
		should: [ rest listCart: 999 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: Store invalidCartIdErrorMessage.
			self deny: carritoId = 999 ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:33:29'!
test09WhenConsultItemsForAnExistingCartThenGetTheItemsOfThatCart
	| rest carritoId listaItemsEnCarrito |
	rest _ RestInterface newFor: market.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	rest
		addToCart: carritoId
		book: testObjectsFactory itemSellByTheStore
		withQuantity: 1.
	listaItemsEnCarrito _ rest listCart: carritoId.
	self deny: listaItemsEnCarrito isEmpty.
	self
		assert: (listaItemsEnCarrito at: 1)
		equals: testObjectsFactory itemSellByTheStore.
	self
		assert: (listaItemsEnCarrito at: 2)
		equals: 1.! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:37:35'!
test10WhenCheckoutValidCartWithValidCreditCardThenListOfPurchasesIsEqualToTheListOfItemsOfTheCart
	| rest carritoId today listaItemsEnCarrito |
	rest _ RestInterface newFor: market.
	today _ DateAndTime now.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	rest
		addToCart: carritoId
		book: testObjectsFactory itemSellByTheStore
		withQuantity: 1.
	listaItemsEnCarrito _ rest listCart: carritoId.
	rest
		checkOutCart: carritoId
		creditCardNumber: 10001
		creditCardExpirationDate:
			(Month
				month: today monthIndex
				year: today yearNumber + 1)
		creditCardOwner: testObjectsFactory validUserOfTheStore.
	self
		assert: (rest listPurchases: testObjectsFactory validUserOfTheStore)
		equals: listaItemsEnCarrito.! !


!RestInterfaceTest methodsFor: 'setup' stamp: 'PGF 6/18/2018 16:24:14'!
setUp
	testObjectsFactory _ StoreTestObjectsFactory new.
	market _ Store newWithCatalog: testObjectsFactory defaultCatalog authentication: (Authentication newWith: testObjectsFactory defaultUserPasswordDictionary).! !


!classDefinition: #Authentication category: #TusLibros!
Object subclass: #Authentication
	instanceVariableNames: 'users'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Authentication methodsFor: 'initialization' stamp: 'PGF 6/18/2018 16:05:00'!
initializeWith: aUserList 
	users _ aUserList.! !


!Authentication methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:04:53'!
auth: anUser withPassword: aPassword 
	|password|
	password _ users at: anUser ifAbsent: [self invalidUserOrPassword].
	password = aPassword ifFalse: [self invalidUserOrPassword].! !


!Authentication methodsFor: 'error handling' stamp: 'PGF 6/18/2018 16:05:09'!
invalidUserOrPassword
	self error: self class invalidUserOrPasswordErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Authentication class' category: #TusLibros!
Authentication class
	instanceVariableNames: ''!

!Authentication class methodsFor: 'instance creation' stamp: 'GAA 6/14/2018 21:20:41'!
newWith: aUserList 
	^self new initializeWith: aUserList.! !


!Authentication class methodsFor: 'error handling' stamp: 'GAA 6/14/2018 21:36:47'!
invalidUserOrPasswordErrorMessage
	^'Combinación de usuario y password inválidos.'.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'PGF 6/18/2018 16:15:01'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'PGF 6/18/2018 16:15:06'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'PGF 6/18/2018 16:15:14'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'PGF 6/18/2018 16:15:21'!
occurrencesOf: anItem
	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:15:27'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:15:33'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'PGF 6/18/2018 16:15:40'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'PGF 6/18/2018 16:14:35'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'PGF 6/18/2018 16:14:45'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:15:54'!
itemList
	^items 
		inject: Dictionary new
		into: [:dict :elem | 
				dict 
					at: elem put: (items occurrencesOf: elem)
					; yourself.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error handling' stamp: 'GAA 6/15/2018 13:46:31'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error handling' stamp: 'GAA 6/15/2018 13:59:31'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'PGF 6/18/2018 16:18:02'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'PGF 6/18/2018 16:18:13'!
createSale
	^ Sale of: total.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'PGF 6/18/2018 16:18:23'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'PGF 6/18/2018 16:18:28'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'PGF 6/18/2018 16:18:40'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'PGF 6/18/2018 16:18:54'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'PGF 6/18/2018 16:22:27'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'PGF 6/18/2018 16:22:19'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'users store'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:22:38'!
addToCart: aCartId book: aBookISBN withQuantity: aQuantity 
	store addToCart: aCartId book: aBookISBN withQuantity: aQuantity.! !

!RestInterface methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:22:43'!
checkOutCart: aCartId creditCardNumber: aCreditCardId creditCardExpirationDate: aMonth creditCardOwner: aUser
	^store checkOutCart: aCartId creditCardNumber: aCreditCardId creditCardExpirationDate: aMonth creditCardOwner: aUser.! !

!RestInterface methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:22:47'!
createCartForId: aUser password: aPassword
	^ store createCartForUser: aUser password: aPassword.! !

!RestInterface methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:23:00'!
listCart: aCartId 
	| itemList |
	itemList _ store itemListFromCart: aCartId.
	^itemList keys
		inject: OrderedCollection new 
		into: [:resList :key | 
				resList 
					addLast: key 
					; addLast: (itemList at: key)
					; yourself .]
	! !

!RestInterface methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:23:12'!
listPurchases: anUser
	| itemList |
	itemList _ store listPurchases: anUser.
	^itemList keys
		inject: OrderedCollection new 
		into: [:resList :key | 
				resList 
					addLast: key 
					; addLast: (itemList at: key)
					; yourself .]! !


!RestInterface methodsFor: 'initialize' stamp: 'PGF 6/18/2018 16:23:36'!
initializeWith: aStore
	store _ aStore.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'GAA 6/14/2018 21:26:38'!
newFor: aXXXX 
	^self new initializeWith: aXXXX.! !


!RestInterface class methodsFor: 'error handling' stamp: 'GAA 6/14/2018 20:30:26'!
invalidCartIdErrorMessage
	^'El número de carrito es inválido'.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'PGF 6/18/2018 16:37:56'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'PGF 6/18/2018 16:37:49'!
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


!classDefinition: #Store category: #TusLibros!
Object subclass: #Store
	instanceVariableNames: 'authentication catalog carts userPurchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'initialization' stamp: 'PGF 6/18/2018 16:40:05'!
initializeWithCatalog: aCatalog authentication: anAuthentication
	catalog _ aCatalog.
	authentication _ anAuthentication.
	carts _ Dictionary new.
	userPurchases _ Dictionary new.! !


!Store methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:38:07'!
addToCart: aCartId book: aBookISBN withQuantity: aQuantity
	| carrito |
	carrito _ self assertCartValidity: aCartId.
	carrito add: aQuantity of: aBookISBN.! !

!Store methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:38:23'!
checkOutCart: aCartId creditCardNumber: aCreditCardId creditCardExpirationDate: aMonth creditCardOwner: aUser
	| carrito cashier creditCard |
	carrito _ self assertCartValidity: aCartId.
	creditCard _ CreditCard expiringOn: aMonth .
	cashier _ Cashier
		toCheckout: carrito 
		charging: creditCard
		throught: CashierTest new setUp
		on: DateAndTime now
		registeringOn: OrderedCollection new.
	cashier checkOut.
	self updateUserPurchases: aCartId.! !

!Store methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:38:35'!
createCartForUser: anUser password: aPassword
	| entry |
	authentication auth:anUser withPassword: aPassword.
	entry _ Dictionary new.
	entry add: #cart -> (Cart acceptingItemsOf: catalog).
	entry add: #timestamp -> Time now.
	entry add: #user -> anUser.
	carts at: 1 put: entry.
	^1.! !

!Store methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:38:45'!
itemListFromCart: aCartId
	| carrito |
	carrito _ self assertCartValidity: aCartId.
	^ carrito itemList.! !

!Store methodsFor: 'accessing' stamp: 'PGF 6/18/2018 16:38:50'!
listPurchases: anUser
	^(userPurchases at: anUser) copy.! !


!Store methodsFor: 'private' stamp: 'PGF 6/18/2018 16:39:20'!
cartTimeOut
	^Duration minutes: 30.! !

!Store methodsFor: 'private' stamp: 'PGF 6/18/2018 16:39:25'!
setTimestamp: aTime forCart: aCartId 
	(carts at: aCartId ) at:#timestamp put: aTime.! !

!Store methodsFor: 'private' stamp: 'PGF 6/18/2018 16:39:49'!
updateUserPurchases: aCartId
	| carrito compras itemsEnCarrito usuario |
	carrito _ self assertCartValidity: aCartId.
	usuario _ (carts at: aCartId ) at: #user.
	compras _ userPurchases at: usuario ifAbsent: [Dictionary new].
	itemsEnCarrito _ carrito itemList.
	itemsEnCarrito keys
		inject: compras 
		into: [:purchases :elem | 
			| cantidadItem |
			cantidadItem _  itemsEnCarrito at: elem.
			purchases at: elem 
				ifPresent: [:number | purchases at: elem put: number + cantidadItem .	] 
				ifAbsent: [purchases at: elem put: cantidadItem.] 
			].
	userPurchases at: usuario put: compras.! !


!Store methodsFor: 'assertions' stamp: 'PGF 6/18/2018 16:39:13'!
assertCartValidity: aCartId
	| cartEntry tiempoDesdeUltimaOperacion |
	cartEntry _ carts
		at: aCartId
		ifAbsent: [ self error: self class invalidCartIdErrorMessage ].
	tiempoDesdeUltimaOperacion _ Time now - (cartEntry at: #timestamp).
	tiempoDesdeUltimaOperacion < self cartTimeOut ifFalse: [
		carts removeKey: aCartId.
		self error: self class cartTimeOutErrorMessage ].
	cartEntry at: #timestamp put: Time now.
	^ cartEntry at: #cart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: #TusLibros!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'instance creation' stamp: 'GAA 6/14/2018 21:23:12'!
newWithCatalog: aCatalog authentication: anAuthentication 
	^self new initializeWithCatalog: aCatalog authentication: anAuthentication.! !


!Store class methodsFor: 'error handling' stamp: 'GAA 6/18/2018 13:38:47'!
cartTimeOutErrorMessage
	^'El carrito al que se quiere accceder ya no existe.'! !

!Store class methodsFor: 'error handling' stamp: 'GAA 6/15/2018 12:06:21'!
invalidCartIdErrorMessage
	^'El número de carrito es inválido'.! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PGF 6/18/2018 16:40:37'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PGF 6/18/2018 16:40:42'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'PGF 6/18/2018 16:40:48'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'PGF 6/18/2018 16:40:21'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'PGF 6/18/2018 16:40:30'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'PGF 6/18/2018 16:40:56'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'PGF 6/18/2018 16:41:01'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'PGF 6/18/2018 16:41:08'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'PGF 6/18/2018 16:41:15'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'PGF 6/18/2018 16:41:23'!
defaultUserPasswordDictionary
	^ Dictionary new
		
			at: self validUserOfTheStore
			put: self validUserPasswordOfTheStore;
		yourself.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'PGF 6/18/2018 16:41:27'!
invalidUserOfTheStore
	^#pablo.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'PGF 6/18/2018 16:41:32'!
invalidUserPasswordOfTheStore
	^ 124.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'PGF 6/18/2018 16:41:37'!
validUserOfTheStore
	^#pepe.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'PGF 6/18/2018 16:41:41'!
validUserPasswordOfTheStore
	^ 123.! !
