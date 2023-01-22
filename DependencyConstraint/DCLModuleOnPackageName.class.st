Class {
	#name : #DCLModuleOnPackageName,
	#superclass : #DCLAbstractModule,
	#instVars : [
		'description',
		'packageName'
	],
	#category : #'DependencyConstraint-Constraints'
}

{ #category : #testing }
DCLModuleOnPackageName >> isFullySpecified [
	^super isFullySpecified and:
	[ packageName isString ]
]

{ #category : #accessing }
DCLModuleOnPackageName >> packageName [
	^packageName
]

{ #category : #accessing }
DCLModuleOnPackageName >> packageName: aString [
	packageName := aString
]

{ #category : #accessing }
DCLModuleOnPackageName >> privateComputeMembers [
	^model allPackages select: [ :p | p name = packageName ]
]
