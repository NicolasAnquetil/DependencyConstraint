Class {
	#name : #DCLAbstractConstraintTest,
	#superclass : #DCLAbstractTest,
	#instVars : [
		'p2p5',
		'p3'
	],
	#category : #'DependencyConstraint-Tests'
}

{ #category : #initialization }
DCLAbstractConstraintTest >> setUp [
	super setUp.

	p2p5 := DCLModule new
		name: 'p2p5' ;
		description: '.*-P[25].*' ;
		model: mooseModel ;
		yourself.
	p3 := DCLModule new
		name: 'p3' ;
		description: '.*-P3.*' ;
		model: mooseModel ;
		yourself.

]
