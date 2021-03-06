NB. test script utilities -----------------------------------------------

cocurrent 'base'

3 : 0 ''
testpath=: '/',~(t i:'/'){.t=. jpath;(4!:4<'ddall'){4!:3''
if. IFWIN do.
 n=. 'tsdll.dll'
else.
 n=: 'libtsdll.',;(UNAME-:'Darwin'){'so';'dylib'
end. 
if. UNAME-:'Android' do.
 LIBTSDLL=: jpath'~bin/../../lib/',n,' '
else.
 LIBTSDLL=: jpath'~bin/',n,' '
end.
1
)

testfiles=: 3 : 0   NB. y. is prefix - e.g., 'g' or 'gm' or 'gs'
 testpath&,&.> /:~ {."1 [1!:0 testpath,y,'*.ijs'
)

ddall    =: (testfiles 'g') -. (<testpath),each 'gfft.ijs';'glapack.ijs' NB. all except gfft and glapack
ddgmbx   =: testfiles 'gmbx'        NB. map boxed arrays
ddgsp    =: testfiles 'gsp'         NB. sparse arrays
ddg      =: ddall -. ddgmbx,ddgsp   NB. "ordinary"

etx      =: 1 : 'x :: (<:@(13!:11)@i.@0: >@{ 9!:8@i.@0:)'  NB. error message from error number
ex       =: ". etx
fex      =: }. @ (i.&(10{a.) {. ]) @ (13!:12) @ i. @ 0: @ (0!:110)
eftx     =: 1 : 'u :: ((10{a.) -.~ (13!:12) @ i. @ 0:)'   NB. full text of error message
efx      =: ". eftx



THRESHOLD=: 0 NB. allow timing tests to trigger failure 
THRESHOLD=: 1 NB. force timing tests to pass

threshold=: 0.75 NB. tighter timing tests
threshold=: 0.2  NB. timing tests

timer    =: 6!:2

type     =: 3!:0
imax     =: IF64{:: 2147483647; 9223372036854775807
imin     =: (-imax)-1
U4MAX    =: 16b110000
C4MAX    =: IF64{:: 2147483647;4294967296
RAND32   =: (] [`(<:@-@[)@.]"0 ?@:($&2)@:$)^:(-.IF64) NB. negate and decrement randomly
UNSGN32  =: <.@:((2^32)&|)^:(-.IF64)                  NB. unsigned 32-bit to double

scheck=: 3 : 0  NB. check sparse array
 s=. $ y
 a=. 2 $. y
 e=. 3 $. y
 i=. 4 $. y
 x=. 5 $. y

 assert. 1 = #$s                      NB. 0
 assert. s -: <.s                     NB. 1
 assert. imax >: #s                   NB. 2
 assert. *./ (0 <: s) *. s <: imax    NB. 3
 assert. _ > */s                      NB. 4

 assert. 1 = #$a                      NB. 5
 assert. *./ a e. i.#s                NB. 6
 assert. a -: ~.a                     NB. 7

 assert. 0 = #$e                      NB. 8
 assert. (type e) = <. 0.001*type y   NB. 9
 assert. (type e) = type x            NB. 10

 assert. 2 = #$i                      NB. 11
 assert. i -: <.i                     NB. 12
 assert. imax >: #i                   NB. 13
 assert. (#i) = #x                    NB. 14
 assert. ({:$i) = #a                  NB. 15
 assert. *./, (0<:i) *. i<"1 a{s      NB. 16
 assert. i -: ~. i                    NB. 17
 assert. i -: /:~i                    NB. 18

 assert. (#$x) = 1+(#s)-#a            NB. 19
 assert. (}.$x) -: ((i.#s)-.a){s      NB. 20
 1
)

comb=: 4 : 0
 c=. 1 {.~ - d=. 1+y-x
 z=. i.1 0
 for_j. (d-1+y)+/&i.d do. z=. (c#j) ,. z{~;(-c){.&.><i.{.c=. +/\.c end.
)

randuni=: 3 : 0
 adot1=: u: /:~ 256?65536
 if. IF64 do.
  adot2=: 10&u: /:~ 256?C4MAX
 else.
  adot2=: /:~ 10&u: RAND32 256?C4MAX
 end.
NB. 256 unique random symbols
 a=.((9#1),~1+?247#9) [ b=. /:~ 256?256
 s0=. a (] s:@:<@({&a.)@:+ i.@[)"0 b
 a=.(1+?256#9) [ b=. /:~ 256?65536-9
 s1=. a (] s:@:<@u:@:+ i.@[)"0 b
 a=.(1+?256#9) [ b=. RAND32 /:~ 256?C4MAX-9
 s2=. /:~^:(-.IF64) a (] s:@:<@(10&u:)@:+ i.@[)"0 b
 s=. ~.(?~256*3){s0,s1,s2
 sdot=: /:~ (256?#s){s
 assert. 256=#~.sdot
 ''
)

NB. ebi extensions

RSET=: 4 : '(x)=: y'
RBAD=: 3 : '>_4}.each(#testpath)}.each(-.RB)#RF'
RUN=: RBAD@('RB'&RSET)@(0!:3)@('RF'&RSET)
RUND=: RBAD@('RB'&RSET)@(0!:2)@('RF'&RSET)  NB. Run w/display

RUN1=: 13 : '0!:2<testpath,y,''.ijs'''

RESUB1=: 3 : 'y[echo >y'
RESUB2=: (13 : '-.0!:3 RESUB1 y')"0
RECHO=: 13 : '+/ RESUB2 y'

RECHO1=: 4 : 0
x123=. x>.1
y123=. y
4!:55 'x';'y'
for_y234. y123 do.
 echo RLAST=: >y234
 for. i.x123 do.
  assert. 0!:2 y234
  assert. 0 s: 11  NB. can cause segfault in subsequent scripts if not caught early
 end.
end.
''
)

RUN2=: 4 : 0
x123=. x>.1
y123=. y
4!:55 'x';'y'
for. i.x123 do.
  0!:2<testpath,y123,'.ijs'
end.
''
)

echo 9!:14''

echo 0 : 0

many scripts have timing tests
typically comparing timing/result of j vs j model
these tests can be essential for new/changed code
but vary greatly across environments
and can result in false failures

THRESHOLD set to 1 by default - ignores timing test failures
threshold set to 0.2 for loose tests (0.75 for tighter tests)

THRESHOLD should be applied as false failures are discovered

gfft/glapack not in ddall - run separately with: RUN1'gfft'
g18x fails on subsequent runs - no idea why
g401 occasionally fails (random data?) but then runs clean

   RUN ddall   NB. report scripts that fail
   
   RUN1 'g000' NB. run script with display
 n RUN2 'g000' NB. run script with display for n times
   
   RBAD ''     NB. report scripts that failed
   RB          NB. 0!:3 result (0 for failure)
   RF          NB. scripts that were run
   
   RECHO ddall  NB. echo script names as run and final count of failures
   RECHO1 ddall NB. script with display for n times and stop on failure
                NB. RLAST is the last script
)
