NB. tgsjo.ijs NB. 9/21/20 

cocurrent 'tgsjo'
require 'gl2 gles ~addons/ide/qt/opengl.ijs'
coinsert 'jgl2 jgles qtopengl'

coinsert_base_'tgsjo'

tgsjopath=:3 :0
({.~ 1+i:&'/')rplc&'\/';(4!:4<'tgsjopath'){4!:3''
)
path=. (tgsjopath'')&,

require path 'tgsjoalias.ijs'
require path 'tgsjoslow.ijs'
require 'math/misc/quatern'

painter_ready=: initialized=: 0

require path 'tgsjoglobals.ijs'
require path 'tgsjoinit.ijs'
require path 'tgsjomoves.ijs'

GL_ERRLIST=: ;:0 :0-.LF NB. https://www.khronos.org/opengl/wiki/OpenGL_Error
GL_INVALID_ENUM GL_INVALID_VALUE GL_INVALID_OPERATION
GL_STACK_OVERFLOW GL_STACK_UNDERFLOW GL_OUT_OF_MEMORY
GL_INVALID_FRAMEBUFFER_OPERATION GL_CONTEXT_LOST
GL_TABLE_TOO_LARGE1 invalid_opengl_error
)
reportErrors=: 3 :0
while. errnum=. {.;{.glGetError''do.
    ndx=. ((16b500+i.8),16b8031)i.errnum
    echo ndx{::GL_ERRLIST
    'breakpoint here to capture stack'
end.
)
err=:1 :0 NB. m: _1 means numeric result and only _1 is error
r=. {.;{.y NB. m: 0 means non zero result is error
if. -.^:(1+m) m = r do. reportErrors '' end.
if. m do. r else. y end.
)
er=:0 err

mp=: +/ .*"2
cp=: ((1|.[) * _1|.]) - (_1|.[) * 1|.]


tgsj_cancel=: tgsj_close=: 3 :0
try.
    wd 'psel tgsj; ptimer 0; pclose'
    er glDeleteBuffers ::0: (;~#)vbo
    er glDeleteProgram ::0: sprog
catch.end.sprog=: GO=: 0
)


TGSO=: 0 : 0
pc tgsj;
minwh 600 600; pmove 500 500 _1 _1;cc g opengl flush;
rem form end;
)

Instructions=: 0 : 0
Enter text turtle commands here in the Term window. 
Notice that now the Term window has "focus"; the cursor 
is blinking.

There are also some controls for the Eye or Camera that 
are executed in the graphics canvas. For example F4 
toggles spinning the camera around and F3 snaps the 
camera and other setting back to their original values. 
To execute them, click first on the graphics canvas.

You can create more turtles using the createTurtle 
command. For example createTurtle 5 5 0 puts a turtle 
at x,y,z = 5,5,0. 

Turn turtles with commands like yaw (right), left, 
pitch, roll followed by degree amounts. Each of these 
commands have abbreviations.

Move or advance turtles with commands like forward, 
back, jumpright, jumpleft, jumpup, and jumpdown, 
followed by amounts. Each of these commands have 
abbreviations: For hints, type onlylower each slowList

After turning or moving turtles, try this command
to learn turtle positions and orientations: 
2 rndm each positions;;/dircos"1 orientations

Type: commands, examples, or resources
)


tgsj_run=: 3 : 0       NB. *************** start here
tgsj_close''
STEPS=: 100    NB. smaller numbers enable more turtle steps and makes turtle smaller
NB. 100 allows about 110 steps
STEPS0=: STEPS
NB. try your own R
R=: 0 0 0
R=: 20 30 0
R0=: R
T=: T0=: 0 0 _19
EYE=: EYE0=: 0 0 1
LR=: UD=: IO=: 0
UP=: 0 1 0
sprog=: 0
GLSL=: 0
Bcolor=: 0.501961 0.501961 0.501961 1 NB. glClearColor Gray
Bcolor=: 0 0 0 1 NB. glClearColor Black

wd TGSO
GO=: 0[HD=: ".wd'qhwndc g'
wd 'ptimer 100'  NB. controls speed of R rotation
wd 'pshow'
gl_paint''
smoutput Instructions
wd 'sm focus term'
)

NB. used for turtle moves and turns
sendGeometry=: 3 :0
names=. 'vertex norm color'
data=. (renderTriangles,eyerenderTriangles);(renderNormals,eyerenderNormals);(renderColors,eyerenderColors) 
vertexpaint=: names y init_vertex_buffers data
try. if. #lineData do.
    linepaint=: 'vertex color' y init_line_buffers renderLines;renderLcolors end.
catch.
end.
)  

