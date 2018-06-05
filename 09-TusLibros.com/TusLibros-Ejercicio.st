!classDefinition: #TusLibrosTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/4/2018 21:11:29'!
test01NewCartIsEmpty
	
	| cart |
	cart _ Cart new.
	self assert: cart isEmpty.
           ! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/4/2018 21:15:01'!
test02CartIsNotEmptyWhenAnElementIsAdded
     | cart |
	cart _ Cart new.
	cart add: #ABook.
	self deny: cart isEmpty.
           ! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/4/2018 21:21:18'!
test03CartIsEmptyWhenABookIsAddedAndRemoved
     | cart |
	cart _ Cart new.
	cart add: #ABook.
	cart remove: #ABook.
	self assert: cart isEmpty.
           ! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/4/2018 21:28:31'!
test04CartSizeIs2WhenTwoBooksAreAdded
	| cart |
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook2.
	self assert: cart size equals: 2.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/4/2018 21:29:49'!
test05CartIsEmptyWhenRemoveAllBooks
	| cart |
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook2.
	cart removeAll.
	self assert: cart isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/4/2018 21:35:21'!
test06CartIncludeAnAddedBook
	| cart |
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook2.
	self assert: (cart includes: #ABook).
	self assert: (cart includes: #ABook2).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/4/2018 21:40:10'!
test07CartIsTheSameWhenRemoveANotAddedBook
	| cart |
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook2.
	cart remove: #ABook3.
	self assert: (cart includes: #ABook).
	self assert: (cart includes: #ABook2).
	self assert: cart size equals: 2.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PGF 6/4/2018 21:48:58'!
test08CartContentIsEqualToTheAddedBooks
	| cart books |
	cart _ Cart new.
	cart add: #ABook.
	cart add: #ABook2.
	books _ cart contents.
	self assert: (books includes: #ABook).
	self assert: (books includes: #ABook2).
	self assert: books size equals: 2.
! !


!classDefinition: #Cart category: #'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'accessing' stamp: 'PGF 6/4/2018 21:18:11'!
add: aBook 
	books add: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/4/2018 21:49:22'!
contents
	^books copy.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/4/2018 21:35:21'!
includes: aBook
	^ books includes: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/4/2018 21:19:44'!
isEmpty
	^books isEmpty.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/4/2018 21:41:57'!
remove: aBook 
	(self includes: aBook) ifTrue: [ books remove: aBook. ].! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/4/2018 21:30:07'!
removeAll
	books removeAll.! !

!Cart methodsFor: 'accessing' stamp: 'PGF 6/4/2018 21:27:44'!
size
	^books size.! !


!Cart methodsFor: 'initialization' stamp: 'PGF 6/4/2018 21:19:16'!
initialize
	books _ OrderedCollection new.! !


!classDefinition: #XXXX category: #'TusLibros-Ejercicio'!
Object subclass: #XXXX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!
