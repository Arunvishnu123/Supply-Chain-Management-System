breed [factories factory]
breed [distributors distributor]
breed [retailers retailer]
breed[customers customer]
breed[rawmaterialssuppliers rawmaterialsuppler]

globals[
  test
  products_quantity_1
  products_quantity_2
  products_quantity_3
  products_quantity_4
  raw_materials_1
  raw_materials_2
  distributor_1_current_quantity
  distributor_2_current_quantity
  distributor_3_current_quantity
  distributor_4_current_quantity
  distributor_5_current_quantity
  Retailer_1_current_quantity
  Retailer_2_current_quantity
  Retailer_3_current_quantity
  Retailer_4_current_quantity
  Retailer_5_current_quantity
  Retailer_6_current_quantity
  Retailer_7_current_quantity
  Retailer_8_current_quantity
  Retailer_9_current_quantity
  Retailer_10_current_quantity
]
retailers-own
[
  products_quantity
]
customers-own
[
  products_quantity
]

distributors-own
[
  products_quantity
]


factories-own
[
  products_quantity
  raw_materials_availability
  tes
]


to  setup
  clear-all
  reset-ticks
  set-default-shape factories "factory"
  set-default-shape distributors "building store"
  set-default-shape customers "person business"
  set-default-shape retailers "house two story"
  set-default-shape rawmaterialssuppliers "house ranch"
  ask patches [set pcolor white]
  set test test + 1
  create-factory_centre
  create-distributor_centre
  create-retailer_centre
  create-customers_centre
  create-links
  create-rawmaterials_centre 24 20.5
 ;; create-rawmaterials_centre -24 -20
  create-rawmaterials_centre -24 20
  ;;create-rawmaterials_centre 24 -20

;;;ask [link-with factory 0  ] of rawmaterialsuppler 57 [ set thickness 4 ]

 ask factories [

   create-links-with rawmaterialssuppliers
      [set color brown]

  ]

ask factories [
    show my-out-links
 ]
 ;; ask rawmaterialsuppler 57 [ ask in-link-neighbors  [set color blue] ]
  end

to go
  sending_products_to_retailer
  manufacture-products
  Sending_Products_to_Distributor

end
to-report tt
  report products_quantity_1
end
to create-factory_centre

   create-factories  1 [
   set size 3
   set color red
   set label (word "F" [who] of self "               ")
   set label-color black
  ]
  repeat 100 [layout-spring factories links 0.5 2 1 ]
  ask factories [setxy 0 0]

end

to create-distributor_centre
  create-ordered-distributors distributor_No
  [
  ;; repeat 5 [layout-spring distributors links 0.5 2 1 ]
   set color blue
   set label (word "D" [who] of self "               ")
   set label-color black
    fd 6
    rt 90
    set size 3
    set pen-size 3
  ]


end


to create-retailer_centre
  create-ordered-retailers retailer_No
  [
  ;; repeat 500 [layout-spring retailers links 0.5 2 1 ]

   set color green
   set label (word "R" [who] of self "              ")
   set label-color black
    fd 14
    rt 90
    set size 3
    set pen-size 3
  ]


end

to create-rawmaterials_centre [ X Y]
  create-rawmaterialssuppliers 1
  [
  ;; repeat 500 [layout-spring retailers links 0.5 2 1 ]
   set color green
   set label (word "RS    " [who] of self "               ")
   set label-color black
   setxy X Y
   set size 3
  ]


end

to create-customers_centre
  create-ordered-customers Customer_No
  [
 ;;;  if pxcor > 10  [
  ;; repeat 500 [layout-spring customers links .5 2 1 ]
   set size 2
   set color cyan
   set label (word "C " [who] of self "       ")
   set label-color black
    fd 23
    rt 90
    set pen-size 3
  ask customers [ show min-one-of retailers [distance myself] ]
  ;;ask customers [setxy random-pxcor random-pycor]
 ;;;   ]
]
end

