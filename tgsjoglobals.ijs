NB. tgsjoglobals.ijs
NB. 3/1/2020

cocurrent 'tgsjo'
NB. defining some globals            ***************

pi=: 1p1
sin=: 1&o.
cos=: 2&o.
arccos=: _2&o.
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

pencolor=: verb define         NB. edit verb
y pencolor~ i.#positions
:
assert.  ({:@$pencolors)-:{:@$y
assert.  ({.@$pencolors)*./@:>,x
pencolors=: y x}pencolors
)


penstate=: verb define         NB. edit verb
y penstate~ i.#positions
:
assert.  (#penstates)*./@:>,x
penstates=: y x}penstates
)


turtlecolor=: verb define         NB. edit verb
y turtlecolor~ i.#positions
:
assert.  ({:@$turtleColors)-:{:@$y
assert.  ({.@$turtleColors)*./@:>,x
turtleColors=: turtleColors x}~vrtxfface y
yw 0
empty''
)


turtletriangle=: verb define         NB. edit verb
y turtletriangle~ i.#positions
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

NB. a handy verb that combines J and turtle commands
NB. fun for 3D spirals
poly3=: 4 : 0
pencolor Red
fd x
rl y
pencolor Blue 
ju x
yw y
pencolor White
jr x
pt -y
empty''
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
pen:   penstate(s) (up is 0, down 1)
pencolor:    pencolor(s) (colorname or 3 fractions)
turtlecolor: turtlecolor(s) (4 colors shape 4 3)
turtletriangle: turtletriangle(s) (4 coordinates shape 4 3)
createTurtle: (3 coordinates)

for available colornames try: '='taketo"1 COLORTABLE
)

examples =: 0 : 0

turtlecolor Yellow,Green,Green,:White

'Joe Mary' =: createTurtle 0 1 0,:0 _1 0
(0,Joe,Mary) pencolor Gray,Red,:Blue

20 repeats do 'yw 18[5 repeats do ''yw 72[fd 2'''

Now click on the canvas pane and press F4. Press F4, again.
Press F3.
Experiment with x,y,z,l,r,a, and s.
Remember to click on the Term pane to continue turtle commands.

clearscreen''

1  (2 repeats fdyw) 30       NB. "fdyw" has left and right args
2 rndm each positions;;/dircos"1 orientations

9 repeats do '(360 arcr 0.008)[rt 40'
fd 1
pencolor Yellow
9 repeatsNO 'do' '(360 arcr 0.008)[rt 40'
)


