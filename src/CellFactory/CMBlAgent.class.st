Class {
	#name : 'CMBlAgent',
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
CMBlAgent class >> example [ 
| builder simulation model grid agents cellSize agentSize e|


	simulation := (CMSimulation for: ECECModel)
		activeInitSelector: #smallEnvironment;
   		activeControlSelector: #step;
   		initializeSimulation;
   		yourself.

	model := simulation cormasModel.

	grid := CMBlGrid new.
	grid cormasModel: model.
	grid buildPresenter open.
	agentSize :=30@30.
	cellSize := grid shapeExtent.
	agents := model agents.


	e:= CMBlAgent new.
	e displayOn: grid model: model cellSize: cellSize agentSize: agentSize.
]

{ #category : 'as yet unclassified' }
CMBlAgent >> borderColorOfAgent: anAgent [

	^ (self povOfAgent: anAgent) borderColor
]

{ #category : 'as yet unclassified' }
CMBlAgent >> borderWidthOfAgent: anAgent [

	^ (self povOfAgent: anAgent) borderWidth
]

{ #category : 'as yet unclassified' }
CMBlAgent >> colorOfAgent: anAgent [

	^ (self povOfAgent: anAgent) color
]

{ #category : 'as yet unclassified' }
CMBlAgent >> createElementForCell: agent size: aSize pos: position [

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
CMBlAgent >> displayOn: aGrid model: aModel cellSize: aCellSize agentSize: anAgentSize [

	| agent agents x y cellPos agentPos e |
	agents := aModel agents.
    agents do: [ :agent |
   | el cellElement|
		e:= CMBlAgent new.
		cellElement := aGrid elementForCell: agent cell.
	"((agent cell rowNumber - 1) * cellSize x) @ ((agent cell columnNumber - 1) * cellSize y)."
		x := (agent cell columnNumber - 1) * aCellSize x.
   		y := (agent cell rowNumber - 1) * aCellSize y.

    	cellPos := x @ y.

    	agentPos := cellPos + ((aCellSize - anAgentSize ) / 2).
		el := e createElementForCell: agent size: anAgentSize pos: agentPos.
		aGrid gridElement addChild: el.


].

]

{ #category : 'examples' }
CMBlAgent >> example [
	<script: 'self example'>
]

{ #category : 'initialization' }
CMBlAgent >> initialize [
	super initialize.
	shapeType := #circle.
	shapeSize := 5.

]

{ #category : 'accessing' }
CMBlAgent >> localPosition: aPoint [
	localPosition := aPoint
]

{ #category : 'as yet unclassified' }
CMBlAgent >> povOfAgent: anAgent [

	^ anAgent pov.
]

{ #category : 'accessing' }
CMBlAgent >> shape [
	^ shape
]

{ #category : 'as yet unclassified' }
CMBlAgent >> shapeElementClass [
	shapeType = #circle ifTrue: [ ^CMCircleShape ].
	shapeType = #triangle ifTrue: [ ^ CMTriangleShape ].
	shapeType = #square ifTrue: [ ^ CMSquareShape ].
	shapeType = #pointyHex ifTrue: [ ^ CMPointyTopHexagonShape ].
	shapeType = #flat6 ifTrue: [ ^ CMFlatTopHexagonShape ].
]

{ #category : 'private - layout' }
CMBlAgent >> updatePosition: aPoint [
	shape position: aPoint.
	
]
