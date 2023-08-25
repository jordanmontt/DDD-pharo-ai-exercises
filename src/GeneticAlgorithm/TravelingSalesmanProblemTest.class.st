"
A TravelingSalesmanProblemTest is a test class for testing the behavior of TravelingSalesmanProblem
"
Class {
	#name : #TravelingSalesmanProblemTest,
	#superclass : #TestCase,
	#instVars : [
		'travelingSalesmanProblem'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #tests }
TravelingSalesmanProblemTest >> distanceMatrix [

	^ {
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

{ #category : #running }
TravelingSalesmanProblemTest >> setUp [

	super setUp.

	travelingSalesmanProblem := TravelingSalesmanProblem new
]

{ #category : #tests }
TravelingSalesmanProblemTest >> testDistanceBetweenAnd [

	self
		assert: (travelingSalesmanProblem distanceBetween: $A and: $B)
		equals: ((self distanceMatrix at: 1) at: 2).
	
	self
		assert: (travelingSalesmanProblem distanceBetween: $D and: $E)
		equals: ((self distanceMatrix at: 4) at: 5).
		
	self
		assert: (travelingSalesmanProblem distanceBetween: $J and: $B)
		equals: ((self distanceMatrix at: 10) at: 2)
]

{ #category : #tests }
TravelingSalesmanProblemTest >> testDistancesMatrix [

	| distancesMatrix |
	distancesMatrix := self distanceMatrix.
	travelingSalesmanProblem distancesMatrix doWithIndex: [ :anArray :i |
		self assert: anArray equals: (distancesMatrix at: i) ]
]

{ #category : #tests }
TravelingSalesmanProblemTest >> testMaximumDistance [

	self assert: travelingSalesmanProblem maximumDistance equals: 58
]

{ #category : #tests }
TravelingSalesmanProblemTest >> testNumberOfCities [

	self assert: travelingSalesmanProblem numberOfCities equals: 10.
	self assert: travelingSalesmanProblem class numberOfCities equals: 10
]
