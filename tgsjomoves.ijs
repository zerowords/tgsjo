NB. tgsjomoves.ijs
NB. 3/7/20

cocurrent 'tgsjo'

rev =: 1 : 'u&:- : (u -)'   NB. reverse for a name change

move=: adverb define
(i.#positions)m move y
:
dir=.m{I3
distance=. y*"0 1 dir rot2dir"1 x{orientations
oldpositions =. positions
newpositions=. distance+"1 x{positions
positions=:newpositions x}positions
drawlines oldpositions
renderTurtles''
)

drawlines=: monad define
if. +./penStates do.
    maskT=. penStates&#
    lines=. y ,. positions
    colors=. penColors ,. penColors
    pathlines=: pathlines,maskT lines
    pathcolors=: pathcolors,maskT colors
    lineData=:  2 rndm, pathlines 
    lcolorData=:  , pathcolors
end.
)

turn=: adverb define
(i.#positions)m turn y
:
axis=. (_4{.m=i.3) rot2dir"1 x{orientations
orientations=: orientations x}~ (x{orientations) qnmul axis rotation y
renderTurtles''
)

NB. these must FOLLOW the move and turn

fd=: 0 move
jl=: 1 move
ju=: 2 move

yw=: 2 turn rev
pt=: 1 turn rev
rl=: 0 turn rev

left=: lt=: yaw=: yw     NB. yaw group
lyw=: yw 
ryw=: rt=: right=: yw rev

rollright=: rollrt=: rrl=: roll=: rl     NB. roll group
rolllt=: rollleft=: lrl=: rl rev

pitchdown=: dpt=: pitch=: pt     NB. pitch group
pitchup=: upt=: pt rev

forward=: fd     NB. move group
jumpleft=: jl
jumpup=: ju

jr=: jumpright=: jl rev
bk=: back=: fd rev
jd=: jumpdown=: ju rev

NB. Below are experimental only
I=: # inv
darctan=:dfr@arctan@%
NB. m is 0 1 or 2 for xy or z marking the axis 
NB.     orthogonal to the plane that turtle will turn in
NB. This untesed adverb works only for direction
NB.    changes within a single plane at a time
NB.    So for example looking at 111 from 000
NB.    has to me done it 2 steps. Eg first 
NB.    looking toward 110 and then 
NB.    looking toward 111 from there.
NB. But for the second towards is tricky because 
NB.    it must be done in an axis plane, too.
NB. The result is a new heading for the turtle,
NB.    not the amount it must turn
towards=: adverb define
(i.#positions)m towards y
:
ind=. m-.~i. 3
dist=.y-&(ind&{)"1 (,x){positions
((180+darctan~)`(90**@])`(darctan~)@.(1&+@*@[))/"1 dist
)

NB. this is an untested variation on glu_LookAt 
NB. the big difference is rPitch in the last line
rPitch =: 2 rndm 3 3{.gl_Rotate 90 0 1 0
lookat=: 3 : 0"1
position=. y
up =. 0 1 0
F=. position -~ ,positions
f=. (% +/&.:*:)F
UPP=. (% +/&.:*:),up
s=. f ((1&|.@:[ * _1&|.@:]) - _1&|.@:[ * 1&|.@:]) UPP
u=. s ((1&|.@:[ * _1&|.@:]) - _1&|.@:[ * 1&|.@:]) f
M=. rPitch mp _3]\ s,  u,  (-f) 
)

normalize=: %length
sm=: [
diag =: (<0 1)&|:
a21=:5 7&{@,
a02=: 6 2&{@,
a10=: 1 3&{@,
lookAtMat=: monad define
mat=. y
sm trace=. +/diag mat
if. trace > 0 do.
smoutput 'positive',":s =: 0.5 % %: 1+trace
sm q0 =: 0.25%s
sm q1 =: s*-/a21 mat
sm q2 =: s*-/a02 mat
sm q3 =: s*-/a10 mat
else. 
if. (>/0 1{diag mat)*.>/0 2{diag mat do.
   smoutput 'zerolarge',":s =: 2.0 * %: 1.0 + -`+/diag mat
   sm q0 =: s%~-/a21 mat
   sm q1 =: 0.25*s
   sm q2 =: s%~+/a10 mat
   sm q3 =: s%~+/a02 mat
elseif. >/1 2{diag mat do.
   smoutput '1>2',":s =: 2.0 * %: 1.0 + -`+/1 0 2{diag mat
   sm q0 =: s%~-/a02 mat
   sm q1 =: s%~+/a10 mat
   sm q2 =: 0.25*s
   sm q3 =: s%~+/a21 mat
elseif. 1 do.
   smoutput 'else',":s =: 2.0 * %: 1.0 +  -`+/2 0 1{diag mat
   sm q0 =: s%~-/a10 mat
   sm q1 =: s%~+/a02 mat
   sm q2 =: s%~+/a21 mat
   sm q3 =: 0.25*s
end.
end.
smoutput 'length: ',":length q0,q1,q2,q3
smoutput 'q2euler: ',":2 rndm q2euler q0,q1,q2,q3
q0,q1,q2,q3
)

normalize =: %length
revyz=: 0 2 1&{"1
sm=: [
lookAt=: monad define
target=. y
   sm F=: normalize target -&revyz&, positions
   sm R=: normalize cross/ F,: revyz 0 0 1
   sm U=: cross/ R,:F
   sm Trace=: (0{R),(1{U),2{F
   trace=. +/Trace
if. trace > 0 do.
smoutput 'positive: ',":s =: 0.5 % %: 1+trace
sm q0 =: 0.25%s
sm q1 =: s*(2{U)- 1{F
sm q2 =: s*(0{F)- 2{R
sm q3 =: s*(1{R)- 0{U
else. 
if. ((0{R)>1{U)*. (0{R)>2{F  do.
   smoutput 'bigR: ',":s =: 2.0 * %: 1.0 + (0{R) - (1{U) + 2{F
   sm q0 =: s%~(2{U)- 1{F
   sm q1 =: 0.25*s
   sm q2 =: s%~(0{U)+ 1{R
   sm q3 =: s%~(0{F)+ 2{R
elseif. (1{U)>2{F do.
   smoutput 'U>F: ',":s =: 2.0 * %: 1.0 + (1{U) - (0{R) + 2{F
   sm q0 =: s%~(0{F)- 2{R
   sm q1 =: s%~(0{U)+ 1{R
   sm q2 =: 0.25*s
   sm q3 =: s%~(1{F)+ 2{U
elseif. 1 do.
   smoutput 'else: ',":s =: 2.0 * %: 1.0 + (2{F) - (0{R) + 1{U
   sm q0 =: s%~(1{R)- 0{U
   sm q1 =: s%~(0{F)+ 2{R
   sm q2 =: s%~(1{F)+ 2{U
   sm q3 =: 0.25*s
end.
end.
smoutput 'length: ',":length q0,q1,q2,q3
smoutput 'q2euler: ',":2 rndm q2euler q0,q1,q2,q3
q0,q1,q2,q3
)


runtest=: monad define
clearscreen''
createTurtle 0 0 0
t=.y
yw t
pt _30
smoutput '*******yw ',": t
smoutput orientations
fd 10
target=. positions
fd _10
pt 30
yw -t
smoutput lookAt target
)

NB. some usage examples
NB. lookAtMat 3 3{.(gl_Rotate 30 0 1 0) mp gl_Rotate _45 0 0 1
NB. runtest"0] 45 _45 135 _135
