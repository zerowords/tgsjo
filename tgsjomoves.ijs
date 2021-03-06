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
orientations=: orientations x}~ (x{orientations) qnmul axis rotation -y
renderTurtles''
)

NB. these must FOLLOW the move and turn

fd=: 0 move
jl=: 1 move
ju=: 2 move

yw=: 2 turn
pt=: 1 turn
rl=: 0 turn

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


normalize =: %length
lfr =: $@] $ ,@[
subtlfr=: lfr-]
lookAt=: verb define
(i.#positions)lookAt y
:
result=. i. 0 3
target=. y
   R=. normalize"1 target subtlfr result,(x&{)positions
   U=. normalize cross/"2 R,:"1 (0 0 1)
   F=. cross/"2 U,:"1 R
   mat=.i. 0 0 3
   mat=. mat,R,"1 2 U,:"1 F
for_i. x do. 
result=. result,lookAt0 i_index{ mat 
end.
)

lookAt0 =: monad define
'R U F'=. y
   Trace=. (0{R),(1{U),2{F
   trace=. +/Trace
if. trace > 0 do.
s =. 0.5 % %: 1+trace
q0 =. 0.25%s
q1 =. s*(2{U)- 1{F
q2 =. s*(0{F)- 2{R
q3 =. s*(1{R)- 0{U
else. 
if. ((0{R)>1{U)*. (0{R)>2{F  do.
   s =. 2.0 * %: 1.0 + (0{R) - (1{U) + 2{F
   q0 =. s%~(2{U)- 1{F
   q1 =. 0.25*s
   q2 =. s%~(0{U)+ 1{R
   q3 =. s%~(0{F)+ 2{R
elseif. (1{U)>2{F do.
   s =. 2.0 * %: 1.0 + (1{U) - (0{R) + 2{F
   q0 =. s%~(0{F)- 2{R
   q1 =. s%~(0{U)+ 1{R
   q2 =. 0.25*s
   q3 =. s%~(1{F)+ 2{U
elseif. 1 do.
   s =. 2.0 * %: 1.0 + (2{F) - (0{R) + 1{U
   q0 =. s%~(1{R)- 0{U
   q1 =. s%~(0{F)+ 2{R
   q2 =. s%~(1{F)+ 2{U
   q3 =. 0.25*s
end.
end.
q2euler q0,q1,q2,q3
)

q2euleramb03=: q2euler : ((i.0 3),q2euler@:{)
turnto=: verb define
(i.#positions) turnto y
:
target=. y
orient=. x q2euleramb03 orientations
new=.|.|: orient
x yw x{,0{new
x pt x{,1{new
x rl x{,2{new
new=. |.|:(x lookAt target)
x yw x{,0{new
x pt x{,1{new
x rl x{,2{new
)

NB. a usage example
NB. to avoid the "slow" feature change locale here
NB. cocurrent 'tgsjo'
NB. createTurtle 0 0 0,:10 0 0
NB. yw 90
NB. turnto target=. 6.12372 6.12372 5,:16.12372 6.12372 5
NB. positions
NB. 2 rndm orientations
NB. fd 10
NB. positions
