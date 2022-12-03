Class {
	#name : #DCLAbstractConstraintTest,
	#superclass : #DCLAbstractTest,
	#instVars : [
		'p2p5',
		'p3',
		'p13',
		'p14'
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
	p13 := DCLModule new
		name: 'p13' ;
		description: '.*-P13.*' ;
		model: mooseModel ;
		yourself.
	p14 := DCLModule new
		name: 'p14' ;
		description: '.*-P14.*' ;
		model: mooseModel ;
		yourself.

]
