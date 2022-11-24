Extension { #name : #FAMIXAccess }

{ #category : #'*DependencyConstraint' }
FAMIXAccess class >> asString [

	^ 'access'
]

{ #category : #'*DependencyConstraint' }
FAMIXAccess >> querySelector [

	^ #queryOutgoingAccesses
]
