Class {
	#name : #DCLModuleOnMooseName,
	#superclass : #DCLModuleOnName,
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #testing }
DCLModuleOnMooseName >> descriptionMatches: aMooseEntity [
	^regexp matches: aMooseEntity mooseName
]
