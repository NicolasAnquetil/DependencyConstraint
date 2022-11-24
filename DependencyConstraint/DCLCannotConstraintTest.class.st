Class {
	#name : #DCLCannotConstraintTest,
	#superclass : #TestCase,
	#instVars : [
		'mooseModel',
		'guiClassGroup',
		'drawClassGroup'
	],
	#category : #'DependencyConstraint-Tests'
}

{ #category : #running }
DCLCannotConstraintTest >> setUp [
	
	mooseModel := SEMExecutor mooseModelWith: 'JHotDraw 7.3.1'.
	
	guiClassGroup := mooseModel allModelNamespaces select: [ :each | each mooseName beginsWith: 'org::jhotdraw::gui' ].
	drawClassGroup := mooseModel allModelNamespaces select: [ :each | each mooseName beginsWith: 'org::jhotdraw::app' ].
	
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
DCLCannotConstraintTest >> testValidate [
	"tests if all the violations are accesses from any package other than gui to the package draw"

	| constraint violations  |
	constraint := ( ( DCLParser new parseConstraints: 
	'gui = org::jhotdraw::gui*
	draw = org::jhotdraw::app*
	gui cannot invoke draw' ) at: 1 ) model: mooseModel.
	
	violations := constraint computeResult asCollection.
	self assert: ( violations allSatisfy: [ :violation | violation isKindOf: FAMIXInvocation ] ).
	self assert: ( violations allSatisfy: [ :violation | guiClassGroup includes: violation from typeScope ] ).
	self assert: ( violations allSatisfy: [ :violation | drawClassGroup includes: violation to typeScope ] )
]
