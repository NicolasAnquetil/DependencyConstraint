Class {
	#name : #DCLCannotConstraintTest,
	#superclass : #DCLConstraintAbstractTest,
	#category : #'DependencyConstraint-Tests'
}

{ #category : #tests }
DCLCannotConstraintTest >> testValidate [
	"tests if all the violations are accesses from any package other than gui to the package draw"

	| constraint violations  guiClassGroup drawClassGroup |
	constraint := ( ( DCLParser new parseConstraints: 
	'gui = org::jhotdraw::gui*
	draw = org::jhotdraw::app*
	gui cannot invoke draw' ) at: 1 ) model: mooseModel.
	
	violations := constraint computeResult asCollection.
	self assert: ( violations allSatisfy: [ :violation | violation usesFamixTrait: FamixTInvocation ] ).
	self assert: ( violations allSatisfy: [ :violation | guiClassGroup includes: violation from typeScope ] ).
	self assert: ( violations allSatisfy: [ :violation | drawClassGroup includes: violation to typeScope ] )
]
