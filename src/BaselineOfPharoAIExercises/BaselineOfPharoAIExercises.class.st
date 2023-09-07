Class {
	#name : #BaselineOfPharoAIExercises,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoAIExercises
}

{ #category : #baselines }
BaselineOfPharoAIExercises >> baseline: spec [

	<baseline>
	spec for: #common do: [
		"Packages"
		spec package: 'GeneticAlgorithm'.
		spec package: 'AI-KMeans'.

		"Groups"
		spec group: 'default' with: #( 'GeneticAlgorithm' 'AI-KMeans' ) ]
]
