"
A DCLOnlyCanConstraint is a dependency constraint that checks:

only moduleA can <depend on> module B

The strategy to find violations is to check if someone depends on moduleB and it's not moduleA
"
Class {
	#name : #DCLOnlyCanConstraint,
	#superclass : #DCLConstraint,
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #private }
DCLOnlyCanConstraint >> computeResult [
	"RULE: only moduleA can depend on moduleB
	 STRATEGY: check if someone depends on moduleB and it's not moduleA"
	
	| classGroupA classGroupB notClassGroupA |
	classGroupA := self collectEntitiesForModule: moduleDefinitionA.
	classGroupB := self collectEntitiesForModule: moduleDefinitionB.
	
	notClassGroupA := FamixClassGroup new.
	notClassGroupA addAll: (self model allClasses reject: #isStub).
	notClassGroupA addAll: (notClassGroupA allClasses flatCollect: #allRecursiveTypes ).
	notClassGroupA removeAll: classGroupA allClasses.
	
	^ notClassGroupA queryOutgoingDependencies: classGroupB byType: dependencyType
]

{ #category : #private }
DCLOnlyCanConstraint >> explanation [

	^ 'only ', moduleDefinitionA name asString, ' can ',
		 dependencyType asString, ' ',
		 moduleDefinitionB name asString
]

{ #category : #private }
DCLOnlyCanConstraint >> label [

	^ 'Exclusive dependency from a given source'
]
