Class {
	#name : #DCLModuleTest,
	#superclass : #DCLAbstractTest,
	#category : #'DependencyConstraint-Tests'
}

{ #category : #tests }
DCLModuleTest >> testAsTag [
	| module tag |
	module := DCLModule new
		name: 'module-full' ;
		description: '.*Full.*' ;
		model: mooseModel ;
		yourself.

	self assert: mooseModel allTags isEmpty.
	self deny: module memberEntities first isTagged.

	tag := module asTag.

	self assert: mooseModel allTags size equals: 1.
	self assert: module memberEntities first isTagged.

]

{ #category : #tests }
DCLModuleTest >> testDescriptionMatches [
	| module |
	module := DCLModule new
		name: 'p123';
		description: '.*abc.*';
		yourself.
	
	self assert: (module descriptionMatches: (FamixStNamedEntity new name: 'abcdefg' ; yourself)).
	self deny:   (module descriptionMatches: (FamixStNamedEntity new name: 'gfedcba' ; yourself)).
]

{ #category : #tests }
DCLModuleTest >> testIsFullySpecified [
	self deny:   (DCLModule new name: 'mod'; yourself) isFullySpecified.
	self deny:   (DCLModule new name: 'mod'; description: '.*abc.*'; yourself) isFullySpecified.
	self assert: (DCLModule new name: 'mod'; description: '.*abc.*'; model: #() ; yourself) isFullySpecified.
	self assert: (DCLModule new name: 'mod'; description: '.*abc.*'; model: mooseModel ; yourself) isFullySpecified.

]

{ #category : #tests }
DCLModuleTest >> testMemberEntities [
	| module |
	module := DCLModule new
		name: 'module-full' ;
		description: '.*Full.*' ;
		model: mooseModel ;
		yourself.
	
	self assert: module memberEntities size equals: 24.

]

{ #category : #tests }
DCLModuleTest >> testNoMemberEntities [
	| module |
	module := DCLModule new
		name: 'module-full' ;
		description: '.*whatever-inexistant.*' ;
		model: mooseModel ;
		yourself.
	
	self assert: module memberEntities isEmpty.

]
