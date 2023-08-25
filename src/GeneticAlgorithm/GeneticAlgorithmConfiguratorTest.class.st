"
A GeneticAlgorithmConfiguratorTest is a test class for testing the behavior of GeneticAlgorithmConfigurator
"
Class {
	#name : #GeneticAlgorithmConfiguratorTest,
	#superclass : #TestCase,
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #tests }
GeneticAlgorithmConfiguratorTest >> testInitialize [

	| configurator |
	configurator := GeneticAlgorithmConfigurator new.

	self assert: configurator crossProbability equals: 0.7.
	self assert: configurator mutationProbability equals: 0.001.
	self assert: configurator convergenceRate equals: 0.9.
	self assert: configurator initialPopulationSize equals: 1000
]
