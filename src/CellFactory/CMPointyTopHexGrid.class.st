Class {
	#name : 'CMPointyTopHexGrid',
	#superclass : 'CMHexagonGrid',
	#category : 'CellFactory',
	#package : 'CellFactory'
}

{ #category : 'building' }
CMPointyTopHexGrid >> build [
    | space r w h xStep yStep offsetX |

    space := BlSpace new.
    space show.

    r := shapeSize.
    w := 2 * r.
    h := 2 * r.

    xStep := w * (3 sqrt / 2).
    yStep := h * 3 / 4.

    offsetX := xStep / 2.

    1 to: rows do: [:row |
        1 to: columns do: [:col |
            | x y shape |

            x := (col - 1) * xStep.
            y := (row - 1) * yStep.

            (row even) ifTrue: [
                x := x + offsetX
            ].

            shape := CMPointyTopHexagonShape new
                size: r;
                position: x @ y;
                color: Color yellow;
                borderColor: Color black;
                borderWidth: 1.

            space root addChild: shape element
        ].
    ].
]
