!classDefinition: #TicTacToeObserverTest category: #TicTacToe!
TestCase subclass: #TicTacToeObserverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 5/31/2018 19:31:52'!
test01
    | console game |
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game addObserver: console.
	
     self assert: console log isEmpty.! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 5/31/2018 19:59:41'!
test02
    | console game |
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game addObserver: console.
	
	game markWithXAt: 1@1.
	
     self assert: ((console log at: 1) = 'X marcó en 1@1') .
     self assert: ((console log at: 2) = 'Estado: Jugando O').
	self assert: console log size = 2.! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 5/31/2018 20:06:00'!
test03
    | console game |
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game addObserver: console.
	
	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	
     self assert: ((console log at: 1) = 'X marcó en 1@1') .
     self assert: ((console log at: 2) = 'Estado: Jugando O').
     self assert: ((console log at: 3) = 'O marcó en 2@2') .
     self assert: ((console log at: 4) = 'Estado: Jugando X').
	self assert: console log size = 4.! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 5/31/2018 20:14:24'!
test04
    | console game |
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game addObserver: console.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@1.
	game markWithXAt: 1@3.
	game markWithOAt: 1@2.
	game markWithXAt: 3@1.
	
     self assert: ((console log at: 1) = 'X marcó en 2@2') .
     self assert: ((console log at: 2) = 'Estado: Jugando O').
     self assert: ((console log at: 3) = 'O marcó en 1@1') .
     self assert: ((console log at: 4) = 'Estado: Jugando X').
     self assert: ((console log at: 5) = 'X marcó en 1@3') .
     self assert: ((console log at: 6) = 'Estado: Jugando O').
     self assert: ((console log at: 7) = 'O marcó en 1@2') .
     self assert: ((console log at: 8) = 'Estado: Jugando X').
     self assert: ((console log at: 9) = 'X marcó en 3@1') .
     self assert: ((console log at: 10) = 'Juego terminado - Ganó X!!').
	self assert: console log size = 10.! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 5/31/2018 20:19:35'!
test05
    | console game |
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game addObserver: console.
	
	game markWithXAt: 2@2.
	game markWithOAt: 1@1.
	game markWithXAt: 3@3.
	game markWithOAt: 1@2.
	game markWithXAt: 3@1.
	game markWithOAt: 1@3.
	
     self assert: ((console log at: 1) = 'X marcó en 2@2') .
     self assert: ((console log at: 2) = 'Estado: Jugando O').
     self assert: ((console log at: 3) = 'O marcó en 1@1') .
     self assert: ((console log at: 4) = 'Estado: Jugando X').
     self assert: ((console log at: 5) = 'X marcó en 3@3') .
     self assert: ((console log at: 6) = 'Estado: Jugando O').
     self assert: ((console log at: 7) = 'O marcó en 1@2') .
     self assert: ((console log at: 8) = 'Estado: Jugando X').
     self assert: ((console log at: 9) = 'X marcó en 3@1') .
     self assert: ((console log at: 10) = 'Estado: Jugando O').
     self assert: ((console log at: 11) = 'O marcó en 1@3') .
     self assert: ((console log at: 12) = 'Juego terminado - Ganó O!!').
	self assert: console log size = 12.! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 5/31/2018 20:28:24'!
test06
    | console game logSize|
	game _ TicTacToe new.
	console _ TicTacToeConsole new.
	game addObserver: console.
	
	game markWithXAt: 1@2.
	game markWithOAt: 1@1.
	game markWithXAt: 3@3.
	game markWithOAt: 2@2.
	game markWithXAt: 3@1.
	game markWithOAt: 2@3.
	game markWithXAt: 2@1.
	game markWithOAt: 3@2.
	game markWithXAt: 1@3.
	
     self assert: ((console log at: 1) = 'X marcó en 1@2') .
     self assert: ((console log at: 2) = 'Estado: Jugando O').
     self assert: ((console log at: 3) = 'O marcó en 1@1') .
     self assert: ((console log at: 4) = 'Estado: Jugando X').
 	logSize _ console log size.
     self assert: ((console log at: logSize) = 'Juego terminado - Empate!!') .
! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 6/3/2018 20:47:55'!
test07
    | viewer game viewNewGame |
	game _ TicTacToe new.
	viewer _ TicTacToeViewer new.
	game addObserver: viewer.
	viewNewGame _ viewer newBoard.
	viewNewGame add: 'Estado: Jugando X'.
	
     self assert: viewer show  = viewNewGame.
! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 6/3/2018 20:37:20'!
test08
    | viewer game viewNewGame |
	game _ TicTacToe new.
	viewer _ TicTacToeViewer new.
	game addObserver: viewer.
	viewNewGame _ viewer newBoard.
	(viewNewGame at: 3) at: 3 put: $X.
	viewNewGame add: 'Estado: Jugando O'.

	
	game markWithXAt: 2@2.
	
     self assert: viewer show  = viewNewGame.
! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 6/3/2018 20:53:17'!
test09
    | viewer game viewNewGame |
	game _ TicTacToe new.
	viewer _ TicTacToeViewer new.
	game addObserver: viewer.
	viewNewGame _ viewer newBoard.
	(viewNewGame at: 1) at: 1 put: $X.
	(viewNewGame at: 3) at: 3 put: $O.
	viewNewGame add: 'Estado: Jugando X'.

	game markWithXAt: 1@1.
	game markWithOAt: 2@2.
	
     self assert: viewer show  = viewNewGame.
! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 6/3/2018 20:56:20'!
test10
    | viewer game viewNewGame |
	game _ TicTacToe new.
	viewer _ TicTacToeViewer new.
	game addObserver: viewer.
	viewNewGame _ viewer newBoard.
	(viewNewGame at: 3) at: 3 put: $X.
	(viewNewGame at: 1) at: 1 put: $O.
	(viewNewGame at: 1) at: 5 put: $X.
	(viewNewGame at: 1) at: 3 put: $O.
	(viewNewGame at: 5) at: 1 put: $X.
	viewNewGame add: 'Juego terminado - Ganó X!!'.

	game markWithXAt: 2@2.
	game markWithOAt: 1@1.
	game markWithXAt: 1@3.
	game markWithOAt: 1@2.
	game markWithXAt: 3@1.
	
    
     self assert: viewer show  = viewNewGame.
! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 6/3/2018 21:00:18'!
test11
    | viewer game viewNewGame |
	game _ TicTacToe new.
	viewer _ TicTacToeViewer new.
	game addObserver: viewer.
	viewNewGame _ viewer newBoard.
	(viewNewGame at: 3) at: 3 put: $X.
	(viewNewGame at: 1) at: 1 put: $O.
	(viewNewGame at: 5) at: 5 put: $X.
	(viewNewGame at: 1) at: 3 put: $O.
	(viewNewGame at: 5) at: 1 put: $X.
	(viewNewGame at: 1) at: 5 put: $O.
	viewNewGame add: 'Juego terminado - Ganó O!!'.

	game markWithXAt: 2@2.
	game markWithOAt: 1@1.
	game markWithXAt: 3@3.
	game markWithOAt: 1@2.
	game markWithXAt: 3@1.
	game markWithOAt: 1@3.
	
    
     self assert: viewer show  = viewNewGame.
! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 6/3/2018 21:01:59'!
test12
    | viewer game viewNewGame |
	game _ TicTacToe new.
	viewer _ TicTacToeViewer new.
	game addObserver: viewer.
	viewNewGame _ viewer newBoard.
	(viewNewGame at: 1) at: 3 put: $X.
	(viewNewGame at: 1) at: 1 put: $O.
	(viewNewGame at: 5) at: 5 put: $X.
	(viewNewGame at: 3) at: 3 put: $O.
	(viewNewGame at: 5) at: 1 put: $X.
	(viewNewGame at: 3) at: 5 put: $O.
	(viewNewGame at: 3) at: 1 put: $X.
	(viewNewGame at: 5) at: 3 put: $O.
	(viewNewGame at: 1) at: 5 put: $X.
	viewNewGame add: 'Juego terminado - Empate!!'.

	game markWithXAt: 1@2.
	game markWithOAt: 1@1.
	game markWithXAt: 3@3.
	game markWithOAt: 2@2.
	game markWithXAt: 3@1.
	game markWithOAt: 2@3.
	game markWithXAt: 2@1.
	game markWithOAt: 3@2.
	game markWithXAt: 1@3.
	
    
     self assert: viewer show  = viewNewGame.
