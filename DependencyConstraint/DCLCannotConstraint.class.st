"
I represent an architectural rule between two architectural modules A and B (DCLModule).
I specify that moduleA **cannot** depend on moduleB
"
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

	| dependenciesFound |
	dependenciesFound := Set new.

	moduleA memberEntities do: [ :entityA || queryResultA |
		queryResultA := entityA queryOutgoing: association.
		(moduleB memberEntities do: [ :entityB | 
			(queryResultA within: entityB)
				ifNotEmpty: [ :dependenciesToB | dependenciesFound addAll: dependenciesToB ]
		])
	].
	^ dependenciesFound
]
