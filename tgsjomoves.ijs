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






