"
K-Means is a clustering, unsupervised machine learning algorithm.

Please refer to the Pharo wiki for more information [Pharo wiki](https://github.com/pharo-ai/wiki).

We used some comments from [scikitlearn](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html#sklearn.cluster.KMeans.transform) in our code.
"
Class {
	#name : #AIKMeans,
	#superclass : #Object,
	#instVars : [
		'numberOfClusters',
		'centroids',
		'clusters',
		'maxIterations',
		'performedIterations',
		'previousCentroids',
		'rand',
		'timesToRun',
		'euclideanDistance'
	],
	#category : #'AI-KMeans-Core'
}

{ #category : #accessing }
AIKMeans class >> defaultMaxIterations [

	^ 300
]

{ #category : #defaults }
AIKMeans class >> defaultNumberOfTimesItIsRun [
	^ 5
]

{ #category : #'instance creation' }
AIKMeans class >> numberOfClusters: anInteger [

	^ self new
		numberOfClusters: anInteger;
		yourself
]

{ #category : #training }
AIKMeans >> assignClusterToPoints: aCollectionOfPoints [
	"Assign clusters to each point. We choose the cluster whose centroid minimizes has the
	shortest distance to the point"

	clusters := {  }
]

{ #category : #accessing }
AIKMeans >> centroids [

	^ centroids
]

{ #category : #accessing }
AIKMeans >> centroids: aCollectionOfPoints [

	centroids := aCollectionOfPoints
]

{ #category : #training }
AIKMeans >> chooseRandomCentroid: aCollectionOfPoints [

	^ #( 0 0 )
]

{ #category : #accessing }
AIKMeans >> clusters [

	^ clusters
]

{ #category : #accessing }
AIKMeans >> clusters: aCollection [
	"Used for testing"

	clusters := aCollection
]

{ #category : #training }
AIKMeans >> distanceBetween: firstPoint and: secondPoint [
	"It follows the Euclidean distance between two points formula."

	^ 0
]

{ #category : #api }
AIKMeans >> fit: aCollectionOfPoints [

	"API method. This is the method that the user will call for using the KMeans algorithm"
	| score bestScore bestCentroids |

	timesToRun timesRepeat: [
		self kMeansAlgorithm: aCollectionOfPoints.

		"The best centroid points are the ones that minimize the score.
		The score is the sum of the mean square errors of the points and its cluster."
		
		"Update the best score and best centroids here" ].

	"We keep the best centroids after running the algo timesToRun-times"
	centroids := bestCentroids.
	
	"Training is finished. There is one more method that you should call"
]

{ #category : #testing }
AIKMeans >> hasConverged [

	^ false
]

{ #category : #testing }
AIKMeans >> hasReachedMaxIterations [

	^ performedIterations >= maxIterations
]

{ #category : #initialization }
AIKMeans >> initialize [

	super initialize.

	clusters := OrderedCollection new.
	centroids := OrderedCollection new.
	previousCentroids := OrderedCollection new.
	performedIterations := 0.

	rand := Random new.
	euclideanDistance := AIEuclideanDistance new.
	maxIterations := self class defaultMaxIterations.
	timesToRun := self class defaultNumberOfTimesItIsRun
]

{ #category : #training }
AIKMeans >> initializeCentroidsKMeansPlusPlus: points [

	" The k-means++ is an algorithm for initializing the centroids. It was proposed in 2007 by Arthur et Vassilvitskii. 
	
	1. Choose the first centroid to be a random point.
	2. Calculate the distance of all the point to the choosen clusters. Keep the min distance of a point to the choosen clusters.
	3. Choose the next cluster the point being the farest being the one with the most probability of being choose.
	4. Repeat Steps 2 and 3 k centroids are selected"
]

{ #category : #training }
AIKMeans >> initializeRandomCentroids: aCollectionOfPoints [
	"Initializa randomly the centroids"

	centroids := 'Something'
]

{ #category : #training }
AIKMeans >> kMeansAlgorithm: aCollectionOfPoints [

	performedIterations := 0.
	"Initialize the centrois"
	
	"Do this loop at least one time."
	[
	self assignClusterToPoints: aCollectionOfPoints.
	self updateCentroids: aCollectionOfPoints.
	performedIterations := performedIterations + 1 ] "convert this to a loop"
]

{ #category : #accessing }
AIKMeans >> maxIterations: anInteger [

	maxIterations := anInteger
]

{ #category : #training }
AIKMeans >> nearestCentroidToPoint: aPoint [

	| minDistance nearestCentroidIndex |	
	minDistance := 0. "initialize it to something that makes sense"

	"Calculate the nearest distance and the nearest index of the centroid"
	
	^ nearestCentroidIndex "Return the index of the nearest centroid for the point aPoint"
]

{ #category : #accessing }
AIKMeans >> numberOfClusters: anObject [

	numberOfClusters := anObject
]

{ #category : #api }
AIKMeans >> predict: aCollectionOfPoints [
	"Asign each point to the closest centroid (in other words, cluster the points)"

	^ aCollectionOfPoints collect: [ :point | self nearestCentroidToPoint: point ]
]

{ #category : #accessing }
AIKMeans >> previousCentroids: aCollection [
	"Method only used for testing"

	previousCentroids := aCollection
]

{ #category : #api }
AIKMeans >> score: aCollectionOfPoints [
	"The score is the sum of all the distances of the points to their respective cluster."

	^ 0
]

{ #category : #accessing }
AIKMeans >> timesToRun: anInteger [

	timesToRun := anInteger
]

{ #category : #api }
AIKMeans >> transform: aCollectionOfPoints [
	"Transform X to a cluster-distance space.
	Compute the distance matrix between each point to each of the centroids"

	^ aCollectionOfPoints collect: [ :aPoint |
		  centroids collect: [ :aCentroid | self distanceBetween: aPoint and: aCentroid ] ]
]

{ #category : #training }
AIKMeans >> updateCentroids: aCollectionOfPoints [
	"Update each centroids by moving it to the center of all its points (take the average of
	all the points that belong to each cluster).
	Don't forget to update the centroids instance variable."

	
]
