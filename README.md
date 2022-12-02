# DependencyConstraint
DCL is a language to define dependency constraints between software entities. It includes a checker to look for constraint violations.

inspired by DCL, proposed by Ricardo Terra et. al, 2012.

How to:
First, we give an example of a constraint in a real project: JHotDraw.
```Smalltalk
gui = org::jhotdraw::gui*
draw = org::jhotdraw::draw*
gui canOnly access draw
```

This constraint defines that the module gui (which comprises all entities defined in the package "gui" and subpackages) can only access attributes of the module draw (defined the same way as module gui). As consequence, all accesses from module gui to any other module than draw will be count as a violation.

The format of a constraint is:
```Smalltalk
only <module> can <depend> <module> | <module> <constraint> <depend> <module>
<constraint> = canOnly | cannot | must
<depend> = access | invoke | reference | inherit
```
The last step, given a Moose model of the project and the command as a String, is to call the dependency checker:

```
violations := DCLChecker check: aMooseModel with: command
```
