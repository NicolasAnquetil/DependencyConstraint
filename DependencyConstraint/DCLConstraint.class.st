"
A DCLConstraint is a constraint for module dependencies. Each constraint implements a specific dependency rule, which is checked in the message >>validate:.

Instance Variables
	dependencyType:		aFAMIXAssociation
	moduleDefinitionA:		aDCLModuleDefinition
	moduleDefinitionB:		aDCLModuleDefinition

dependencyType
	- the type of dependency that the rule will check

moduleDefinitionA
	- the source of the dependency

moduleDefinitionB
	- the target of the dependency

"
Class {
	#name : #DCLConstraint,
	#superclass : #REPMooseQueryConcern,
	#instVars : [
		'moduleDefinitionA',
		'dependencyType',
		'moduleDefinitionB'
	],
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #accessing }
DCLConstraint >> collectEntitiesForModule: module [

	| entities |
	module ifNil: [ ^ FAMIXClassGroup new ].
	
	entities := self model getEntitiesForComponentTag: module.
	^ FAMIXClassGroup new
		addAllWithoutUpdate: (entities collect: #typeScope );
		addAllWithoutUpdate: ((entities collect: #typeScope ) flatCollect: #allRecursiveTypes );
		yourself
]

{ #category : #accessing }
DCLConstraint >> dependencyType [

	^ dependencyType
]

{ #category : #accessing }
DCLConstraint >> dependencyType: aFamixAssociation [

	dependencyType := aFamixAssociation
]

{ #category : #accessing }
DCLConstraint >> moduleDefinitionA [
	^ moduleDefinitionA
]

{ #category : #accessing }
DCLConstraint >> moduleDefinitionA: anObject [
	moduleDefinitionA := anObject
]

{ #category : #accessing }
DCLConstraint >> moduleDefinitionB [
	^ moduleDefinitionB
]

{ #category : #accessing }
DCLConstraint >> moduleDefinitionB: anObject [
	moduleDefinitionB := anObject
]

{ #category : #private }
DCLConstraint >> stakeholder [

	^ REPStakeholder named: 'Dependency Constraint Checker'
]
