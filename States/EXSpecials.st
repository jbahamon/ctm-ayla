;===========================================================================
; Alternate Special Moves
;===========================================================================

;Gou Hadouken
[Statedef 11000]
type = S
physics = S
movetype = A
anim = 11000
ctrl = 0
velset = 0, 0
poweradd = 72 * !var(21)
sprpriority = 1
facep2 = 1

[State 1020, Rock Sound]
type = PlaySnd
trigger1 = !Time
value = S8000,0

[State 1020, Rock Sound]
type = PlaySnd
trigger1 = AnimElem = 4
value = S7000,1

[State 1000, Strength]
type = varset
trigger1 = !time 
var(0) = ifelse(command = "qcfc", 2, ifelse(command = "qcfb", 1, 0))

[State 1000, Hadouken]
type = helper
trigger1 = animelem = 4
helpertype = normal
stateno = 11005
ID = 11005
name = "Hadouken"
postype = p1
pos = 10, -17
ownpal = 1

[State 1000, End]
type = changestate
trigger1 = !animtime
value = 0
ctrl = 1

;Gou Hadouken Helper
[Statedef 11005]
type = S
physics = N
movetype = A
anim = 11005
ctrl = 0
velset = 0, 0
sprpriority = 4

[State 1005, Trans]
type = Trans
trigger1 = 1
trans = addalpha
alpha = Floor(256 - 32*Abs(Sin(Time/5.0))), Floor(128*Abs(Sin(Time/5.0)))

[State 1005, HitOverride]
type = hitoverride
trigger1 = 1
time = -1
attr = SCA, AA, AP, AT
stateno = 11006
ignorehitpause = 1

[State 1005, HB]
type = hitby
trigger1 = 1
time = -1
value = SCA, NP, SP, HP
ignorehitpause = 1

[State 1005, Strength]
type = varset
trigger1 = !time
var(0) = root, var(0)

[State 1005, movehitvar]
type = varset
trigger1 = movecontact && numtarget
trigger1 = !(target, ishelper)
var(3) = 1
ignorehitpause = 1

[State 1005, timevar]
type = assertspecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 1005, timevar]
type = varadd
trigger1 = time && var(1) < 25
var(1) = 1

[State 1005, Vel]
type = velset
trigger1 = 1
x = ifelse(var(0) = 2, 5.6, ifelse(var(0) = 1, 4.5, 3)) * 0.7
y = 0

[State 1005, HitSound]
type = playsnd
trigger1 = movehit && numtarget
trigger1 = !(target, time) && target, movetype = H
value = S7020,5
channel = 1
persistent = 0
ignorehitpause = 1

[State 1001, Dampen]
Type = ParentVarset
Trigger1 = MoveHit
trigger1 = !(target, time) && target, movetype = H
fvar(39) = parent, Fvar(39)*0.85
persistent = 0
ignorehitpause = 1

[State 1005, Hit]
type = hitdef
trigger1 = 1
priority = 4, Hit
attr = S, SP
damage = ceil(ifelse(time <= 1, 68, 54) * root, fvar(39)), 7
animtype = Hard
hitflag = MAF
guardflag = MA
pausetime = 0, 4
sparkno = -1
guardsound = s2, 0
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = ifelse(var(1) <= 12, -4, -7.52) * 0.6, ifelse(var(1) <= 12, -2.5, 0) * 0.8
ground.cornerpush.veloff = 0
air.velocity = (-.75  * 0.6) * vel x , -2  * 0.8
fall = var(1) <= 12
air.fall = 1
fall.recover = 1
fall.recovertime = 16
getpower = ifelse(p2movetype = H, 72, 144) * !(root, var(21)), 36 * !(root, var(21))
givepower = 36, 36
envshake.time = 14
envshake.freq = 120
envshake.ampl = 4
p1sprpriority = 4
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
airguard.ctrltime = 16
airguard.velocity = ifelse((root, var(21)), -4, -8) * 0.6, -1.5 * 0.6
forcestand = 1

[State 1005, End]
type = changestate
trigger1 = movecontact
trigger2 = Time > 60
value = 11006

