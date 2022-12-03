"
I represent an architectural module

I have:
- a #name
- a #description -- a regex describing the name of the entities that belongs to me
- a #model -- (a collection of Moose entitites) on which I apply

I can also be converted to a Famix tag in my #model (#asTag)
"
Class {
	#name : #DCLModule,
	#superclass : #Object,
	#instVars : [
		'description',
		'name',
		'regexp',
		'model',
		'cache'
	],
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #converting }
DCLModule >> asTag [
	| tag |
	self isFullySpecified ifFalse: [ ^nil ].
	tag := self mooseModel tagNamed: name.
	self memberEntities do: [ :e |
		(e isTaggedWith: tag)
			ifFalse: [ e tagWith: tag ] ].
	^tag
]

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
	regexp := aString asRegex.
	cache := nil
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
	cache ifNil: [ cache := self model entitiesInDCLModule: self ].
	^cache
]

{ #category : #accessing }
DCLModule >> model [

	^ model
]

{ #category : #accessing }
DCLModule >> model: anObject [

	model := anObject.
	cache := nil
]

{ #category : #accessing }
DCLModule >> mooseModel [
	"returns the MooseModel containing entities in my #model"
	model isCollection ifFalse: [ ^nil ].
	^model anyOne mooseModel
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
