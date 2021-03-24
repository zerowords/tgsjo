# tgsjo
A "modern" openGL turtle graphics/turtle geometry system using the J programming language
```
Turtle commands control multiple turtles at once with J's tradtional "ambivalent" arguments.
The monadic (right-hand argument) versions supply quantitative values to all turtles.
The left-hand argument list of dyadic versions selects individuals, by index or name.

A "slow" turtle action mode can be controlled via `MS_tgsjo_=: 300` for example.
Quaternions manage the turtle movements using J code on turtle orientations and positions.

Scripts are defined in the 'tgsjo' locale. 
The user typically is in the 'base' locale (which inherits the terms of 'tgsjo').
The full J language is available to the user at https://www.jsoftware.com/ .

Turtles are simple tetrahedra constructed from 4 coordinates in 3D.
The turtle pens are colored by the user with the `penColor` command.
The pen colors are retained in the 'penColors' noun.
Other commands and attributes are retained using a similar naming pattern.
```

## Setup
To install tgsjo enter the **indented** lines in jconsole or jqt.

```
   install'github:zerowords/tgsjo@righthand'
installed: zerowords/tgsjo righthand into folder: zerowords/tgsjorighthand
   dir '~addons/zerowords/tgsjorighthand/'
manifest.ijs             292 29-Sep-20 16:26:06
readme.ijs              4374 23-Sep-20 17:14:52
tgsjorighthand.ijs     13687 29-Sep-20 16:23:02
tgsjoalias.ijs           440 29-Sep-20 16:23:02
tgsjoglobals.ijs        3676 29-Sep-20 16:23:02
tgsjoinit.ijs           1334 29-Sep-20 16:23:02
tgsjomoves.ijs          1535 23-Sep-20 18:28:25
tgsjoslow.ijs           1685 29-Sep-20 16:33:41
```
## More readme
``` load '~addons/zerowords/tgsjorighthand/readme.ijs'```

## Run tgsjo
```
load 'zerowords/tgsjorighthand'
createTurtle 0 0 0
```
