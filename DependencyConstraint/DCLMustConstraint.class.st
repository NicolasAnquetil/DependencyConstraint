Class {
	#name : #DCLMustConstraint,
	#superclass : #DCLAbstractConstraint,
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #checking }
DCLMustConstraint >> check [
	"checks whether there is a dependency from ModuleA to ModuleB
	 - compute all outgoing dependencies from moduleA (gives a list of QueryResults)
	 - for each entity member of moduleB, looks if it is in one of the queryResults (that must be 'raised' at the right scope)"

	| moduleBMembers moduleADependencies |
	moduleBMembers := moduleB memberEntities.
	moduleADependencies := moduleA memberEntities collect: [:entityA | (entityA queryOutgoing: association) ].

	^(moduleBMembers anySatisfy: [:entityB |
		moduleADependencies anySatisfy: [ :queryResult | (queryResult atScope: entityB class) includes: entityB ] ])
		ifTrue: [ #() ]
		ifFalse: [ moduleADependencies flatCollect: #yourself ]
]
