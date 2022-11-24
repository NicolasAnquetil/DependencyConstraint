Extension { #name : #FAMIXInvocation }

{ #category : #'*DependencyConstraint' }
FAMIXInvocation class >> asString [

	^ 'invoke'
]

{ #category : #'*DependencyConstraint' }
FAMIXInvocation >> querySelector [

	^ #queryAllOutgoingInvocations
]
