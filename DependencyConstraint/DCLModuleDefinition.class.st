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
		'description',
		'name',
		'regexp'
	],
	#category : #'DependencyConstraint-Parser'
}

{ #category : #parsing }
DCLModuleDefinition >> applyDefinitionOn: aMooseGroup [
	"returns a group with all the entities in the module definition. if the description is not defined (in the case referencing
	a module that was not created) then return an empty group"
	description ifNil: [ ^ MooseSpecializedGroup new ].
	^aMooseGroup entitiesInDCLModule: self
]

{ #category : #accessing }
DCLModuleDefinition >> description [
	^ description
]

{ #category : #accessing }
DCLModuleDefinition >> description: aString [
	description := aString.
	regexp := aString asRegex
]

{ #category : #testing }
DCLModuleDefinition >> descriptionMatches: aMooseEntity [
	^regexp matches: aMooseEntity name
]

{ #category : #accessing }
DCLModuleDefinition >> name [
	^ name
]

{ #category : #accessing }
DCLModuleDefinition >> name: anObject [
	name := anObject
]
