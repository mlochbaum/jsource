NB. prehashed i. family of functions ------------------------------------

randuni''

3 : 0 ''
if. IFRASPI do.
 echo'gipht IFRASPI ignores timings, but runs all sentences (coarse timer??)'
end.
)

f0=: 4 : 0
 f=: x&i.
 assert. IFRASPI +. THRESHOLD +. </ (1,threshold) %~ t=: timer 'f y',:'x i. y'
 1
)

x f0 0+x=:      1e4 ?@$ m=: 1e1
x f0 0+x=: m -~ 1e4 ?@$ 2*m
x f0 0+x=:      1e4 ?@$ m=: 1e3
x f0 0+x=: m -~ 1e4 ?@$ 2*m
x f0 0+x=:      1e4 ?@$ m=: 1e5
x f0 0+x=: m -~ 1e4 ?@$ 2*m
x f0 0+x=:      1e4 ?@$ m=: 1e7
x f0 0+x=: m -~ 1e4 ?@$ 2*m
x f0 0+x=:      1e4 ?@$ m=: 1e9
x f0 0+x=: m -~ 1e4 ?@$ 2*m

x f0 1=x=:           1e6   ?@$ 2
x f0 1=x=:           1e4 4 ?@$ 2
x f0 0+x=:           1e4   ?@$ 1e9
x f0 0+x=:           1e4 4 ?@$ 1e9
x f0 0+x=:           1e4   ?@$ 0
x f0 0+x=:           1e4 4 ?@$ 0
x f0 0+x=: j./_1e4+2 1e4   ?@$ 2e4
x f0 0+x=: j./_1e4+2 1e4 4 ?@$ 2e4  
x f0 0+x=:        x: 1e4   ?@$ 3e3
x f0 0+x=:        x: 1e4 4 ?@$ 3e3
x f0 0+x=: %/x:0 1+2 1e4   ?@$ 3e3
x f0 0+x=: %/x:0 1+2 1e4 4 ?@$ 3e3

NB. possible garbage collect can louse up timing
(x=: a.{~ 1e4   ?@$ #a.  ) f0 :: 1: y=: a.{~ 1e4   ?@$ #a.

(x=: a.{~ 1e4 4 ?@$ #a.  ) f0 y=: a.{~ 1e4 4 ?@$ #a.
(x=: adot1{~ 1e4 4 ?@$ #adot1  ) f0 y=: adot1{~ 1e4 4 ?@$ #adot1
(x=: adot2{~ 1e4 4 ?@$ #adot2  ) f0 y=: adot2{~ 1e4 4 ?@$ #adot2
(x=: sdot{~ 1e4 4 ?@$ #sdot  ) f0 y=: sdot{~ 1e4 4 ?@$ #sdot
(x=: u:   1e4   ?@$ 256  ) f0 y=: u:   1e4   ?@$ 256
(x=: u:   1e4 4 ?@$ 256  ) f0 y=: u:   1e4 4 ?@$ 256
(x=: u:   1e4   ?@$ 65536) f0 y=: u:   1e4   ?@$ 65536
(x=: u:   1e4 4 ?@$ 65536) f0 y=: u:   1e4 4 ?@$ 65536
(x=:10&u:   1e4   ?@$ 256  ) f0 y=: 10&u:   1e4   ?@$ 256
(x=:10&u:   1e4 4 ?@$ 256  ) f0 y=: 10&u:   1e4 4 ?@$ 256
(x=:10&u: RAND32   1e4   ?@$ C4MAX) f0 y=: 10&u:   1e4   ?@$ C4MAX
(x=:10&u: RAND32   1e4 4 ?@$ C4MAX) f0 y=: 10&u:   1e4 4 ?@$ C4MAX

mean=: +/ % #

g=: 4 : 0
 xx=: x     ?@$ y
 yy=: 10000 ?@$ y
 f=: xx&i.
 timer '3 : ''for_q. y do. k=. f q end.'' yy'
)

f1=: 3 : 0
 t=: (2e4*>:i.8) g"0 y
 assert. THRESHOLD +. (1-threshold) > >./| t (- % ]) mean t
 1
)


f1"0 ]1e1 1e3 1e5 1e7 1e9


4!:55 ;:'adot1 adot2 sdot f f0 f1 g m mean t x xx y yy'

 
