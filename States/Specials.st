;===========================================================================
; Special Moves
;===========================================================================

;---------------------------------------------------------------------------
;Backflip Kick
[Statedef 1010]
type    = S
movetype= A
physics = S
juggle  = 3
ctrl = 0
anim = 1010
sprpriority = 1
poweradd = 72
facep2 = 1

[State 1010, Strength]
type = VarSet
trigger1 = !Time
var(0) = ifelse(command = "dfc", 2, ifelse(command = "dfb", 1, 0))

[State 1100, nothitby]
type = nothitby
trigger1 = animelemtime(3) < 0
value = SCA
time = 1
ignorehitpause = 1

[State 1100, nothitby]
type = PlaySnd
trigger1 = AnimElem = 3
value = S7000,1
ignorehitpause = 1

[State 1010, Jump]
type = StateTypeSet
trigger1 = AnimElem = 3
statetype = A
physics = N

[State 1010, Jump]
type = VelSet
trigger1 = AnimElem = 3
y = ifelse(var(0) = 2, -7, ifelse(var(0) = 1, -5.3, -4.5))

[State 1010, Jump]
type = VelAdd
trigger1 = AnimElemNo(0) > 3 && Vel Y < 0
y = .8

[State 1010, Jump]
type = VelSet
trigger1 = AnimElem = 3
x = 2

[State 1010, Jump]
type = ChangeAnim
trigger1 = AnimElemNo(0) = [2, 6]
trigger1 = Pos Y < -20
trigger1 = MoveContact
trigger1 = Command = "a" || Command = "b" || Command = "c" 
value = 1010
elem = 7
persistent = 0

[State 1010, Jump]
type = VelSet
trigger1 = AnimElem = 7
y = 0
x = 0

[State 1010, Jump]
type = VelSet
trigger1 = AnimElem = 9
y = ifelse(var(0) = 2, 7.5, ifelse(var(0) = 1, 5.2, 4))
x = ifelse(var(0) = 2, 4, ifelse(var(0) = 1, 5.2, 7.5))

[State 1100, nothitby]
type = PlaySnd
trigger1 = AnimElem = 9
value = S7050,0
ignorehitpause = 1

[State 1010, HitDef]
type = HitDef
trigger1 = !Time
attr = A, SA
damage = 67,7
animtype = Hard
air.type = Low
guardflag = M
hitflag = MAF
priority = 6, Hit
pausetime = 12,12
sparkno = S7009
;guard.sparkno = S8105
sparkxy = -10,-30
hitsound = S7020,5
guardsound = 5,0
ground.type = High
ground.velocity = 0, ifelse(var(0) = 2, -7, ifelse(var(0) = 1, -7, -5));-4
ground.hittime = 16
ground.slidetime = 16
guard.velocity = -10
air.velocity = 0, ifelse(var(0) = 2, -7, ifelse(var(0) = 1, -7, -5));-4
airguard.velocity = -1, -3
air.hittime = 16
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
yaccel = 0.4
air.fall = 1
fall.recover = 1
getpower = ifelse(p2movetype = H, 36, 72), 36 
givepower = 36, 36
envshake.time = 8
envshake.freq = 120
envshake.ampl = 2
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 1010, HitDef]
type = HitDef
trigger1 = AnimElem = 8
attr = A, SA
damage = 62,7
animtype = Hard
guardflag = HA
hitflag = MA
priority = 6, Hit
pausetime = 16,16
sparkno = S7001
hitsound = S7040,3
guardsound = 5,0
ground.type = High
ground.velocity = ifelse(var(0) = 2, -2, ifelse(var(0) = 1, -3, -4)), ifelse(var(0) = 2, -4, ifelse(var(0) = 1, -3, -2))
guard.velocity = -2
ground.hittime = 16
guard.ctrltime = 16
airguard.velocity = -2, -1
air.hittime = 17
ground.cornerpush.veloff = 0
air.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
getpower = 28, 14
givepower = 56,0
yaccel = 0.625
fall = 1
fall.recover = 0
getpower = ifelse(p2movetype = H, 36, 72), 36 
givepower = 36, 36
envshake.time = 8
envshake.freq = 120
envshake.ampl = 2
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 1010, End]
type = ChangeState
trigger1 = Pos Y >= 0 && AnimElemNo(0) = 9
value = 52

;---------------------------------------------------------------------------
; Rock Throw
[Statedef 1020]
type    = S
movetype= A
physics = S
juggle  = 3
poweradd= 72
ctrl = 0
anim = 1020
sprpriority = 1
facep2 = 1
velset = 0,0

