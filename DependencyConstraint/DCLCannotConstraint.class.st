Class {
	#name : #DCLCannotConstraint,
	#superclass : #DCLAbstractConstraint,
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #checking }
DCLCannotConstraint >> check [

	"checks that there is no dependency from ModuleA to ModuleB.
	If there is none, returns empty array (no violations)	
	If there is some, returns them"

	| moduleBMembers dependenciesFound |
	moduleBMembers := moduleB memberEntities.
	dependenciesFound := Set new.

	moduleA memberEntities do: [ :entityA || queryResultA |
		queryResultA := entityA queryOutgoing: association.
		(moduleBMembers do: [ :entityB | 
			(queryResultA within: entityB)
				ifNotEmpty: [ :dependenciesToB | dependenciesFound addAll: dependenciesToB ]
		])
	].
	^ dependenciesFound
]
