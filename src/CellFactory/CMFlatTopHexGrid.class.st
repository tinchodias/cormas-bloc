Class {
	#name : 'CMFlatTopHexGrid',
	#superclass : 'CMHexagonGrid',
	#category : 'CellFactory',
	#package : 'CellFactory'
}

{ #category : 'building' }
CMFlatTopHexGrid >> build [
    | space r w h xStep yStep offsetY |

    space := BlSpace new.
    space show.

    r := shapeSize.
    w := 2 * r.
    h := 2 * r.

    xStep := w * 3 / 4.
    yStep := h * (3 sqrt / 2).

    offsetY := yStep / 2.

    1 to: rows do: [:row |
        1 to: columns do: [:col |
            | x y shape |

            x := (col - 1) * xStep.
            y := (row - 1) * yStep.

            (col even) ifTrue: [
                y := y + offsetY
            ].

            shape := CMFlatTopHexagonShape new
                size: r;
                position: x @ y;
                color: Color yellow;
                borderColor: Color black;
                borderWidth: 1.

            space root addChild: shape element
        ].
    ].
]
