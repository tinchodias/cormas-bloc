Class {
	#name : 'CMFlatTopHexagonShape',
	#superclass : 'CMHexagonShape',
	#category : 'CellFactory',
	#package : 'CellFactory'
}

{ #category : 'examples' }
CMFlatTopHexagonShape class >> example [

	self new show
]

{ #category : 'accessing' }
CMFlatTopHexagonShape >> extent [
    | r |

    r := size.
    ^ (r * 2) @ (r * 3 sqrt)
]

{ #category : 'accessing' }
CMFlatTopHexagonShape >> geometry [
    | r h a |

    r := size.
    h := r * 3 sqrt / 2.   
    a := r * (3 sqrt / 2). 

    ^ BlPolygonGeometry vertices: {
        ( r @ 0).
        ( r / 2 @ a).
        (-1*r / 2 @ a).
        (-1*r @ 0).
        (-1*r / 2 @ (-1*a)).
        ( r / 2 @ (-1*a) )
    }
]
