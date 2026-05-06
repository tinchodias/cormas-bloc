Class {
	#name : 'CMBlGrid',
	#superclass : 'Object',
	#instVars : [
		'cormasModel'
	],
	#category : 'CellFactory',
	#package : 'CellFactory'
}

{ #category : 'examples' }
CMBlGrid class >> example [

	| simulation grid |
	simulation := (CMSimulation for: ECECModel)
		activeInitSelector: #smallEnvironment;
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
	
	| shapeSize spacing diameter step gridElement spacePresenter space |
	
	shapeSize := 50.
	spacing := 0.

	diameter := shapeSize * 2.
	step := diameter + spacing.
	
	gridElement := BlElement new.
	gridElement extent: (step * self numberOfRows) @ (step * self numberOfColumns).

	1 to: self numberOfRows do: [ :row |
		1 to: self numberOfColumns do: [ :col |
			| cell position shape |
			cell := cormasModel cellAt: row at: col.
			
			position := ((row - 1) * step) @ ((col - 1) * step).

 			shape := self cellElementClass new
				size: diameter;
				position: position;
 				color: (self colorOfCell: cell);
				borderColor: (self borderColorOfCell: cell);
				borderWidth: (self borderWidthOfCell: cell) * diameter;
				yourself.
				
			"shape orientation: ((row + col) odd
				ifTrue: [ #top ]
				ifFalse: [ #bottom ])."

			gridElement addChild: shape element ] ].
	
	spacePresenter := SpBlSpaceInMorphPresenter new.
	space := spacePresenter space.
	
	space root layout: BlFrameLayout new.
	
	gridElement constraintsDo: [ :c |
		c frame vertical alignCenter.
		c frame horizontal alignCenter ].
	
	space root addChild: gridElement.

	^ spacePresenter
]

{ #category : 'as yet unclassified' }
CMBlGrid >> cellElementClass [
   
	^ CMSquareShape 
]

{ #category : 'as yet unclassified' }
CMBlGrid >> cellElementClass: n [

    n = 3 ifTrue: [ ^ CMTriangleShape ].
    n = 4 ifTrue: [ ^ CMSquareShape ].
    n = 6 ifTrue: [ ^ CMPointyTopHexagonShape ].
	 n = #flat6 ifTrue: [ ^ CMFlatTopHexagonShape ].
 
]

{ #category : 'as yet unclassified' }
CMBlGrid >> colorOfCell: aCell [

	^ (self povOfCell: aCell) color
]

{ #category : 'accessing' }
CMBlGrid >> cormasModel: aCormasModel [

	cormasModel := aCormasModel
]

{ #category : 'examples' }
CMBlGrid >> example [
	<script: 'self example'>
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
CMBlGrid >> povOfCell: aCell [

	^ aCell perform: aCell class activePovSelector
]
