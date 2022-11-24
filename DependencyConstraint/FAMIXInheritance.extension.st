Extension { #name : #FAMIXInheritance }

{ #category : #'*DependencyConstraint' }
FAMIXInheritance class >> asString [

	^ 'inherit'
]

{ #category : #'*DependencyConstraint' }
FAMIXInheritance >> querySelector [

	^ #queryOutgoingInheritances
]