ignorehitpause = 1
[State 1006, End]
type = destroyself
trigger1 = pos x != [ -240, 240]

; Gou Hadouken GetHit/End
[Statedef 11006]
type = A
physics = N
movetype = I
anim = 7008
velset = Vel X, 0
ctrl = 0
sprpriority = 4
movehitpersist = 1

[State 1005, timevar]
type = assertspecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 1006, End]
type = VelMul
trigger1 = 1
X = 0.9

[State 1006, End]
type = destroyself
trigger1 = !animtime

;---------------------------------------------------------------------------
; Zankuu Hadouken
[Statedef 11050]
type = A
physics = A
movetype = A
anim = 11050
ctrl = 0
poweradd = 72 * !var(21)
sprpriority = 1


[State 1020, Rock Sound]
type = PlaySnd
trigger1 = !Time || animelem = 4
value = S8000,0
channel = 0


[State 1020, Rock Sound]
type = PlaySnd
trigger1 = animelem = 2 || animelem = 5
value = S7000,1
channel = 1


[State 1250, slow]
type = veladd
trigger1 = 1
y = -const(movement.yaccel) * 0.2

[State 1050, Strength]
type = varset
trigger1 = !time
var(0) = ifelse(command = "qcfc", 2, ifelse(command = "qcfb", 1, 0))

[State 1050, Hadouken]
type = helper
trigger1 = animelem = 2 || animelem = 5
helpertype = normal
stateno = 11055
ID = 11055
name = "Hadouken"
postype = p1
pos = ifelse((animelem = 2), 5, 6), ifelse((animelem = 2), -4, -4)
ownpal = 1


;Zankuu Hadouken Helper
[Statedef 11055]
type = S
physics = N
movetype = A
anim = 11055
ctrl = 0
velset = 0, 0
sprpriority = 4

[State 1001, Dampen]
Type = ParentVarset
Trigger1 = MoveHit
trigger1 = !(target, time) && target, movetype = H
fvar(39) = parent, Fvar(39)*0.85
persistent = 0
ignorehitpause = 1


[State 1005, Trans]
type = Trans
trigger1 = 1
trans = addalpha
alpha = Floor(256 - 32*Abs(Sin(Time/5.0))), Floor(128*Abs(Sin(Time/5.0)))

[State 1005, Trans]
type = AngleDraw
trigger1 = 1
value = -45

[State 1005, HitOverride]
type = hitoverride
trigger1 = 1
time = -1
attr = SCA, AA, AP, AT
stateno = 11056
ignorehitpause = 1

[State 1005, HB]
type = hitby
trigger1 = 1
time = -1
value = SCA, NP, SP, HP
ignorehitpause = 1

[State 1005, Strength]
type = varset
trigger1 = !time
var(0) = root, var(0)

[State 1005, movehitvar]
type = varset
trigger1 = movecontact && numtarget
trigger1 = !(target, ishelper)
var(3) = 1
ignorehitpause = 1

[State 1005, timevar]
type = assertspecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 1005, timevar]
type = varadd
trigger1 = time && var(1) < 25
var(1) = 1

[State 1055, Vel]
type = velset
trigger1 = 1
x = ifelse(var(0) = 3, 5.7, ifelse(var(0) = 2, 4.3, 2.9)) * 0.8
y = ifelse(var(0) = 3, 4, ifelse(var(0) = 2, 3, 2)) * 0.8

[State 1055, Hit]
type = hitdef
trigger1 = 1
priority = 4, Hit
attr = A, SP
damage = ceil(47 * root, fvar(39)), 7
animtype = Back
fall.animtype = Back
hitflag = MAFD
guardflag = MA
pausetime = 0, 8
sparkno = -1
sparkxy = -10, 0
hitsound = S7020,5
guardsound = s2, 0
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = -7.51*0.8, 0
guard.velocity = -10.52*0.8
ground.cornerpush.veloff = 0
air.velocity = -vel x, vel y
down.hittime = 20
down.velocity = 0, 0
air.fall = 1
fall.recover = 1
fall.recovertime = 16
getpower = ifelse(p2movetype = H, 72, 144) * !(root, var(21)), 36 * !(root, var(21))
givepower = 36, 36
envshake.time = 14
envshake.freq = 120
envshake.ampl = 4
p1sprpriority = 4
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
airguard.ctrltime = 16
airguard.velocity = ifelse((root, var(21)), -4, -8)*0.8, -1.5*0.8
forcestand = 1

