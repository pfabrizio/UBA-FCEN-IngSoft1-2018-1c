!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'GAA 6/15/2018 13:47:03'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'GAA 6/15/2018 13:58:55'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'GAA 6/15/2018 13:47:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
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
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
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

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
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

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
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

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
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

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
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

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
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


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: #TusLibros!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory xxxx'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'testing' stamp: 'GAA 6/16/2018 16:05:30'!
setUp
	testObjectsFactory := StoreTestObjectsFactory new.
	xxxx _ XXXX 
		newWithCatalog: testObjectsFactory defaultCatalog 
		authentication: (Authentication newWith: testObjectsFactory defaultUserPasswordDictionary).! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'GAA 6/16/2018 15:43:14'!
test01RestInterfaceWhenSuccessfullReturnsCartID
	| rest carritoId |
	rest _ RestInterface newFor: xxxx.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	self assert: carritoId isInteger.! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'GAA 6/16/2018 16:04:30'!
test02CanNotCreateCartIDWithInvalidUsername
	| rest carritoId |
	rest _ RestInterface newFor: xxxx.
	self
		should: [
			carritoId _ rest
				createCartForId: testObjectsFactory invalidUserPasswordOfTheStore 
				password: testObjectsFactory validUserPasswordOfTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: error messageText equals: Authentication invalidUserOrPasswordErrorMessage.
			self deny: carritoId isInteger ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'GAA 6/16/2018 16:04:20'!
test03CanNotCreateCartIDWithInvalidUserPassword
	| rest carritoId |
	rest _ RestInterface newFor: xxxx.
	self
		should: [
			carritoId _ rest
				createCartForId: testObjectsFactory validUserOfTheStore 
				password: testObjectsFactory invalidUserPasswordOfTheStore]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: error messageText equals: Authentication invalidUserOrPasswordErrorMessage.
			self deny: carritoId isInteger ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'GAA 6/16/2018 16:04:07'!
test04CanNotAddToCartWithInvalidCartId
	| rest carritoId |
	rest _ RestInterface newFor: xxxx.
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
			self assert: error messageText equals: XXXX invalidCartIdErrorMessage.
			self deny: carritoId = 999.].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'GAA 6/16/2018 16:03:50'!
test05CanNotAddToCartWithAnItemNotInCatalog
	| rest carritoId |
	rest _ RestInterface newFor: xxxx.
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
			self assert: error messageText equals: Cart invalidItemErrorMessage ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'GAA 6/16/2018 16:03:39'!
test06CanNotAddToCartWithInvalidItemQuantity
	| rest carritoId |
	rest _ RestInterface newFor: xxxx.
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
			self assert: error messageText equals: Cart invalidQuantityErrorMessage ].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'GAA 6/16/2018 15:56:51'!
test07
	| rest carritoId |
	rest _ RestInterface newFor: xxxx.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	self 
		should: [rest listCart: 999.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText equals: XXXX invalidCartIdErrorMessage.
			self deny: carritoId = 999.]! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'GAA 6/16/2018 16:03:15'!
test08
	| rest carritoId listaItemsEnCarrito |
	rest _ RestInterface newFor: xxxx.
	carritoId _ rest
		createCartForId: testObjectsFactory validUserOfTheStore
		password: testObjectsFactory validUserPasswordOfTheStore.
	rest
		addToCart: carritoId
		book: testObjectsFactory itemSellByTheStore
		withQuantity: 1.
	listaItemsEnCarrito _ rest listCart: carritoId.
	
	self deny: listaItemsEnCarrito isEmpty.
	self assert: (listaItemsEnCarrito at: 1) equals: testObjectsFactory itemSellByTheStore.
	self assert: (listaItemsEnCarrito at: 2) equals: 1.! !


!classDefinition: #Authentication category: #TusLibros!
Object subclass: #Authentication
	instanceVariableNames: 'users'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Authentication methodsFor: 'initialization' stamp: 'GAA 6/14/2018 21:21:56'!