[State 1020, Strength]
type = VarSet
trigger1 = !Time
var(0) = ifelse(command = "qcfc", 2, ifelse(command = "qcfb", 1, 0))

[State 1020, Rock Sound]
type = PlaySnd
trigger1 = AnimElem = 3
value = S7010,1

[State 1020, Rock]
type = Helper
trigger1 = AnimElem = 3
name = "Big Rock"
ID = 1020
stateno = 1021
pos = 5,0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1

[State 1020, Explod]
type = Explod
trigger1 = AnimElemTime(3) >= 0 && AnimElemTime(3) <= 6 && NumExplod(1021) < 3
anim = 7105 - (NumExplod(1021) % 2)
ID = 1021
pos = 5, - floor(random % 6)
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
vel = 1 + 0.8 * (random)/1000.0 ,-5 + 2 * (random - 500.0)/500.0
accel = 0,.52
removetime = 15
scale = 1 + 0.1 * (random - 500.0)/500.0 ,1 + 0.1 * (random - 500.0)/500.0
sprpriority = 4
ontop = 0
shadow = -1
ownpal = 1
removeongethit = 0

[State 1020, ModifyExplod]
type = ModifyExplod
trigger1 = NumExplod(1021) > 0 && AnimElemTime(3) >= 0 
ID = 1021
pos = 0,0
trans = addalpha
alpha = floor((1 - AnimElemTime(3)/30.0)*256), floor(256*(AnimElemTime(3)/30.0))

[State 1020, Rock Sound]
type = PlaySnd
trigger1 = AnimElem = 4
value = S7000,1

[State 1020, ChangeState]
type = ChangeState
trigger1 = !AnimTime
value = 0
ctrl = 1

; The Rock
[Statedef 1021]
type    = S
movetype= I
physics = S
juggle  = 3
ctrl = 0
anim = 7100
sprpriority = 3

[State 1021, PosSet]
type = VarSet
trigger1 = !Time
var(0) = parent, var(0)
var(1) = 0

[State 1021, HitOverride]
type = HitOverride
trigger1 = 1
time = -1
attr = SCA, AA, AP, AT
stateno = 1022
ignorehitpause = 1

[State 1021, HB]
type = HitBy
trigger1 = 1
time = -1
value = SCA, NP, SP, HP
ignorehitpause = 1

[State 1021, PosSet]
type = VelSet
trigger1 = parent, AnimElem = 3 && parent, StateNo = 1020
y = -8

[State 1021, PosSet]
type = VelSet
trigger1 = time > 0 && parent, AnimElemNo(0) = 3 && parent, AnimElemTime(3) < 6 && parent, StateNo = 1020
x = -4

[State 1021, PosSet]
type = VelMul
trigger1 = time > 0 && parent, AnimElemNo(0) = 3 && parent, AnimElemTime(3) < 6  && parent, StateNo = 1020
y = 0.64

[State 1021, PosSet]
type = VarSet
trigger1 = parent, AnimElem = 4 && parent, StateNo = 1020
var(1) = 1

[State 1021, PosSet]
type = VelSet
trigger1 = parent, AnimElem = 4 && parent, StateNo = 1020
x = IfElse(var(0) = 0, 6,IfElse(var(0) = 1, 5, 6))
y = IfElse(var(0) = 0, -2,IfElse(var(0) = 1, -4, -5))

[State 1021, PosSet]
type = VelAdd
trigger1 = var(1)
y = IfElse(var(0) = 0, .56,IfElse(var(0) = 1, .53, .5))

[State 1021, PosSet]
type = StateTypeSet
trigger1 = parent, AnimElem = 4 && parent, StateNo = 1020
statetype = S
movetype = A
physics = N

[State 1021, HitDef]
type = HitDef
trigger1 = parent, AnimElem = 4 && parent, StateNo = 1020
attr = S, SP
hitflag = MAF        ;HLAFD+-
guardflag = MA         ;HLA
animtype = Hard
sparkno = S7001
damage = 72,0
sparkxy = -10,-15
hitsound = S220,1
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = -5.52, 0
ground.cornerpush.veloff = 0
givepower = 36, 36
envshake.time = 14
envshake.freq = 120
envshake.ampl = 2
air.velocity = -4, -4
air.fall = 1
fall.recover = 1
fall.recovertime = 30
yaccel = 0.5
airguard.ctrltime = 16
airguard.velocity = -8, -1.5
forcestand = 1
getpower = ifelse(p2movetype = H, 72, 144), 36
givepower = 36, 36
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 1021, ChangeState]
type = ChangeState
trigger1 = pos y >= 1 || (parent, StateNo != 1020 && !var(1)) || HitCount > 0
value = 1022
ctrl = 0
ignorehitpause = 1

