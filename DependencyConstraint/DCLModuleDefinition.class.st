"
A DCLModuleDefinition is the definition of a module as a set of software entities. Its description is evaluated into entities at checking time.

Instance Variables
	moduleDescription:		aString
	moduleName:		aString

moduleDescription
	- the description of a module in regular expression

moduleName
	- the label of the module, it is used to define a constraint

"
Class {
	#name : #DCLModuleDefinition,
	#superclass : #Object,
	#instVars : [
		'moduleName',
		'moduleDescription'
	],
	#category : #'DependencyConstraint-Parser'
}

{ #category : #accessing }
DCLModuleDefinition >> moduleDescription [
	^ moduleDescription
]

{ #category : #accessing }
DCLModuleDefinition >> moduleDescription: anObject [
	moduleDescription := anObject
]

{ #category : #accessing }
DCLModuleDefinition >> moduleName [
	^ moduleName
]

{ #category : #accessing }
DCLModuleDefinition >> moduleName: anObject [
	moduleName := anObject
]

{ #category : #parsing }
DCLModuleDefinition >> parseDefinitionOn: aMooseModel [
	"returns a class group with all the classes in the module definition. if the description is not defined (in the case referencing
	a module that was not created) then return an empty class group"

	| namespaceGroup |
	moduleDescription ifNil: [ ^ FAMIXClassGroup new ].
	(moduleDescription endsWith: '*') 
		ifTrue: [ 
			moduleDescription := moduleDescription copyFrom: 1 to: moduleDescription size - 1.
			namespaceGroup := ( aMooseModel allModelScopingEntities select: [ :each | each mooseName beginsWith: moduleDescription ] )
		 ] ifFalse: [ 
			namespaceGroup := FAMIXNamespaceGroup new.
			namespaceGroup add: ( ( aMooseModel allModelPackages select: [ :each | each mooseName = moduleDescription ] ) at: 1 ) ].
		
	^ FAMIXClassGroup new
		addAllWithoutUpdate: ( namespaceGroup flatCollect: #allClasses );
		addAllWithoutUpdate: ((namespaceGroup flatCollect: #allClasses ) flatCollect: #allRecursiveTypes );
		yourself
]
