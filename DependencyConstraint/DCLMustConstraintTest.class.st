Class {
	#name : #DCLMustConstraintTest,
	#superclass : #DCLConstraintAbstractTest,
	#category : #'DependencyConstraint-Tests'
}

{ #category : #tests }
DCLMustConstraintTest >> testValidate [
	"tests if all the violations are accesses from any package other than gui to the package draw"

	| constraint violations  |
	constraint := ( ( DCLParser new parseConstraints: 
	'gui = org::jhotdraw::gui*
	draw = org::jhotdraw::draw*
	gui must access draw' ) at: 1 ) model: mooseModel.
	
	violations := constraint computeResult asCollection.
	self assert: violations size equals: 1.
	self assert: ( violations allSatisfy: [ :violation | violation from isNil ] ).
]
