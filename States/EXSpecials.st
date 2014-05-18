;===========================================================================
; Special Moves
;===========================================================================

;Gou Hadouken
[Statedef 11000]
type = S
physics = S
movetype = A
anim = 11000
ctrl = 0
velset = 0, 0
poweradd = 72 * !var(20)
sprpriority = 1
facep2 = 1

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
type = varadd
trigger1 = time && var(1) < 25
var(1) = 1

[State 1005, Vel]
type = velset
trigger1 = 1
x = ifelse(var(0) = 2, 6, ifelse(var(0) = 1, 4.5, 3)) * 0.8
y = 0

[State 1005, HitSound]
type = playsnd
trigger1 = movehit && numtarget
trigger1 = !(target, time) && target, movetype = H
value = 2, 7
channel = 1
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
ground.velocity = ifelse(var(1) <= 12, -4, -10.52) * 0.8, ifelse(var(1) <= 12, -2.5, 0) * 0.8
ground.cornerpush.veloff = 0
air.velocity = (-.75  * 0.8) * vel x , -2  * 0.8
fall = var(1) <= 12
air.fall = 1
fall.recover = 1
fall.recovertime = 16
getpower = ifelse(p2movetype = H, 72, 144) * !(root, var(20)), 36 * !(root, var(20))
givepower = 36, 36
envshake.time = 14
envshake.freq = 120
envshake.ampl = 4
p1sprpriority = 4
airguard.ctrltime = 16
airguard.velocity = ifelse((root, var(20)), -4, -8) * 0.8, -1.5 * 0.8
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
velset = 0.5*Vel X, 0
ctrl = 0
sprpriority = 4
movehitpersist = 1

[State 1006, End]
type = destroyself
trigger1 = !animtime
;---------------------------------------------------------------------------
; Gou Shoryuuken
[Statedef 11010]
type = S
physics = S
movetype = A
anim = 11010
ctrl = 0
velset = 0, 0
poweradd = 72 * !var(20)
juggle = ifelse((p2movetype = H && p2statetype = A), 7, 9)
facep2 = 1
sprpriority = 1

[State 1100, Strength]
type = VarSet
trigger1 = !Time
var(0) = IfElse(Command = "dfc", 2, IfElse(Command = "dfb", 1, 0))

[State 1100, nothitby]
type = NotHitBy
trigger1 = Anim = 11010 && AnimElemTime(4) < 0
value = SCA
time = 1
ignorehitpause = 1

[State 1100, Vel]
type = velset
trigger1 = anim = 11010 && AnimElem = 4
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
trigger1 = anim = 11010 && animelem = 3
value = 3, 9
channel = 0
ignorehitpause = 1
persistent = 0

[State 1100, Hit]
type = hitdef
trigger1 = animelem = 2 && anim = 11010
trigger2 = animelem = 3 && anim = 11010
attr = S, SA
damage = ifelse((animelem = 3), 27, 67 + 7 * var(0)), 7
animtype = Hard
fall.animtype = Hard
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = ifelse(var(20), 6, 12), ifelse(var(20), 5, 11)
sparkno = s7001
sparkxy = -7 + Random % 2 , ifelse((animelem = 2), -5, -10)
hitsound = s2, 3
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
getpower = ifelse(p2movetype = H, 72, 144) * !var(20), 36 * !var(20)
givepower = 36, 36
envshake.time = 16
envshake.freq = 120
envshake.ampl = 4
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
trigger1 = animelem = 4 && anim = 11010
attr = A, SA
damage = 20, 7
animtype = Back
guardflag = MA
hitflag = MAF
priority = 4, Hit
pausetime = ifelse(var(20), 8, 16), ifelse(var(20), 8, 16)
sparkno = s7001
sparkxy = -7 + Random % 2, -20
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = (-2 -(var(0) / 2)) * 0.8, (-6 -var(0)) * 0.8
air.type = Low
air.velocity = (-2 -(var(0) / 2)) * 0.8, (-6 -var(0)) * 0.8
ground.cornerpush.veloff = 0
guard.velocity = -10.52* 0.8
guard.cornerpush.veloff = 0;-12.74
getpower = ifelse(p2movetype = H, 72, 144) * !var(20), 36 * !var(20)
givepower = 36, 36
envshake.time = 16
envshake.freq = 120
envshake.ampl = 4
fall = 1
fall.recover = 1
fall.recovertime = 120
airguard.ctrltime = 16
airguard.velocity = ifelse(var(20), -4, -8) * 0.8, -1.5 * 0.8
forcestand = 1
airguard.cornerpush.veloff = 0

[State 1100, statetype]
type = statetypeset
trigger1 = anim = 11010 && animelemtime(4) >= 0
statetype = A
physics = A

[State 1100, Anim]
type = changeanim
trigger1 = anim = 11010 && animelemtime(4) > 0 && vel y > (ifelse(var(10) = 3, -5.3, ifelse(var(10) = 2, -4, -2.7))) * 0.8
value = 11011

[State Idle]
type = statetypeset
trigger1 = anim = 11101
movetype = I


;---------------------------------------------------------------------------