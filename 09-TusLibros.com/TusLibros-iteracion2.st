!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'cashier cart creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'PGF 6/7/2018 20:30:53'!
aValidItem
	^#ABook.! !

!CashierTest methodsFor: 'support' stamp: 'PGF 6/7/2018 19:03:58'!
creditCard
	^CreditCard newWithId: 22222 validFrom: (May of: 2012) goodThru: (May of: 2022).! !

!CashierTest methodsFor: 'support' stamp: 'PGF 6/7/2018 21:21:59'!
creditCardInvalid
	| validFrom validTo todayMonth |
	todayMonth _ FixedGregorianDate today monthOfYear.
	validFrom _  GregorianMonthOfYear yearNumber: (todayMonth year number - 2) month: todayMonth month. 
	validTo _ GregorianMonthOfYear yearNumber: (todayMonth year number - 1) month: todayMonth month. 
	
	^CreditCard newWithId: 22222 validFrom: validFrom goodThru: validTo.! !

!CashierTest methodsFor: 'support' stamp: 'PGF 6/7/2018 21:22:10'!
creditCardValid
	| validFrom validTo todayMonth |
	todayMonth _ FixedGregorianDate today monthOfYear.
	validFrom _ GregorianMonthOfYear yearNumber: (todayMonth year number - 1) month: todayMonth month. 
	validTo _ GregorianMonthOfYear yearNumber: (todayMonth year number + 1) month: todayMonth month. 
	
	^CreditCard newWithId: 22223 validFrom: validFrom goodThru: validTo.! !

!CashierTest methodsFor: 'support' stamp: 'PGF 6/7/2018 20:29:37'!
initializeCartWithDefaultCatalog
	cart _ Cart acceptingItemsOf: self priceList keys.! !

!CashierTest methodsFor: 'support' stamp: 'PGF 6/7/2018 20:26:01'!
initializeCashierWithDefaultPriceList
	cashier _ Cashier withPriceList: self priceList.! !

!CashierTest methodsFor: 'support' stamp: 'PGF 6/7/2018 20:48:24'!
priceList
	|diccionario|
	diccionario _ Dictionary new.
	diccionario at: #ABook put: 100.
	^PriceList newWith: diccionario.! !


!CashierTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 21:03:59'!
test01CashierWhenCheckoutEmptyCartThenThrowsEmptyCartErrorMessage
	self initializeCashierWithDefaultPriceList.
	self initializeCartWithDefaultCatalog.
	creditCard _ self creditCard.
	
	self 
		should: [ cashier checkout: cart payingWith: creditCard. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier emptyCartErrorMessage.
			"self assert: cart isEmpty" ]! !

!CashierTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 21:04:57'!
test02CashierWhenCheckOutWIthInvalidCreditCardForDateThenThrowInvalidDateCreditCardErrorMessage
	self initializeCashierWithDefaultPriceList.
	self initializeCartWithDefaultCatalog.
	cart add: self aValidItem.
	creditCard _ self creditCardInvalid.
	self
		should: [
			cashier
				checkout: cart
				payingWith: creditCard
				]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: Cashier invalidDateCreditCardErrorMessage ].! !

!CashierTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 21:05:20'!
test03CashierCheckoutAvalidCartAndAValidCreditCardDebitsTheTotalPriceOfTheCartItems
	self initializeCashierWithDefaultPriceList.
	self initializeCartWithDefaultCatalog.
	cart add: self aValidItem.
	creditCard _ self creditCardValid.
	self
		assert:
			(cashier
				checkout: cart
				payingWith: creditCard)
		equals: (self priceList at: self aValidItem).! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

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


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'PGF 6/7/2018 20:13:41'!
contents
	^items copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'accessing' stamp: 'PGF 6/7/2018 21:02:41'!
checkout: aCart payingWith: aCreditCard 
	|totalAmount|
	aCart isEmpty ifTrue: [ self error: self class emptyCartErrorMessage ].
	self assertCreditCardValid: aCreditCard.
     totalAmount _ aCart contents inject: 0 into: [:total :anItem | total + (priceList at: anItem) ].
	self debit: totalAmount from: aCreditCard.
	^totalAmount.! !

!Cashier methodsFor: 'accessing' stamp: 'PGF 6/7/2018 20:22:34'!
debit: anAmount from: aCreditCard
! !


!Cashier methodsFor: 'initialization' stamp: 'PGF 6/7/2018 19:56:56'!
withPriceList: aPriceList
	priceList _ aPriceList.! !


!Cashier methodsFor: 'checking private' stamp: 'PGF 6/7/2018 21:14:48'!
assertCreditCardValid: aCreditCard  
	(FixedGregorianDate today monthOfYear between: aCreditCard validFrom and: aCreditCard validTo ) ifFalse:[self error: self class invalidDateCreditCardErrorMessage .].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error handling' stamp: 'PGF 6/7/2018 19:10:09'!
emptyCartErrorMessage
	^'No se puede hacer checkout de un carrito vacio.'! !

!Cashier class methodsFor: 'error handling' stamp: 'PGF 6/7/2018 19:47:55'!
invalidDateCreditCardErrorMessage
	^ 'Tarjeta de credito invalida para la fecha indicada.'.! !


!Cashier class methodsFor: 'class initialization' stamp: 'PGF 6/7/2018 19:56:08'!
withPriceList: aPriceList
	^self new withPriceList: aPriceList.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'id validFrom goodThru'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'PGF 6/7/2018 19:07:40'!
newWithId: aId validFrom: aMonthOfYearFrom goodThru: aMonthOfYearTo
	id _ aId.
	validFrom _ aMonthOfYearFrom .
	goodThru _ aMonthOfYearTo .! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'PGF 6/7/2018 20:09:40'!
validFrom
	^validFrom copy.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'PGF 6/7/2018 20:09:56'!
validTo
	^goodThru copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'initialization' stamp: 'PGF 6/7/2018 19:06:24'!
newWithId: aId validFrom: aMonthOfYearFrom goodThru: aMonthOfYearTo
	^self new newWithId: aId validFrom: aMonthOfYearFrom goodThru: aMonthOfYearTo.! !


!classDefinition: #PriceList category: #TusLibros!
Object subclass: #PriceList
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PriceList methodsFor: 'initialization' stamp: 'PGF 6/7/2018 20:44:41'!
newWith: aDictionary
	items _ aDictionary.! !


!PriceList methodsFor: 'accessing' stamp: 'PGF 6/7/2018 20:45:42'!
at: anItem
	^items at: anItem.! !

!PriceList methodsFor: 'accessing' stamp: 'PGF 6/7/2018 20:47:38'!
keys
	^items keys.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PriceList class' category: #TusLibros!
PriceList class
	instanceVariableNames: ''!

!PriceList class methodsFor: 'instance creation' stamp: 'PGF 6/7/2018 20:44:07'!
newWith: aDictionary
	^self new newWith: aDictionary.! !
