NB. tgsjoglobals.ijs
NB. 3/1/2020

cocurrent 'tgsjo'
NB. defining some globals            ***************

pi=: 1p1
sin=: 1&o.
cos=: 2&o.
arccos=: _2&o.
arctan=: _3&o.
dfr=: *&(180%pi)
rfd=: *&(pi%180)
NB. matrix and vector verbs
x=: mp=: +/ . *"2
mfv0=: _3&(]\)"1    NB. matrix from vector
length=: +/&.:*:"1
sqlength=: +/&: *:"1
nrmlz=: ] % [: length ]
I3=: =@i. 3

copies =: $,:
rndm =: 1 : ' <.@:+&0.5&.(%&(10^-m))'
NB.    4 rndm pi
NB. 3.1416
cl=: 2 rndm

bgcolor=: 3 : 0
wh=. gl_qwh''
Bcolor_tgsjo_ =: 4{.!.1 y
gl_sel HD
gl_paint''
)

NB. As for movement verbs, dyadic versions apply to turtle list
NB.    in the next few verbs.    *************
penColor=: verb define         NB. edit verb
y penColor~ i.#positions
:
assert.  ({:@$penColors)-:{:@$y
assert.  ({.@$penColors)*./@:>,x
penColors=: y x}penColors
)

pen=: penState=: verb define         NB. edit verb
y penState~ i.#positions
:
assert.  (#penStates)*./@:>,x
penStates=: y x}penStates
)

turtleColor=: verb define         NB. edit verb
y turtleColor~ i.#positions
:
assert.  ({:@$turtleColors)-:{:@$y
assert.  ({.@$turtleColors)*./@:>,x
turtleColors=: turtleColors x}~vrtxfface y
yw 0
empty''
)

turtleTriangle=: verb define         NB. edit verb
y turtleTriangle~ i.#positions
:
assert.  ({:@$turtleTriangles)-:{:@$y
assert.  ({.@$turtleTriangles)*./@:>,x
turtleTriangles=: turtleTriangles x}~Vertices{y
yw 0
empty''
)

NB. Below apply only to ALL turtles ********

NB. enable one-liner turtle movement sequences
repeats=: conjunction define
for. i. m
do. v y
end.
:
for. i. m
do. x v y
end.
)

repeatsNO=: conjunction define
wd'timer 500'
queue =: a:
for. i. m
do. queue =: queue,<n,' ', ":y
end.
queue_tgsjo_=:}.queue
NB. wd'timer 0'
:
wd'timer 500'
for. i. m
do. queue =: queue,<x,' ', n,' ', ":y
end.
queue_tgsjo_=:}.queue
NB. wd'timer 0'
)

NB. a handy verb that combines J and turtle commands
ywfd=: yawforward=: dyad define
yw x
fd y
)

fdyw=: forwardyaw=: dyad define
fd x
yw y
)

NB. Turtle Geometry Abelson & diSessa
NB. a handy verb that combines J and turtle commands
NB. fun for 3D spirals
poly3=: 4 : 0
totalangle=.0
p=. positions
o=. orientations
whilst. 360|totalangle=.totalangle+y do.
    penColor Red
    fd x
    rl y
    penColor Blue 
    ju x
    yw y
    penColor White
    jr x
    pt -y  NB. or y
end.
)

NB. 2 poly 144
poly=: dyad define
totalangle=.0
p=. positions
o=. orientations
whilst. 360|totalangle=.totalangle+y do.
    fd x
    rt y
end.
)


NB. eg: 90 arcr 0.01
arcr=: dyad define
deg=. x
r=. y
for. i. x do.
    fd r
    rt 1
end.
)

arcl=: dyad define
deg=. x
r=. y
for. i. x do.
    fd r
    lt 1
end.
)

