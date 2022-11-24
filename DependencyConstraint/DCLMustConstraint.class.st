"
A DCLMustConstraint is a dependency constraint that checks:

moduleA must <depend on> module B

The strategy to find violations is to check if there are no dependencies from moduleA to moduleB. If so, a violation is created for the absense of dependencies.
"
Class {
	#name : #DCLMustConstraint,
	#superclass : #DCLConstraint,
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #private }
DCLMustConstraint >> computeResult [
	"RULE: moduleA must depend on moduleB
	 STRATEGY: check if there are no dependencies from moduleA to moduleB"
	
	| classGroupA classGroupB |
	classGroupA := self collectEntitiesForModule: moduleDefinitionA.
	classGroupB := self collectEntitiesForModule: moduleDefinitionB.
	
	^ ( classGroupA queryOutgoingDependencies: classGroupB byType: dependencyType )
		asCollection ifEmpty: [ MooseGroup new add: ( dependencyType new ) ]
]

{ #category : #private }
DCLMustConstraint >> explanation [

	^ moduleDefinitionA name asString, ' must ',
		 dependencyType asString, ' ',
		 moduleDefinitionB name asString
]

{ #category : #private }
DCLMustConstraint >> label [

	^ 'Obligatory dependency to a given target'
]
