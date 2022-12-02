Class {
	#name : #DCLOnlyCanConstraintTest,
	#superclass : #DCLConstraintAbstractTest,
	#category : #'DependencyConstraint-Tests'
}

{ #category : #tests }
DCLOnlyCanConstraintTest >> testValidate [
	"tests if all the violations are accesses from any package other than gui to the package draw"

	| constraint violations  guiClassGroup drawClassGroup |
	constraint := ( ( DCLParser new parseConstraints: 
	'gui = org::jhotdraw::gui*
	draw = org::jhotdraw::draw*
	only gui can access draw' ) at: 1 ) model: mooseModel.
	
	violations := constraint computeResult asCollection.
	self assert: ( violations allSatisfy: [ :violation | violation usesFamixTrait: FamixTAccess ] ).
	self assert: ( violations noneSatisfy: [ :violation | guiClassGroup includes: violation from typeScope ] ).
	self assert: ( violations allSatisfy: [ :violation | drawClassGroup includes: violation to typeScope ] )
]
