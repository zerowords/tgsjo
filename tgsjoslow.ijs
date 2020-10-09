NB. tgsjoslow.ijs
NB. 9/28/20
NB. This script enables Slow movement of turtles.
NB. The slowness is controlled by setting MS_tgsjo_ 
NB.    to the number of milliseconds between moves.
NB. This feature can only be used from locale 'base'.
NB. To completely avoid Slow, execute turtle movement
NB.    commands from locale 'tgsjo'.
NB. This tricky feature was designed by Raul Miller.

cocurrent'tgsjo'
buildDeferralQueue=:3 :0
for_cmd. y do. buildDeferrals;cmd end.
((;: 'userQ autoQ tgsjo '),copath 'base') copath 'base'
(;: 'autoQ tgsjo z') copath 'userQ'
(;: 'tgsjo z') copath 'autoQ'
stop''
)

stop=:3 :0
instructionQueue_tgsjo_=:''
)

buildDeferrals=:3 :0
'unm anm tnm'=:y,L:0 cutopen '_userQ_ _autoQ_ _tgsjo_'
(unm)=: 0 defer2q anm
(anm)=: 1 defer2q tnm
i.0 0
)

defer2q=:2 :0
ins=. n,' ',5!:5<'y' [y
m deferToQueue <ins
:
ins=: '(',(5!:5<'x'),') ',n,' ',5!:5<'y'
m deferToQueue <ins
)

deferToQueue=:1 :0
if.m do.
    instructionQueue_tgsjo_=:y,instructionQueue_tgsjo_
else.
    instructionQueue_tgsjo_=:instructionQueue_tgsjo_,y
end.
wd'timer ',":1>.MS_tgsjo_
i.0 0
)

sys_timer_z_=: sys_timer_tgsjo_=: 3 :0
try. timer_handler_tgsjo_''
catch.
    echo 'caught error in sys_timer_z_'
    echo 13!:12 ''
    wd'timer 0'
end.
)

timer_handler_tgsjo_=:3 :0
if. #instructionQueue_tgsjo_ do.
    ins=: ;{.instructionQueue_tgsjo_
    instructionQueue_tgsjo_=: }.instructionQueue_tgsjo_
    ". ins
else.
    wd 'timer 0'
end.
)


NB. Next several lines initialize the deferall queues
onlylower=: 3 : 0
x=. I. 26 > ((97+i.26){a.) i. t=. ,y
x{t
)

slowList=: ;:'yAw rOLl pItCH fORWARd bACk jUMPuP jUMPdOWN jUMPrIGHT jUMPlEFT rrl lrl rolllEFt rollrIGHt dpt upt'

buildDeferralQueue  onlylower each slowList
buildDeferralQueue    tolower each slowList
buildDeferralQueue   ;:'penColor pen penState turtleColor triangleColor' 

cocurrent'base'

