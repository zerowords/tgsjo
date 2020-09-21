smoutput readme =: 0 : 0
Readme file for tgsjo.ijs

The purpose of these tgsjo scripts is to demonstrate
a J-like environment for experimenting with the 
Logo-like turtle geometry language developed at 
MIT by the likes of Seymour Papert, Harold Abelson, 
and Andrea diSessa. This version uses openGL for 
the graphics system. The scripts are written in 
standard J to encourage more people to use J 
and to understand and modify the code.

I want to give special thanks to Raul Miller who 
wrote almost all of the difficult parts of the code 
and provided endless guidance to me about openGL 
and quaternions. Others of the J developers and 
community have continued to provide invaluable aid. 

**.....** below signals a command that can be entered
in the jQt Term window (but not when the graphics
canvas has focus.

 *.....* below signals an entry or revision that
applies to the script file gsjo.ijs.

The command *tgsj_run''* at the bottom of the script
tgsjo.ijs executes the script in jQt (only).
*tgsj_run''* is automatically run when you load the
script.

The scripts must all be saved together in a directory 
in the J user directory. If necessary, change the
definition of the noun *path* near the top of the
script tgsjo.ijs.

Upon successful (automatic) initialization of the tgsjo
system, a single turtle will be created at position
x,y,z:0 0 0. You will see turtle 0 in the center of the
graphics canvas facing east. You can immediately give
turtle 0 monadic commands to turtle 0 such as **fd
20**, **rt 90**, **lt 45**. The commands are monadic,
meaning they have only a righthand argument. As monadic
commands they apply to all existing turtles created
with the **createTurtle x,y,z** command. If you wish to
give different turtle commands to different turtles, a
lefthand argument will accept its or their turtle
numbers. Because **createTurtle 0 0 0** returns an
index number for each turtle it creates, you can even
assign a name to each turtle, to be used alternatively
to the turtle's number; for example,
**Sweetpea=:createTurtle 0 5 0**.

Enter **commands** to see a list of the key turtle 
commands.
Enter **examples** to see a few turtle examples.
)


Note '(readme is repeated below with no wrapping.)'
Readme file for tgsjo.ijs 

The purpose of these tgsjo scripts is to demonstrate a J-like environment for experimenting with the Logo-like turtle geometry language developed at MIT by the likes of Seymour Papert, Harold Abelson, and Andrea diSessa. This version uses openGL for the graphics system. The scripts are written in standard J to encourage more people to use J and to understand and modify the code.

I want to give special thanks to Raul Miller who wrote almost all of the difficult parts of the code and provided endless guidance to me about openGL and quaternions. Others of the J developers and community have continued to provide invaluable aid. 

**.....** below signals a command that can be entered in the jQt Term window (but not when the graphics canvas has focus.
 *.....* below signals an entry or revision that applies to the script file gsjo.ijs.

The command *tgsj_run''* at the bottom of the script tgsjo.ijs executes the script in jQt (only).
*tgsj_run''* is automatically run when you load the script. 

The scripts must all be saved together in a directory in the J user directory. If necessary, change the definition of the noun *path* near the top of the script tgsjo.ijs.

Upon successful (automatic) initialization of the tgsjo system, a single turtle will be created at position x,y,z:0 0 0.
You will see turtle 0 in the center of the graphics canvas facing east. You can immediately give turtle 0 monadic commands to turtle 0 such as **fd 20**, **rt 90**, **lt 45**. The commands are monadic, meaning they have only a righthand argument. As monadic commands they apply to all existing turtles created with the **createTurtle x,y,z** command. If you wish to give different turtle commands to different turtles, a lefthand argument will accept its or their turtle numbers. Because **createTurtle 0 0 0** returns an index number for each turtle it creates, you can even assign a name to each turtle, to be used alternatively to the turtle's number; for example, **Sweetpea=:createTurtle 0 5 0**.

Enter **commands** to see a list of the key turtle commands.
Enter **examples** to see a few turtle examples.
)