! !

!TicTacToeObserverTest methodsFor: 'Testing' stamp: 'PGF 6/3/2018 21:04:07'!
test13
    | viewer game viewNewGame console |
	game _ TicTacToe new.
	viewer _ TicTacToeViewer new.
	game addObserver: viewer.
	console _ TicTacToeConsole new.
	game addObserver: console.
	
	
	viewNewGame _ viewer newBoard.
	(viewNewGame at: 3) at: 3 put: $X.
	(viewNewGame at: 1) at: 1 put: $O.
	(viewNewGame at: 1) at: 5 put: $X.
	(viewNewGame at: 1) at: 3 put: $O.
	(viewNewGame at: 5) at: 1 put: $X.
	viewNewGame add: 'Juego terminado - Ganó X!!'.

	game markWithXAt: 2@2.
	game markWithOAt: 1@1.
	game markWithXAt: 1@3.
	game markWithOAt: 1@2.
	game markWithXAt: 3@1.
	
    
     self assert: viewer show  = viewNewGame.

     self assert: ((console log at: 1) = 'X marcó en 2@2') .
     self assert: ((console log at: 2) = 'Estado: Jugando O').
     self assert: ((console log at: 3) = 'O marcó en 1@1') .
     self assert: ((console log at: 4) = 'Estado: Jugando X').
     self assert: ((console log at: 5) = 'X marcó en 1@3') .
     self assert: ((console log at: 6) = 'Estado: Jugando O').
     self assert: ((console log at: 7) = 'O marcó en 1@2') .
     self assert: ((console log at: 8) = 'Estado: Jugando X').
     self assert: ((console log at: 9) = 'X marcó en 3@1') .
     self assert: ((console log at: 10) = 'Juego terminado - Ganó X!!').
	self assert: console log size = 10.
! !


!classDefinition: #TicTacToeTest category: #TicTacToe!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/27/2017 17:25:54'!
functionalException

	^Error - MessageNotUnderstood! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 10/26/2017 15:10:54'!
test01GameStartsWithAnEmptyBoarAndPlayingX

	"I initialize it on each test and not in the setUp to facilitate the restar of the test - Hernan"
	
	game _ TicTacToe new.

	self assertXIsMarkedOn: {} andOOn: {}.
	self assertIsPlayingX.
	
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:35'!
test02AfterMarkingWithXGameKeepsMarkAndNextPlayerIsO

	game _ TicTacToe new.
	
	game markAll: {1@1}.

	self assertXIsMarkedOn: {1@1} andOOn: {}.
	self assertIsPlayingO

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:31'!
test03AfterMarkingWithOGameKeepsMarkAndNextPlayerIsY

	game _ TicTacToe new.

	game markAll: { 1 @ 1. 2 @ 2 }.

	self assertXIsMarkedOn: {1@1} andOOn: {2@2}.
	self assertIsPlayingX.

! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:28'!
test04CanNotMarkWithXWhenLastMarkWasX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException
		withExceptionDo: [ :anError |
			self assert: TicTacToe notXTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:23'!
test05CanNotMarkWithOWhenLastMarkWasO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithOAt: 3 @ 3 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe notOTurnErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:19'!
test06CanNotMarkWithXAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:16'!
test07CanNotMarkWithXAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2 }.

	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:12'!
test08CanNotMarkWithOAnAlreadyMarkedPositionWithX

	game _ TicTacToe new.
	
	game markAll: { 1@1 }.
	
	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:08'!
test09CanNotMarkWithOAnAlreadyMarkedPositionWithO

	game _ TicTacToe new.

	game markAll: {1@1. 2@2. 3@3 }.

	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionTakenErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {1@1. 3@3} andOOn: {2@2} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:43:04'!