initializeWith: aUserList 
	users _ aUserList.! !


!Authentication methodsFor: 'accessing' stamp: 'GAA 6/14/2018 21:32:44'!
auth: anUser withPassword: aPassword 
	|password|
	password _ users at: anUser ifAbsent: [self invalidUserOrPassword].
	password = aPassword ifFalse: [self invalidUserOrPassword].! !


!Authentication methodsFor: 'error handling' stamp: 'GAA 6/14/2018 21:36:13'!
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


!Cart methodsFor: 'assertions' stamp: 'GAA 6/15/2018 13:46:53'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'GAA 6/15/2018 13:59:17'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'GAA 6/16/2018 15:18:41'!
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

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
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

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
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


!RestInterface methodsFor: 'accessing' stamp: 'GAA 6/15/2018 12:04:34'!
addToCart: aCartId book: aBookISBN withQuantity: aQuantity 
	store addToCart: aCartId book: aBookISBN withQuantity: aQuantity.! !

!RestInterface methodsFor: 'accessing' stamp: 'GAA 6/14/2018 21:33:15'!
createCartForId: aUser password: aPassword
	^ store createCartForUser: aUser password: aPassword.! !

!RestInterface methodsFor: 'accessing' stamp: 'GAA 6/16/2018 15:17:52'!
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


!RestInterface methodsFor: 'initialize' stamp: 'GAA 6/14/2018 21:27:22'!
initializeWith: aXXXX 
	store _ aXXXX.! !

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

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
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

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'GAA 6/16/2018 15:42:00'!
defaultUserPasswordDictionary
	^ Dictionary new
		
			at: self validUserOfTheStore
			put: self validUserPasswordOfTheStore;
		yourself.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'GAA 6/16/2018 15:40:04'!
invalidUserOfTheStore
	^#pablo.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'GAA 6/16/2018 15:41:45'!
invalidUserPasswordOfTheStore
	^ 124.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'GAA 6/16/2018 15:38:01'!
validUserOfTheStore
	^#pepe.! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'GAA 6/16/2018 15:42:00'!
validUserPasswordOfTheStore
	^ 123.! !


!classDefinition: #XXXX category: #TusLibros!
Object subclass: #XXXX
	instanceVariableNames: 'authentication catalog carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!XXXX methodsFor: 'initialization' stamp: 'GAA 6/15/2018 13:51:42'!
initializeWithCatalog: aCatalog authentication: anAuthentication
	catalog _ aCatalog.
	authentication _ anAuthentication.
	carts _ Dictionary new.! !


!XXXX methodsFor: 'accessing' stamp: 'GAA 6/15/2018 13:54:39'!
addToCart: aCartId book: aBookISBN withQuantity: aQuantity
	| carrito |
	carrito _ carts at: aCartId ifAbsent: [self error: self class invalidCartIdErrorMessage.].
	carrito add: aQuantity of: aBookISBN.! !

!XXXX methodsFor: 'accessing' stamp: 'GAA 6/15/2018 13:50:57'!
createCartForUser: anUser password: aPassword
	authentication auth:anUser withPassword: aPassword.
	carts at: 1 put:(Cart acceptingItemsOf: catalog).
	^1.! !

!XXXX methodsFor: 'accessing' stamp: 'GAA 6/16/2018 15:08:51'!
itemListFromCart: aCartId 
	| carrito |
	carrito _ carts at: aCartId ifAbsent: [self error: self class invalidCartIdErrorMessage.].
	^carrito itemList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXXX class' category: #TusLibros!
XXXX class
	instanceVariableNames: ''!

!XXXX class methodsFor: 'instance creation' stamp: 'GAA 6/14/2018 21:23:12'!
newWithCatalog: aCatalog authentication: anAuthentication 
	^self new initializeWithCatalog: aCatalog authentication: anAuthentication.! !


!XXXX class methodsFor: 'error handling' stamp: 'GAA 6/15/2018 12:06:21'!
invalidCartIdErrorMessage
	^'El número de carrito es inválido'.! !
