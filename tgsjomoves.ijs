NB. tgsjomoves.ijs
NB. 3/7/20

cocurrent 'tgsjo'

NB. RightLeft is also used in 'turn'
rev =: 1 : 'u&:- : (u -)'   NB. reverse for a name change
Inv =: ^: RightLeft         NB. change axis handedness; change after RightLeft

yw=: yaw     NB. yaw group
lyw=: yw :.  (yw rev)
lt=: left=: lyw Inv
ryw=: (yw rev) :.  yw
rt=: right=: ryw Inv

rl=: roll     NB. roll group
lrl=: rl :.  (rl rev)
rolllt=: rollleft=: lrl 
rrl=: (rl rev) :.  rl
rollrt=: rollright=: rrl 

pt=: pitch     NB. pitch group
upt=: pt :.  (pt rev)
pitchup=: upt Inv
dpt=: (pt rev) :.  pt
pitchdown=: dpt Inv

forward=: fd     NB. move group
jumpleft=: jl
ju=: jumpup

jr=: jumpright=: jl rev
bk=: back=: fd rev
jd=: jumpdown=: ju rev

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

yw=: 2 turn
pt=: 1 turn
rl=: 0 turn

NB. Below are experimental only
I=: # inv
darctan=:dfr@arctan@%
NB. m is 0 1 or 2 for fd jl or ju
NB. This untesed adverb works only for direction
NB.    changes within a single plane at a time
NB.    So for example looking at 111 from 000
NB.    has to me done it 2 steps. Eg first 
NB.    looking toward 110 and then 
NB.    looking toward 111 from there.
towards=: adverb define
(i.#positions)m towards y
:
ind=. m-.~i. 3
dist=.y-&(ind&{)"1 (,x){positions
chk0=. -. 0 0 *./ . ="1 dist
dist=. chk0#dist
x=. chk0#x
NB. apparently yw and rl have to be negated in next line
(_1^m+1)* (,chk0) I ((180+darctan/~)`(90**@[/~)`(darctan/~)@.(1&+@*@[))/"1 dist
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

