NB. tgsjoslow.ijs
NB. 9/28/20


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

refCard=: 0 :0
  rl:    roll turtle(s) right side upward (degrees)
  yw:    yaw  turtle(s) right (degrees)
  pt:    pitch turtle(s) nose downward (degrees)
  fd:    move turtle(s) forward (steps)
  bk:    move turtle(s) backward (steps)
  ju:    jump turtle(s) upward (steps)
  jr:    jump turtle(s) rightward (steps)
  pen:   penState(s) (up is 0, down 1)
  penColor:    penColor(s) (colorname or 3 fractions)
  turtleColor: turtleColor(s) (4 colors shape 4 3)
  turtleTriangle: turtleTriangle(s) (4 coordinates shape 4 3)
  createTurtle: (3 coordinates)
)

onlylower=: 3 : 0
x=. I. 26 > ((97+i.26){a.) i. t=. ,y
x{t
)

slowList=: ;:'yAw rOLl pItCH fORWARd bACk jUMPuP jUMPdOWN jUMPrIGHT jUMPlEFT rrl lrl rolllEFt rollrIGHt dpt upt'
userCommands=: <@({.~ i.&':');._2 refCard -.32{a.

NB. buildDeferralQueue userCommands
buildDeferralQueue  onlylower each slowList
buildDeferralQueue    tolower each slowList

cocurrent'base'