to create-links

  ask links [die]
  ifelse Show_Links = true
  [ create-links-d-r 1  6  7
    create-links-d-r 2  8  9
    create-links-d-r 3  10  11
    create-links-d-r 4  13  12
    create-links-d-r 5  14  15
    create-links-r-c 6 16 17 54 55
    create-links-r-c 7 18 19 20 21
    create-links-r-c 8 22 23 24 25
    create-links-r-c 9 26 27 28 29
    create-links-r-c 10 30 31 32 33
    create-links-r-c 11 34 35 36 37
    create-links-r-c 12 38 39 40 41
    create-links-r-c 13 42 43 44 45
    create-links-r-c 14 46 47 48 49
    create-links-r-c 15 50 51 52 53
  ask factories [
   create-links-with distributors
     [set color red]
    create-links-with rawmaterialssuppliers
      [set color green]

  ]]
  [ask links [die]]
end

to create-links-d-r [d_n r_n1 r_n2]
   ask  distributor d_n
    [
    create-link-with retailer r_n1
      [set color blue]
    create-link-with retailer r_n2
      [set color blue]
    ]
end

to create-links-r-c [r_n c_n1 c_n2 c_n3 c_n4]
   ask  retailer r_n
    [
    create-link-with customer c_n1
      [set color green]
    create-link-with customer c_n2
      [set color green]
     create-link-with customer c_n3
      [set color green]
      create-link-with customer c_n4
      [set color green]
    ]
end

to manufacture-products

if products_quantity_1 < Factory_Storage_Capacity_Product_1 [
    every .1 [set products_quantity_1 products_quantity_1 + 1]
    every .1 [ set raw_materials_1 raw_materials_1 - 1]
    show products_quantity_1 ]

 if products_quantity_2 < Factory_Storage_Capacity_Product_2 [
    every .1 [set products_quantity_2 products_quantity_2 + 1]
    every .1 [ set raw_materials_2 raw_materials_2 - 2]
    show products_quantity_1 ]

  if raw_materials_1 < 20
    [
     ;; user-message (word "Sending rawmaterial 1 to Factory")
      send_raw_materials_to_Factory 56
      set raw_materials_1 raw_materials_1 + 10
       ]


  if raw_materials_2 < 20
    [
      ;; user-message (word "Sending rawmaterial 2 to Factory")
      send_raw_materials_to_Factory 57
      set raw_materials_2 raw_materials_2 + 10
 ]


end

to buy_product
set products_quantity_1 100
  show products_quantity_1
end

to send_raw_materials_to_Factory [raw_materials_no]

every .2 [ask link 0 raw_materials_no
  [
    set thickness .9
    set color red
  ]]
  wait .5

  every .2[ ask link 0 raw_materials_no
  [
    set thickness .1
    set color blue
  ]]
  wait .5

 ask rawmaterialsuppler raw_materials_no [
   every .1 [ set color white ]
    wait .3
    every .2 [ set color red ]
    wait .5

  ]
end

to send_products_to_distributor [Distributed_Number distributor_current_quantity]

  if distributor_current_quantity < Distributor_Storage_Capacity and products_quantity_1 > 20
       [send_finished_products 0 Distributed_Number
          set products_quantity_1 products_quantity_1 - 20
       if Distributed_Number = 1
          [set distributor_1_current_quantity distributor_1_current_quantity + 20]
       if Distributed_Number = 2
          [set distributor_2_current_quantity distributor_2_current_quantity + 20]
       if Distributed_Number = 3
          [set distributor_3_current_quantity distributor_3_current_quantity + 20]
       if Distributed_Number = 4
          [set distributor_4_current_quantity distributor_4_current_quantity + 20]
       if Distributed_Number = 5
          [set distributor_5_current_quantity distributor_5_current_quantity + 20]
        ]
end


