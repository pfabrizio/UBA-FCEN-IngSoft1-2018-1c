!classDefinition: #TusLibrosTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 15:52:33'!
test01NewCartIsEmpty

	cart _ Cart new.
	self assert: cart isEmpty.
           ! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 15:52:51'!
test02CartIsNotEmptyWhenAnElementIsAdded
	cart _ Cart new.
	cart add: #ABook.
	self deny: cart isEmpty.
           ! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 15:53:00'!
test03CartIsEmptyWhenABookIsAddedAndRemoved
	cart _ Cart new.
	cart add: #ABook.
	cart remove: #ABook.
	self assert: cart isEmpty.
           ! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 15:53:15'!
test04CartSizeIs2WhenTwoBooksAreAdded
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook2.
	self assert: cart size equals: 2.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 15:53:31'!
test05CartIsEmptyWhenRemoveAllBooks
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook2.
	cart removeAll.
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 15:53:47'!
test06CartIncludeAnAddedBook
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook2.
	self assert: (cart includes: #ABook).
	self assert: (cart includes: #ABook2).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 15:54:05'!
test07CartIsTheSameWhenRemoveANotAddedBook
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook2.
	cart remove: #ABook3.
	self assert: (cart includes: #ABook).
	self assert: (cart includes: #ABook2).
	self assert: cart size equals: 2.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 15:54:29'!
test08CartContentIsEqualToTheAddedBooks
	| books |
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook2.
	books _ cart contents.
	self assert: (books includes: #ABook).
	self assert: (books includes: #ABook2).
	self assert: books size equals: 2.
! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 15:54:39'!
test09CartShouldRaiseErrorWithItemNotInCatalog
	cart _ Cart new.
	self should: [cart add: #NotABook.]
	  	  raise: Error - MessageNotUnderstood 
		  withExceptionDo: [:anError |	self assert: anError messageText equals: Cart notInCatalogErrorMessage.].
! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/7/2018 16:02:20'!
test10WhenAddedTwoIdenticalBookThenThatBookQuantityInCartIs2
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook.
	cart add: #ABook2.

	self assert: (cart productQuantity: #ABook) equals: 2.! !


!classDefinition: #Cart category: #'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'accessing' stamp: 'PGF 6/7/2018 16:03:11'!
add: aBook
	catalog detect: [:anItem | anItem = aBook] ifNone: [self error: self class notInCatalogErrorMessage]. 
	books add: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/7/2018 16:03:16'!
contents
	^books copy.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/7/2018 16:03:21'!
includes: aBook
	^ books includes: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/7/2018 16:03:25'!
isEmpty
	^books isEmpty.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/7/2018 16:00:10'!
productQuantity: aProduct
	|quantity|
	quantity _ 0.
	books do: [:anElement | anElement = aProduct ifTrue: [ quantity _ quantity + 1.]].
	^quantity.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/7/2018 16:03:31'!
remove: aBook 
	(self includes: aBook) ifTrue: [ books remove: aBook. ].! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/7/2018 16:03:34'!
removeAll
	books removeAll.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/7/2018 15:57:15'!
size
	^books size.! !


!Cart methodsFor: 'initialization' stamp: 'PGF 6/7/2018 16:03:48'!
initialize
	books _ OrderedCollection new.
	catalog _ #(#ABook #ABook2).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'exceptions' stamp: 'GAA 6/7/2018 13:21:34'!
notInCatalogErrorMessage
	^ 'Item not in catalog'.! !
