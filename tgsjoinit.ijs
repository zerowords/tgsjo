NB. tgsjoinit.ijs
NB. 3/1/2020

cocurrent 'tgsjo'
require '~addons/graphics/color/colortab.ijs'

NB. setting global parameter values  ***************

''[do(>@{.,%&255&.".&>@{:)"1]23 split"1 COLORTABLE 

RightLeft=:  1      NB. yaw is left
RightLeft=: _1      NB. yaw is right NB. left hand axis

initTurtle=: monad define

queue=:''
Vertices=: 0 2 1,1 2 3,3 2 0,:0 1 3
LHip=: _9 _4 0
RHip=: _9  4 0
Butt=: _7  0 5
Face=:  0  0 0
Coordinates=: %&15 LHip,RHip,Butt,:Face
baseTurtleTriangles=: turtleTriangles=:  ,: Vertices { Coordinates

vrtxfface=: (_3 ]\ 3 # ])"2

NB. Red back, blue sides, white bottom
turtleColors=:,: vrtxfface Red,Blue,Blue,:White
baseTurtleColors=:turtleColors


sceneTriangles=: i.0 0 0
sceneNormals=: i.0 0 0
sceneColors=: i.0 0 0
sceneLines=: i.0 0 0
sceneLcolors=: i.0 0 0

positions=:i.0 3
orientations=: i.0 4

turtleScale=:1

penColors=: i. 0 3              NB. specimen
penColors0=: White              NB. default
penColorA=: 3 : 'penColors=: penColors,penColors0 ' NB. append-1 verb

penStates=: i. 0                NB. specimen
penStates0=: 1                  NB. default
penStateA=: 3 : 'penStates=: penStates,penStates0 ' NB. append-1 verb

pathlines=: i. 0 6
pathcolors=: i. 0 6

)



