Class {
	#name : 'CMTriangleShape',
	#superclass : 'CMShape',
	#instVars : [
		'orientation'
	],
	#category : 'CellFactory',
	#package : 'CellFactory'
}

{ #category : 'examples' }
CMTriangleShape class >> example [

	self new show
]

{ #category : 'examples' }
CMTriangleShape class >> exampleBottom [

	self newBottom show
]

{ #category : 'examples' }
CMTriangleShape class >> exampleLeft [

	self newLeft show
]

{ #category : 'examples' }
CMTriangleShape class >> exampleRight [

	self newRight show
]

{ #category : 'examples' }
CMTriangleShape class >> exampleTop [

	self newTop show
]

{ #category : 'instance creation' }
CMTriangleShape class >> newBottom [

	^ self new
		orientation: #bottom;
		yourself
]

{ #category : 'instance creation' }
CMTriangleShape class >> newLeft [

	^ self new
		orientation: #left;
		yourself
]

{ #category : 'instance creation' }
CMTriangleShape class >> newRight [

	^ self new
		orientation: #right;
		yourself
]

{ #category : 'instance creation' }
CMTriangleShape class >> newTop [

	^ self new
		orientation: #top;
		yourself
]

{ #category : 'examples' }
CMTriangleShape >> exampleBottom [

	<script: 'self exampleBottom'>
]

{ #category : 'examples' }
CMTriangleShape >> exampleLeft [

	<script: 'self exampleLeft'>
]

{ #category : 'examples' }
CMTriangleShape >> exampleRight [

	<script: 'self exampleRight'>
]

{ #category : 'examples' }
CMTriangleShape >> exampleTop [

	<script: 'self exampleTop'>
]

{ #category : 'accessing' }
CMTriangleShape >> extent [
    | w h |

    w := size * 2.
    h := (3 sqrt * 3 / 2) * size.

    ^ w @ h
]

{ #category : 'accessing' }
CMTriangleShape >> geometry [
    | map |

    map := Dictionary new
        at: #top put: (self triangleTopVertices);
        at: #bottom put: (self triangleBottomVertices);
        at: #left put: (self triangleLeftVertices);
        at: #right put: (self triangleRightVertices);
        yourself.

    ^ BlPolygonGeometry vertices: (map at: orientation)
]

{ #category : 'initialization' }
CMTriangleShape >> initialize [ 
	super initialize.
	orientation := #bottom
]

{ #category : 'accessing' }
CMTriangleShape >> orientation: aSymbol [
	orientation := aSymbol 
]

{ #category : 'as yet unclassified' }
CMTriangleShape >> triangleBottomVertices [
    | r a h |

    r := size.
    a := r * 3 sqrt.
    h := (3 * r) / 2.

    ^ {
        (0 @ (h / 2)).
        (a / -2 @ (h / -2)).
        (a / 2 @ (h / -2))
    }
]

{ #category : 'as yet unclassified' }
CMTriangleShape >> triangleLeftVertices [
    ^ (self triangleTopVertices)
        collect: [ :p |
            (p y) @ (p x)
        ]
]

{ #category : 'as yet unclassified' }
CMTriangleShape >> triangleRightVertices [
    ^ (self triangleLeftVertices)
        collect: [ :p |
            (p x negated) @ p y
        ]
]

{ #category : 'as yet unclassified' }
CMTriangleShape >> triangleTopVertices [

    ^ self triangleBottomVertices
        collect: [ :p |
            p negated
        ]
]