test10XWinsWhenCompletesRowNumber1

	game _ TicTacToe new.

	game markAll: {1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self assertXWon.
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:59'!
test11XWinsWhenCompletesRowNumber2

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 3@1. 2@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:54'!
test12XWinsWhenCompletesRowNumber3

	game _ TicTacToe new.

	game markAll: {3@1. 1@1. 3@2. 2@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:50'!
test13XWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 1@1. 2@2. 1@2. 3@3. 1@3}.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:45'!
test14XWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 1@1. 1@2. 2@2. 1@3. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:41'!
test15XWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: { 1@3. 1@2. 2@2. 2@1. 3@ 1 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:35'!
test16OWinsWhenCompletesARow

	game _ TicTacToe new.

	game markAll: {2@1. 1@1. 2@2. 1@2. 3@1. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:31'!
test17OWinsWhenCompletesAColumn

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 3@3. 1@2. 2@3. 1@3 }.

	self assertOWon! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:25'!
test18OWinsWhenCompletesDiagonalGoingDown

	game _ TicTacToe new.

	game markAll: { 3@2. 1@3. 1@2. 2@2. 1@1. 3@1 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:20'!
test19OWinsWhenCompletesDiagonalGoingUp

	game _ TicTacToe new.

	game markAll: {1@2. 1@1. 1@3. 2@2. 2@1. 3@3 }.

	self assertOWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:15'!
test20OCanNotPlayWhenXWon

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markWithOAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:12'!
test21XCanNotPlayWhenOWon

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 2@1. 1@2. 3@1. 1@3 }.

	self
		should: [ game markWithXAt: 3 @ 2 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: { 2@2. 2@1. 3@1 } ]
		! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:08'!
test22GameCanEndUpTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self assertGameIsTied! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:42:01'!
test23XCanWinOnLastEmptyPosition

	game _ TicTacToe new.

	game markAll: { 2@2. 1@2. 1@1. 2@1. 1@3. 2@3. 3@2. 3@1. 3@3 }.

	self assertXWon ! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:41:58'!
test24CanNotPlayWhenGameIsTied

	game _ TicTacToe new.

	game markAll: { 2@2. 1@1. 1@3. 3@1. 2@1. 2@3. 1@2. 3@2. 3@3 }.

	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText ].! !

!TicTacToeTest methodsFor: 'testing' stamp: 'JG 5/12/2018 13:23:11'!
test25CanNotMarkOutsideBoard

	game _ TicTacToe new.

	#(0 4) do: [ :aPositionComponent |
		self assertCanNotMarkAt: aPositionComponent @ 1.
		self assertCanNotMarkAt: 1 @ aPositionComponent ].
	! !

!TicTacToeTest methodsFor: 'testing' stamp: 'HAW 5/31/2018 18:49:43'!
test26OCanNotMarkWhenGameIsOver

	game _ TicTacToe new.

	game markAll: { 1@1. 2@1. 1@2. 3@1. 1@3 }.
	
	self
		should: [ game markAt: 3 @ 1 ]
		raise: self functionalException 
		withExceptionDo: [ :anError |
			self assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage equals: anError messageText.
			self assertOIsMarkedOn: {2@1. 3@1} ].! !


!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:06'!
assertCanNotMarkAt: aPosition

	self assertCanNotMarkUsing: [ game markWithXAt: aPosition ].
	self assertCanNotMarkUsing: [ game markWithOAt: aPosition ].
	
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/27/2017 10:29:29'!
assertCanNotMarkUsing: aMarkingClosure

	self
		should: aMarkingClosure 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: TicTacToe positionOutsideBoardErrorMessage equals: anError messageText.
			self assertXIsMarkedOn: {} andOOn: {} ].! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:14'!
assertGameIsNotOver

	self deny: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:48'!
assertGameIsOver
	
	self assert: game isOver.

	self deny: game isPlayingX.
	self deny: game isPlayingO.
		
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:40:41'!
assertGameIsTied

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:13:05'!
assertIsPlayingO
	
	self deny: game isPlayingX.
	self assert: game isPlayingO.
	self assertGameIsNotOver ! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:11:05'!
