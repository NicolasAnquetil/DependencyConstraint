Class {
	#name : #DCLMustConstraintTest,
	#superclass : #DCLAbstractConstraintTest,
	#category : #'DependencyConstraint-Tests'
}

{ #category : #tests }
DCLMustConstraintTest >> testCheckNotOK [
	| violations |
	violations := (p2p5 must invoke: p3) check.
	self deny: violations isEmpty
]

{ #category : #tests }
DCLMustConstraintTest >> testCheckOK [
	| violations |
	violations := (p3 must invoke: p2p5) check.
	self assert: violations isEmpty
]

{ #category : #tests }
DCLMustConstraintTest >> testIsFullySpecified [
	| constraint |
	constraint := p2p5 must access: p3.

	self assert: constraint class equals: DCLMustConstraint.
	self assert: constraint isFullySpecified 
]

{ #category : #tests }
DCLMustConstraintTest >> testIsNotFullySpecified [
	| constraint |
	constraint := p2p5 must.

	self assert: constraint class equals: DCLMustConstraint.
	self deny: constraint isFullySpecified 
]
