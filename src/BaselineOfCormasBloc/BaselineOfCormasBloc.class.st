Class {
	#name : 'BaselineOfCormasBloc',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCormasBloc',
	#package : 'BaselineOfCormasBloc'
}

{ #category : 'baselines' }
BaselineOfCormasBloc >> baseline: spec [
	<baseline>

	spec
		for: #common
		do: [ 
			self declareCormasOn: spec.
			self declareBlocOn: spec.

			spec
				package: 'CellFactory'
				with: [ spec requires: #('Cormas' 'Bloc') ] ]
]

{ #category : 'external projects' }
BaselineOfCormasBloc >> declareBlocOn: spec [

	spec
		baseline: 'Bloc'
		with: [ spec repository: 'github://pharo-graphics/Bloc:v2.8.0/src' ]
]

{ #category : 'external projects' }
BaselineOfCormasBloc >> declareCormasOn: spec [

	spec
		baseline: 'Cormas'
		with: [ spec repository: 'github://cormas/cormas:v0.97.1/src' ]
]