;Destroyed Rock
[Statedef 1022]
type    = S
movetype= I
physics = S
juggle  = 3
ctrl = 0
anim = 7103
sprpriority = 3

[State 1022, Sound]
type = PlaySnd
trigger1 = !Time
value = S7020,5

[State 1022, Must not be seen]
type = AssertSpecial
trigger1 = 1
flag = invisible
ignorehitpause = 1

[State 1022, Explod]
type = Explod
trigger1 = NumExplod(1022) < 3 && Time < 5
anim = 7105 - (NumExplod(1022) % 2)
ID = 1022
pos = floor(random % 12) - 6 , ifelse(pos y > 0, floor(-Pos y), floor(random % 12) - 6) 
postype = p1 ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
vel = ifelse(NumExplod(1022) < 3, -1, 1) * (2.5 + 1 * (random)/1000.0) , -5 + 1 * (random - 500.0)/500.0
accel = 0,.52
removetime = 20
scale = 1 , 1
sprpriority = 4
ontop = 0
shadow = -1
ownpal = 0
removeongethit = 0

[State 1022, PosSet]
type = PosSet
trigger1 = pos y > 0
y = 0

[State 1022, ModifyExplod]
type = ModifyExplod
trigger1 = NumExplod(1022) > 0
ID = 1022
pos = 0,0
trans = addalpha
alpha = floor((1 - Time/30.0)*256), floor(256*Time/30.0)

[State 1022, DestroySelf]
type = DestroySelf
trigger1 = Time = 20

;---------------------------------------------------------------------------
; Cat Attack
[Statedef 1030]
type    = S
movetype= A
physics = S
juggle  = 3
ctrl = 0
anim = 1030
sprpriority = 1
facep2 = 1
velset = 0,0

[State 1030, Jump]
type = PlaySnd
trigger1 = !Time
value = 7010,1

[State 1030, Jump]
type = VarSet
trigger1 = !Time
var(0) = 0

[State 1030, Width]
type = Width
trigger1 = AnimElemNo(0) > 4 || Anim = 1033
value = -3,-3

[State 1030, Jump]
type = StateTypeSet
trigger1 = Anim = 1030 && AnimElem = 5
statetype = A
physics = N

[State 1030, Jump]
type = PosAdd
trigger1 = Anim = 1030 && AnimElem = 5
Y = - 5

[State 1030, Jump]
type = VarSet
trigger1 = Anim = 1033
var(0) = 1

[State 1030, Jump]
type = VelSet
trigger1 = Anim = 1030 && AnimElem = 5
X = 5
Y = -6

[State 1030, Jump]
type = PlaySnd
trigger1 = Anim = 1030 && AnimElem = 5
value = 7050,0

[State 1030, Width]
type = ChangeAnim
trigger1 = Vel Y > 0
value = 1033
persistent = 0

[State 1030, Jump]
type = VelAdd
trigger1 = (Anim = 1030 && AnimElemNo(0) >= 5) || Anim = 1033
Y = 0.55

[State 1030, Land]
type = VelSet
trigger1 = AnimElemNo(0) > 4 && Pos Y >= 0
Y = 0

[State 1030, Land]
type = PosSet
trigger1 = AnimElemNo(0) > 4  && Pos Y >= 0
Y = 0

[State 1030, Fail]
type = ChangeState
triggerall = Pos Y > -15 
trigger1 = Anim = 1033 && var(0)
;trigger2 = (AnimElemNo(0) > 4)
value = 52
ctrl = 0

[State 1030, Hit]
type = HitDef
trigger1 = !Time
attr = A, ST 
hitflag = M-
priority = 2, Miss
sparkno = -1
hitsound = s7010, 0
p1stateno = 1031
p2stateno = 1032
guard.dist = 0
ground.velocity = 0,0
fall = 1
fall.recover = 1
fall.recovertime = 120

;Cat Attack - Success
[Statedef 1031]
type    = A
movetype= A
physics = N
juggle  = 3
ctrl = 0
anim = 1031
sprpriority = 1
poweradd = 72
velset = 0,0

