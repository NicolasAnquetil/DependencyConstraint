# DependencyConstraint
DCL is a language to define dependency constraints between software entities.
It is intended to define and check architectural constraints.

It is inspired by: Valente, Terra, "A dependency constraint language to manage object-oriented software architectures", *Software Practice and Experience,* 39(12), 1073-1094, August 2009

How to:
- Create "Modules"
```Smalltalk
gui := DCLModule new
  name: 'gui' ;
  description: '.*\.gui'; "match entities with name ending in '.gui'"
  model: <a-moose-model> ;
  yourself.
draw := DCLModule new
  name: 'draw' ;
  description: '.*\.draw'; "match entities with name ending in '.draw'"
  model: <a-moose-model> ;
  yourself.
```
- Define constraints
```Smalltalk
constraint := gui canOnly depend: draw.
```
- Check that the constraint is verified
```Smalltalk
violations := constraint check.
```

Possible constraints are:
- `moduleA cannot <a-dependence> moduleB` -- moduleA cannot depend on moduleB
- `moduleA must <a-dependence> moduleB` -- moduleA must have dependence(s) on moduleB
- `moduleA canOnly <a-dependence> moduleB` -- moduleA can only depend on moduleB (apart from self dependencies in moduleA)
- `moduleA onlyCan <a-dependence> moduleB` -- moduleA only, can depend on moduleB (apart from self dependencies in moduleB)

The possible dependencies are:
- `access:` -- looks for `FamixTAccesse` between the 2 modules
- `invoke:` -- looks for `FamixTInvocation` between the 2 modules
- `reference:` -- looks for `FamixTReference` between the 2 modules
- `inherit:` -- looks for `FamixTInheritance` between the 2 modules
- `dependence:` -- looks for `FamixTassociation` between the 2 modules
