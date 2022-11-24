Class {
	#name : #DCLModuleDefinitionTest,
	#superclass : #TestCase,
	#instVars : [
		'mooseModel'
	],
	#category : #'DependencyConstraint-Tests'
}

{ #category : #running }
DCLModuleDefinitionTest >> setUp [

	mooseModel := SEMExecutor mooseModelWith: 'JHotDraw 7.3.1'

	
]

{ #category : #tests }
DCLModuleDefinitionTest >> testParseDefinitionOn [

	| moduleDefinition classGroup |
	moduleDefinition := DCLModuleDefinition new
		moduleName: 'gui';
		moduleDescription: 'org::jhotdraw::gui*'.
	classGroup := moduleDefinition parseDefinitionOn: mooseModel.
	
	self assert: classGroup size = 148.
	self assert: ( classGroup allClasses allSatisfy: [ :class | class container mooseName beginsWith: 'org::jhotdraw::gui' ]).

	moduleDefinition := DCLModuleDefinition new
		moduleName: 'gui';
		moduleDescription: 'org::jhotdraw::gui'.
	classGroup := moduleDefinition parseDefinitionOn: mooseModel.
		
	self assert: classGroup size = 77.
	self assert: ( classGroup allClasses allSatisfy: [ :class | class container mooseName beginsWith: 'org::jhotdraw::gui' ]).
]