NB. https://en.wikipedia.org/wiki/Gosper_curve
NB. 4 gl 50
NB. be careful not to make x bigger than 4
gl=: dyad define
st=.x
ln=.y
st=. st - 1
ln=. ln %%: 7
if. st > 0 do.
    lt 60 
    st rg ln
    rt 60 
    st gl ln
    st gl ln 
    rt 120 
    st gl ln 
    rt 60 
    st rg ln 
    lt 120 
    st rg ln 
    lt 60 
    st gl ln
end.
if. st = 0 do.
    lt 60 
    fd ln 
    rt 60 
    fd ln 
    fd ln 
    rt 120 
    fd ln 
    rt 60 
    fd ln 
    lt 120 
    fd ln 
    lt 60 
    fd ln
end.
)

rg=: dyad define 
st=.x
ln=.y
st=. st - 1
ln=. ln %%: 7
if. st > 0 do.
    st rg ln
    rt 60 
    st gl ln
    rt 120 
    st gl ln
    lt 60 
    st rg ln
    lt 120 
    st rg ln
    st rg ln
    lt 60 
    st gl ln
    rt 60
end.
if. st = 0 do.
    fd ln 
    rt 60 
    fd ln 
    rt 120 
    fd ln 
    lt 60 
    fd ln 
    lt 120 
    fd ln 
    fd ln 
    lt 60 
    fd ln 
    rt 60
end.
)


commands =: 0 : 0

key turtle commands              ***************
x args are turtle number(s) or '' for all turtles
y args are suggested below in parentheses
yw:    yaw turtle(s) clockwise (degrees)
rl:    roll turtle(s) right side upward (degrees)
pt:    pitch turtle(s) nose downward (degrees)
fd:    move turtle(s) forward (steps)
bk:    move turtle(s) backward (steps)
ju:    jump turtle(s) upward (steps)
jr:    jump turtle(s) rightward (steps)
pen:   penState(s) (up is 0, down 1)
penColor:    penColor(s) (colorname or 3 fractions)
turtleColor: turtleColor(s) (4 colors shape 4 3)
turtleTriangle: turtleTriangle(s) (4 coordinates shape 4 3)

for available colornames try: '='taketo"1 COLORTABLE

createTurtle: (3 coordinates)  [x arg quaternion]
clearscreen:  ('')  [no y arg]
)

examples =: 0 : 0

turtleColor Yellow,Green,Green,:White
;/{.turtleColors   NB. shows current colors at each vertex

'Joe Mary' =: createTurtle 0 10 0,:0 _10 0
(0,Joe,Mary) penColor Gray,Red,:Blue
penColors   NB. shows the current colors
NB. shows 3 position vertices and 3 direction-cosine matrices
2 rndm each positions;;/dircos"1 orientations

20 repeats do 'yw 18[5 repeats do ''yw 72[fd 25'''

Now click on the canvas pane and press F4. Press F4, again.
Press F3.
Experiment with x,y,z,l,r,a, and s.
Remember to click on the Term pane to continue turtle commands.

clearscreen''  NB. This resets with initTurtle'' too

penColor Yellow
fd 30[pen 1[fd 10[pen 0[fd 10
2 repeats do '(360 arcr 0.08)[rt 40'

NB. now to see how repeats works, try repeatsNO
2 repeatsNO 'do' '(360 arcr 0.08)[rt 40'
NB. then manually execute each boxed command

NB. next slow down the turtle with MS_tgsjo_
MS_tgsjo_=: 200   NB. 200 milliseconds, later change back to 0
20  (3 repeats fdyw) 30       NB. "fdyw" has left and right args

NB. also try 72 60 135 108 with poly
20 poly 144

clearscreen''  NB. This resets with initTurtle'' too
MS_tgsjo_=: 0   NB. 0 milliseconds to speed up
NB. helix? 
5 (4 repeats poly3)72

clearscreen''  
4 gl 100 NB. gosper snowflake

NB. Because of a known bug, newly defined multiline j verbs
NB.    cannot be entered directly into the jqt Term window, so
NB.    you must define them in an editor and either load
NB.    them or you can copy them to the clipboard and F8
NB.    (paste) them into the Term window.
NB.    The bug is being researched by the fine J team.
)