[State 1005, End]
type = changestate
trigger1 = movecontact
trigger2 = Pos Y > Vel Y && Vel Y > 0
value = 11056

ignorehitpause = 1
[State 1006, End]
type = destroyself
trigger1 = pos x != [ -240, 240]

; Zankuu Hadouken GetHit/End
[Statedef 11056]
type = A
physics = N
movetype = I
anim = 11056
velset = 0, 0
ctrl = 0
sprpriority = 4
movehitpersist = 1

[State 1005, Trans]
type = AngleDraw
trigger1 = 1
value = 0

[State 1006, End]
type = PosSet
trigger1 = Pos Y > 0
Y = 0


[State 1005, timevar]
type = assertspecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 1006, End]
type = destroyself
trigger1 = !animtime

;---------------------------------------------------------------------------
; Gou Shoryuuken
[Statedef 11100]
type = S
physics = S
movetype = A
anim = 11100
ctrl = 0
velset = 0, 0
poweradd = 72 * !var(21)
juggle = ifelse((p2movetype = H && p2statetype = A), 7, 9)
facep2 = 1
sprpriority = 1

[State N, Sound]
type = PlaySnd
trigger1 = !Time
value = S7000,1
channel = 1

[State N, Sound]
type = PlaySnd
trigger1 = !Time
value = S8000,1
channel = 0

[State 200, Dampen]
Type=Varset
Trigger1 = MoveHit
fvar(39) = (FVar(39))*0.85
persistent = 0
ignorehitpause = 1


[State 1100, Strength]
type = VarSet
trigger1 = !Time
var(0) = IfElse(Command = "dfc", 2, IfElse(Command = "dfb", 1, 0))

[State 1100, nothitby]
type = NotHitBy
trigger1 = Anim = 11100 && AnimElemTime(4) < 0
value = SCA
time = 1
ignorehitpause = 1

[State 1100, Vel]
type = velset
trigger1 = anim = 11100 && AnimElem = 4
x = IfElse(Var(0) = 2, 12, IfElse(Var(0) = 1, 9, 6))*0.8
y = IfElse(Var(0) = 2, -11, IfElse(Var(0) = 1, -8.5, -6))*0.8

[State 1100, Vel]
type = velmul
trigger1 = 1
x = 0.88

[State 1100, Vel]
type = velmul
trigger1 = vel y > 0
x = 0

[State 1100, Snd]
type = playsnd
trigger1 = anim = 11100 && animelem = 3
value = 3, 9
channel = 0
ignorehitpause = 1
persistent = 0

[State 1100, Hit]
type = hitdef
trigger1 = animelem = 2 && anim = 11100
trigger2 = animelem = 3 && anim = 11100
attr = S, SA
damage = ifelse((animelem = 3), 27, 67 + 7 * var(0)), 7
animtype = Hard
fall.animtype = Hard
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = ifelse(var(21), 6, 12), ifelse(var(21), 5, 11)
sparkno = s7001
sparkxy = -7 + Random % 2 , ifelse((animelem = 2), -5, -10)
hitsound = S7020,0
guardsound = s2, 0
ground.type = Low
ground.slidetime = 16
ground.hittime = 16
ground.velocity = 0.5 * 0.8, -5.5 * 0.8
air.type = Low
air.velocity = 0.5 * 0.8, -5.5 * 0.8
ground.cornerpush.veloff = 0
guard.velocity = -10.52
guard.cornerpush.veloff = 0;-12.74
getpower = ifelse(p2movetype = H, 72, 144) * !var(21), 36 * !var(21)
givepower = 36, 36
envshake.time = 16
envshake.freq = 120
envshake.ampl = 4
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
fall = 1
fall.recover = 1
fall.recovertime = 120
fall.animtype = Medium
forcestand = 1
airguard.ctrltime = 16
airguard.cornerpush.veloff = 0
airguard.velocity = -8, -1.5

