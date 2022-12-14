Extension { #name : #MooseModel }

{ #category : #'*DependencyConstraint' }
MooseModel >> allModelScopingEntities [

	^ self sourceLanguage isJava 
		ifTrue: [ self allNamespaces reject: [ :n | n isStub ] ]
		ifFalse: [ self allModelPackages ]
]
