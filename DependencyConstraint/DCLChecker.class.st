Class {
	#name : #DCLChecker,
	#superclass : #REPReport,
	#instVars : [
		'constraints'
	],
	#category : #'DependencyConstraint-Checker'
}

{ #category : #executing }
DCLChecker class >> check: aMooseModel with: aString [

	^ self new
		constraints: ( DCLParser new parseConstraints: aString );
		model: aMooseModel;
		open
]

{ #category : #accessing }
DCLChecker >> addAllConstraints: newConstraints [

	constraints addAll: newConstraints
]

{ #category : #accessing }
DCLChecker >> addConstraint: newConstraint [

	constraints add: newConstraint
]

{ #category : #executing }
DCLChecker >> build: spec [

	spec label: 'Dependency Constraints Report'.
	
	spec composite: 'Divergency Violations' meaning: 'Dependency rules that are being broken' with: [ 
		constraints
			reject: [ :constraint | constraint isKindOf: DCLMustConstraint ]
			thenCollect: [ :constraint | spec concern: constraint ] ].
	
	spec composite: 'Absence Violations' meaning: 'Dependency rules that are not being applied' with: [ 
		constraints
			select: [ :constraint | constraint isKindOf: DCLMustConstraint ]
			thenCollect: [ :constraint | spec concern: constraint ] ]
]

{ #category : #accessing }
DCLChecker >> constraints [

	^ constraints
]

{ #category : #accessing }
DCLChecker >> constraints: anObject [

	constraints := anObject
]

{ #category : #initialization }
DCLChecker >> initialize [

	moduleDefinitions := OrderedCollection new.
	constraints := OrderedCollection new
]

{ #category : #accessing }
DCLChecker >> removeConstraint: aDCLConstraint [

	constraints remove: aDCLConstraint
]

{ #category : #executing }
DCLChecker >> update [

	self spec root children do: #update.
	self open
]
