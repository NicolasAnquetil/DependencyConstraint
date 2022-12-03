"
I represent an architectural rule between two architectural modules A and B (DCLModule).
I specify that moduleA **only, can** depend on moduleB (and no other module apart for moduleB itself)
"
Class {
	#name : #DCLOnlyCanConstraint,
	#superclass : #DCLAbstractConstraint,
	#category : #'DependencyConstraint-Constraints'
}