[State 1100, hit2]
type = hitdef
trigger1 = animelem = 4 && anim = 11100
attr = A, SA
damage = 20, 7
animtype = Back
guardflag = MA
hitflag = MAF
priority = 4, Hit
pausetime = ifelse(var(21), 8, 16), ifelse(var(21), 8, 16)
sparkno = s7001
sparkxy = -7 + Random % 2, -20
hitsound = S7020,5
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = (-2 -(var(0) / 2)) * 0.8, (-6 -var(0)) * 0.8
air.type = Low
air.velocity = (-2 -(var(0) / 2)) * 0.8, (-6 -var(0)) * 0.8
ground.cornerpush.veloff = 0
guard.velocity = -10.52* 0.8
guard.cornerpush.veloff = 0;-12.74
getpower = ifelse(p2movetype = H, 72, 144) * !var(21), 36 * !var(21)
givepower = 36, 36
envshake.time = 16
envshake.freq = 120
envshake.ampl = 4
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
fall = 1
fall.recover = 1
fall.recovertime = 120
airguard.ctrltime = 16
airguard.velocity = ifelse(var(21), -4, -8) * 0.8, -1.5 * 0.8
forcestand = 1
airguard.cornerpush.veloff = 0

[State 1100, statetype]
type = statetypeset
trigger1 = anim = 11100 && animelemtime(4) >= 0
statetype = A
physics = A

[State 1100, Anim]
type = changeanim
trigger1 = anim = 11100 && animelemtime(4) > 0 && vel y > (ifelse(var(10) = 3, -5.3, ifelse(var(10) = 2, -4, -2.7))) * 0.8
value = 11101

[State Idle]
type = statetypeset
trigger1 = anim = 11101
movetype = I


;---------------------------------------------------------------------------
; Tatsumaki Zankuu Kyaku
[Statedef 11200]
type = A
physics = N
movetype = A
anim = 11200
ctrl = 0
velset = 0, 0
poweradd = 72 * !var(21)
juggle = 8
facep2 = 1
sprpriority = 1


[State N, Sound]
type = PlaySnd
trigger1 = !Time
value = S7000,1
channel = 1


[State N, Sound]
type = PlaySnd
trigger1 = !Time
value = S8000,2
channel = 0

[State 200, Dampen]
Type=Varset
Trigger1 = MoveHit
fvar(39) = (FVar(39))*0.85
persistent = 0
ignorehitpause = 1

[State 1200, Strength]
type = varset
trigger1 = !time && !AIlevel
var(0) = ifelse((command = "qcbc"), 2, ifelse(command = "qcbb", 1, 0))

[State 1200, nothitby]
type = nothitby
trigger1 = anim = 11200 && animelemtime(2) < 0
value = SCA
time = 1
ignorehitpause = 1

[State 1200, Anim]
type = changeanim
trigger1 = anim = 11200 && !animtime
value = 11201

[State 1200, statetype]
type = statetypeset
trigger1 = anim = 11200 || anim = 11205
statetype = A
physics = A

[State 1200, statetype]
type = statetypeset
trigger1 = anim = 11201
statetype = A
physics = N

[State 1200, Vel]
type = velset
trigger1 = anim = 11200 && animelem = 1
x = 3.5*0.7
y = -4

[State 1200, Vel]
type = velset
trigger1 = anim = 11201
x = 3.5*0.7
y = 0

[State 1200, Anim]
type = changeanim
trigger1 = anim = 11201 && ifelse(var(0) = 2, !animtime, ifelse(var(0) = 1, animelemtime(18) >= 0, animelemtime(6) >= 0))
value = 11205
persistent = 0

