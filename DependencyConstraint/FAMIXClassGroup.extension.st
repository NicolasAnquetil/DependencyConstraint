Extension { #name : #FAMIXClassGroup }

{ #category : #'*DependencyConstraint' }
FAMIXClassGroup >> queryOutgoingDependencies: aClassGroup byType: aFAMIXAssociationClass [
	"queries all dependencies to a class group that has a given type"
	
	^ self allClasses flatCollect: [ :class | 
		( class perform: aFAMIXAssociationClass new querySelector )
			select: [ :dependency | 
				dependency to asCollection anySatisfy: [ :to | aClassGroup includes: to typeScope ] ] ]
]
