NB. tgsjoglobals.ijs
NB. 3/1/2020

cocurrent 'tgsjo'
NB. defining some global utilities            ***************

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
NB. round to m decimal digits
rndm =: 1 : ' <.@:+&0.5&.(%&(10^-m))'
NB.    4 rndm pi
NB. 3.1416
cl=: 2 rndm

bgcolor=: 3 : 0
smoutput 'Bcolor_tgsjo_ was: ', ":Bcolor_tgsjo_
wh=. gl_qwh''
Bcolor_tgsjo_ =: 4{.!.1 y
gl_sel HD
gl_paint''
Bcolor_tgsjo_
)

msec=: 3 : 0
smoutput 'MS_tgsjo_ was: ', ":MS_tgsjo_
MS_tgsjo_=: +|y
)

stereo=: 3 : 0
smoutput 'stereodev_tgsjo_ was: ', ":stereodev_tgsjo_
stereodev_tgsjo_=: y
)

rotR=: 3 : 0
smoutput 'R_tgsjo_ was: ', ":R_tgsjo_
if. y-:'' do. y =. R0_tgsjo_ end.
wh=. gl_qwh''
R_tgsjo_=: 3{.y
gl_sel HD
gl_paint''
R_tgsjo_
)

translate=: 3 : 0
smoutput 'T_tgsjo_ was: ', ":T_tgsjo_
if. y-:'' do. y =. T0_tgsjo_ end.
wh=. gl_qwh''
T_tgsjo_=: 3{.y
gl_sel HD
gl_paint''
T_tgsjo_
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
x yw 0
empty''
)

turtleScale=: verb define         NB. edit verb
y turtleScale~ i.#positions
:
assert.  (#turtleScales)*./@:>,x
turtleScales=: y x}turtleScales
x yw 0
)

