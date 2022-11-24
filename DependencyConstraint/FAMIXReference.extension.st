Extension { #name : #FAMIXReference }

{ #category : #'*DependencyConstraint' }
FAMIXReference class >> asString [

	^ 'reference'
]

{ #category : #'*DependencyConstraint' }
FAMIXReference >> querySelector [

	^ #queryOutgoingReferences
]
