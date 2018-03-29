!classDefinition: #I category: #'Quinta Actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Quinta Actividad'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'PGF 3/22/2018 21:55:00'!
* aPeanoNumber
	^aPeanoNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'PGF 3/22/2018 21:07:10'!
+ unNumeroDePeano
	^ unNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:35:40'!
- aPeanoNumber
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:01'!
/ aPeanoNumber
	aPeanoNumber = I
	ifTrue: [^self.]
	ifFalse: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor. ]! !

!I class methodsFor: 'as yet unclassified' stamp: 'PGF 3/23/2018 12:03:48'!
> aPeanoNumber
	^false! !

!I class methodsFor: 'as yet unclassified' stamp: 'PGF 3/26/2018 20:52:23'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor.'! !

!I class methodsFor: 'as yet unclassified' stamp: 'PGF 3/26/2018 20:55:16'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Los numeros de peano no soportan negativos'! !

!I class methodsFor: 'as yet unclassified' stamp: 'PGF 3/22/2018 20:59:32'!
next
^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'PGF 3/22/2018 21:04:33'!
previous
self error: 'El I no tiene numero previo'! !


!classDefinition: #II category: #'Quinta Actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Quinta Actividad'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/23/2018 11:36:50'!
* aPeanoNumber
^aPeanoNumber + (self previous * aPeanoNumber )! !

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/22/2018 21:25:05'!
+ aPeanoNumber
^self previous + aPeanoNumber next! !

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/22/2018 21:38:56'!
- unNumeroDePeano
 unNumeroDePeano = I 
	ifTrue: [^self previous]
	ifFalse: [^self previous - unNumeroDePeano previous]
 ! !

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:35:00'!
/ aPeanoNumber
|resto|
aPeanoNumber > self
ifTrue:[^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.]
ifFalse:[
		self = aPeanoNumber
		ifTrue:[^I]
		ifFalse: [
				resto := self - aPeanoNumber.
				(resto > aPeanoNumber) | (resto = aPeanoNumber)
				ifTrue:[ ^I+ (resto / aPeanoNumber).]
				ifFalse: [^I].
			]
	]
! !

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/23/2018 12:03:40'!
> aPeanoNumber
	aPeanoNumber = I
	ifTrue: [^true]
	ifFalse: [^self previous > aPeanoNumber previous]! !

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:34:09'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor.'! !

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:06:32'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Los numeros de peano no soportan negativos'! !

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/22/2018 21:28:42'!
next
	next ifNil: [ 
		next := self cloneNamed: (self name, 'I').
		next previous: self.
		].
	^next  ! !

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/22/2018 21:21:25'!
previous
^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/22/2018 21:21:45'!
previous: aPrevious
previous:= aPrevious! !

!II class methodsFor: 'as yet unclassified' stamp: 'PGF 3/22/2018 21:48:06'!
removeAllNext
  next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	] ! !

II instVarNamed: 'next' put: III!
II instVarNamed: 'previous' put: I!

!classDefinition: #III category: #'Quinta Actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Quinta Actividad'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
* aPeanoNumber
^aPeanoNumber + (self previous * aPeanoNumber )! !

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
+ aPeanoNumber
^self previous + aPeanoNumber next! !

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
- unNumeroDePeano
 unNumeroDePeano = I 
	ifTrue: [^self previous]
	ifFalse: [^self previous - unNumeroDePeano previous]
 ! !

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
/ aPeanoNumber
|resto|
aPeanoNumber > self
ifTrue:[^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.]
ifFalse:[
		self = aPeanoNumber
		ifTrue:[^I]
		ifFalse: [
				resto := self - aPeanoNumber.
				(resto > aPeanoNumber) | (resto = aPeanoNumber)
				ifTrue:[ ^I+ (resto / aPeanoNumber).]
				ifFalse: [^I].
			]
	]
! !

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
> aPeanoNumber
	aPeanoNumber = I
	ifTrue: [^true]
	ifFalse: [^self previous > aPeanoNumber previous]! !

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor.'! !

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Los numeros de peano no soportan negativos'! !

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
next
	next ifNil: [ 
		next := self cloneNamed: (self name, 'I').
		next previous: self.
		].
	^next  ! !

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
previous
^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
previous: aPrevious
previous:= aPrevious! !

!III class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
removeAllNext
  next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	] ! !

III instVarNamed: 'next' put: IIII!
III instVarNamed: 'previous' put: II!

!classDefinition: #IIII category: #'Quinta Actividad'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Quinta Actividad'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
* aPeanoNumber
^aPeanoNumber + (self previous * aPeanoNumber )! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
+ aPeanoNumber
^self previous + aPeanoNumber next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
- unNumeroDePeano
 unNumeroDePeano = I 
	ifTrue: [^self previous]
	ifFalse: [^self previous - unNumeroDePeano previous]
 ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
/ aPeanoNumber
|resto|
aPeanoNumber > self
ifTrue:[^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.]
ifFalse:[
		self = aPeanoNumber
		ifTrue:[^I]
		ifFalse: [
				resto := self - aPeanoNumber.
				(resto > aPeanoNumber) | (resto = aPeanoNumber)
				ifTrue:[ ^I+ (resto / aPeanoNumber).]
				ifFalse: [^I].
			]
	]
! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
> aPeanoNumber
	aPeanoNumber = I
	ifTrue: [^true]
	ifFalse: [^self previous > aPeanoNumber previous]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor.'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Los numeros de peano no soportan negativos'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
next
	next ifNil: [ 
		next := self cloneNamed: (self name, 'I').
		next previous: self.
		].
	^next  ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
previous
^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
previous: aPrevious
previous:= aPrevious! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'PGF 3/27/2018 13:36:22'!
removeAllNext
  next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next:= nil.
	] ! !

IIII instVarNamed: 'next' put: nil!
IIII instVarNamed: 'previous' put: III!