to send_products_to_retailer [retailer_Number retailer_current_quantity distributor_current_quantity Distributed_Number]

  if retailer_current_quantity < Retailer_Storage_Capacity and distributor_current_quantity > 15
       [send_finished_products Distributed_Number retailer_Number

       if retailer_Number = 6
          [set Retailer_1_current_quantity Retailer_1_current_quantity + 5
           set distributor_1_current_quantity distributor_1_current_quantity - 5]
       if retailer_Number = 7
          [set Retailer_2_current_quantity Retailer_2_current_quantity + 5
          set distributor_1_current_quantity distributor_1_current_quantity - 5]
       if retailer_Number = 8
          [set Retailer_3_current_quantity Retailer_3_current_quantity + 5
          set distributor_2_current_quantity distributor_2_current_quantity - 5]
       if retailer_Number = 9
          [set Retailer_4_current_quantity Retailer_4_current_quantity + 5
          set distributor_2_current_quantity distributor_2_current_quantity - 5]
       if retailer_Number = 10
          [set Retailer_5_current_quantity Retailer_5_current_quantity + 5
          set distributor_3_current_quantity distributor_3_current_quantity - 5]
       if retailer_Number = 11
          [set Retailer_6_current_quantity Retailer_6_current_quantity + 5
          set distributor_3_current_quantity distributor_3_current_quantity - 5]
       if retailer_Number = 12
          [set Retailer_7_current_quantity Retailer_7_current_quantity + 5
          set distributor_4_current_quantity distributor_4_current_quantity - 5]
       if retailer_Number = 13
          [set Retailer_8_current_quantity Retailer_8_current_quantity + 5
          set distributor_4_current_quantity distributor_4_current_quantity - 5]
       if retailer_Number = 14
          [set Retailer_9_current_quantity Retailer_9_current_quantity + 5
          set distributor_5_current_quantity distributor_5_current_quantity - 5]
       if retailer_Number = 15
          [set Retailer_10_current_quantity Retailer_10_current_quantity + 5
          set distributor_5_current_quantity distributor_5_current_quantity - 5]
        ]
end

to print-probabilities
  clear-output
  output-print "Factory"
  ;;output-print products_quantity_1 raw_materials_1 raw_materials_2
  ;;output-print ""

end


to Sending_Products_to_Distributor
  send_products_to_distributor 1 distributor_1_current_quantity
  send_products_to_distributor 2 distributor_2_current_quantity
  send_products_to_distributor 3 distributor_3_current_quantity
  send_products_to_distributor 4 distributor_4_current_quantity
  send_products_to_distributor 5 distributor_5_current_quantity
end
to sending_products_to_retailer
  send_products_to_retailer 6  Retailer_1_current_quantity distributor_1_current_quantity 1
  send_products_to_retailer 7  Retailer_2_current_quantity distributor_1_current_quantity 1
  send_products_to_retailer 8  Retailer_3_current_quantity distributor_2_current_quantity 2
  send_products_to_retailer 9  Retailer_4_current_quantity distributor_2_current_quantity 2
  send_products_to_retailer 10 Retailer_5_current_quantity distributor_3_current_quantity 3
  send_products_to_retailer 11 Retailer_6_current_quantity distributor_3_current_quantity 3
  send_products_to_retailer 12 Retailer_7_current_quantity distributor_4_current_quantity 4
  send_products_to_retailer 13 Retailer_8_current_quantity distributor_5_current_quantity 4
  send_products_to_retailer 14 Retailer_9_current_quantity distributor_5_current_quantity 5
  send_products_to_retailer 15 Retailer_10_current_quantity distributor_5_current_quantity 5
end

to send_finished_products [y x]
  every .2 [ask link y X
  [
    set thickness .9
    set color red
  ]]
  wait .5

  every .2[ ask link y X
  [
    set thickness .1
    set color blue
  ]]
  wait .5

 end
@#$#@#$#@
GRAPHICS-WINDOW
397
21
1151
629
-1
-1
12.23
1
10
1
1
1
0
1
1
1
-30
30
-24
24
0
0
1
ticks
30.0

SLIDER
191
23
363
56
distributor_No
distributor_No
0
5
5.0
1
1
NIL
HORIZONTAL

BUTTON
257
115
340
150
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
194
66
362
99
Show_Links
Show_Links
0
1
-1000

SLIDER
0
114
230
147
Factory_Storage_Capacity_Product_1
Factory_Storage_Capacity_Product_1
0
500
149.0
1
1
NIL
HORIZONTAL

MONITOR
183
297
286
342
Product Quantity 1
products_quantity_1
17
1
11

MONITOR
0
296
87
341
Raw Materials 1
Raw_Materials_1
17
1
11

MONITOR
91
296
179
341
Raw Materials 2
Raw_materials_2
17
1
11

MONITOR
289
297
391
342
Product Quantity 2
products_quantity_2
17
1
11

MONITOR
2
366
74
411
Distributor 1
distributor_1_current_quantity
17
1
11

BUTTON
256
198
342
231
NIL
clear-all
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
8
64
180
97
Customer_No
Customer_No
0
40
40.0
1
1
NIL
HORIZONTAL

