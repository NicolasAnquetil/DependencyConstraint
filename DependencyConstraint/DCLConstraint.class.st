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
	#superclass : #Object,
	#instVars : [
		'moduleDefinitionA',
		'dependencyType',
		'moduleDefinitionB',
		'model'
	],
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #accessing }
DCLConstraint >> collectEntitiesForModule: module [

	| entities |
	module ifNil: [ ^ MooseGroup new ].
	
	entities := self model entitiesInDCLModule: module.
	^ MooseGroup new
		addAll: (entities flatCollect: [ :entity | entity allToScope: FamixTType ] );
		yourself
]

{ #category : #running }
DCLConstraint >> computeResult [
	"check the constraint on 'self model'"
	self subclassResponsibility 
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
DCLConstraint >> model [
	^model
]

{ #category : #accessing }
DCLConstraint >> model: aModel [
	model := aModel 
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
