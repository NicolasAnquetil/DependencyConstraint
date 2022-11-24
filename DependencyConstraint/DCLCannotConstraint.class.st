"
A DCLCannotConstraint is a dependency constraint that checks:

moduleA cannot <depend on> moduleB

The strategy to find violations is to check if moduleA depends on moduleB.

"
Class {
	#name : #DCLCannotConstraint,
	#superclass : #DCLConstraint,
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #private }
DCLCannotConstraint >> computeResult [
	"RULE: moduleA cannot depend on moduleB
	 STRATEGY: check if module A depends on moduleB"
	
	| classGroupA classGroupB |
	classGroupA := self collectEntitiesForModule: moduleDefinitionA.
	classGroupB := self collectEntitiesForModule: moduleDefinitionB.
	
	^ classGroupA queryOutgoingDependencies: classGroupB byType: dependencyType
]

{ #category : #private }
DCLCannotConstraint >> explanation [

	^ moduleDefinitionA name asString, ' cannot ',
		 dependencyType asString, ' ',
		 moduleDefinitionB name asString
]

{ #category : #private }
DCLCannotConstraint >> label [

	^ 'Prohibited dependency to a given target'
]
