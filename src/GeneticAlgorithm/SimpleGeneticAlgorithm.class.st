"
I am an implementation of a Simple Genetic algorithm. I use the roulette Wheel Selection (https://en.wikipedia.org/wiki/Fitness_proportionate_selection) as the algorithm for randomly choosing the crossing individuals.

For using me, you need to subclass the class Chromosome and implement the missing methods.

I am implemented to **maximize** the fitness function (look the `reducePopulation` method)
"
Class {
	#name : #SimpleGeneticAlgorithm,
	#superclass : #Object,
	#instVars : [
		'population',
		'random',
		'generations',
		'configurator',
		'convergedGeneration'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
SimpleGeneticAlgorithm >> configurator [

	^ configurator
]

{ #category : #accessing }
SimpleGeneticAlgorithm >> convergedGeneration [

	^ convergedGeneration
]

{ #category : #accessing }
SimpleGeneticAlgorithm >> convergedGeneration: anInteger [

	convergedGeneration := anInteger
]

{ #category : #'genetic algorithm' }
SimpleGeneticAlgorithm >> createMapHowManyTimesFitnessAppears [
	"This is the same as doing `(population collect: #fitness) asBag` and then ask for the
	values, for example with `aBag valuesAndCounts values`. But this implementation is faster."

	"Create a map, or a Dictionary, that contains each fitness value of the population with how
	many times that fitness value is present. So, count the ocurrences of the fitness values
	in the population"

	^ {  }
]

{ #category : #'genetic algorithm' }
SimpleGeneticAlgorithm >> doesItConverge [

	| elementsThatMustHaveTheSameFitnessValue fitnessFrequency |
	"Calculate the number of elements that should have the same value"
	
	fitnessFrequency := self createMapHowManyTimesFitnessAppears.
	
	"Search if there is the sufficient elements with the same value in the map."
	
	^ false
]

{ #category : #'genetic algorithm' }
SimpleGeneticAlgorithm >> evolveOneGeneration [

	| numberOfCrosses rouletteWheelSelection father mother childOne childTwo descendants |
	descendants := OrderedCollection empty.
	numberOfCrosses := configurator initialPopulationSize * configurator crossProbability / 2.

	"the indidividuals with a better fitness function will be more likely to be chosen"
	rouletteWheelSelection := self rouletteWheelSelection.

	[ numberOfCrosses = 0 ] whileFalse: [
		"Select randomly the two individuals that will cross"
		father := rouletteWheelSelection at: (random nextInteger: rouletteWheelSelection size).
		mother := rouletteWheelSelection at: (random nextInteger: rouletteWheelSelection size).

		"Cross the individuals and obtain their descendants"
		childOne := father cross: mother.
		childTwo := mother cross: father.

		"Mutate the descendants"
		childOne := self mutate: childOne.
		childTwo := self mutate: childTwo.

		"Insert childre into the descendants population"
		descendants add: childOne.
		descendants add: childTwo.

		numberOfCrosses := numberOfCrosses - 1 ].

	"Join old population (population) with the new population (descendants)"
	population addAll: descendants.
	population := self reducePopulation.
	generations := generations + 1
]

{ #category : #'genetic algorithm' }
SimpleGeneticAlgorithm >> generatePopulation [
	"Generate a random population of the initialPopulationSize size"

	^ {  }
]

{ #category : #accessing }
SimpleGeneticAlgorithm >> generations [

	^ generations
]

{ #category : #'genetic algorithm' }
SimpleGeneticAlgorithm >> hasToMutate [

	| probability randomNumber |
	probability := self mutationIntegerProbability.
	"Generate a random number within the probability"
	randomNumber := random nextInteger: probability.
	"Compare with arbitrary number"
	^ false
]

{ #category : #initialization }
SimpleGeneticAlgorithm >> initialize [

	super initialize
]

{ #category : #'genetic algorithm' }
SimpleGeneticAlgorithm >> mutate: individual [

	self hasToMutate ifTrue: [ individual mutate ].
	^ individual
]

{ #category : #'genetic algorithm' }
SimpleGeneticAlgorithm >> mutationIntegerProbability [

	| probability aux |
	"Get the probability as a integer number.
	0.1 Becomes 10.
	0.001 becomes 1000"
	^ 0
]

{ #category : #accessing }
SimpleGeneticAlgorithm >> population [

	^ population
]

{ #category : #accessing }
SimpleGeneticAlgorithm >> population: aCollection [

	population := aCollection
]

{ #category : #'genetic algorithm' }
SimpleGeneticAlgorithm >> reducePopulation [

	| reducedPopulation sortedPopulation |
	reducedPopulation := OrderedCollection empty.
	"Sort with the higher fitness is the best"

	"Take the best fits"

	^ {  }
]

{ #category : #'genetic algorithm' }
SimpleGeneticAlgorithm >> rouletteWheelSelection [
	"https://en.wikipedia.org/wiki/Fitness_proportionate_selection"

	| flatteredPopulation |
	flatteredPopulation := OrderedCollection empty.
	"Create a collection with n times each fitness of each element"

	^ {  }
]

{ #category : #api }
SimpleGeneticAlgorithm >> run [

	| doesConverge |
	"Generate random population"
	
	"Reset generations"
	
	"While it does not converge, evolve one generation"
		
	"Update convergedGeneration"
	
	"Return the best chromosome. Population is already sorted"
	^ nil
]