SLIDER
7
22
179
55
retailer_No
retailer_No
0
10
10.0
1
1
NIL
HORIZONTAL

MONITOR
77
366
154
411
Distributor 2
distributor_2_current_quantity
17
1
11

MONITOR
158
366
234
411
Distributor 3
distributor_3_current_quantity
17
1
11

MONITOR
237
367
318
412
Distributor 4
distributor_4_current_quantity
17
1
11

MONITOR
321
367
392
412
Distributor 5
distributor_5_current_quantity
17
1
11

SLIDER
2
149
229
182
Factory_Storage_Capacity_Product_2
Factory_Storage_Capacity_Product_2
0
500
500.0
1
1
NIL
HORIZONTAL

MONITOR
2
447
62
492
Retailer 1
Retailer_1_current_quantity
17
1
11

MONITOR
67
447
128
492
Retailer 2
Retailer_2_current_quantity
17
1
11

MONITOR
133
447
195
492
Retailer 3
Retailer_3_current_quantity
17
1
11

MONITOR
199
447
259
492
Retailer 4
Retailer_4_current_quantity
17
1
11

MONITOR
263
447
324
492
Retailer 5
Retailer_5_current_quantity
17
1
11

MONITOR
327
447
390
492
Retailer 6
Retailer_6_current_quantity
17
1
11

MONITOR
0
497
63
542
Retailer 7
Retailer_7_current_quantity
17
1
11

MONITOR
67
497
133
542
Retailer 8
Retailer_8_current_quantity
17
1
11

MONITOR
137
497
203
542
Retailer 9
Retailer_9_current_quantity
17
1
11

MONITOR
205
497
278
542
Retailer 10
Retailer_10_current_quantity
17
1
11

SLIDER
2
185
230
218
Distributor_Storage_Capacity
Distributor_Storage_Capacity
0
100
50.0
1
1
NIL
HORIZONTAL

SLIDER
2
220
230
253
Retailer_Storage_Capacity
Retailer_Storage_Capacity
0
100
15.0
1
1
NIL
HORIZONTAL

BUTTON
257
158
343
191
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
91
344
361
372
Distributor Current Product Storage Quantity
11
70.0
1

TEXTBOX
87
423
343
451
Retailer Current Products Storage Capacity
11
0.0
1

TEXTBOX
0
271
209
299
Raw Materials Storage quantity in factory
11
0.0
1

TEXTBOX
218
272
368
290
Current Production Quantity
11
0.0
1

PLOT
1157
21
1507
258
Storage Capacity
Product Quantity
Time
0.0
500.0
0.0
100.0
true
true
"" ""
PENS
"Manufacture" 1.0 0 -5298144 true "" "plot tt"
"Distributor" 1.0 0 -11881837 true "" "plot tt"
"Retailer" 1.0 0 -7500403 true "" "plot tt"

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

building institution
false
0
Rectangle -7500403 true true 0 60 300 270
Rectangle -16777216 true false 130 196 168 256
Rectangle -16777216 false false 0 255 300 270
Polygon -7500403 true true 0 60 150 15 300 60
Polygon -16777216 false false 0 60 150 15 300 60
Circle -1 true false 135 26 30
Circle -16777216 false false 135 25 30
Rectangle -16777216 false false 0 60 300 75
Rectangle -16777216 false false 218 75 255 90
Rectangle -16777216 false false 218 240 255 255
Rectangle -16777216 false false 224 90 249 240
Rectangle -16777216 false false 45 75 82 90
Rectangle -16777216 false false 45 240 82 255
Rectangle -16777216 false false 51 90 76 240
Rectangle -16777216 false false 90 240 127 255
Rectangle -16777216 false false 90 75 127 90
Rectangle -16777216 false false 96 90 121 240
Rectangle -16777216 false false 179 90 204 240
Rectangle -16777216 false false 173 75 210 90
Rectangle -16777216 false false 173 240 210 255
Rectangle -16777216 false false 269 90 294 240
Rectangle -16777216 false false 263 75 300 90
Rectangle -16777216 false false 263 240 300 255
Rectangle -16777216 false false 0 240 37 255
Rectangle -16777216 false false 6 90 31 240
Rectangle -16777216 false false 0 75 37 90
Line -16777216 false 112 260 184 260
Line -16777216 false 105 265 196 265

