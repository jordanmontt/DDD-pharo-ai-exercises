Class {
	#name : #SimpleGAPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'geneticAlgorithm',
		'evolveButton',
		'generatePopulationButton',
		'resetButton',
		'chromosomeVisualizerPresenter',
		'inspectButton'
	],
	#category : #'GeneticAlgorithm-UI'
}

{ #category : #'instance creation' }
SimpleGAPresenter class >> open [

	<script>
	^ self new open
]

{ #category : #initialization }
SimpleGAPresenter >> connectPresenters [

	evolveButton action: [ self evolveAction ].
	resetButton action: [ self resetAction ].
	inspectButton action: [ self inspectAction ].
	generatePopulationButton action: [ self generateRandomPopulationAction ]
]

{ #category : #layout }
SimpleGAPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: generatePopulationButton;
				   add: evolveButton;
				   add: inspectButton;
				   add: resetButton;
				   yourself)
		  expand: false;
		  add: chromosomeVisualizerPresenter;
		  yourself
]

{ #category : #action }
SimpleGAPresenter >> evolveAction [

	geneticAlgorithm population ifNil: [
		self openAlertModal.
		^ self ].

	geneticAlgorithm evolveOneGeneration.
	geneticAlgorithm doesItConverge & geneticAlgorithm convergedGeneration isNil ifTrue: [
		geneticAlgorithm convergedGeneration: geneticAlgorithm generations ].

	chromosomeVisualizerPresenter
		geneticAlgorithm: geneticAlgorithm;
		individual: geneticAlgorithm population atRandom;
		refresh
]

{ #category : #action }
SimpleGAPresenter >> generateRandomPopulationAction [

	geneticAlgorithm generatePopulation.
	chromosomeVisualizerPresenter
		geneticAlgorithm: geneticAlgorithm;
		individual: geneticAlgorithm population atRandom;
		refresh
]

{ #category : #initialization }
SimpleGAPresenter >> initialize [

	geneticAlgorithm := SimpleGeneticAlgorithm new.
	super initialize
]

{ #category : #initialization }
SimpleGAPresenter >> initializePresenters [

	chromosomeVisualizerPresenter := self instantiate: ChromosomeVisualizerPresenter.
	evolveButton := self newButton
		label: 'Evolve one generation';
		iconName: #smallDoIt;
		yourself.
	inspectButton := self newButton
		label: 'Inspect';
		iconName: #smallInspectIt;
		yourself.
	generatePopulationButton := self newButton
		label: 'Generate random population';
		iconName: #smallNew;
		yourself.
	resetButton := self newButton
		label: 'Reset';
		yourself
]

{ #category : #initialization }
SimpleGAPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Traveling Salesman Genetic Algoritm';
		initialExtent: 600 @ 500
]

{ #category : #action }
SimpleGAPresenter >> inspectAction [

	geneticAlgorithm inspect
]

{ #category : #action }
SimpleGAPresenter >> openAlertModal [

	| alertModal |
	alertModal := SpModalWindowPresenter new.
	alertModal
		presenter: 'No population' asPresenter;
		title: 'Alert';
		open
]

{ #category : #action }
SimpleGAPresenter >> resetAction [

	geneticAlgorithm := SimpleGeneticAlgorithm new.
	chromosomeVisualizerPresenter
		individual: nil;
		refresh
]
