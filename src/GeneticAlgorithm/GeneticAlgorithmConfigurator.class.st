"
I am an object that serves to provide the default parameters for the simple genetic algorithm
"
Class {
	#name : #GeneticAlgorithmConfigurator,
	#superclass : #Object,
	#instVars : [
		'crossProbability',
		'mutationProbability',
		'initialPopulationSize',
		'convergenceRate'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GeneticAlgorithmConfigurator >> convergenceRate [

	^ convergenceRate
]

{ #category : #accessing }
GeneticAlgorithmConfigurator >> convergenceRate: aFloat [
	"A number in the range [0.0, 1.0]"

	convergenceRate := aFloat
]

{ #category : #accessing }
GeneticAlgorithmConfigurator >> crossProbability [

	^ crossProbability
]

{ #category : #accessing }
GeneticAlgorithmConfigurator >> crossProbability: anObject [

	crossProbability := anObject
]

{ #category : #accessing }
GeneticAlgorithmConfigurator >> initialPopulationSize [

	^ initialPopulationSize
]

{ #category : #accessing }
GeneticAlgorithmConfigurator >> initialPopulationSize: anObject [

	initialPopulationSize := anObject
]

{ #category : #initialization }
GeneticAlgorithmConfigurator >> initialize [

	super initialize
]

{ #category : #accessing }
GeneticAlgorithmConfigurator >> mutationProbability [

	^ mutationProbability
]

{ #category : #accessing }
GeneticAlgorithmConfigurator >> mutationProbability: anObject [

	mutationProbability := anObject
]
