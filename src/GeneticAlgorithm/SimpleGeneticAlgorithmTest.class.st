"
A GeneticAlgorithmTest is a test class for testing the behavior of GeneticAlgorithm
"
Class {
	#name : #SimpleGeneticAlgorithmTest,
	#superclass : #TestCase,
	#instVars : [
		'geneticAlgorithm'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #running }
SimpleGeneticAlgorithmTest >> setUp [

	super setUp.

	geneticAlgorithm := SimpleGeneticAlgorithm new
]

{ #category : #tests }
SimpleGeneticAlgorithmTest >> testCreateMapHowManyTimesFitnessAppears [

	| individualOne individualTwo map |
	individualOne := TravelingSalesmanChromosome chromosome: 'ACBHJDFGIEA'.
	individualTwo := TravelingSalesmanChromosome chromosome: 'ADEHFICJBGA'.

	geneticAlgorithm population: { individualOne . individualOne copy . individualOne copy . individualTwo . individualTwo copy }.
	geneticAlgorithm configurator initialPopulationSize: 5.

	map := geneticAlgorithm createMapHowManyTimesFitnessAppears.

	self assert: map size equals: 2.
	self assert: (map at: individualOne fitness) equals: 3.
	self assert: (map at: individualTwo fitness) equals: 2.
]

{ #category : #tests }
SimpleGeneticAlgorithmTest >> testDoesItConverge [

	| population populationSize convergenceRate |
	populationSize := 1000.
	convergenceRate := 0.8. "80%"
	population := OrderedCollection empty.

	geneticAlgorithm configurator initialPopulationSize: 1000.
	geneticAlgorithm configurator convergenceRate: convergenceRate.

	"Add 80% of equal chromosomes"
	population addAll: ((1 to: populationSize * convergenceRate) collect: [ :i |
		TravelingSalesmanChromosome chromosome: 'ABCDEFGHIJA' ]).
	"The rest different individuals with different fitness function"
	population addAll: ((1 to: populationSize * (1 - convergenceRate)) collect: [ :i |
		TravelingSalesmanChromosome generateRandomIndividual ]).
	
	geneticAlgorithm population: population.

	"It should converge as we have 80% of individuals with the same fitness function"
	self assert: geneticAlgorithm doesItConverge.
	
	geneticAlgorithm configurator convergenceRate: 0.9.
	self deny: geneticAlgorithm doesItConverge
]

{ #category : #tests }
SimpleGeneticAlgorithmTest >> testEvolveOneGeneration [

	| initialPopulation initialFitness firstIndividual initialGeneration |
	initialPopulation := geneticAlgorithm generatePopulation.
	initialFitness := initialPopulation sum: #fitness.
	initialGeneration := geneticAlgorithm generations.
	geneticAlgorithm evolveOneGeneration.

	"Overall fitness should improve"
	self assert: (geneticAlgorithm population sum: #fitness) > initialFitness.
	"One generations has passed"
	self assert: geneticAlgorithm generations > initialGeneration.

	firstIndividual := geneticAlgorithm population first.
	"Population should be sorted"
	geneticAlgorithm population do: [ :individual |
		self assert: firstIndividual fitness >= individual fitness ]
]

{ #category : #tests }
SimpleGeneticAlgorithmTest >> testGeneratePopulation [

	| population |
	population := geneticAlgorithm generatePopulation.
	self assert: population size equals: geneticAlgorithm configurator initialPopulationSize.
	population do: [ :individual |
		self assert: individual class equals: TravelingSalesmanChromosome ]
]

{ #category : #tests }
SimpleGeneticAlgorithmTest >> testMutationIntegerProbability [

	geneticAlgorithm configurator mutationProbability: 0.0002.
	self assert: geneticAlgorithm mutationIntegerProbability equals: 5000
]

{ #category : #tests }
SimpleGeneticAlgorithmTest >> testReducePopulation [

	| population lowDistanceIndividual highDistanceIndividual reducedPopulation |
	highDistanceIndividual := 'ACBHJDFGIEA'.
	lowDistanceIndividual := 'ADEHFICJBGA'.
	population := OrderedCollection empty.
	8 timesRepeat: [ population add: (TravelingSalesmanChromosome chromosome: lowDistanceIndividual) ].
	8 timesRepeat: [ population add: (TravelingSalesmanChromosome chromosome: highDistanceIndividual) ].

	geneticAlgorithm configurator initialPopulationSize: 10.
	geneticAlgorithm population: population.
	reducedPopulation := geneticAlgorithm reducePopulation.

	self assert: reducedPopulation size equals: 10.
	self
		assert: (reducedPopulation count: [ :e | e chromosomeString = lowDistanceIndividual ])
		equals: 8.
	self
		assert: (reducedPopulation count: [ :e | e chromosomeString = highDistanceIndividual ])
		equals: 2
]

{ #category : #tests }
SimpleGeneticAlgorithmTest >> testRouletteWheelSelection [

	| chromosomes population frequencies |
	chromosomes := #( 'ABCDEFJHIJA' 'AIHJEDBFCGA' 'ABFCJGEHIDA' ).
	population := chromosomes collect: [ :e | TravelingSalesmanChromosome chromosome: e ].
	
	geneticAlgorithm population: population.
	geneticAlgorithm configurator initialPopulationSize: population size.

	self
		assert: geneticAlgorithm rouletteWheelSelection size
		equals: (population sum: [ :individual | individual fitness ]).

	frequencies := geneticAlgorithm rouletteWheelSelection asBag valuesAndCounts.
	population do: [ :individual |
		self assert: (frequencies at: individual) equals: individual fitness ]
]

{ #category : #tests }
SimpleGeneticAlgorithmTest >> testRun [

	| solution |
	geneticAlgorithm configurator convergenceRate: 1.0.
	solution := geneticAlgorithm run.

	self assert: solution fitness equals: 40.
	self assert: solution totalDistance equals: 20.
	self assert: geneticAlgorithm generations < 50
]
