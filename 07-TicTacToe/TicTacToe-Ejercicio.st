!classDefinition: #TicTacToeTest category: #'TicTacToe-Ejercicio'!
TestCase subclass: #TicTacToeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Ejercicio'!

!TicTacToeTest methodsFor: 'Testing' stamp: 'PGF 5/28/2018 18:53:46'!
test01NewGameBoardIsEmpty

	|game|
	
	game := TicTacToe new.
	
	self assert: game Xs isEmpty.
	self assert: game Os isEmpty.
	! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'PGF 5/28/2018 18:55:54'!
test02WhenXPlayOneMoveOnlyAreOneXOnTheBoardMarked
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	self
		assert: 1
		equals: game Xs size.
	self assert: (game Xs includes: 1 @ 1).
	self assert: game Os isEmpty.! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'PGF 5/28/2018 18:57:15'!
test03WhenXPlayAndThenPlayOTheraAreOnlyOneXAndOneOOnTheBoardMarked
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	self
		assert: 1
		equals: game Xs size.
	self assert: (game Xs includes: 1 @ 1).
	self
		assert: 1
		equals: game Os size.
	self assert: (game Os includes: 2 @ 2).! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 11:33:30'!
test04XCanNotPlayTwiceConsecutive
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notXTurnErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: game Os isEmpty ].! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 11:33:12'!
test05OCanNotPlayTwiceConsecutive
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	self
		should: [ game markWithOAt: 3 @ 3 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe notOTurnErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 11:40:25'!
test06XCanNotPlayInTheSamePositionAsItself
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	self
		should: [ game markWithXAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 11:41:09'!
test07XCanNotPlayInTheSamePositionAsO
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	self
		should: [ game markWithXAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 11:41:44'!
test08OCanNotPlayInTheSamePotitionAsX
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	self
		should: [ game markWithOAt: 1 @ 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 1
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: game Os isEmpty ].! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 11:42:17'!
test09OCanNotPlayInSamePotitionAsItself
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	game markWithXAt: 3 @ 3.
	self
		should: [ game markWithOAt: 2 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe positionTakenErrorMessage
				equals: anError messageText.
			self
				assert: 2
				equals: game Xs size.
			self assert: (game Xs includes: 1 @ 1).
			self assert: (game Xs includes: 3 @ 3).
			self
				assert: 1
				equals: game Os size.
			self assert: (game Os includes: 2 @ 2) ].! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 11:44:00'!
test10NobodyIsAWinnerInAUnfinishedGame
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 3 @ 3.
	self deny: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 12:43:52'!
test11XWonWithFirstRowCompleted
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 3.
	game markWithXAt: 1 @ 3.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 12:44:39'!
test12XWonWithSecondRowCompleted
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 2 @ 3.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 12:44:59'!
test13XWonWithThirdRowCompleted
	| game |
	game _ TicTacToe new.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 3 @ 3.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 12:47:00'!
test14XWonWithFirstColumnCompleted
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 2.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 3 @ 3.
	game markWithXAt: 3 @ 1.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 12:47:57'!
test15XWonWithDownDiagonal
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 3 @ 3.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 12:48:48'!
test16XWonWithUpDiagonal
	| game |
	game _ TicTacToe new.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 1 @ 3.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 12:49:26'!
test17OWonWithFirstRowCompleted
	| game |
	game _ TicTacToe new.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 3.
	game markWithOAt: 1 @ 3.
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon.! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 13:56:42'!
test18OCanNotPlayWhenGameIsOver
	| game |
	game _ TicTacToe new.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 1 @ 3.
	self
		should: [ game markWithOAt: 3 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self
				assert: 2
				equals: game Os size.
			self assert: (game Os includes: 2 @ 1).
			self assert: (game Os includes: 3 @ 1) ].! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 13:57:03'!
test19XCanNotPlayWhenGameIsOver
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 3 @ 1.
	game markWithOAt: 1 @ 3.
	self
		should: [ game markWithXAt: 3 @ 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: TicTacToe canNotPlayWhenGameIsOverErrorMessage
				equals: anError messageText.
			self
				assert: 3
				equals: game Xs size.
			self assert: (game Xs includes: 2 @ 2).
			self assert: (game Xs includes: 2 @ 1).
			self assert: (game Xs includes: 3 @ 1) ].! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 13:59:28'!
test20InTiedGameNobodyWinsAndGameIsOver
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 1.
	game markWithXAt: 1 @ 3.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 2 @ 1.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 1 @ 2.
	game markWithOAt: 3 @ 2.
	game markWithXAt: 3 @ 3.
	self assert: game isOver.
	self deny: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self assert: game isTied.! !

!TicTacToeTest methodsFor: 'Testing' stamp: 'GAA 5/29/2018 14:00:03'!
test21IfXPlayerWonGameIsOver
	| game |
	game _ TicTacToe new.
	game markWithXAt: 2 @ 2.
	game markWithOAt: 1 @ 2.
	game markWithXAt: 1 @ 1.
	game markWithOAt: 2 @ 1.
	game markWithXAt: 1 @ 3.
	game markWithOAt: 2 @ 3.
	game markWithXAt: 3 @ 2.
	game markWithOAt: 3 @ 1.
	game markWithXAt: 3 @ 3.
	self assert: game isOver.
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon.
	self deny: game isTied.! !


!classDefinition: #StateTicTacToe category: #'TicTacToe-Ejercicio'!
Object subclass: #StateTicTacToe
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Ejercicio'!

!StateTicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:35:30'!
hasCompletedColumn: positions
	
	^ (1 to: 3) anySatisfy: [ :y | (positions count: [ :position | position y = y ]) = 3 ]! !

!StateTicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:35:43'!
hasCompletedRow: positions

	^ (1 to: 3) anySatisfy: [ :x | (positions count: [ :posicion | posicion x = x ]) = 3 ]! !

!StateTicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:36:07'!
hasDownDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@n ]! !

!StateTicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:36:20'!
hasUpDiagonal: positions

	^(1 to: 3) allSatisfy: [ :n | positions includes: n@(4-n) ]! !

!StateTicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:35:16'!
hasWin: positions

	^(self hasCompletedRow: positions)
		or: [(self hasCompletedColumn: positions) 
				or: [(self hasDownDiagonal: positions)
					or: [(self hasUpDiagonal: positions)]]]
! !

!StateTicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:18:46'!
markWithOAt: aPosition inGame: aGame
	^self subclassResponsibility.! !

!StateTicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:18:50'!
markWithXAt: aPosition inGame: aGame
	^self subclassResponsibility.! !

!StateTicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:33:29'!
nextStateFor: positions
	^self subclassResponsibility.! !


!classDefinition: #StateTied category: #'TicTacToe-Ejercicio'!
StateTicTacToe subclass: #StateTied
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Ejercicio'!

!StateTied methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:14:28'!
markWithOAt: aPosition inGame: aGame
	aGame gameAlreadyOver.! !

!StateTied methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:14:28'!
markWithXAt: aPosition inGame: aGame
	aGame gameAlreadyOver.! !

!StateTied methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:33:01'!
nextStateFor: positions! !


!classDefinition: #StateTurnO category: #'TicTacToe-Ejercicio'!
StateTicTacToe subclass: #StateTurnO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Ejercicio'!

!StateTurnO methodsFor: 'accessing' stamp: 'PGF 5/28/2018 20:52:45'!
markWithOAt: aPosition inGame: aGame
	aGame inTurnOmarkWithOAt: aPosition.! !

!StateTurnO methodsFor: 'accessing' stamp: 'PGF 5/28/2018 20:52:57'!
markWithXAt: aPosition inGame: aGame
	aGame inTurnOmarkWithXAt: aPosition.! !

!StateTurnO methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:32:40'!
nextStateFor: positions
	(self hasWin: positions) ifTrue: [ ^StateWinnerO new. ].
	^StateTurnX new.! !


!classDefinition: #StateTurnX category: #'TicTacToe-Ejercicio'!
StateTicTacToe subclass: #StateTurnX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Ejercicio'!

!StateTurnX methodsFor: 'accessing' stamp: 'PGF 5/28/2018 20:53:08'!
markWithOAt: aPosition inGame: aGame
	aGame inTurnXmarkWithOAt: aPosition.! !

!StateTurnX methodsFor: 'accessing' stamp: 'PGF 5/28/2018 20:53:27'!
markWithXAt: aPosition inGame: aGame
	aGame inTurnXmarkWithXAt: aPosition.! !

!StateTurnX methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:32:13'!
nextStateFor: positions
	(self hasWin: positions) ifTrue: [ ^StateWinnerX new. ].
	(positions size = 5) ifTrue: [ ^StateTied new. ].
	^StateTurnO new.! !


!classDefinition: #StateWinnerO category: #'TicTacToe-Ejercicio'!
StateTicTacToe subclass: #StateWinnerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Ejercicio'!

!StateWinnerO methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:14:28'!
markWithOAt: aPosition inGame: aGame
	aGame gameAlreadyOver.! !

!StateWinnerO methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:14:28'!
markWithXAt: aPosition inGame: aGame
	aGame gameAlreadyOver.! !

!StateWinnerO methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:32:53'!
nextStateFor: positions! !


!classDefinition: #StateWinnerX category: #'TicTacToe-Ejercicio'!
StateTicTacToe subclass: #StateWinnerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Ejercicio'!

!StateWinnerX methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:14:28'!
markWithOAt: aPosition inGame: aGame
	aGame gameAlreadyOver.! !

!StateWinnerX methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:14:28'!
markWithXAt: aPosition inGame: aGame
	aGame gameAlreadyOver.! !

!StateWinnerX methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:30:46'!
nextStateFor: positions
! !


!classDefinition: #TicTacToe category: #'TicTacToe-Ejercicio'!
Object subclass: #TicTacToe
	instanceVariableNames: 'os xs state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TicTacToe-Ejercicio'!

!TicTacToe methodsFor: 'accessing' stamp: 'jg 5/22/2018 10:01:34'!
Os

	^os copy.! !

!TicTacToe methodsFor: 'accessing' stamp: 'jg 5/22/2018 10:01:25'!
Xs

	^xs copy.! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:05:16'!
hasPlayerOWon
	^ state isKindOf: StateWinnerO.! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:05:32'!
hasPlayerXWon
	^ state isKindOf: StateWinnerX.! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 20:08:34'!
inTurnOmarkWithOAt: aPosition
	! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 19:54:44'!
inTurnOmarkWithXAt: aPosition
	^self error: self class notXTurnErrorMessage! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 19:54:09'!
inTurnXmarkWithOAt: aPosition
	^self error: self class notOTurnErrorMessage! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 20:08:58'!
inTurnXmarkWithXAt: aPosition
	! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 18:51:47'!
isOver
	^ self hasPlayerXWon or: [
		self hasPlayerOWon or: [ self isTied ]].! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:05:58'!
isPlayingO
	^state isKindOf: StateTurnO.! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:06:03'!
isPlayingX
	^state isKindOf: StateTurnX.! !

!TicTacToe methodsFor: 'accessing' stamp: 'GAA 5/29/2018 11:26:46'!
isTied
	^state isKindOf: StateTied.
! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:54:44'!
markAt: aPosition on: positions 
	((xs includes: aPosition) or: [os includes:aPosition.])  ifTrue: [ self error: self class positionTakenErrorMessage ].
	positions add: aPosition.
	
	state _ state nextStateFor: positions.! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:55:09'!
markWithOAt: aPosition
	state markWithOAt: aPosition inGame: self.
	self markAt: aPosition on: os.! !

!TicTacToe methodsFor: 'accessing' stamp: 'PGF 5/28/2018 21:55:21'!
markWithXAt: aPosition
	state markWithXAt: aPosition inGame: self.
	self markAt: aPosition on: xs.! !


!TicTacToe methodsFor: 'initialization' stamp: 'PGF 5/28/2018 20:57:48'!
initialize
	
	xs _ Set new.
	os _ Set new.

	state _ StateTurnX new.! !


!TicTacToe methodsFor: 'error handling' stamp: 'PGF 5/28/2018 21:14:28'!
gameAlreadyOver
	self error: self class canNotPlayWhenGameIsOverErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicTacToe class' category: #'TicTacToe-Ejercicio'!
TicTacToe class
	instanceVariableNames: ''!

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 13:15:31'!
canNotPlayWhenGameIsOverErrorMessage
	
	^'Can not play when game is over'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'PGF 5/28/2018 19:54:23'!
notOTurnErrorMessage

	^'Not O turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 10:26:38'!
notXTurnErrorMessage

	^'Not X turn'! !

!TicTacToe class methodsFor: 'as yet unclassified' stamp: 'jg 5/22/2018 11:20:12'!
positionTakenErrorMessage
	
	^'Position taken'! !