[State 1031, Measure]
type = PosAdd
trigger1 = !Time
Y = IfElse(Pos Y < -30, 20, -Pos Y)

[State 1031, Measure]
type = VarSet
trigger1 = !Time
fvar(0) = (Target, Const(size.ground.front) + Target, Const(size.ground.back))*1.0*(GameWidth/(Target, GameWidth))

[State 1031, Jump]
type = VelSet
trigger1 = AnimElem = 6
y = -6
x = (fvar(0) + 20) / 30

[State 1031, Shake]
type = PlaySnd
trigger1 = AnimElem = 6
trigger2 = AnimElem = 13
value = 7010,1

[State 1031, VelAdd]
type = VelAdd
trigger1 = AnimElemNo(0) = [6,9]
Y = 0.4

[State 1031, VelAdd]
type = VelSet
trigger1 = AnimElem = 10
Y = 0
X = 0

[State 1031, Jump2]
type = VelSet
trigger1 = AnimElem = 13
y = -6
x = 0

[State 1031, VelAdd2]
type = VelAdd
trigger1 = AnimElemNo(0) = [13,16]
Y = 0.4

[State 1031, Jump2]
type = VelSet
trigger1 = AnimElem = 17
y = 0
x = 0

[State 1031, Jump2]
type = VelSet
trigger1 = !AnimTime
x = -3
y = -7

[State 1031, Shake]
type = EnvShake
trigger1 = AnimElem = 3
trigger2 = AnimElem = 5
trigger3 = AnimElem = 11
trigger4 = AnimElem = 17
time = 14
freq = 120
ampl = 4

[State 1031, Snd]
type = PlaySnd
trigger1 = AnimElem = 3
trigger2 = AnimElem = 5
trigger3 = AnimElem = 11
value = 7020,2

[State 1031, Final Snd]
type = PlaySnd
trigger1 = AnimElem = 17
value = 7020,5

[State 1031, Hit]
type = HitAdd
trigger1 = !Time
value = -1

[State 1031, Hit]
type = HitAdd
trigger1 = AnimElem = 3
trigger2 = AnimElem = 5
trigger3 = AnimElem = 11
trigger4 = AnimElem = 17
value = 1

[State 1031, Turn]
type = Turn
trigger1 = AnimElem = 10

[State 1031, End]
type = ChangeState
trigger1 = !AnimTime
value = 50
ctrl = 0

; Get Hit - Ground
[Statedef 1032]
type = S
physics = N
movetype = H
velset = 0,0

[State 1032, Anim]
type = ChangeAnim2
trigger1 = !Time
value= 1032

[State 1032, Shtuff]
type = PosFreeze
trigger1 = 1

[State 1032, Shake]
type = PalFx
trigger1 = Time = 30
trigger2 = Time = 60
trigger3 = Time = 118
trigger4 = Time = 176
add = 200, 200, 200
mul = 256, 256, 256
time = 25

[State 1032, Argh]
type = LifeAdd
trigger1 = Time = 30
trigger2 = Time = 60
trigger3 = Time = 118
trigger4 = Time = 176
value = - 27
kill = 0

[State 1032, Shake]
type = Turn
trigger1 = Time = 118

[State 1032, Self]
type = ChangeState
trigger1 = !AnimTime
value = 1033

; Gethit - Air
[Statedef 1033]
type = A
physics = N
movetype = H
velset = -3,-7

[State 1033, Vel]
type = VelAdd
trigger1 = 1
y = .56

[State 1033, Vel]
type = ChangeAnim2
trigger1 = Vel Y > 0
value = 804

[State 1033, Life]
type = LifeAdd
trigger1 = (Vel y > 0) && (Pos y >= 0)
value = -33

[State 1033, Pal]
type = PalFX
trigger1 = (Vel y > 0) && (Pos y >= 0)
add = 200, 200, 200
mul = 256, 256, 256
time = 8

[State 1033, Life]
type = EnvShake
trigger1 = (Vel y > 0) && (Pos y >= 0)
time = 14
freq = 120
ampl = 4

[State 1033, Life]
type = PosSet
trigger1 = (Vel y > 0) && (Pos y >= 0)
y = 0

[State 1033, Hit Ground]
type = SelfState
trigger1 = (Vel y > 0) && (Pos y >= 0)
value = 5100

;Drill Kick
[Statedef 1034]
type = A
movetype = A
physics = N
anim = 1034

[State 1034, Stop]
type = VelAdd
trigger1 = 1
Y = .55

