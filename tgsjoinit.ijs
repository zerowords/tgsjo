NB. tgsjoinit.ijs
NB. 3/1/2020

cocurrent 'tgsjo'
require '~addons/graphics/color/colortab.ijs'

NB. setting global parameter values  ***************

''[do(>@{.,%&255&.".&>@{:)"1]23 split"1 COLORTABLE 

initTurtle=: monad define


vrtxfface=: (_3 ]\ 3 # ])"2
NB. 0.7 interpolate turtleTriangles
interpolate=: (-.@[ * ]) +"1 [ * (+/ % 3:)@]

if. -. initialized do.
MS=: 0              NB. 0 millisecond delay for turtle actions
NB. Red back, blue sides, white bottom
turtleColors=:,: vrtxfface Red,Blue,Blue,:White
turtleColors0=:turtleColors
turtleEyeColors=:,: vrtxfface Black,:Black
turtleEyeColors0=:turtleEyeColors

queue=:''           NB. associated with conjunction repeatsNO
Vertices=: 0 2 1,1 2 3,3 2 0,:0 1 3
LHip=: _9  4 0
RHip=: _9 _4 0
Butt=: _4  0 5
Nose=:  0  0 0
end.

turtleColors=:turtleColors0=:1 4 3 3{.turtleColors
turtleEyeColors=:turtleEyeColors0=:1 2 3 3{.turtleEyeColors
Coordinates=: %&0.8 LHip,RHip,Butt,:Nose
turtleTriangles0=: turtleTriangles=:  ,: Vertices { Coordinates
turtleEyeTriangles0=: turtleEyeTriangles=: 0.8 interpolate"2 ]1 2{"3 turtleTriangles

sceneTriangles=: i.0 0 0
sceneNormals=: i.0 0 0
sceneColors=: i.0 0 0
sceneLines=: i.0 0 0
sceneLcolors=: i.0 0 0

positions=:i.0 3
orientations=: i.0 4


penColors=: i. 0 3              NB. specimen
penColors0=: White              NB. default
penColorA=: 3 : 'penColors=: penColors,penColors0 ' NB. append-1 verb

turtleScales=: i. 0                NB. specimen
turtleScales0=: 1                  NB. default
turtleScaleA=: 3 : 'turtleScales=: turtleScales,turtleScales0 ' NB. append-1 verb

penStates=: i. 0                NB. specimen
penStates0=: 1                  NB. default
penStateA=: 3 : 'penStates=: penStates,penStates0 ' NB. append-1 verb

pathlines=: i. 0 6
pathcolors=: i. 0 6

)



