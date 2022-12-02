Class {
	#name : #DCLCanOnlyConstraintTest,
	#superclass : #DCLConstraintAbstractTest,
	#category : #'DependencyConstraint-Tests'
}

{ #category : #tests }
DCLCanOnlyConstraintTest >> testValidate [

	"tests if all the violations are accesses from the package gui to any package other than draw"

	| modulesDefinitions constraint1 constraint2 violations |
	modulesDefinitions := 'p2 = Moose-TestResources-KGB-P2.*
		 p3 = Moose-TestResources-KGB-P3.*
		 p5 = Moose-TestResources-KGB-P5.*'.

	constraint1 := (DCLParser new parseConstraints:
			                modulesDefinitions , String cr
			                , 'p2 canOnly access p5') first
		               model: mooseModel;
		               yourself.
	constraint2 := (DCLParser new parseConstraints:
			                modulesDefinitions , String cr
			                , 'p3 canOnly access p5') first
		               model: mooseModel;
		               yourself.

	violations := constraint1 computeResult.
	self assert: (violations allSatisfy: [ :violation | 
			 violation usesFamixTrait: FamixTAccess ]).
	self assert:
		(violations allSatisfy: [ :violation | violation source typeScope ])
	"self assert: ( violations noneSatisfy: [ :violation | drawClassGroup includes: violation to typeScope ] )"
]

{ #category : #tests }
DCLCanOnlyConstraintTest >> testValideConstraint [

	| constraint violations |
	constraint := (DCLParser new parseConstraints:
		'p3 = Moose-TestResources-KGB-P3.*
		 p25 = Moose-TestResources-KGB-P[25].*
		 p3 canOnly access p25') first.
	constraint model: mooseModel.

	violations := constraint computeResult.
	self assert: (violations allSatisfy: [ :violation | 
			 violation usesFamixTrait: FamixTAccess ]).
	self assert:
		(violations allSatisfy: [ :violation | violation source typeScope ])
	"self assert: ( violations noneSatisfy: [ :violation | drawClassGroup includes: violation to typeScope ] )"
]
