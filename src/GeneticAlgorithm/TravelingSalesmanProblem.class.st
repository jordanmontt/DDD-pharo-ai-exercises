"
I am a modelization of the traveling salesman problem (https://en.wikipedia.org/wiki/Travelling_salesman_problem).
I represent the graph as an adjacency matrix.
"
Class {
	#name : #TravelingSalesmanProblem,
	#superclass : #Object,
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #'as yet unclassified' }
TravelingSalesmanProblem class >> numberOfCities [

	^ 0
]

{ #category : #api }
TravelingSalesmanProblem >> distanceBetween: cityA and: cityB [

	^ 0
]

{ #category : #accessing }
TravelingSalesmanProblem >> distancesMatrix [

	^ { {  } }
]

{ #category : #initialization }
TravelingSalesmanProblem >> initialize [

	super initialize
]

{ #category : #accessing }
TravelingSalesmanProblem >> maximumDistance [

	^ 0
]

{ #category : #accessing }
TravelingSalesmanProblem >> numberOfCities [

	^ 0
]
