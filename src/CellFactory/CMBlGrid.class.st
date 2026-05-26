Class {
	#name : 'CMBlGrid',
	#superclass : 'Object',
	#instVars : [
		'cormasModel',
		'shapeSize',
		'spacing',
		'degree',
		'gridElement',
		'cellElements',
		'shapeExtent'
	],
	#category : 'CellFactory',
	#package : 'CellFactory'
}

{ #category : 'examples' }
CMBlGrid class >> example [

	| simulation grid |
	simulation := (CMSimulation for: ECECModel )
		activeInitSelector: #smallEnvironment  ;
		activeControlSelector: #step;
		initializeSimulation;
		yourself. 
	
	grid := self for: simulation cormasModel.
	grid buildPresenter open
]

{ #category : 'instance creation' }
CMBlGrid class >> for: aCormasModel [
	
	^ self new
		cormasModel: aCormasModel;
		yourself
]

{ #category : 'as yet unclassified' }
CMBlGrid >> borderColorOfCell: aCell [

	^ (self povOfCell: aCell) borderColor
]

{ #category : 'as yet unclassified' }
CMBlGrid >> borderWidthOfCell: aCell [

	^ (self povOfCell: aCell) borderWidth
]

{ #category : 'building' }
CMBlGrid >> buildPresenter [
	
	| spacePresenter space|
	
	cellElements := Dictionary new.
	gridElement := BlElement new.
	gridElement extent: ( self step x * self numberOfRows) @ (self step y * self numberOfColumns).

	1 to: self numberOfRows do: [ :row |
		1 to: self numberOfColumns do: [ :col |
			| cell position shape |
			cell := cormasModel cellAt: row at: col.
			
			position := self position: row col: col.

 			shape := self cellElementClass new
				size: shapeSize;
				position: position;
 				color: (self colorOfCell: cell);
				borderColor: (self borderColorOfCell: cell);
				borderWidth: (self borderWidthOfCell: cell) * shapeSize * 2;
				yourself.
				
				self setOrientation: row col: col shape: shape.
			
			gridElement addChild: shape element. 
			shapeExtent:= shape extent.
			cellElements
                at: row @ col
                put: shape element
			
			
			] ].
	
	spacePresenter := SpBlSpaceInMorphPresenter new.
	space := spacePresenter space.
	
space root layout: BlFrameLayout new.

    gridElement constraintsDo: [ :c |
        c frame vertical alignCenter.
        c frame horizontal alignCenter
    ].
	
	space root addChild: gridElement.

	^ spacePresenter
]

{ #category : 'as yet unclassified' }
CMBlGrid >> cellElementClass [

    degree = 3 ifTrue: [ ^ CMTriangleShape ].
    degree = 4 ifTrue: [ ^ CMSquareShape ].
    degree = 6 ifTrue: [ ^ CMPointyTopHexagonShape ].
	 degree = #flat6 ifTrue: [ ^ CMFlatTopHexagonShape ].
 
]

{ #category : 'as yet unclassified' }
CMBlGrid >> colorOfCell: aCell [

	^ (self povOfCell: aCell) color
]

{ #category : 'accessing' }
CMBlGrid >> cormasModel: aCormasModel [

	cormasModel := aCormasModel
]

{ #category : 'accessing' }
CMBlGrid >> degree: aNumber [
	degree := aNumber.
]

{ #category : 'as yet unclassified' }
CMBlGrid >> elementAtRow: row col: col [
	^ cellElements at: row @ col
]

{ #category : 'as yet unclassified' }
CMBlGrid >> elementForCell: aCell [

    ^ self
        elementAtRow: aCell rowNumber
        col: aCell columnNumber
]

{ #category : 'examples' }
CMBlGrid >> example [
	<script: 'self example'>
]

{ #category : 'accessing' }
CMBlGrid >> gridElement [
    ^ gridElement
]

{ #category : 'initialization' }
CMBlGrid >> initialize [
    super initialize.
    shapeSize := 50.
    spacing := 0.
	 degree:= 4.
]

{ #category : 'accessing' }
CMBlGrid >> numberOfColumns [

	^ cormasModel spaceModel numberOfColumns
]

{ #category : 'accessing' }
CMBlGrid >> numberOfRows [

	^ cormasModel spaceModel numberOfRows
]

{ #category : 'as yet unclassified' }
CMBlGrid >> position: aRow col: aCol [

	|x y step offsetX offsetY|

	x := y := step := offsetX := offsetY :=0.
    step := self step.
    degree = 6 ifTrue: [
        offsetX := step x / 2.
    ].

    degree = #flat6 ifTrue: [
        offsetY := step y / 2.
    ].

    x := (aCol - 1) * (step x + spacing).
    y := (aRow - 1) * (step y + spacing).

    degree = 6 ifTrue: [
        (aRow even) ifTrue: [ x := x + offsetX ].
    ].

    degree = #flat6 ifTrue: [
        (aCol even) ifTrue: [ y := y + offsetY ].
    ].
 	^ x @ y
]

{ #category : 'as yet unclassified' }
CMBlGrid >> povOfCell: aCell [

	^ aCell perform: aCell class activePovSelector
]

{ #category : 'as yet unclassified' }
CMBlGrid >> setOrientation: aRow col: aCol shape: aShape [
	degree = 3 ifTrue: [
								aShape orientation: ((aRow + aCol ) odd
								ifTrue: [ #top ]
								ifFalse: [ #bottom ]).
							].
]

{ #category : 'accessing' }
CMBlGrid >> shapeExtent [
	^shapeExtent
]

{ #category : 'accessing' }
CMBlGrid >> shapeSize [
	^shapeSize
]

{ #category : 'accessing' }
CMBlGrid >> shapeSize: aNumber [
	shapeSize := aNumber.
]

{ #category : 'accessing' }
CMBlGrid >> spacing: aNumber [
	spacing := aNumber.
]

{ #category : 'stepping' }
CMBlGrid >> step [
    degree = 3 ifTrue: [
        ^ (3 sqrt / 2) @ (3 / 2) * shapeSize
    ].

    degree = 4 ifTrue: [
        ^ (1 @ 1) * shapeSize
    ].

    degree = 6 ifTrue: [
        ^ (3 sqrt @ (3 / 2)) * shapeSize
    ].

    degree = #flat6 ifTrue: [
        ^ ((3 / 2) @ (3 sqrt)) * shapeSize
    ].
]
