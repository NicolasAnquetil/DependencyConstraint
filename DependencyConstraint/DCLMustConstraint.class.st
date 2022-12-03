Class {
	#name : #DCLMustConstraint,
	#superclass : #DCLAbstractConstraint,
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #checking }
DCLMustConstraint >> check [
	"checks whether there is a dependency from ModuleA to ModuleB.
	If there is sone, returns empty array (no violations)	
	If there is none, returns all dependencies from moduleA

	 - compute all outgoing dependencies from moduleA (QueryResults)
	 - for each entity member of moduleB, looks if it is in one of the queryResults (that must be 'raised' at the right scope)"

	| moduleBMembers moduleADependencies |
	moduleBMembers := moduleB memberEntities.
	moduleADependencies := Set new.

	moduleA memberEntities do: [ :entityA || queryResultA |
		queryResultA := entityA queryOutgoing: association.
		moduleBMembers do: [:entityB |
			(queryResultA within: entityB)
				ifNotEmpty: [ ^#() ] ].
		moduleADependencies addAll: queryResultA
	].
	^moduleADependencies

]
