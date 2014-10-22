;===========================================================================
; Helpers and other States
;===========================================================================

;SuperPause Helper
[Statedef 7000]
type = S
physics = N
movetype = I
anim = 7200

[State 8520, Assert]
type = assertspecial
trigger1 = Time < 100
flag = nobardisplay

[State 7000, Var]
type = VarSet
trigger1 = !Time
var(0) = (Parent, StateNo = 2100)

[State 7000, Pal Down]
type = BGPalFX
trigger1 = !var(0)
trigger1 = time <= 10 ;&& root, var(10) = 5
time = 1
add = 256 -ceil(20.6 * time), 256 -ceil(20.6 * time), 256 -ceil(20.6 * time)
mul = 256 -floor(20.6 * time), 256 -floor(20.6 * time), 256 -floor(20.6 * time)
color = 256 -floor(25.6 * time)

[State 7000, Pal Static]
type = BGPalFX
trigger1 = !var(0)
trigger1 = (time = [11, 39]); && root, var(10) = 5
time = 1
mul = 50,50,50;128, 128, 128
color = 0

[State 7000, Pal Up]
type = BGPalFX
trigger1 = time >= 40 
trigger1 = !var(0)
time = 1
mul = 50 + ceil(41.2 * (time - 40)), 50 + ceil(41.2 * (time - 40)), 50 +ceil(41.2 * (time - 40))
color = floor(51.2 * (time - 40))

[State 7000, Pal Down]
type = BGPalFX
trigger1 = time <= 10 ;&& root, var(10) = 5
trigger1 = var(0)
time = 1
mul = 256, 256 -floor(25.6 * time), 256 -floor(25.6 * time)
color = 256 -floor(25.6 * time)

[State 7000, Pal Static]
type = BGPalFX
trigger1 = (time = [11, 39]); && root, var(10) = 5
trigger1 = var(0)
time = 1
mul = 256, 0, 0
color = 0

[State 7000, Pal Up]
type = BGPalFX
trigger1 = time >= 40 
trigger1 = var(0)
time = 1
mul = 256, ceil(51.2 * (time - 40)), ceil(51.2 * (time - 40))
color = floor(51.2 * (time - 40))

[State 7000, End]
type = DestroySelf
trigger1 = Time >= 45

;Pulsing Portrait
[Statedef 7001]
type = A
movetype = I
physics = N
velset = 0,0
anim = 13999

[State 8520, Pos]
type = Turn
trigger1 = facing != 1

[State 8520, Pos]
type = PosAdd
trigger1 = 1
X = 160 - ScreenPos X
Y = floor((1.3333333 * gameheight / gamewidth) * 120) - ScreenPos Y

[State 8520, Scale]
type = AssertSpecial
trigger1 = 1
flag = noshadow

[State 8520, Trans]
type = Trans
trigger1 = Time < 8
trans = addalpha
alpha = Time * 32, 256

[State 8520, Trans]
type = Trans
trigger1 = Time = [8, 29]
trans = addalpha
alpha = 256, 256

[State 8520, Scale]
type = AngleDraw
trigger1 = 1
scale = 0.5 + IfElse(Time > 29, (Time - 29)/32.0, 0), 0.5 + IfElse(Time > 29, (Time - 29)/32.0, 0)

[State 8520, Scale]
type = Trans
trigger1 = Time >= 29
trans = addalpha
alpha = 256 - 16 * (Time - 29), 256

[State 8520, Safety]
type = DestroySelf
trigger1 = Time >= 45