[State 1200, Hit]
type = hitdef
trigger1 = anim = 11200 && animelemtime(2) = -1
trigger2 = anim = 11201 && (animelem = 2 || animelem = 8 || animelem = 14 || animelem = 20)
attr = S, SA
damage = ifelse(anim = 11200, 35, 42), 7
animtype = Hard
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = ifelse(var(21), 7, 14), ifelse(var(21), 7, 14)
sparkno = s7001
sparkxy = -10, -7
hitsound = S7020,0
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = -2.5*0.7, -8*0.6
air.type = Low
air.velocity =  -2.5*0.7, -6.5*0.6
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.6
getpower = ifelse(p2movetype = H, 72, 144) * !var(21), 36 * !var(21)
givepower = 36, 36
envshake.time = 16
envshake.freq = 120
envshake.ampl = 4
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
fall = 1
fall.recover = 1
fall.recovertime = 120
airguard.ctrltime = 16
airguard.velocity = ifelse(var(21), -4, -8)*0.6, -1.5*0.6
forcestand = 1
airguard.cornerpush.veloff = 0

[State 1200, hitb]
type = hitdef
trigger1 = anim = 11201 && (animelem = 5 || animelem = 11 || animelem = 17 || animelem = 23)
attr = S, SA
damage = 42, 7
animtype = Hard
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = ifelse(var(21), 7, 14), ifelse(var(21), 7, 14)
hitsound = S7020,0
sparkno = s7001
sparkxy = -10, -7
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = 3*0.7, -8*0.6
air.type = Low
air.velocity =  3*0.7, -6.5*0.6
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.6
guard.cornerpush.veloff = 0;-12.74
getpower = ifelse(p2movetype = H, 72, 144) * !var(21), 36 * !var(21)
givepower = 36, 36
envshake.time = 16
envshake.freq = 120
envshake.ampl = 4
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
fall = 1
fall.recover = 1
fall.recovertime = 120
airguard.ctrltime = 16
airguard.velocity = ifelse(var(21), -4, -8)*0.6, -1.5*0.6
forcestand = 1
airguard.cornerpush.veloff = 0

[State Idle]
type = statetypeset
trigger1 = anim = 11205
movetype = I
;---------------------------------------------------------------------------
; Kuchuu Tatsumaki Zankuu Kyaku
[Statedef 11250]
type = A
physics = A
movetype = A
anim = 11250
ctrl = 0
velset = (vel x) + ifelse(vel x >= 0, 2, -2), (vel y) - 3
poweradd = 72 * !var(21)
juggle = 8
sprpriority = 1


[State N, Sound]
type = PlaySnd
trigger1 = !Time
value = S7000,1
channel = 1

[State N, Sound]
type = PlaySnd
trigger1 = !Time
value = S8000,2
channel = 0

[State 200, Dampen]
Type=Varset
Trigger1 = MoveHit
fvar(39) = (FVar(39))*0.85
persistent = 0
ignorehitpause = 1

[State 1250, Strength]
type = varset
trigger1 = !time
var(0) = ifelse((command = "qcbc"), 2, ifelse(command = "qcbb", 1, 0))

[State 1250, slow]
type = veladd
trigger1 = 1
y = -const(movement.yaccel) * 0.5

[State 1250, Hit]
type = hitdef
trigger1 = animelem = 5 || animelem = 11 || animelem = 17 || animelem = 23
attr = A, SA
damage = 42, 7
animtype = Hard
guardflag = HA
hitflag = MAF
priority = 4, Hit
pausetime = ifelse(var(21), 7, 14), ifelse(var(21), 7, 14)
sparkno = s7001
sparkxy = -10, -6
hitsound = S7020,0
guardsound = s2, 0
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = -2*0.7, -7*0.6
air.type = Low
air.velocity = -2*0.7, -6*0.6
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.5
guard.cornerpush.veloff = 0;-12.74
getpower = ifelse(p2movetype = H, 72, 144) * !var(21), 36 * !var(21)
givepower = 36, 36
envshake.time = 16
envshake.freq = 120
envshake.ampl = 4
fall = 1
fall.recover = 1
fall.recovertime = 120
airguard.ctrltime = 16
airguard.velocity = ifelse(var(21), -4, -8)*0.6, -1.5*0.6
forcestand = 1
airguard.cornerpush.veloff = 0