[State 1034, Stop]
type = VarSet
trigger1 = !Time
var(0) = 0

[State 1034, Stop]
type = VarSet
trigger1 = !Time
fvar(0) = Vel X

[State 1034, Stop]
type = VelSet
trigger1 = !Time
X = 0
Y = 0
persistent = 0

[State 1034, Stop]
type = VelSet
trigger1 = AnimElem = 2
X = fvar(0)
persistent = 0

[State 1034, Stop]
type = VarSet
trigger1 = AnimElem = 4
var(0) = 1

[State 1034, Stop]
type = VelSet
trigger1 = !var(0)
Y = 0

[State 220, 2]
type = HitDef
trigger1 = !Time
attr = A, SA
animtype  = Hard
damage    = 98, 7
guardflag = MAF
pausetime = 12,12
sparkno = S7008
sparkxy = -10, 0
hitsound   = S7020,3
guardsound = 6,0
ground.type = High
ground.slidetime = 14
ground.hittime  = 17
ground.velocity = -4
air.velocity = -4,-2
getpower = ifelse(p2movetype = H, 72, 216), 36
givepower = 36, 36
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
fall = 1
ground.cornerpush.veloff = -2;
air.cornerpush.veloff = -2;

[State 1034, End]
type = ChangeState
trigger1 = Pos Y > 0
value = 1035

[Statedef 1035]
type = C
physics = C
movetype = I
velset = 0,0
anim = 10
ctrl = 0

[State 1035, Pos]
type = PosSet
trigger1 = !Time
Y = 0

[State 1035, Pos]
type = ChangeState
trigger1 = Time > 10
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Tail Whirl
[Statedef 1040]
type    = A
movetype= A
physics = A
juggle  = 3
poweradd= 72
ctrl = 0
anim = 1040
sprpriority = 1
facep2 = 1

[State 1040, Vel]
type = VelSet
trigger1 = !Time
x = 3;IfElse(Vel X > 0, 0.5 *(Vel X), 0.5)

[State 1040, Vel]
type = VelSet
trigger1 = AnimElemNo(0) = 1
y = -0.7

[State 1040, Vel]
type = PlaySnd
trigger1 = AnimElemNo(0) = 2
value = S7000,1
loop = 1
channel = 0


[State 1040, Vel]
type = StopSnd
trigger1 = AnimElemNo(0) > 9
channel = 0
;loop = 1


[State 1040, Vel]
type = VelSet
trigger1 = AnimElemNo(0) = [2,9]
y = 0

[State 1250, Hit]
type = HitDef
trigger1 = animelem = 2 || animelem = 6 
attr = A, SA
damage = 47, 7
animtype = Hard
guardflag = HA
hitflag = MAF
priority = 4, Hit
pausetime = 14, 14
sparkno = s7001
sparkxy = -10, 0
hitsound = s2, 6
guardsound = s2, 0
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = -2, -7
air.type = Low
air.velocity = -2, -6
air.cornerpush.veloff = 0
ground.cornerpush.veloff = 0
guard.velocity = -10.52
guard.cornerpush.veloff = 0;-12.74
getpower = ifelse(p2movetype = H, 72, 144), 36
givepower = 36, 36
envshake.time = 16
envshake.freq = 120
envshake.ampl = 4
fall = 1
fall.recover = 1
fall.recovertime = 120
yaccel = 0.5
airguard.ctrltime = 16
airguard.velocity = -8, -1.5
forcestand = 1
airguard.cornerpush.veloff = 0
airguard.cornerpush.veloff = 0
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 1250, hitb]
type = HitDef
trigger1 = animelem = 4 || animelem = 8
attr = A, SA
damage = 47, 7
animtype = Hard
guardflag = HA
hitflag = MAF
priority = 4, Hit
pausetime = 14, 14
sparkno = s7001
sparkxy = -10, 0
hitsound = s2, 6
guardsound = s2, 0
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = 2, -7
air.type = Low
air.velocity = 2, -6
air.cornerpush.veloff = 0
ground.cornerpush.veloff = 0
guard.velocity = -10.52
guard.cornerpush.veloff = 0;-12.74
getpower = ifelse(p2movetype = H, 72, 144), 36
givepower = 36, 36
envshake.time = 16
envshake.freq = 120
envshake.ampl = 4
fall = 1
fall.recover = 1
fall.recovertime = 120
yaccel = 0.5
airguard.ctrltime = 16
airguard.velocity = -8, -1.5
forcestand = 1
airguard.cornerpush.veloff = 0
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

