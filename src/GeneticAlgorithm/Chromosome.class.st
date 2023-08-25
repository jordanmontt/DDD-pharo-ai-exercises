"
I am a chromosome used for the SimpleGeneticAlgorithm. You need to subclass me and implement the missing methods.

Basically, you need to implement how I can random generate an individual, how to cross two individuals, how to mutate me, and how to calculate my fitness function
"
Class {
	#name : #Chromosome,
	#superclass : #Object,
	#instVars : [
		'fitnessValue'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #'as yet unclassified' }
Chromosome class >> generateRandomIndividual [

	^ self subclassResponsibility
]

{ #category : #calculating }
Chromosome >> calculateFitness [

	^ self subclassResponsibility
]

{ #category : #api }
Chromosome >> cross: anotherChromosome [

	^ self subclassResponsibility
]

{ #category : #api }
Chromosome >> fitness [

	^ fitnessValue ifNil: [ fitnessValue := self calculateFitness ]
]

{ #category : #api }
Chromosome >> mutate [

	self subclassResponsibility
]
