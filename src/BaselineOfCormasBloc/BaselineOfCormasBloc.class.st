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
			self declareBlocOn: spec.

			spec
				package: 'CellFactory'
				with: [ spec requires: #('Bloc') ] ]
]

{ #category : 'external projects' }
BaselineOfCormasBloc >> declareBlocOn: spec [

	spec
		baseline: 'Bloc'
		with: [ spec repository: 'github://pharo-graphics/Bloc:v2.8.0/src' ]
]
