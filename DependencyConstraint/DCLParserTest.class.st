Class {
	#name : #DCLParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'DependencyConstraint-Tests'
}

{ #category : #running }
DCLParserTest >> setUp [

	parser := DCLParser new
]

{ #category : #tests }
DCLParserTest >> testIsValidConstraint [

	self assert: ( DCLParser isValidConstraint: 'only moduleX can access moduleY' ).
	self assert: ( DCLParser isValidConstraint: 'moduleA cannot inherit moduleB' ).
	self assert: ( DCLParser isValidConstraint: 'moduleC canOnly reference moduleD' ).
	self assert: ( DCLParser isValidConstraint: 'moduleE must invoke moduleF' ).
	
	self deny: ( DCLParser isValidConstraint: 'only moduleA cannot access module B' ).
	self deny: ( DCLParser isValidConstraint: 'module B canOnly invoke moduleC' ).
	self deny: ( DCLParser isValidConstraint: 'moduleD must depend moduleE' ).
	self deny: ( DCLParser isValidConstraint: 'moduleE can not access moduleF' ).
	self deny: ( DCLParser isValidConstraint: 'only moduleG can inherit module H' ).
	self deny: ( DCLParser isValidConstraint: 'only nameyourmodule canOnly invoke moduleI' )
]

{ #category : #tests }
DCLParserTest >> testIsValidModuleDefinition [

	self assert: ( DCLParser isValidModuleDefinition: 'moduleA = org.myproject.mypackage' ).
	self assert: ( DCLParser isValidModuleDefinition: 'moduleB = org.myproject.mypackage.*' ).
	self assert: ( DCLParser isValidModuleDefinition: 'moduleC = org' ).
	self assert: ( DCLParser isValidModuleDefinition: 'moduleD = oRg.[mM]ypackage' ).
	
	self deny: ( DCLParser isValidModuleDefinition: '= org.myproject.mypackage' ).
	self deny: ( DCLParser isValidModuleDefinition: 'org.mypackage' ).
	self deny: ( DCLParser isValidModuleDefinition: 'moduleA = *org.myproject.mypackage' ).
	self deny: ( DCLParser isValidModuleDefinition: 'moduleB = .org.myproject.mypackage' ).
	self deny: ( DCLParser isValidModuleDefinition: 'moduleC = org.myproje*ct.mypackage' ).
	self deny: ( DCLParser isValidModuleDefinition: 'mod*uleD = org.myproject.mypackage' ).
	self deny: ( DCLParser isValidModuleDefinition: 'module E = org.myproject.mypackage' ).
]

{ #category : #tests }
DCLParserTest >> testParseConstraint [

	| constraint |
	parser parseModuleDefinitions: 
	'moduleX = org.myproject.packageA.*
	moduleY = org.myproject.packageB'.
	
	constraint := parser parseConstraint: 'only moduleX can access moduleY'.
	self assert: ( constraint isKindOf: DCLOnlyCanConstraint ).
	self assert: constraint moduleDefinitionA name equals: 'moduleX'.
	self assert: constraint dependencyType equals: FamixTAccess.
	self assert: constraint moduleDefinitionB name equals: 'moduleY'.
	
	constraint := parser parseConstraint: 'moduleX cannot inherit moduleY'.
	self assert: ( constraint isKindOf: DCLCannotConstraint ).
	self assert: constraint moduleDefinitionA name equals: 'moduleX'.
	self assert: constraint dependencyType equals: FamixTInheritance.
	self assert: constraint moduleDefinitionB name equals: 'moduleY'.
	
	constraint := parser parseConstraint: 'moduleX canOnly reference moduleY'.
	self assert: ( constraint isKindOf: DCLCanOnlyConstraint ).
	self assert: constraint moduleDefinitionA name equals: 'moduleX'.
	self assert: constraint dependencyType equals: FamixTReference.
	self assert: constraint moduleDefinitionB name equals: 'moduleY'.
	
	constraint := parser parseConstraint: 'moduleX must invoke moduleY'.
	self assert: ( constraint isKindOf: DCLMustConstraint ).
	self assert: constraint moduleDefinitionA name equals: 'moduleX'.
	self assert: constraint dependencyType equals: FamixTInvocation.
	self assert: constraint moduleDefinitionB name equals: 'moduleY'.
	
	constraint := parser parseConstraint: 'moduleA must invoke moduleB'.
	self assert: ( constraint isKindOf: DCLMustConstraint ).
	self assert: constraint moduleDefinitionA description isNil.
	self assert: constraint dependencyType equals: FamixTInvocation.
	self assert: constraint moduleDefinitionB description isNil.
]

{ #category : #tests }
DCLParserTest >> testParseModuleDefinition [

	| moduleDefinition |
	moduleDefinition := parser parseModuleDefinition: 'moduleA = org.myproject.mypackage'.
	self assert: moduleDefinition name equals: 'moduleA'.
	self assert: moduleDefinition description equals: 'org.myproject.mypackage'.
	
	moduleDefinition := parser parseModuleDefinition: 'moduleB = org.myproject.mypackage.*'.
	self assert: moduleDefinition name equals: 'moduleB'.
	self assert: moduleDefinition description equals: 'org.myproject.mypackage.*'.
]

{ #category : #tests }
DCLParserTest >> testParseModuleDefinitions [

	| moduleDefinitionString moduleDefinitions moduleDefinition |
	moduleDefinitionString := 
	'moduleA = org.myproject.mypackage
	moduleB = org.myproject.mypackage.*
	= org.myproject.mypackage
	moduleC = org
	moduleA = *org.myproject.mypackage'.
	
	moduleDefinitions := parser parseModuleDefinitions: moduleDefinitionString.
	self assert: moduleDefinitions size equals: 3.
	
	moduleDefinition := moduleDefinitions at: 1.
	self assert: moduleDefinition name equals: 'moduleA'.
	self assert: moduleDefinition description equals: 'org.myproject.mypackage'.
	
	moduleDefinition := moduleDefinitions at: 2.
	self assert: moduleDefinition name equals: 'moduleB'.
	self assert: moduleDefinition description equals: 'org.myproject.mypackage.*'.
	
	moduleDefinition := moduleDefinitions at: 3.
	self assert: moduleDefinition name equals: 'moduleC'.
	self assert: moduleDefinition description equals: 'org'.
]
