Class {
	#name : #DCLModule,
	#superclass : #Object,
	#instVars : [
		'description',
		'name',
		'regexp',
		'model'
	],
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #constraint }
DCLModule >> canOnly [
	^self constraint: DCLCanOnlyConstraint
]

{ #category : #constraint }
DCLModule >> cannot [
	^self constraint: DCLCannotConstraint 
]

{ #category : #constraint }
DCLModule >> constraint: aDCLConstraint [
	^aDCLConstraint  new
		moduleA: self ;
		yourself
]

{ #category : #accessing }
DCLModule >> description [

	^ description
]

{ #category : #accessing }
DCLModule >> description: aString [
	description := aString.
	regexp := aString asRegex
]

{ #category : #testing }
DCLModule >> descriptionMatches: aMooseEntity [
	^regexp matches: aMooseEntity name
]

{ #category : #testing }
DCLModule >> isFullySpecified [
	^(regexp notNil) and:
	 [(regexp class canUnderstand: #matches:) and:
	 [ self model isCollection ] ]
]

{ #category : #applying }
DCLModule >> memberEntities [
	self isFullySpecified
		ifFalse: [ ^ MooseSpecializedGroup new ].
	^self model entitiesInDCLModule: self
]

{ #category : #accessing }
DCLModule >> model [

	^ model
]

{ #category : #accessing }
DCLModule >> model: anObject [

	model := anObject
]

{ #category : #constraint }
DCLModule >> must [
	^self constraint: DCLMustConstraint
]

{ #category : #accessing }
DCLModule >> name [

	^ name
]

{ #category : #accessing }
DCLModule >> name: anObject [

	name := anObject
]
