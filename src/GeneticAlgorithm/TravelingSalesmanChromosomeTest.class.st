Class {
	#name : #TravelingSalesmanChromosomeTest,
	#superclass : #TestCase,
	#instVars : [
		'travelingSalesmanProblem',
		'chromosome'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #tests }
TravelingSalesmanChromosomeTest >> calculateDistance: travelingSalesmanChromosome [

	| distance startingValue chromosomeString distancesMatrix |
	chromosomeString := travelingSalesmanChromosome chromosomeString.
	distancesMatrix := TravelingSalesmanProblem new distancesMatrix.
	distance := 0.
	startingValue := $A asciiValue - 1.

	1 to: travelingSalesmanChromosome chromosomeSize - 1 do: [ :i |
		| a b |
		a := (chromosomeString at: i) asciiValue - startingValue.
		b := (chromosomeString at: i + 1) asciiValue - startingValue.
		distance := distance + ((distancesMatrix at: a) at: b) ].
	^ distance
]

{ #category : #running }
TravelingSalesmanChromosomeTest >> setUp [

	super setUp.

	travelingSalesmanProblem := TravelingSalesmanProblem new.
	chromosome := TravelingSalesmanChromosome chromosome: 'ABCDEFGHIJA'.
]

{ #category : #tests }
TravelingSalesmanChromosomeTest >> testCalculateFitness [

	| distance chromosomeString |
	chromosomeString := 'ABCDEFGHIJA'.
	chromosome := TravelingSalesmanChromosome chromosome: chromosomeString.
	distance := 38.

	self assert: chromosome calculateFitness
		equals: travelingSalesmanProblem maximumDistance + 2 - distance
]

{ #category : #tests }
TravelingSalesmanChromosomeTest >> testCalculateTotalDistance [

	self assert: chromosome calculateTotalDistance equals: 38.

	chromosome := TravelingSalesmanChromosome chromosome: 'ACBHJDFGIEA'.
	self
		assert: chromosome calculateTotalDistance
		equals: travelingSalesmanProblem maximumDistance.

	chromosome := TravelingSalesmanChromosome chromosome: 'ADEHFICJBGA'.
	self assert: chromosome calculateTotalDistance equals: 20
]

{ #category : #tests }
TravelingSalesmanChromosomeTest >> testChromosome [

	self assert: chromosome chromosome class equals: OrderedCollection
]

{ #category : #tests }
TravelingSalesmanChromosomeTest >> testChromosomeSize [

	self assert: chromosome chromosomeSize equals: 11
]

{ #category : #tests }
TravelingSalesmanChromosomeTest >> testChromosomeString [

	self assert: chromosome chromosomeString class equals: ByteString.
	self
		assert: chromosome chromosomeString size
		equals: chromosome chromosomeSize
]

{ #category : #tests }
TravelingSalesmanChromosomeTest >> testCross [

	| chromosomeOne chromosomeTwo child |
	chromosomeOne := TravelingSalesmanChromosome generateRandomIndividual.
	chromosomeTwo := TravelingSalesmanChromosome generateRandomIndividual.
	child := chromosomeOne cross: chromosomeTwo.

	"It must start and end in the initial city"
	self assert: child chromosomeString first equals: $A.
	self assert: child chromosomeString last equals: $A.
	"It must have the all the other cities"
	self assertCollection: (child chromosomeString copyFrom: 2 to: child chromosomeString size - 1) hasSameElements: 'BCDEFGHIJ'
]

{ #category : #tests }
TravelingSalesmanChromosomeTest >> testGenerateRandomIndividual [

	| chromosomeString |
	chromosome := TravelingSalesmanChromosome generateRandomIndividual.
	chromosomeString := chromosome chromosomeString.

	self assert: chromosomeString size equals: chromosome chromosomeSize.

	"It must start and end in the initial city"
	self assert: chromosomeString first equals: $A.
	self assert: chromosomeString last equals: $A.
	"It must have the all the other cities"
	self
		assertCollection: (chromosomeString copyFrom: 2 to: chromosomeString size - 1)
		hasSameElements: 'BCDEFGHIJ'
]

{ #category : #tests }
TravelingSalesmanChromosomeTest >> testMutate [

	| originalChromosomeString difference |
	originalChromosomeString := chromosome chromosomeString.
	chromosome mutate.
	self deny: chromosome chromosomeString equals: originalChromosomeString.
	"Swap only one city"
	difference := OrderedCollection empty.
	originalChromosomeString with: chromosome chromosomeString do: [ :a :b |
		difference add: (a = b ifTrue: [ 0 ] ifFalse: [ 1 ]) ].
	self assert: difference sum equals: 2.

	"It must start and end in the initial city"
	self assert: chromosome chromosomeString first equals: $A.
	self assert: chromosome chromosomeString last equals: $A.
	"It must have the all the other cities"
	self assertCollection: chromosome removeHomeCity hasSameElements: 'BCDEFGHIJ'
]

{ #category : #tests }
TravelingSalesmanChromosomeTest >> testRemoveHomeCity [

	| chromosomeCollection |
	chromosomeCollection := chromosome chromosome.

	self assert: chromosome chromosome first equals: $A.
	self assert: chromosome chromosome last equals: $A.

	chromosomeCollection := chromosome removeHomeCity.

	self deny: chromosomeCollection first equals: $A.
	self deny: chromosomeCollection last equals: $A.

	"Original chromosome didn't change"
	self assert: chromosome chromosome first equals: $A.
	self assert: chromosome chromosome last equals: $A
]
