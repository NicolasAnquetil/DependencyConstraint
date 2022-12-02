Class {
	#name : #DCLModuleDefinitionTest,
	#superclass : #DCLConstraintAbstractTest,
	#category : #'DependencyConstraint-Tests'
}

{ #category : #tests }
DCLModuleDefinitionTest >> testApplyDefinitionOn [
	| module entities |
	module := DCLModuleDefinition new
		name: 'p123';
		description: '.*-P[123].*'.
	entities := module applyDefinitionOn: mooseModel.
	
	self assert: entities size equals: 3.
	self assert: (entities includes: (mooseModel entityNamed: 'Moose-TestResources-KGB-P1FullReferencer')).
	self assert: (entities includes: (mooseModel entityNamed: 'Moose-TestResources-KGB-P2InteractedReferencerReferee')).
	self assert: (entities includes: (mooseModel entityNamed: 'Moose-TestResources-KGB-P3InteractedReferencer')).

]

{ #category : #tests }
DCLModuleDefinitionTest >> testApplyDefinitionOnNone [
	| module entities |
	module := DCLModuleDefinition new
		name: 'empty';
		description: '.*-whatever-inexistant-.*'.
	entities := module applyDefinitionOn: mooseModel.
	
	self assert: entities size equals: 0
]