assertIsPlayingX
		
	self assert: game isPlayingX.
	self deny: game isPlayingO.
	self assertGameIsNotOver.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:38:07'!
assertOIsMarkedOn: oPositions
		
	self assert: oPositions size equals: game playerOPositions size.
	self assert: (game playerOPositions difference: oPositions) isEmpty.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:32:18'!
assertOWon

	self assertGameIsOver.
	
	self deny: game hasPlayerXWon.
	self assert: game hasPlayerOWon.
	self deny: game isTied.
! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:56'!
assertXIsMarkedOn: xPositions

	self assert: xPositions size equals: game playerXPositions size.
	self assert: (game playerXPositions difference: xPositions) isEmpty.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:37:44'!
assertXIsMarkedOn: xPositions andOOn: oPositions
 
	self assertXIsMarkedOn: xPositions.
	self assertOIsMarkedOn: oPositions.
	! !

!TicTacToeTest methodsFor: 'assertions' stamp: 'HAW 10/26/2017 15:23:30'!
assertXWon
	
	self assertGameIsOver.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.
! !


!classDefinition: #TicTacToe category: #TicTacToe!
Object subclass: #TicTacToe
	instanceVariableNames: 'state playerOPositions playerXPositions observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToe methodsFor: 'initialization' stamp: 'PGF 6/3/2018 20:47:07'!
initialize
	playerXPositions _ OrderedCollection new.
	playerOPositions _ OrderedCollection new.
	observers _ OrderedCollection new.
	state _ PlayingX for: self.
	self notifyNewState: state.! !


!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:39'!
markAll: positions

	positions do: [ :aPosition | self markAt: aPosition ]! !

!TicTacToe methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:23'!
markAt: aPosition

	^state markAt: aPosition ! !

!TicTacToe methodsFor: 'marking board' stamp: 'PGF 5/31/2018 20:07:08'!
markWithOAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	self notifyMarkWithOAt: aPosition.
	
	state markWithOAt: aPosition.
	
	self notifyNewState: state.! !

!TicTacToe methodsFor: 'marking board' stamp: 'PGF 5/31/2018 19:58:24'!
markWithXAt: aPosition

	self assertIsInBoardBounds: aPosition.
	
	self notifyMarkWithXAt: aPosition.
	
	state markWithXAt: aPosition.
	
	self notifyNewState: state.
	
	! !


!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:41:25'!
add: aPosition to: positions nextPlayerState: nextPlayingState winnerState: winnerState

	positions add: aPosition.
	state := (self stateAfterAddingTo: positions with: nextPlayingState and: winnerState) for: self
	! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/25/2017 15:35:08'!
assertIsFree: aPosition

	(self isTaken: aPosition) ifTrue: [ self error: self class positionTakenErrorMessage ].
! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/27/2017 10:26:10'!
assertIsInBoardBounds: aPosition

	(aPosition between: 1@1 and: 3@3) ifFalse: [ self error: self class positionOutsideBoardErrorMessage ]! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'JG 5/12/2018 12:34:04'!
markWithOWhenPlayingOAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerOPositions
		nextPlayerState: PlayingX
		winnerState: PlayerOWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOWhenPlayingXAt: aPosition
	self error: self class notOTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXWhenPlayingOAt: aPoint
	self error: self class notXTurnErrorMessage.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXWhenPlayingXAt: aPosition
	self assertIsFree: aPosition.
	self
		add: aPosition
		to: playerXPositions
		nextPlayerState: PlayingO
		winnerState: PlayerXWon.! !

!TicTacToe methodsFor: 'marking board - private' stamp: 'HAW 10/26/2017 12:44:57'!
stateAfterAddingTo: positions with: nextPlayingState and: winnerState

	(self hasWin: positions) ifTrue: [ ^ winnerState ].
	self shouldBeTiedWhenNoOneWon ifTrue: [ ^ GameTied ].

	^ nextPlayingState.! !


!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ state hasPlayerOWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ state hasPlayerXWon.! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 13:32:14'!
isOver
	
	^state isOver! !

