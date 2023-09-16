"
I am a modelization of the traveling salesman problem (https://en.wikipedia.org/wiki/Travelling_salesman_problem).
I represent the graph as an adjacency matrix.
"
Class {
	#name : 'TravelingSalesmanProblem',
	#superclass : 'Object',
	#instVars : [
		'distancesMatrix'
	],
	#category : 'GeneticAlgorithm-Core',
	#package : 'GeneticAlgorithm',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
TravelingSalesmanProblem class >> numberOfCities [

	^ 10
]

{ #category : 'api' }
TravelingSalesmanProblem >> distanceBetween: cityA and: cityB [

	| startingValue |
	"Collections  indeces start at 1"
	startingValue := $A asciiValue - 1.
	^ (distancesMatrix at: cityA asciiValue - startingValue) at: cityB asciiValue - startingValue
]

{ #category : 'accessing' }
TravelingSalesmanProblem >> distancesMatrix [

	^ distancesMatrix
]

{ #category : 'initialization' }
TravelingSalesmanProblem >> initialize [

	super initialize.
	distancesMatrix := {
		                   { 0. 5. 9. 1. 8. 5. 1. 4. 4. 2 }.
		                   { 5. 0. 8. 6. 7. 4. 2. 6. 5. 3 }.
		                   { 9. 8. 0. 4. 2. 6. 3. 5. 2. 1 }.
		                   { 1. 6. 4. 0. 3. 5. 5. 3. 3. 4 }.
		                   { 8. 7. 2. 3. 0. 4. 2. 2. 4. 2 }.
		                   { 5. 4. 6. 5. 4. 0. 5. 3. 2. 3 }.
		                   { 1. 2. 3. 5. 2. 5. 0. 1. 4. 4 }.
		                   { 4. 6. 5. 3. 2. 3. 1. 0. 3. 5 }.
		                   { 4. 5. 2. 3. 4. 2. 4. 3. 0. 3 }.
		                   { 2. 3. 1. 4. 2. 3. 4. 5. 3. 0 } }
]

{ #category : 'accessing' }
TravelingSalesmanProblem >> maximumDistance [

	^ 58
]
