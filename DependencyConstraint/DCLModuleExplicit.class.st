"
A DCLModule created with an explicit list of member entities
"
Class {
	#name : #DCLModuleExplicit,
	#superclass : #DCLAbstractModule,
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #accessing }
DCLModuleExplicit >> memberEntities: aCollection [
	memberEntities := aCollection
]

{ #category : #accessing }
DCLModuleExplicit >> privateComputeMembers [
	Error signal: 'You should have given a list of member entities when creating this DCLModuleExplicit'
]
