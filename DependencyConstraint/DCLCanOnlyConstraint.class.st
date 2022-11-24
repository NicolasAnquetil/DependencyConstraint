"
A DCLCanOnlyConstraint is a dependency constraint that checks:

moduleA can only <depend on> module B

The strategy to find violations is to check if moduleA depends on other module than moduleB.
"
Class {
	#name : #DCLCanOnlyConstraint,
	#superclass : #DCLConstraint,
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #private }
DCLCanOnlyConstraint >> computeResult [
	"RULE: moduleA can only depend on moduleB
	 STRATEGY: check if module A depends on other module than moduleB"
	
	| classGroupA classGroupB notClassGroupB |
	classGroupA := self collectEntitiesForModule: moduleDefinitionA.
	classGroupB := self collectEntitiesForModule: moduleDefinitionB.
	
	notClassGroupB := FAMIXClassGroup new.
	notClassGroupB addAllWithoutUpdate: ( self model allModelScopingEntities flatCollect: #allClasses ).
	notClassGroupB addAllWithoutUpdate: ( notClassGroupB allClasses flatCollect: #allRecursiveTypes ).
	notClassGroupB removeAllWithoutUpdate: classGroupB allClasses.
	
	^ classGroupA queryOutgoingDependencies: notClassGroupB byType: dependencyType
]

{ #category : #private }
DCLCanOnlyConstraint >> explanation [
	
	^ moduleDefinitionA name asString, ' can only ', 
		dependencyType asString, ' ', 
		moduleDefinitionB name asString
]

{ #category : #private }
DCLCanOnlyConstraint >> label [
	
	^ 'Exclusive dependency to a given target'
]
