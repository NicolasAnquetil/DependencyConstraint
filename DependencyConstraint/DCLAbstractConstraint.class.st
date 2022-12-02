"
I represent an architectural rle between two marchitectural modules. Here, moduleA must depend on moduleB.
"
Class {
	#name : #DCLAbstractConstraint,
	#superclass : #Object,
	#instVars : [
		'moduleB',
		'association',
		'moduleA'
	],
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #accessing }
DCLAbstractConstraint >> access: aDCLModule [
	association := FamixTAccess.
	moduleB := aDCLModule
]

{ #category : #accessing }
DCLAbstractConstraint >> association [

	^ association
]

{ #category : #accessing }
DCLAbstractConstraint >> association: anObject [

	association := anObject
]

{ #category : #checking }
DCLAbstractConstraint >> check [
	self subclassResponsibility 
]

{ #category : #accessing }
DCLAbstractConstraint >> depend: aDCLModule [
	association := FamixTAssociation.
	moduleB := aDCLModule
]

{ #category : #accessing }
DCLAbstractConstraint >> inherit: aDCLModule [
	association := FamixTInheritance.
	moduleB := aDCLModule
]

{ #category : #accessing }
DCLAbstractConstraint >> invoke: aDCLModule [
	association := FamixTInvocation.
	moduleB := aDCLModule
]

{ #category : #testing }
DCLAbstractConstraint >> isFullySpecified [ 
| a |
a isNil.
	^ (moduleA notNil) and:
		[ moduleA isFullySpecified and: 
		[ moduleB isNotNil and:
		[ moduleB isFullySpecified and:
		[ association notNil ] ] ] ].

]

{ #category : #accessing }
DCLAbstractConstraint >> moduleA [

	^ moduleA
]

{ #category : #accessing }
DCLAbstractConstraint >> moduleA: anObject [

	moduleA := anObject
]

{ #category : #accessing }
DCLAbstractConstraint >> moduleB [

	^ moduleB
]

{ #category : #accessing }
DCLAbstractConstraint >> moduleB: anObject [

	moduleB := anObject
]

{ #category : #accessing }
DCLAbstractConstraint >> reference: aDCLModule [
	association := FamixTReference.
	moduleB := aDCLModule
]
