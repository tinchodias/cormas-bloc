Class {
	#name : 'CMTriangleGrid',
	#superclass : 'CMGrid',
	#category : 'CellFactory',
	#package : 'CellFactory'
}

{ #category : 'instance creation' }
CMTriangleGrid >> build [

    | space stepX stepY |

    space := BlSpace new.
    space show.

    stepX := 3 sqrt /2 * shapeSize.
    stepY :=  3/2 * shapeSize.

    1 to: rows do: [:row |
        1 to: columns do: [:col |

            | x y orientation shape |

            x := gridPosition x
                + (col - 1) * stepX
                .

            y := gridPosition y
                + (row - 1) * stepY.

            orientation :=
                ((row + col) odd)
                    ifTrue: [ #top ]
                    ifFalse: [ #bottom ].

            shape := CMTriangleShape new
                size: shapeSize ;
                color: Color orange;
                borderColor: Color black;
                borderWidth: 1;
                position: x @ y;
                orientation: orientation.

            space root addChild: shape element.
        ].
    ].
]