turtleEyeColor=: verb define         NB. edit verb
y turtleEyeColor~ i.#positions
:
assert.  ({:@$turtleEyeColors)-:{:@$y
assert.  ({.@$turtleEyeColors)*./@:>,x
turtleEyeColors=: turtleEyeColors x}~vrtxfface y
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

NB. forward 0[turtleScale_tgsjo_=:0 can make turtles invisible
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

NB. forward 0[turtleScale_tgsjo_=:0 can make turtles invisible
NB. https://www.win.tue.nl/~wstomv/publications/3d-turtle-geometry-reduced-unstyled.pdf
NB. https://www.win.tue.nl/~wstomv/talks/3d-turtle-geometry-talk-4up-reduced.pdf
NB. createTurtle 0 0 0[clearscreen''
NB. (3 repeats Spiralosaurus 5)
segment=: verb define"1
(i.#positions)segment y
:
'd rla ywa'=. y
x fd d
x rl rla
x yw ywa
)
Td=: ([: segment 0 90,~]) :([segment 0 90,~])
Rd=: ([: segment 90 90,~]) :([segment 90 90,~])
Pd=: ([: segment 180 90,~]) :([segment 180 90,~])
Ld=: ([: segment _90 90,~]) :([segment _90 90,~])
Spiralosaurus_base_=: Spiralosaurus=: 3 : 0
2 repeats Td y*4
2 repeats Ld y*9
2 repeats Td y*4
6 repeats Rd y*3
)
NB. createTurtle 0 0 0[clearscreen''
NB. (3 repeats Braidwork 5)
Braidwork_base_=: Braidwork=: 3 : 0
Ld 1*y
Rd 5*y
2 repeats Rd 6*y
Ld 3*y
Rd 1*y
Ld 5*y
2 repeats Ld 6*y
Rd 3*y
)

NB. 4 BPoly"0 ]BPy[penColor White
NB. pen 1[jumpup 1[pen 0
NB. 4 BPoly"0 ]6|.BPy[penColor Blue
NB. pen 1[jumpdown 2[pen 0
NB. 4 BPoly"0 ]_6|.BPy[penColor Yellow
BPoly_base_=: BPoly=: ((Rd@[)`(Pd@[)`(Ld@[))@.]
BPy=: 0 1 2 1 0 2 1 1 0 1 1 2 0 1 2 1 0 2

NB. see redo using BPoly above
BorromeanPolylink_base_=: BorromeanPolylink=: 3 : 0
Rd y*3 
Pd y*3 
Ld y*3 
Pd y*3 
Rd y*3 
Ld y*3 
2 repeats Pd y*3
Rd y*3 
2 repeats Pd y*3
Ld y*3 
Rd y*3 
Pd y*3 
Ld y*3 
Pd y*3 
Rd y*3 
Ld y*3
)

rnd=: <.@(0.5&+)
HSqrt3=: 2%~%:3
Sqrt3=: %:3
Sqrt2=: %:2
HSqrt2=: 2%~%:2
oddQ=: 2&|
evenQ=: -.@oddQ
duple=: 4&|
double=: 2&#
across=: (0 1$~-:@#) |:@:(|."_1) (_2]\])  NB. 9/19/9
Foursomes=: i. 4

dosido_tgsjo_=: dyad define
NB. quarters=. rnd NumSteps*y NB. number of quarter revolutions
quarters=. 4
pairs=. x NB. couple pairs
dancers=. ,/ pairs
if. oddQ quarters do. smoutput 'nonce' return. end.
NB. face pairs
dancers lt 45
while. quarters do.
  dancers fd y*HSqrt2
  dancers rt 45
  dancers fd y*0.5
  quarters=. <: quarters
  if. 0=quarters do. return. end.
  dancers fd y*0.5
  dancers rt 45
  dancers fd y*HSqrt2
  dancers lt 45
  quarters=. <: quarters
  if. 0=quarters do.
    if. Foursomes nneQ dancers do.
      position=. Foursomes i. {."1 pairs
      perm=. I_4 C.~ <duple position
    else.
      position=. Foursomes i."1 ({.,{:)"1 pairs
      perm=. I_4 C.~ <"1 duple |: position
    end.
    NB. DancerSymbols {~ each sfd arrangeFoursomes perm
    return.
  end.
  dancers lt 45
  dancers bk y*HSqrt2
  dancers rt 45
  dancers bk y*0.5
  quarters=. <: quarters
  if. 0=quarters do. return. end.
  dancers bk y*0.5
  dancers rt 45
  dancers bk y*HSqrt2
  dancers lt 45
  quarters=. <: quarters
  if. 0=quarters do.
    NB. DancerSymbols {~ each sfd Dancers
    return.
  end.
  dancers y*lt 45
end.
)

Note 'dosido setup'
LHip_tgsjo_=: %&15 LHip_tgsjo_
RHip_tgsjo_=: %&15 RHip_tgsjo_
Butt_tgsjo_=: %&15 Butt_tgsjo_
Nose_tgsjo_=: %&15 Nose_tgsjo_
NB. Coordinates_tgsjo_=: %&15 Coordinates_tgsjo_

rotR 45  0 0 
translate _0.5 0 _3
clearscreen''
'lead0 follow0 lead1 follow1' =: createTurtle _15 0 0,_15 _10 0,_5 _10 0,:_5 0 0
'lead2 follow2 lead3 follow3' =: createTurtle 25 0 0,25 _10 0,35 _10 0,:35 0 0
(lead1,follow1,lead3,follow3)rt 180
(".&>'follow' nl 0) penColor Yellow
(".&>'follow' nl 0) turtleEyeColor Yellow
0 1 4 5 turtleColor Yellow,Brown,Brown,:Gray

msec 400
(i.2 4)dosido 4
)

Note'description'
http://paulbourke.net/fractals/lorenz/

dx / dt = lorenza (y - x)
dy / dt = x (lorenzb - z) - y
dz / dt = xy - lorenzc z

One commonly used set of constants is lorenza = 10, lorenzb = 28, lorenzc = 8 / 3. 
Another is a = 28, b = 46.92, c = 4. 
"a" is sometimes known as the Prandtl number and "b" the Rayleigh number.
)

lorenz=: monad define
'X Y Z' =. |: p=. y
dx =. lorenza*Y-X
dy =. Y-~X*(lorenzb-Z)
dz =. -/ (X*Y),:lorenzc*Z
turnto p+d=. |:dt%~dx,dy,:dz
fd length d
positions
)
lorenza=: 10
lorenzb=: 28
lorenzc=: 8%3
dt=: 100

Note 'run lorenz with commands like the following'
NB. run 1
createTurtle 0.1 0 0
translate 0 0 _15
lorenz_tgsjo_^:50[positions
NB. or: 50 repeats do 'lorenz_tgsjo_ positions'
NB. repeat or even increase 50

NB. run 2 (drag the screen as wide as possible)
cs''
stereodev_tgsjo_=:_0.1
translate _1 0 _9
createTurtle _4 _4 0
lorenz_tgsjo_^:500[positions
NB. click F4 on the graphics pane
)

Note 'views for lorenz'
x
|-y     rotR 180 0 90

z
|-x     rotR 90 0 0

z
|-y     rotR 0 90 _90
)

commands =: 0 : 0

key turtle commands              ***************
x args are turtle number(s) or '' for all turtles
y args are suggested below in parentheses
yw:     yaw turtle(s) clockwise (degrees)
rl:     roll turtle(s) right side upward (degrees)
pt:     pitch turtle(s) nose upward (degrees)
fd:     move turtle(s) forward (steps)
bk:     move turtle(s) backward (steps)
ju:     jump turtle(s) upward (steps)
jr:     jump turtle(s) rightward (steps)
turnto: turn turtle(s) toward (3 coordintates)
createTurtle:  (3 coordinates)  [x arg quaternion]
pen:           penState(s) (up is 0, down 1)
penColor:      penColor(s) (colorname or 3 fractions)
turtleColor:   turtleColor(s) (4 colors shape 4 3)
turtleScale:   turtleScale(s) (0 is invisible, 1 default)
turtleTriangle:turtleTriangle(s) (4 coordinates shape 4 3)
               [(LHip,RHip,Butt,:Nose facing east)]

following have no x arguments
clearscreen: ('')
clearlines:  ('')
msec:        slow movements in millisecs (0 is default)
translate:   translate Eye (0 0 _19 is default)
rotR:        rotate Eye (20 30 0 is default)
bgcolor:     background color (colorname or 3 fractions)
stereo:      dev  (negative=X;0=2D;positive=||)
for available colornames try: list'='taketo"1 COLORTABLE
)

examples =: 0 : 0

sweetP=: createTurtle 0 0 0
translate 0 0 _3
turtleEyeColor Yellow,:Yellow
lilT=: createTurtle 20 0 0
lilT turtleEyeColor White,:White
rotR 0 0 0

lilT turtleColor Yellow,Green,Green,:White
;/{.turtleColors   NB. first turtle's colors at each vertex
;/{.turtleEyeColors   NB. similar for turtle eye colors

translate''  NB. return Eye/Camera to original position
NB. ct is an abbreviation for createTurtle
'Betty Joe Mary' =: ct _10 0 0,_10 10 0,:_10 _10 0
(Joe,Mary) penColor Red,:Blue
penColors   NB. shows the current colors
lt 45
2 3 4 fd 30 
0 1 bk 30 25
NB. shows 5 position vertices and 5 direction-cosine matrices
2 rndm each positions;;/dircos"1 orientations

ct 0 0 0[clearscreen'' NB. This resets with initTurtle'' too

20 repeats do 'yw 18[5 repeats do ''yw 72[fd 25'''

Now click on the canvas pane and press F4. Press F4, again.
Press F3.
Experiment with x,y,z,l,r,a, and s.
Remember to click on the Term pane to continue turtle commands.

ct 0 0 0[cs'' NB. cs is an abbreviation for clearscreen
rotR''   NB. rotate Eye/Camera to default 20 30 0

penColor Yellow
fd 30[pen 1[fd 10[pen 0[fd 10
2 repeats do '(360 arcr 0.08)[rt 40'

NB. now to see how repeats works, try repeatsNO
2 repeatsNO 'do' '(360 arcr 0.08)[rt 40'
NB. then manually execute each boxed command

NB. next slow down the turtle with MS_tgsjo_
msec 200   NB. 200 milliseconds, later change back to 0
20  (3 repeats fdyw) 30       NB. "fdyw" has left and right args

NB. also try 72 60 135 108 with poly
20 poly 144

ct 0 0 0[cs'' 
msec 0   NB. 0 milliseconds to speed up
NB. helix? 
10 poly3 30

ct 0 0 0[cs'' 
rotR''
3 gl 100 NB. gosper snowflake (do not increase the 3 above 4)

NB. Because of a known bug, newly defined multiline j verbs
NB.    cannot be entered directly into the jqt Term window, so
NB.    you must define them in an editor and either load
NB.    them or you can copy them to the clipboard and F8
NB.    (paste) them into the Term window.
NB.    The bug is being researched by the fine J team.
)

resources=: 0 : 0
Art and math with turtle commands.
https://www.win.tue.nl/~wstomv/publications/3d-turtle-geometry-reduced-unstyled.pdf
Brian Harvey, legendary teacher of logo.
https://people.eecs.berkeley.edu/~bh/
https://people.eecs.berkeley.edu/~bh/pdf/v1ch10.pdf
The Logo foundation, many resources.
https://el.media.mit.edu/logo-foundation/resources/websites_forums.html
An unbelievable text with 400 pages and 9 chapters.
https://www.academia.edu/5203649/Visual_modeling_with_Logo_a_structured_approach_to_seeing
3D online turtle graphics system
http://etl.ppp.uoa.gr/malt2/
)