NB. send a named list of attributes to the vertex shader.
NB. each attribute can be width 1, 2, 3 or 4
NB. each must be supplied the same number of "rows"
NB. each number will be native 32 bit ieee 754 binary floating point
init_vertex_buffers=:1 :0
:
program=. m
NB. assert. */({:@$@> y) e. 1 2 3 4 assert. 1=#~.*/@}:@$@> y
if. L. x do. names=. x else. names=. ;: x end. assert. names -:&# y
buffers=. vbo{.~#names
r=.i.0 0 for_name. names do. j=.name_index
namedAttr=.  _1 err glGetAttribLocation program;name
er glBindBuffer GL_ARRAY_BUFFER;j{buffers
data=. 1 fc,j{::y
er glBufferData GL_ARRAY_BUFFER;(#data);(symdat<'data');GL_STREAM_DRAW
r=.r, GL_ARRAY_BUFFER,(j{buffers),namedAttr,{:$j{::y
  end. glBindBuffer GL_ARRAY_BUFFER;0
  r
)

paint_vertex_buffers=: 3 :0 NB. uses result from init_vertex_buffers
for_row. y do.
    'target buffer attr width'=. row
    assert. target-:GL_ARRAY_BUFFER
    er glBindBuffer GL_ARRAY_BUFFER;buffer
    er glEnableVertexAttribArray attr NB. this only makes sense if target is GL_ARRAY_BUFFER
    er glVertexAttribPointer attr;width;GL_FLOAT;0;0;0
end.
er glBindBuffer GL_ARRAY_BUFFER;0
)

init_line_buffers=:1 :0
:
program=. m
assert. */({:@$@> y) e. 1 2 3 4 assert. 1=#~.*/@}:@$@> y
if. L. x do. names=. x else. names=. ;: x end. assert. names -:&# y
buffers=. vbo{.~-#names
r=.i.0 0 for_name. names do. j=.name_index
namedAttr=.  _1 err glGetAttribLocation program;name
er glBindBuffer GL_ARRAY_BUFFER;j{buffers
data=. 1 fc,j{::y
er glBufferData GL_ARRAY_BUFFER;(#data);(symdat<'data');GL_STREAM_DRAW
r=.r, GL_ARRAY_BUFFER,(j{buffers),namedAttr,{:$j{::y
  end. glBindBuffer GL_ARRAY_BUFFER;0
  r
)

paint_line_buffers=: 3 :0 NB. uses result from init_line_buffers
for_row. y do.
    'target buffer attr width'=. row
    assert. target-:GL_ARRAY_BUFFER
    er glBindBuffer GL_ARRAY_BUFFER;buffer
    er glEnableVertexAttribArray attr NB. this only makes sense if target is GL_ARRAY_BUFFER
    er glVertexAttribPointer attr;width;GL_FLOAT;0;0;0
end.
er glBindBuffer GL_ARRAY_BUFFER;0
)

clear_vertex_buffers=:1 :0
:
program=. m
if. L. x do. names=. x else. names=. ;: x end. assert. names -:&# y
buffers=. vbo{.~#names
r=.i.0 0 for_name. names do. j=.name_index
namedAttr=.  _1 err glGetAttribLocation program;name
er glBindBuffer GL_ARRAY_BUFFER;j{buffers
data=. 1 fc,j{::y
er glBufferData GL_ARRAY_BUFFER;(#data);(symdat<'data');GL_STREAM_DRAW
r=.r, GL_ARRAY_BUFFER,(j{buffers),namedAttr,{:$j{::y
  end. glBindBuffer GL_ARRAY_BUFFER;0
  r
)

clear_line_buffers=:1 :0
:
program=. m
if. L. x do. names=. x else. names=. ;: x end. assert. names -:&# y
buffers=. vbo{.~-#names
r=.i.0 0 for_name. names do. j=.name_index
namedAttr=.  _1 err glGetAttribLocation program;name
er glBindBuffer GL_ARRAY_BUFFER;j{buffers
data=. 1 fc,j{::y
er glBufferData GL_ARRAY_BUFFER;(#data);(symdat<'data');GL_STREAM_DRAW
r=.r, GL_ARRAY_BUFFER,(j{buffers),namedAttr,{:$j{::y
  end. glBindBuffer GL_ARRAY_BUFFER;0
  r
)

clearscreen=: monad define
initTurtle''
erase ;:'lineData lcolorData'
vertex_clear=: 'vertex norm color' 10 clear_vertex_buffers sceneTriangles;sceneNormals;sceneColors
linepaint=: 'vertex color' 10 clear_line_buffers sceneLines;sceneLcolors
sendGeometry sprog
renderTurtles''
)

clearlines=: monad define
erase ;:'lineData lcolorData'
pathlines=: i. 0 6
pathcolors=: i. 0 6
linepaint=: 'vertex color' 10 clear_line_buffers sceneLines;sceneLcolors
gl_paint''
)

showGlString=:3 :0
if.r=. >{.glGetString".y do.echo y,': ',memr r,0 _1 2 end.r
)

showGl=:3 :0
if. 0=showGlString 'GL_VERSION' do._1[echo'cannot retrieve GL_VERSION'return.end.
showGlString'GL_VENDOR'
showGlString'GL_RENDERER'
0[showGlString'GL_SHADING_LANGUAGE_VERSION'
)

require 'regex' NB. for older j versions
rplcnm=:2 :0
(('\b',m,'\b');n) rxrplc y
)

vcompat=:3 :0
fsrc=. 1 e. ' invary ' E. y
v=.'' if.120<:GLSL=.wglGLSL'' do.
y=. 'inattr' rplcnm 'attribute' y
y=. 'invary' rplcnm 'varying' y
y=. 'outvary' rplcnm 'varying' y
if. 0~:GLES_VERSION do.
    y=. 'attribute' rplcnm 'attribute highp' y
    y=. 'varying' rplcnm 'varying highp' y
end.
  else.
      y=. 'inattr' rplcnm 'in' y
      y=. 'invary' rplcnm 'in' y
      y=. 'outvary' rplcnm 'out' y
  end.
  if. fsrc * (GLSL>:300) * 0~:GLES_VERSION do.
      y=. 'void main' rplcnm ('out vec4 gl_FragColor;',LF,'void main') y
  end.
  v=.'#version ',(":GLSL),(GLSL>:300)#(*GLES_VERSION){::' core';' es'
  v,LF,y
)

tgsj_g_initialize=: 3 :0
if.showGl''do.return.end.
wglPROC''
GLSL=: wglGLSL''
'vsrc fsrc'=: vcompat each vsrcMeta;fsrcMeta NB. save for inspection
vbo=: 2{:: er glGenBuffers (;#&_1)#;:'vertex norm color line lcolor'  
'err prog'=. gl_makeprogram vsrc;fsrc
if.#err do. echo err return.end.
NB. vertex_meta=: send_vertices prog
sendGeometry prog
assert _1~:mvpUni=: >{.glGetUniformLocation prog;'mvp'
initialized=: 1+initialized  
sprog=: prog
)

tgsj_g_char=: 3 : 0
if. 0=#sysdata do. return. end.
R=: 360 | R + 2 * 'xyz' = 0 { sysdata
R=: 360 | R - 2 * 'XYZ' = 0 { sysdata
k=. 0{sysdata
STEPS=: 200 <. STEPS + 's' = k
STEPS=: 3 >. STEPS - 'a' = k
LR=: LR - 0.01*'r'=k
LR=: LR + 0.01*'l'=k
gl_paint ''
)

tgsj_timer=: 3 : 0
if. 0=GO do. return. end.
R=: 360 | R + 2 * 1 1 1
gl_sel HD
gl_paint''
)

tgsj_g_paint=:3 :0
try.paint_handler''
catch.
    echo 'caught error in tgsj_g_paint'
    echo 13!:12 ''
    wd'timer 0'
end.
)

ff =: [,~-@],],-@],]
frustum=: 1 100 ff 0.3  NB. matches closely with gl_Perspective 30,(),1 10

paint_handler=: 3 : 0
if. 0=sprog do. return. end.

wh=. gl_qwh''
er glClearColor Bcolor
er glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT

er glUseProgram sprog
er glEnable GL_DEPTH_TEST
NB. glEnable GL_CULL_FACE

NB. matrix convention: current matrix on the left
NB. note pre-multiplication

NB. model-view
mvp=: (mp/gl_Rotate"1 (,.=@i.@#)R) mp (gl_Scale STEPS%2000) mp (gl_Translate T) mp glu_LookAt EYE,LR,UD,IO,UP

NB. projection
NB. mvp=: mvp mp gl_Perspective 30, (%/wh),1 10
mvp=: mvp mp gl_Frustum frustum
er glDepthFunc GL_GREATER NB. Frustum needs this
er glDepthRange 1 0
er glClearDepth 0
er glClear GL_DEPTH_BUFFER_BIT

NB. note GL_FALSE, no transpose
er glUniformMatrix4fv mvpUni; 1; GL_FALSE; mvp

paint_vertex_buffers vertexpaint

er glDrawArrays GL_TRIANGLES; 0; */}:$renderTriangles,eyerenderTriangles

paint_line_buffers linepaint

try. if. #lineData do. er glDrawArrays GL_LINES; 0; 3%~#lineData end.
catch. 1 end.

er glDisable GL_DEPTH_TEST

er glUseProgram 0

    er gl_clear ''
    er gl_rgb 255 255 255
    er gl_textcolor ''
    er gl_textxy 10 30
if. #positions do.
    er gl_text '(this window) keys: x y z a s l r F4 F3'
    er gl_textxy 10 50
    er gl_text 'scale: ',":STEPS%100
    er gl_textxy 10 70
    er gl_text 'angle: ',":R
    er gl_textxy 10 90
    if. 0=sprog do. return. end.
    er gl_text 'matrix:'
    for_i. i.4 do.
        er gl_textxy 10, 105+i*15
        er gl_text 6j2": i{mvp
    end.
else. 
    gl_text'First, create a turtle (at the origin?): createTurtle 0 0 0'
end.
painter_ready=: 1
)

tgsj_f4_fkey=: 3 : 0  NB. Rotate camera
GO=: -.GO
)

tgsj_f3_fkey=: 3 : 0  NB. Reset camera
STEPS=: STEPS0
R=: R0
EYE=: EYE0
LR=: UD=: IO=: 0
UP=: 0 1 0
wd TGSO
gl_sel HD
gl_paint''
)

createTurtle=:3 :0"1
1 0 0 0 createTurtle 3{.y
:
assert.(,3)-:$y
r=. #positions
if. r do.
    turtleColors =: turtleColors, turtleColors0
    turtleTriangles =: turtleTriangles, turtleTriangles0
    turtleEyeColors =: turtleEyeColors, turtleEyeColors0
    turtleEyeTriangles =: turtleEyeTriangles, turtleEyeTriangles0
end.
positions=:positions, y
orientations=: orientations, x
penColorA''
penStateA''
renderTurtles''
r
)

NB. rotate y degrees around axis x
rotation=:4 :0"1 0
:
angle=. y%360p_1 NB. y in degrees
NB. https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles#Definition
assert. (,3)-:$,x
axis=. (% +/&.:*:),x
(cos angle),axis*sin angle
)

dircos=:3 :0
NB. https://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation#Conversion_to_and_from_the_matrix_representation
q2=: *:'a b c d'=. y
R00=.+/1 1 _1 _1*q2
R01=.2*(b*c)-a*d
R02=.2*(b*d)+a*c
R10=.2*(b*c)+a*d
R11=.+/1 _1 1 _1*q2
R12=.2*(c*d)-a*b
R20=.2*(b*d)-a*c
R21=.2*(c*d)+a*b
R22=.+/1 _1 _1 1*q2
R00`R01`R02,R10`R11`R12,:R20`R21`R22
)

q2euler=:3 :0"1
phi=. _3 o. 2*(+/*/(0 2,:1 3){ y) % 1 - 2 * +/*: 1 2 { y
tht=. _1 o. 2* -/*/(0 3,:2 1){ y
psi=. _3 o. 2*(+/*/(0 1,:2 3){ y) % 1 - 2 * +/*: 2 3 { y
180p_1*phi,tht,psi
)

NB. x is a direction vector
NB. y is a rotation quaternion
NB. result is that direction vector rotated by that quaternion
rot2dir=:3 :0
0 1 0 0 rot2dir y
:
}.(qncon y) qnmul (_4{.x) qnmul y
)

cross=: ((_1 |. [) * 1 |. ]) - (1 |. [) * _1 |. ]	

NB. add a triangle to the scene in the frame of reference of a turtle
addTriangle=:1 :0
:
assert. 3 3-:$y assert. 3-:{:$x
if. 3>#~.y do. 
    echo 'ignoring degenerate triangle'
    echo y
    return.
end.
c=. m,'Colors'
o=. m,'Normals'
t=. m,'Triangles'
ca=. (c)=: (".c),($y)$,x
oa=. (o)=: (".o),(% +/&.:*:"1) (cross"1 (1&|.)) (- 2&|.) y
ta=. (t)=: (".t),turtleScale*y
assert. 3 3 -: }.$ca
assert. 3 3 -: }.$oa
assert. 3 3 -: }.$ta
)

renderTurtles=:3 :0
facing=. dircos"1 orientations
eyerenderColors=: renderColors=: sceneColors 
eyerenderTriangles=: renderTriangles=: sceneTriangles
eyerenderNormals=: renderNormals=: sceneNormals
for_turtle.i.#positions do.
    (turtle{turtleColors) 'render'addTriangle"_1 (turtle{positions)+"1 (turtle{turtleTriangles)+/ .* turtle{facing
    fudge=. _0.1 0.1 *"0 1]0 1 0 rot2dir"1 turtle{orientations  NB. based on pretend jumpleft
    (turtle{turtleEyeColors) 'eyerender'addTriangle"_1 ((turtle{positions)+"1 (turtle{turtleEyeTriangles)+/ .* turtle{facing)+"1"3 2 fudge
end.
try. 
    renderLines=: turtleScale*_3]\lineData
    renderLcolors=: _3]\lcolorData
catch. end.
if. initialized do.
    sendGeometry  sprog
end.
if. painter_ready do. gl_paint '' end.
i.0 0
)

NB. =========================================================
vsrcMeta=: 0 :0
inattr vec3 vertex;
inattr vec3 norm;
inattr vec3 color;
inattr vec3 line;
inattr vec3 lcolor;
outvary vec4 v_color;
outvary vec4 l_color;
uniform mat4 mvp;
void main(void){
/* vertex based color interpolation with mild, fixed lighting from 'above' */
vec4 lightv= vec4(0.0,-1.0,0.0,0.0);   /* changed .0 to 0.0 */
float cosTheta= clamp(dot(vec4(norm,1.0)*mvp, lightv), 0, 1);
vec3 glare= 0.1*vec3(cosTheta);
/* v_color= clamp(vec4(color*(0.6+0.4*cosTheta)+glare, 1.0), 0, 1); */
v_color = vec4(color,1.0)*(0.7+0.3*cosTheta);
/* world transform */
gl_Position= mvp  * vec4(vertex,1.0);
l_color = vec4(lcolor,1.0);
}
)

fsrcMeta=: 0 :0
invary vec4 v_color;
void main(void){
gl_FragColor= v_color;
}
)
initTurtle''
renderTurtles''
wd 'timer 500'

tgsj_run''