building store
false
0
Rectangle -7500403 true true 30 45 45 240
Rectangle -16777216 false false 30 45 45 165
Rectangle -7500403 true true 15 165 285 255
Rectangle -16777216 true false 120 195 180 255
Line -7500403 true 150 195 150 255
Rectangle -16777216 true false 30 180 105 240
Rectangle -16777216 true false 195 180 270 240
Line -16777216 false 0 165 300 165
Polygon -7500403 true true 0 165 45 135 60 90 240 90 255 135 300 165
Rectangle -7500403 true true 0 0 75 45
Rectangle -16777216 false false 0 0 75 45

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

factory
false
0
Rectangle -7500403 true true 76 194 285 270
Rectangle -7500403 true true 36 95 59 231
Rectangle -16777216 true false 90 210 270 240
Line -7500403 true 90 195 90 255
Line -7500403 true 120 195 120 255
Line -7500403 true 150 195 150 240
Line -7500403 true 180 195 180 255
Line -7500403 true 210 210 210 240
Line -7500403 true 240 210 240 240
Line -7500403 true 90 225 270 225
Circle -1 true false 37 73 32
Circle -1 true false 55 38 54
Circle -1 true false 96 21 42
Circle -1 true false 105 40 32
Circle -1 true false 129 19 42
Rectangle -7500403 true true 14 228 78 270

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

house bungalow
false
0
Rectangle -7500403 true true 210 75 225 255
Rectangle -7500403 true true 90 135 210 255
Rectangle -16777216 true false 165 195 195 255
Line -16777216 false 210 135 210 255
Rectangle -16777216 true false 105 202 135 240
Polygon -7500403 true true 225 150 75 150 150 75
Line -16777216 false 75 150 225 150
Line -16777216 false 195 120 225 150
Polygon -16777216 false false 165 195 150 195 180 165 210 195
Rectangle -16777216 true false 135 105 165 135

house ranch
false
0
Rectangle -7500403 true true 270 120 285 255
Rectangle -7500403 true true 15 180 270 255
Polygon -7500403 true true 0 180 300 180 240 135 60 135 0 180
Rectangle -16777216 true false 120 195 180 255
Line -7500403 true 150 195 150 255
Rectangle -16777216 true false 45 195 105 240
Rectangle -16777216 true false 195 195 255 240
Line -7500403 true 75 195 75 240
Line -7500403 true 225 195 225 240
Line -16777216 false 270 180 270 255
Line -16777216 false 0 180 300 180

house two story
false
0
Polygon -7500403 true true 2 180 227 180 152 150 32 150
Rectangle -7500403 true true 270 75 285 255
Rectangle -7500403 true true 75 135 270 255
Rectangle -16777216 true false 124 195 187 256
Rectangle -16777216 true false 210 195 255 240
Rectangle -16777216 true false 90 150 135 180
Rectangle -16777216 true false 210 150 255 180
Line -16777216 false 270 135 270 255
Rectangle -7500403 true true 15 180 75 255
Polygon -7500403 true true 60 135 285 135 240 90 105 90
Line -16777216 false 75 135 75 180
Rectangle -16777216 true false 30 195 93 240
Line -16777216 false 60 135 285 135
Line -16777216 false 255 105 285 135
Line -16777216 false 0 180 75 180
Line -7500403 true 60 195 60 240
Line -7500403 true 154 195 154 255

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

person business
false
0
Rectangle -1 true false 120 90 180 180
Polygon -13345367 true false 135 90 150 105 135 180 150 195 165 180 150 105 165 90
Polygon -7500403 true true 120 90 105 90 60 195 90 210 116 154 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 183 153 210 210 240 195 195 90 180 90 150 165
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 76 172 91
Line -16777216 false 172 90 161 94
Line -16777216 false 128 90 139 94
Polygon -13345367 true false 195 225 195 300 270 270 270 195
Rectangle -13791810 true false 180 225 195 300
Polygon -14835848 true false 180 226 195 226 270 196 255 196
Polygon -13345367 true false 209 202 209 216 244 202 243 188
Line -16777216 false 180 90 150 165
Line -16777216 false 120 90 150 165

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
