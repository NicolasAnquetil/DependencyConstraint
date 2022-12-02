Class {
	#name : #DCLNewModuleTest,
	#superclass : #DCLAbstractTest,
	#category : #'DependencyConstraint-Tests'
}

{ #category : #tests }
DCLNewModuleTest >> testDescriptionMatches [
	| module |
	module := DCLModule new
		name: 'p123';
		description: '.*abc.*';
		yourself.
	
	self assert: (module descriptionMatches: (FamixStNamedEntity new name: 'abcdefg' ; yourself)).
	self deny:   (module descriptionMatches: (FamixStNamedEntity new name: 'gfedcba' ; yourself)).
]

{ #category : #tests }
DCLNewModuleTest >> testIsFullySpecified [
	self deny:   (DCLModule new name: 'mod'; yourself) isFullySpecified.
	self deny:   (DCLModule new name: 'mod'; description: '.*abc.*'; yourself) isFullySpecified.
	self assert: (DCLModule new name: 'mod'; description: '.*abc.*'; model: #() ; yourself) isFullySpecified.
	self assert: (DCLModule new name: 'mod'; description: '.*abc.*'; model: mooseModel ; yourself) isFullySpecified.

]

{ #category : #tests }
DCLNewModuleTest >> testMemberEntities [
	| module |
	module := DCLModule new
		name: 'module-full' ;
		description: '.*Full.*' ;
		model: mooseModel ;
		yourself.
	
	self assert: module memberEntities size equals: 23.

]

{ #category : #tests }
DCLNewModuleTest >> testNoMemberEntities [
	| module |
	module := DCLModule new
		name: 'module-full' ;
		description: '.*whatever-inexistant.*' ;
		model: mooseModel ;
		yourself.
	
	self assert: module memberEntities isEmpty.

]