[State 1250, hitb]
type = hitdef
trigger1 = animelem = 8 || animelem = 14 || animelem = 20 || animelem = 26
attr = A, SA
damage = 42, 7
animtype = Hard
guardflag = HA
hitflag = MAF
priority = 4, Hit
pausetime = ifelse(var(21), 7, 14), ifelse(var(21), 7, 14)
sparkno = s7001
sparkxy = -10, -6
hitsound = s7020,0
guardsound = s2, 0
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = 2*0.7, -7*0.6
air.type = Low
air.velocity = 2*0.7, -6*0.6
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.6
guard.cornerpush.veloff = 0;-12.74
getpower = ifelse(p2movetype = H, 72, 144) * !var(21), 36 * !var(21)
givepower = 36, 36
envshake.time = 16
envshake.freq = 120
envshake.ampl = 4
fall = 1
fall.recover = 1
fall.recovertime = 120
airguard.ctrltime = 16
airguard.velocity = ifelse(var(21), -4, -8)*0.6, -1.5*0.6
forcestand = 1
airguard.cornerpush.veloff = 0

[State Idle]
type = statetypeset
trigger1 = animelemtime(27) >= 0
movetype = I
;---------------------------------------------------------------------------
; Ashura Zenkuu
[Statedef 11400]
type = S
physics = N
movetype = I
anim = 11400
velset = 0, 0
ctrl = 0
sprpriority = -1
facep2 = 1

[State 1400, Strength]
type = varset
trigger1 = !time && !AIlevel
var(0) = ifelse(command = "dfbc", 3, ifelse(command = "dfab", 2, ifelse(command = "dbbc", -3, -2)))

[State 1400, Anim]
type = changeanim
trigger1 = !time && prevstateno = 195
value = 11400
elem = 3

[State 1400, afterimage]
type = afterimage
trigger1 = animelem = 3 && !var(21)
time = 2
timegap = 1
framegap = 6
length = ifelse((var(0) = 3 || var(0) = -3), 24, 18)
palbright = 0, 0, 0
paladd = 0, 0, 0
palmul = 0.9, 0.9, 0.9
palcontrast = 160, 160, 160
palpostbright = 0, 0, 0
trans = add1

[State -3, AfterImagePersist]
type = afterimagetime
trigger1 = 1
time = 2

[State 1400, Vel]
type = velset
trigger1 = animelemtime(2) > 0 && animelemtime(6) < 0
x = ifelse(var(0) = 3, -7, ifelse(var(0) = 2, -4, ifelse(var(0) = -3, 7, 4))) * sin((time -2) / 2) * 0.5

[State 1400, Vel]
type = velset
trigger1 = animelem = 6
x = ifelse(var(0) = 3, 14, ifelse(var(0) = 2, 9, ifelse(var(0) = -3, -14, -9)))  * 0.5

[State 1400, Vel]
type = velmul
trigger1 = animelemtime(6) > ifelse((var(0) = 3 || var(0) = -3), 16, 9)
x = 0.9

[State 1400, Push]
type = playerpush
trigger1 = animelemtime(3) >= 0
value = 0

[State 1400, nothitby]
type = nothitby
triggerall = animelemtime(6) <= ifelse((var(10) = 3 || var(10) = -3), 35, 20)
trigger1 = animelemtime(6) < 0
trigger2 = vel x < 0 && backedgebodydist > ifelse((var(10) = 3 || var(10) = -3), 14, 9)
trigger3 = vel x > 0 && frontedgebodydist > ifelse((var(10) = 3 || var(10) = -3), 14, 9)
value = SCA, AA, AP, AT
time = 1
ignorehitpause = 1

[State 1400, Turn]
type = turn
trigger1 = animelemtime(6) > 0 && p2dist x < 0

[State 1400, End]
type = changestate
trigger1 = animelemtime(6) = ifelse((var(10) = 3 || var(10) = -3), 40, 25)
trigger2 = animelemtime(6) > 0 && vel x < 0 && backedgebodydist <= 0
trigger3 = animelemtime(6) > 0 && vel x > 0 && frontedgebodydist <= 0
value = 0
ctrl = 1