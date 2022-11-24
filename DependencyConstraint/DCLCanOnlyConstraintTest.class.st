Class {
	#name : #DCLCanOnlyConstraintTest,
	#superclass : #TestCase,
	#instVars : [
		'mooseModel',
		'guiClassGroup',
		'drawClassGroup'
	],
	#category : #'DependencyConstraint-Tests'
}

{ #category : #running }
DCLCanOnlyConstraintTest >> setUp [
	
	mooseModel := SEMExecutor mooseModelWith: 'JHotDraw 7.3.1'.
	
	guiClassGroup := mooseModel allModelNamespaces select: [ :each | each mooseName beginsWith: 'org::jhotdraw::gui' ].
	drawClassGroup := mooseModel allModelNamespaces select: [ :each | each mooseName beginsWith: 'org::jhotdraw::draw' ].
	
	guiClassGroup := FAMIXClassGroup new
		addAllWithoutUpdate: ( guiClassGroup 
			flatCollect: #allClasses;
			flatCollect: [ :namespace | namespace allClasses flatCollect: #allRecursiveTypes ] ).
			
	drawClassGroup := FAMIXClassGroup new
		addAllWithoutUpdate: ( drawClassGroup 
			flatCollect: #allClasses;
			flatCollect: [ :namespace | namespace allClasses flatCollect: #allRecursiveTypes ] ).
]

{ #category : #tests }
DCLCanOnlyConstraintTest >> testValidate [
	"tests if all the violations are accesses from the package gui to any package other than draw"

	| constraint violations  |
	constraint := ( ( DCLParser new parseConstraints: 
	'gui = org::jhotdraw::gui*
	draw = org::jhotdraw::draw*
	gui canOnly access draw' ) at: 1 ) model: mooseModel.
	
	violations := constraint computeResult asCollection.
	self assert: ( violations allSatisfy: [ :violation | violation isKindOf: FAMIXAccess ] ).
	self assert: ( violations allSatisfy: [ :violation | guiClassGroup includes: violation from typeScope ] ).
	self assert: ( violations noneSatisfy: [ :violation | drawClassGroup includes: violation to typeScope ] )
]
