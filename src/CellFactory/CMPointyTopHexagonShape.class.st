Class {
	#name : 'CMPointyTopHexagonShape',
	#superclass : 'CMHexagonShape',
	#category : 'CellFactory',
	#package : 'CellFactory'
}

{ #category : 'examples' }
CMPointyTopHexagonShape class >> example [

	self new show
]

{ #category : 'accessing' }
CMPointyTopHexagonShape >> extent [
    | r |

    r := size.

    ^ (r * 3 sqrt) @ (r * 2)
]

{ #category : 'accessing' }
CMPointyTopHexagonShape >> geometry [
    | r a |

    r := size.
    a := r * (3 sqrt / 2).

    ^ BlPolygonGeometry vertices: {
        (0 @ r).

        (a @ (r / 2)).
        (a @ (-1 * r / 2)).

        (0 @ (-1 * r)).

        (-1 * a @ (-1 * r / 2)).
        (-1 * a @ (r / 2))
    }
]