!TicTacToe methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:01'!
isTied
	
	^ state isTied! !


!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:38'!
isPlayingO
	
	^state isPlayingO! !

!TicTacToe methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:14'!
isPlayingX
	
	^state isPlayingX ! !


!TicTacToe methodsFor: 'testing board positions' stamp: 'HAW 10/25/2017 15:50:52'!
isTaken: aPosition
	^ (playerXPositions includes: aPosition) or: [ playerOPositions includes: aPosition ].! !


!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:16'!
playerOPositions
	^ playerOPositions copy.! !

!TicTacToe methodsFor: 'positions' stamp: 'HAW 10/25/2017 15:56:32'!
playerXPositions
	^ playerXPositions copy.! !


!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:22:42'!
has: positions threeOf: aPositionComponent

	^(positions collect: aPositionComponent) asBag contents values includes: 3 
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:09:34'!
hasCompletedColumn: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition x ]
	
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:25:55'!
hasCompletedDiagonal: positions 
	
	^(self hasUpDiagonal: positions) or: [self hasDownDiagonal: positions]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/25/2017 16:10:47'!
hasCompletedLine: positions
	
	^self has: positions threeOf: [ :aPosition | aPosition y ]
! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 5/31/2018 00:25:48'!
hasCompletedStraightLine: positions
	
	^(self hasCompletedColumn: positions) or: [self hasCompletedLine: positions ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/24/2017 17:12:48'!
hasUpDiagonal: positions
	
	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:26:17'!
hasWin: positions

	^positions size >= 3 and: [ (self hasCompletedStraightLine: positions) or: [ self hasCompletedDiagonal: positions ]].
		
	! !

!TicTacToe methodsFor: 'game over testing - private' stamp: 'HAW 10/26/2017 12:44:42'!
shouldBeTiedWhenNoOneWon

	^ playerXPositions size = 5 and: [ playerOPositions size = 4 ].! !


!TicTacToe methodsFor: 'notifications' stamp: 'PGF 5/31/2018 19:09:10'!
addObserver: anObserver
    observers add: anObserver.! !

!TicTacToe methodsFor: 'notifications' stamp: 'PGF 5/31/2018 19:12:57'!
notifyMarkWithOAt: aPosition
	observers do: [ :each |
		each notifyMarkWithOAt: aPosition ].! !

!TicTacToe methodsFor: 'notifications' stamp: 'PGF 5/31/2018 19:12:29'!
notifyMarkWithXAt: aPosition
	observers do: [ :each |
		each notifyMarkWithXAt: aPosition ].! !

!TicTacToe methodsFor: 'notifications' stamp: 'PGF 5/31/2018 19:13:30'!
notifyNewState: aState
	observers do: [ :each |
		each notifyNewState: aState ].! !

!TicTacToe methodsFor: 'notifications' stamp: 'PGF 5/31/2018 19:10:06'!
removeObserver: anObserver
    observers remove: anObserver.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #TicTacToe!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notOTurnErrorMessage
	
	^'Not O''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
notXTurnErrorMessage
	
	^'Not X''s turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/27/2017 10:26:31'!
positionOutsideBoardErrorMessage
	
	^'Position is outside board'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'HAW 10/24/2017 17:12:48'!
positionTakenErrorMessage
	
	^'Position taken'! !


!classDefinition: #TicTacToeObserver category: #TicTacToe!
Object subclass: #TicTacToeObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeObserver methodsFor: 'notifications' stamp: 'PGF 6/3/2018 21:07:03'!
notifyMarkWithOAt: aPosition
	^self subclassResponsibility. ! !

!TicTacToeObserver methodsFor: 'notifications' stamp: 'PGF 6/3/2018 21:07:53'!
notifyMarkWithXAt: aPosition
	^self subclassResponsibility. ! !

!TicTacToeObserver methodsFor: 'notifications' stamp: 'PGF 6/3/2018 21:08:09'!
notifyNewState: aState
	^self subclassResponsibility. ! !


!classDefinition: #TicTacToeConsole category: #TicTacToe!
TicTacToeObserver subclass: #TicTacToeConsole
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeConsole methodsFor: 'initialization' stamp: 'PGF 5/31/2018 19:31:05'!
initialize
	lines _ OrderedCollection new.! !


!TicTacToeConsole methodsFor: 'accessing' stamp: 'PGF 5/31/2018 20:52:24'!
log
	^lines copy.! !


!TicTacToeConsole methodsFor: 'notifications' stamp: 'PGF 5/31/2018 20:06:27'!
notifyMarkWithOAt: aPosition
	lines add: 'O marcó en ', aPosition printString! !

!TicTacToeConsole methodsFor: 'notifications' stamp: 'PGF 5/31/2018 19:42:34'!
notifyMarkWithXAt: aPosition
	lines add: 'X marcó en ', aPosition printString! !

!TicTacToeConsole methodsFor: 'notifications' stamp: 'PGF 5/31/2018 20:16:48'!
notifyNewState: aState
	(aState isKindOf: PlayingO) ifTrue: [ lines add: 'Estado: Jugando O' ].
	(aState isKindOf: PlayingX) ifTrue: [ lines add: 'Estado: Jugando X' ].
	(aState isKindOf: PlayerXWon) ifTrue: [ lines add: 'Juego terminado - Ganó X!!' ].
	(aState isKindOf: PlayerOWon) ifTrue: [ lines add: 'Juego terminado - Ganó O!!' ].
	(aState isKindOf: GameTied) ifTrue: [ lines add: 'Juego terminado - Empate!!' ].
	! !


!classDefinition: #TicTacToeViewer category: #TicTacToe!
TicTacToeObserver subclass: #TicTacToeViewer
	instanceVariableNames: 'positions state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeViewer methodsFor: 'initialization' stamp: 'PGF 6/3/2018 20:50:55'!
initialize
	
	
	positions _ self newBoard.
	state _ 'Estado: Jugando X'.
	! !

!TicTacToeViewer methodsFor: 'initialization' stamp: 'PGF 6/3/2018 20:07:30'!
newBoard
	| board row1 row2 row3 separator |
	
	board _ OrderedCollection new: 5.
	
	row1 _ #(' ' '|' ' ' '|' ' ').
	row2 _ #(' ' '|' ' ' '|' ' ').
	row3 _ #(' ' '|' ' ' '|' ' ').
	separator _ #('-' '-' '-' '-' '-').

	board add: row1.
	board add: separator.
	board add: row2.
	board add: separator.
	board add: row3.
	^board.! !


!TicTacToeViewer methodsFor: 'notifications' stamp: 'PGF 6/3/2018 20:31:48'!
notifyMarkWithOAt: aPosition
	 | newRow |
	newRow _ positions at:(aPosition x + (aPosition x - 1)).
	newRow at: (aPosition y + (aPosition y - 1)) put: $O.! !

!TicTacToeViewer methodsFor: 'notifications' stamp: 'PGF 6/3/2018 20:31:31'!
notifyMarkWithXAt: aPosition
     | newRow |
	newRow _ positions at:(aPosition x + (aPosition x - 1)).
	newRow at: (aPosition y + (aPosition y - 1)) put: $X.
! !

!TicTacToeViewer methodsFor: 'notifications' stamp: 'PGF 5/31/2018 20:46:49'!
notifyNewState: aState
	(aState isKindOf: PlayingO) ifTrue: [ state _ 'Estado: Jugando O' ].
	(aState isKindOf: PlayingX) ifTrue: [ state _ 'Estado: Jugando X' ].
	(aState isKindOf: PlayerXWon) ifTrue: [ state _ 'Juego terminado - Ganó X!!' ].
	(aState isKindOf: PlayerOWon) ifTrue: [ state _ 'Juego terminado - Ganó O!!' ].
	(aState isKindOf: GameTied) ifTrue: [ state _ 'Juego terminado - Empate!!' ].! !


!TicTacToeViewer methodsFor: 'accessing' stamp: 'PGF 6/3/2018 20:45:14'!
show
	| result |
	result _ positions copy.
	result add: state.
	^result.! !


!classDefinition: #TicTacToeState category: #TicTacToe!
Object subclass: #TicTacToeState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerOWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
hasPlayerXWon
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isOver
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:28:07'!
isTied
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingO
	
	self subclassResponsibility! !

!TicTacToeState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:28:07'!
isPlayingX
	
	self subclassResponsibility! !


!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:31'!
markAt: aPosition

	self subclassResponsibility ! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	self subclassResponsibility.! !

!TicTacToeState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	self subclassResponsibility.! !


!TicTacToeState methodsFor: 'initialization' stamp: 'HAW 10/25/2017 13:05:13'!
initializeFor: aGame

	game := aGame ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToeState class' category: #TicTacToe!
TicTacToeState class
	instanceVariableNames: ''!

!TicTacToeState class methodsFor: 'as yet unclassified' stamp: 'HAW 10/25/2017 13:05:29'!
for: aTicTacToe 
	
	^self new initializeFor: aTicTacToe ! !


!classDefinition: #GameOverState category: #TicTacToe!
TicTacToeState subclass: #GameOverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameOverState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 11:53:57'!
isOver
	
	^true! !


!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:23'!
isPlayingO
	
	^false! !

!GameOverState methodsFor: 'testing playing turn' stamp: 'HAW 10/26/2017 12:05:27'!
isPlayingX
	
	^false! !


!GameOverState methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:09'!
markAt: aPosition

	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:25'!
markWithOAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !

!GameOverState methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:16'!
markWithXAt: aPosition
	game error: game class canNotPlayWhenGameIsOverErrorMessage.! !


!classDefinition: #GameTied category: #TicTacToe!
GameOverState subclass: #GameTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!GameTied methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:24:49'!
isTied
	
	^true! !


!classDefinition: #PlayerOWon category: #TicTacToe!
GameOverState subclass: #PlayerOWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ true.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ false.! !

!PlayerOWon methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:06:24'!
isTied
	
	^false! !


!classDefinition: #PlayerXWon category: #TicTacToe!
GameOverState subclass: #PlayerXWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 16:14:31'!
hasPlayerOWon
	^ false.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:51:46'!
hasPlayerXWon
	^ true.! !

!PlayerXWon methodsFor: 'testing game result' stamp: 'HAW 10/25/2017 15:25:44'!
isTied
	
	^false! !


!classDefinition: #PlayingState category: #TicTacToe!
TicTacToeState subclass: #PlayingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:10'!
hasPlayerOWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:17'!
hasPlayerXWon
	^ false.! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:26'!
isOver
	
	^false! !

!PlayingState methodsFor: 'testing game result' stamp: 'HAW 10/26/2017 12:07:52'!
isTied
	
	^false! !


!classDefinition: #PlayingO category: #TicTacToe!
PlayingState subclass: #PlayingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:36'!
isPlayingO
	
	^true! !

!PlayingO methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:18:27'!
isPlayingX
	
	^false! !


!PlayingO methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:13'!
markAt: aPosition

	^game markWithOAt: aPosition ! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:29:45'!
markWithOAt: aPosition
	game markWithOWhenPlayingOAt: aPosition.! !

!PlayingO methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:32'!
markWithXAt: aPosition
	game markWithXWhenPlayingOAt: aPosition.! !


!classDefinition: #PlayingX category: #TicTacToe!
PlayingState subclass: #PlayingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe'!

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:50'!
isPlayingO
	
	^false! !

!PlayingX methodsFor: 'testing playing turn' stamp: 'HAW 10/25/2017 16:17:23'!
isPlayingX
	
	^true! !


!PlayingX methodsFor: 'marking board' stamp: 'HAW 5/31/2018 18:49:17'!
markAt: aPosition

	^game markWithXAt: aPosition ! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:01'!
markWithOAt: aPosition
	game markWithOWhenPlayingXAt: aPosition.! !

!PlayingX methodsFor: 'marking board' stamp: 'HAW 10/26/2017 12:30:46'!
markWithXAt: aPosition
	game markWithXWhenPlayingXAt: aPosition.! !
