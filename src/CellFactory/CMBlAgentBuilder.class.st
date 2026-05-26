Class {
	#name : 'CMBlAgentBuilder',
	#superclass : 'Object',
	#instVars : [
		'localPosition',
		'shapeType',
		'shapeSize',
		'shape'
	],
	#category : 'CellFactory',
	#package : 'CellFactory'
}

{ #category : 'exa' }
CMBlAgentBuilder class >> example [ 
	| simulation model gridBuilder agents cellSize agentSize agentBuilder|


	simulation := (CMSimulation for: ECECModel)
		activeInitSelector: #smallEnvironment;
   		activeControlSelector: #step;
   		initializeSimulation;
   		yourself.

	model := simulation cormasModel.

	gridBuilder := CMBlGridBuilder new.
	gridBuilder cormasModel: model.
	gridBuilder buildPresenter open.
	
	agentSize :=30@30.
	cellSize := gridBuilder shapeExtent.
	agents := model agents.


	agentBuilder:= CMBlAgentBuilder new.
	agentBuilder displayOn: gridBuilder model: model cellSize: cellSize agentSize: agentSize.
]

{ #category : 'as yet unclassified' }
CMBlAgentBuilder >> borderColorOfAgent: anAgent [

	^ (self povOfAgent: anAgent) borderColor
]

{ #category : 'as yet unclassified' }
CMBlAgentBuilder >> borderWidthOfAgent: anAgent [

	^ (self povOfAgent: anAgent) borderWidth
]

{ #category : 'as yet unclassified' }
CMBlAgentBuilder >> colorOfAgent: anAgent [

	^ (self povOfAgent: anAgent) color
]

{ #category : 'as yet unclassified' }
CMBlAgentBuilder >> createElementForCell: agent size: aSize pos: position [

	| agentElement shape shapeElement |
	agentElement := BlElement new.
	shape := self shapeElementClass new.

	shape
		size: aSize ;
		color: (self colorOfAgent: agent);
		borderColor: (self borderColorOfAgent: agent);
		borderWidth: (self borderWidthOfAgent: agent) * aSize x;
		yourself.

	shapeElement := shape element.
	shapeElement extent: aSize .
	agentElement
		extent: aSize ;
		position: position.

	agentElement addChild: shapeElement.

	^ agentElement
]

{ #category : 'as yet unclassified' }
CMBlAgentBuilder >> displayOn: aGrid model: aModel cellSize: aCellSize agentSize: anAgentSize [

	| config positionInCell cell cellCoordinates intersectionProportion shiftProportionX shiftProportionY shiftProportion intersectionOffset offset agentPos el cellElement |
	
	config := aModel spaceModel neighbourhoodConfiguration.
	positionInCell := 0.5@0.5.

   aModel agents do: [ :agent |
		cell := agent cell.
		cellElement := aGrid elementForCell: cell.
		
		cellCoordinates := cell columnNumber @ cell rowNumber.
		
		intersectionProportion :=
			config boundingRectangleHorizontalIntersection @
			config boundingRectangleVerticalIntersection.
			
		shiftProportionX := cell rowNumber even
			ifTrue: [ config boundingRectangleHorizontalShiftEven ]
			ifFalse: [ config boundingRectangleHorizontalShiftOdd ].
		
		shiftProportionY := cell columnNumber even
			ifTrue: [ config boundingRectangleVerticalShiftEven ]
			ifFalse: [ config boundingRectangleVerticalShiftOdd ].
		
		shiftProportion := shiftProportionX @ shiftProportionY.
	
		intersectionOffset := (cellCoordinates - 1) * intersectionProportion.
		offset := (cellCoordinates - 1) - intersectionOffset + shiftProportion.

    	agentPos :=  (offset + positionInCell - config cellShapeOriginOffset) * aCellSize - (anAgentSize/2).
		el := self createElementForCell: agent size: anAgentSize pos: agentPos.
		aGrid gridElement addChild: el ].

]

{ #category : 'examples' }
CMBlAgentBuilder >> example [
	<script: 'self example'>
]

{ #category : 'initialization' }
CMBlAgentBuilder >> initialize [
	super initialize.
	shapeType := #circle.
	shapeSize := 5.

]

{ #category : 'accessing' }
CMBlAgentBuilder >> localPosition: aPoint [
	localPosition := aPoint
]

{ #category : 'as yet unclassified' }
CMBlAgentBuilder >> povOfAgent: anAgent [

	^ anAgent pov.
]

{ #category : 'accessing' }
CMBlAgentBuilder >> shape [
	^ shape
]

{ #category : 'as yet unclassified' }
CMBlAgentBuilder >> shapeElementClass [
	shapeType = #circle ifTrue: [ ^CMCircleShape ].
	shapeType = #triangle ifTrue: [ ^ CMTriangleShape ].
	shapeType = #square ifTrue: [ ^ CMSquareShape ].
	shapeType = #pointyHex ifTrue: [ ^ CMPointyTopHexagonShape ].
	shapeType = #flat6 ifTrue: [ ^ CMFlatTopHexagonShape ].
]

{ #category : 'private - layout' }
CMBlAgentBuilder >> updatePosition: aPoint [
	shape position: aPoint.
	
]
