Class {
	#name : #ChromosomeVisualizerPresenter,
	#superclass : #SpRoassalPresenter,
	#instVars : [
		'individual',
		'travelingSalesman',
		'geneticAlgorithm'
	],
	#category : #'GeneticAlgorithm-UI'
}

{ #category : #roassal }
ChromosomeVisualizerPresenter >> addLegend: canvas [

	| label |
	label := RSMultilineLabelBuilder new shapeFor: self legengText.
	label isFixed: true.
	RSHorizontalLineLayout on: { label }.
	canvas addShape: label
]

{ #category : #roassal }
ChromosomeVisualizerPresenter >> createEdges: nodes [

	| edges |
	edges := (1 to: nodes size - 1) collect: [ :i |
		         self makeLineFrom: (nodes at: i) to: (nodes at: i + 1) ]
		         as: OrderedCollection.
	edges add: (self makeLineFrom: nodes last to: nodes first).
	^ edges
]

{ #category : #roassal }
ChromosomeVisualizerPresenter >> createNodes [

	| boxes labels models colors |
	models := individual chromosome allButLast.
	colors := #('2191FB' '4877CF' '6E5CA3' '944277' 'BA274A' '841C26' '9B8484' 'A7B8B3' 'B2ECE1' '8CDEDC')
		collect: [ :hex | Color fromHexString: hex ].
	boxes := (1 to: models size) collect: [ :i |
		RSBox new
			color: Color white;
			border: (RSBorder new joinMiter; color: (colors at: i));
			yourself ].
	boxes first color: (Color fromHexString: '457b9d').
	labels := (1 to: models size) collect: [ :i |
		RSLabel new
			color: Color black;
			yourself ].
	^ RSComposite models: models boxes: boxes labels: labels
]

{ #category : #accessing }
ChromosomeVisualizerPresenter >> geneticAlgorithm: ga [

	geneticAlgorithm := ga
]

{ #category : #accessing }
ChromosomeVisualizerPresenter >> individual: anIndividual [

	individual := anIndividual
]

{ #category : #initialization }
ChromosomeVisualizerPresenter >> initialize [

	super initialize.

	self script: [ :canvas | self renderIn: canvas ].
	travelingSalesman := TravelingSalesmanProblem new
]

{ #category : #accessing }
ChromosomeVisualizerPresenter >> legengText [

	^ 'Generation: ' , geneticAlgorithm generations asString , String cr , 'Fitness: '
	  , individual fitness asString , String cr , 'Distance: ' , individual totalDistance asString
	  , String cr , ' Has converged: ' , geneticAlgorithm doesItConverge asString
]

{ #category : #roassal }
ChromosomeVisualizerPresenter >> makeLayout: canvas [

	| forceBasedLayout |
	RSCircleLayout on: canvas nodes.

	forceBasedLayout := RSForceBasedLayout new
		                    length: 80;
		                    charge: -300;
		                    addNodes: canvas nodes;
		                    edges: OrderedCollection empty;
		                    alpha: 0.1;
		                    yourself.

	canvas lines do: [ :e |
		| mockedLine |
		mockedLine := (forceBasedLayout newMockLineFor: e) length: e model * 15.
		forceBasedLayout edges add: mockedLine ].

	canvas newAnimation repeat onStepDo: [ :t |
		forceBasedLayout step.
		canvas zoomToFit ].
	canvas nodes @ (RSDraggableForceInteraction new layout: forceBasedLayout)
]

{ #category : #roassal }
ChromosomeVisualizerPresenter >> makeLineFrom: a to: b [

	| distance |
	distance := travelingSalesman distanceBetween: a model and: b model.
	^ RSArrowedLine new
		  from: a;
		  to: b;
		  model: distance;
		  withBorderAttachPoint;
		  color: Color black;
		  yourself
]

{ #category : #roassal }
ChromosomeVisualizerPresenter >> renderIn: canvas [

	| nodes |
	individual ifNil: [ ^ self ].
	nodes := self createNodes.
	canvas addAll: nodes.
	canvas addAll: (self createEdges: nodes).

	self makeLayout: canvas.

	canvas @ RSCanvasController.
	self addLegend: canvas.
	"nodes @ RSDraggable"
]
