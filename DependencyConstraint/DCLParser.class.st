Class {
	#name : #DCLParser,
	#superclass : #Object,
	#instVars : [
		'moduleDefinitions'
	],
	#category : #'DependencyConstraint-Parser'
}

{ #category : #constants }
DCLParser class >> constraintRegex [

	^ '^(only (\w+) (can) (access|inherit|invoke|reference) (\w+))|((\w+) (cannot|canOnly|must) (access|inherit|invoke|reference) (\w+))$' asRegex
]

{ #category : #validating }
DCLParser class >> isValidConstraint: aString [
	"checks if the given command is sintatically correct"
	
	^ self constraintRegex matches: aString
]

{ #category : #validating }
DCLParser class >> isValidModuleDefinition: aString [
	"checks if the given module definition is sintatically correct"
	
	^ self moduleDefinitionRegex matches: aString
]

{ #category : #constants }
DCLParser class >> moduleDefinitionRegex [

	^ '(\w+) = ([\w]+[\w:\\.-]+[\\*]?)' asRegex
]

{ #category : #searching }
DCLParser >> findModuleNamed: aString [
	"search for a module definition with a given name. if no one is found, a new definition is created with no description"

	^ moduleDefinitions 
		detect: [ :moduleDefinition | moduleDefinition moduleName = aString ]
		ifNone: [ ^ DCLModuleDefinition new moduleName: aString ]
]

{ #category : #executing }
DCLParser >> parseConstraint: aString [

	| constraintRegex constraintName matches |
	constraintRegex := DCLParser constraintRegex.
	constraintRegex matches: aString.
	
	"hack to avoid nil subexpressions"
	matches := OrderedCollection new.
	(1 to: constraintRegex subexpressionCount) do: [ :index | 
		| match |
		match := constraintRegex subexpression: index.
		match ifNotNil: [ matches add: match ] ].
	
	"<whole match> <match expression> <module> <constraint> <dependency> <module>"
	constraintName := matches at: 4.	
	^ (self parseConstraintClass: constraintName) new
		moduleDefinitionA: ( self findModuleNamed: (matches at: 3) );
		dependencyType: ( self parseDependencyType: (matches at: 5) );
		moduleDefinitionB: ( self findModuleNamed: (matches at: 6) );
		yourself.
		 
]

{ #category : #executing }
DCLParser >> parseConstraintClass: aString [

	(aString = 'can') ifTrue: [ ^ DCLOnlyCanConstraint ].
	(aString = 'cannot') ifTrue: [ ^ DCLCannotConstraint ].
	(aString = 'canOnly') ifTrue: [ ^ DCLCanOnlyConstraint ].
	(aString = 'must') ifTrue: [ ^ DCLMustConstraint ]
]

{ #category : #executing }
DCLParser >> parseConstraints: aString [

	| constraints constraintRegex |
	moduleDefinitions ifNil: [ self parseModuleDefinitions: aString ].
	constraints := OrderedCollection new.
	constraintRegex := DCLParser constraintRegex.
	
	(aString findTokens: String crlf) do: [ :command |
		(DCLParser isValidConstraint: command trim) 
			ifTrue: [ constraints add: (self parseConstraint: command trim) ]
	].
		
	^ constraints
]

{ #category : #executing }
DCLParser >> parseDependencyType: aString [

	(aString = 'access') ifTrue: [ ^ FAMIXAccess ].
	(aString = 'inherit') ifTrue: [ ^ FAMIXInheritance ].
	(aString = 'invoke') ifTrue: [ ^ FAMIXInvocation ].
	(aString = 'reference') ifTrue: [ ^ FAMIXReference ]
]

{ #category : #executing }
DCLParser >> parseModuleDefinition: aString [

	| moduleDefinitionRegex |
	moduleDefinitionRegex := DCLParser moduleDefinitionRegex.
	moduleDefinitionRegex matches: aString.
	
	^ DCLModuleDefinition new
		moduleName: (moduleDefinitionRegex subexpression: 2);
		moduleDescription: (moduleDefinitionRegex subexpression: 3);
		yourself.
		
		
]

{ #category : #executing }
DCLParser >> parseModuleDefinitions: aString [

	| moduleDefinitionRegex |
	moduleDefinitions := OrderedCollection new.
	moduleDefinitionRegex := DCLParser moduleDefinitionRegex.
	
	(aString findTokens: String crlf) do: [ :command |
		(DCLParser isValidModuleDefinition: command trim) 
			ifTrue: [ moduleDefinitions add: (self parseModuleDefinition: command trim) ]
	].
		
	^ moduleDefinitions
		
		
]
