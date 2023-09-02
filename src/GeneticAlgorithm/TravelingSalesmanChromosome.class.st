Class {
	#name : #TravelingSalesmanChromosome,
	#superclass : #Chromosome,
	#instVars : [
		'chromosome',
		'chromosomeSize',
		'totalDistance',
		'travelingSalesmanProblem'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #'as yet unclassified' }
TravelingSalesmanChromosome class >> generateRandomIndividual [

	| city cities |
	"Start with the second city, B"
	
	"Add the other cities in order until the last city."
	
	"Mix randonmly the collection"
	
	"Add initial city at the end and last"
	
	^ self chromosome: OrderedCollection new
]

{ #category : #comparing }
TravelingSalesmanChromosome >> = aTravelingSalesmanChromosome [

	"Compare with objects of the same class"

	"The chromosome string are unique"

	
]

{ #category : #calculating }
TravelingSalesmanChromosome >> calculateFitness [
	"We add 2 to not have 0"

	^ travelingSalesmanProblem maximumDistance + 2 - self totalDistance
]

{ #category : #calculating }
TravelingSalesmanChromosome >> calculateTotalDistance [

	totalDistance := 0.
	^ totalDistance
]

{ #category : #accessing }
TravelingSalesmanChromosome >> chromosome [

	^ chromosome
]

{ #category : #accessing }
TravelingSalesmanChromosome >> chromosome: aCollection [
]

{ #category : #accessing }
TravelingSalesmanChromosome >> chromosomeSize [

	^ chromosomeSize
]

{ #category : #accessing }
TravelingSalesmanChromosome >> chromosomeString [

	^ String streamContents: [ :stream | chromosome do: [ :e | stream nextPut: e ] ]
]

{ #category : #api }
TravelingSalesmanChromosome >> cross: anotherChromosome [

	| random l1 l2 inferiorLimit superiorLimit anotherChromosomeCopy chromosomeCopy initialCity child |

	"Take initial city"
	
	"Remove home cities from crossing chromosomes"
	
	"Generete the lower and upper limit. The limits range should not be the equal or bigger as
	the chromosome size. The limits should not be the same neither."

	"Create the child collection"

	"Within the range of the limits, copy the subcollection of chromosomeCopy into the child.
	Remove those cities of anotherChromosome"
	
	"For the nil characters, add the rest of the anotherChromosomeCopy cities in order removing them."
	
	"Add initial city"
	
	"Return new instance with the new chrosome"
	^ self class
]

{ #category : #comparing }
TravelingSalesmanChromosome >> hash [

	"Overrride me"
]

{ #category : #initialization }
TravelingSalesmanChromosome >> initialize [

	super initialize
]

{ #category : #api }
TravelingSalesmanChromosome >> mutate [
	"Swap two chromosome elements at a random position"

	| random positionToMutate temp |
	
	"Get position to swap. Do not swap the initial city (the first and the last)"
	
	"temp variable to swap"
	
	"swap position with position + 1"

]

{ #category : #printing }
TravelingSalesmanChromosome >> printOn: aStream [

	super printOn: aStream
]

{ #category : #calculating }
TravelingSalesmanChromosome >> removeHomeCity [
	"The home city is always at the start and at the end"

	"Return a copy. Do not modify original receiver"
	^ chromosome copy
]

{ #category : #api }
TravelingSalesmanChromosome >> totalDistance [

	^ totalDistance ifNil: [ totalDistance := self calculateTotalDistance ]
]
