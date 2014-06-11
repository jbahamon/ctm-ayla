;===========================================================================
; Alternate Super Moves
;===========================================================================

; Messatsu Gou Hadou
[Statedef 13000]
type = S
physics = S
movetype = A
anim = 13000
ctrl = 0
velset = 0, 0
sprpriority = 1
facep2 = 1
poweradd = -1000

[State 2010, PalFx]
type = PalFX
trigger1 = Anim = 13000
trigger1 = (Time % 8 = 0)
time = 2
add = 200, 200, 200
mul = 256, 256, 256

[State 2010, Offset]
type = OffSet
trigger1 = Anim = 13000
X = (random % 8) - 4
Y = (random % 8) - 4

[State 3000, Strength]
type = varset
trigger1 = var(0) != 5
var(0) = 5

[State 3000, ECreset]
type = palfx
trigger1 = !time
time = 1

[State 2010, Super Pause FX]
type = helper
trigger1 = Anim = 13000 && AnimElem = 3
helpertype = normal
stateno = 7000
ID = 7000
name = "Super Charge"
postype = p1
pos = 0,0
ownpal = 1
persistent = 0
supermovetime = 9999

[State 2010, Super Pause]
type = superpause
trigger1 = Anim = 13000 && AnimElem = 3
time = 45
movetime = 45
anim = -1
sound = S7010,2
p2defmul = 1
darken = 0

[State Corner Push]
type = varset
trigger1 = anim = 13000 && animelem = 3
fvar(5) = 0

[State 3000, NHB]
type = nothitby
trigger1 = anim = 13000
trigger2 = anim = 13001 && animelemtime(2) < 1
time = 1
value = SCA

[State 3000, Anim]
type = changeanim
trigger1 = anim = 13000 && time = 48
value = 13001

[State 3000, hadouken]
type = helper
trigger1 = anim = 13001 && animelem = 2
helpertype = normal
stateno = 13005
ID = 13005
name = "Hadouken"
postype = p1
pos = 8, -22
ownpal = 1

[State 3000, Snd]
type = playsnd
trigger1 = anim = 13001 && animelem = 2
value = 3, 7
channel = 0
[State 3000, Snd]
type = playsnd
trigger1 = anim = 13001 && animelem = 2
value = 5, 0

[State 3000, End]
type = changestate
trigger1 = anim = 13001 && !animtime
value = 0
ctrl = 1

; Messatsu Gou Hadou Projectile
[Statedef 13005]
type = S
physics = N
movetype = A
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

[State 3005, HitOverride]
type = hitoverride
trigger1 = 1
time = -1
attr = SCA, AA, AP, AT
stateno = ifelse(var(2) < 8, 13005, 13006)
ignorehitpause = 1

[State 3005, hitby]
type = hitby
trigger1 = 1
time = -1
value = SCA, NP, SP, HP
ignorehitpause = 1

[State 3005, Strength]
type = varset
trigger1 = !time && !prevstateno
var(10) = 5

[State 3005, Anim]
type = changeanim
trigger1 = !time && !prevstateno
value = 13005

[State 3005, hitvar]
type = varadd
trigger1 = !time
var(2) = 1
[State 3005, movehitvar]
type = varset
trigger1 = movecontact && numtarget
trigger1 = !(target, ishelper)
var(3) = 1
ignorehitpause = 1

[State 3005, Vel]
type = velset
trigger1 = 1
x = ifelse((time < 2 && var(2) > 1), 1, 9)
y = 0

[State 3005, Trans]
type = assertspecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 1005, Trans]
type = Trans
trigger1 = 1
trans = addalpha
alpha = Floor(256 - 64*Abs(Sin(GameTime/5.0))), Floor(128*Abs(Sin(GameTime/5.0)))
ignorehitpause = 1

[State 3005, Hit]
type = hitdef
trigger1 = 1
priority = 4, Hit
attr = S, HP
damage = ceil(25 * root, fvar(39)), 4
animtype = Back
hitflag = MAF
guardflag = M
pausetime = 4 * (var(2) < 8), 6
sparkno = -1
sparkxy = -10, 0
guard.sparkno = s7001
guardsound = s2, 0
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = ifelse(var(2) < 8, -10.52, -6)*0.7, ifelse(var(2) < 8, 0, -4)*0.7
ground.cornerpush.veloff = 0
air.velocity = -6*0.7, -4*0.7
guard.velocity = -10.52*0.7
fall = (var(2) >= 8)
air.fall = 1
fall.recover = 0
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
palfx.sinadd = 64, 64, 64, 4
palfx.mul = 128, 128, 128
palfx.time = 32
p1sprpriority = 4
airguard.ctrltime = 16
airguard.velocity = ifelse((root, var(21)), -4, -8)*0.7, -1.5*0.7
forcestand = 1

[State 3005, Sparks]
type = explod
trigger1 = movehit && numtarget
trigger1 = !(target, time) && target, movetype = H
anim = 7001
ID = 7000
sprpriority = 5
postype = left
pos = ceil((target, pos x) -((target, const(size.ground.front) -10) * facing) + 160), ceil(screenpos y)
random = 4, 4
removetime = -2
ownpal = 1
facing = -1
ignorehitpause = 1
persistent = 0
pausemovetime = 100
supermovetime = 100

[State 3005, End]
type = changestate
trigger1 = movecontact
value = ifelse(var(2) < 8, 13005, 13006)

[State 3005, End]
type = destroyself
trigger1 = pos x != [ -280, 280]

; Messatsu Gou Hadou End
[Statedef 13006]
type = A
physics = N
movetype = I
anim = 7008
ctrl = 0
velset = 0, 0
sprpriority = 4

[State 3006, Trans]
type = trans
trigger1 = 1
trans = addalpha
alpha = 256, 256
ignorehitpause = 1

[State 3006, End]
type = destroyself
trigger1 = !animtime



; Tenma Gou Zankuu
[Statedef 13050]
type = A
physics = N
movetype = A
anim = 13050
ctrl = 0
velset = 0, 0
sprpriority = 1
poweradd = -1000

[State 2010, PalFx]
type = PalFX
trigger1 = Anim = 13050
trigger1 = AnimElemNo(0) < 8
trigger1 = (Time % 8 = 0)
time = 2
add = 200, 200, 200
mul = 256, 256, 256

[State 2010, Offset]
type = OffSet
trigger1 = Anim = 13050
trigger1 = AnimElemNo(0) < 8
X = (random % 8) - 4
Y = (random % 8) - 4

[State 3050, Strength]
type = varset
trigger1 = var(10) != 5
var(10) = 5

[State 3050, ECreset]
type = palfx
trigger1 = !time
time = 1

[State 3050, Super Pause FX]
type = helper
trigger1 = animelem = 2
helpertype = normal
stateno = 7000
ID = 7000
name = "Super Charge"
postype = p1
pos = 0, 0
ownpal = 1
persistent = 0
supermovetime = 9999

[State 3050, Super Pause]
type = superpause
trigger1 = animelem = 2
time = 45
anim = -1
p2defmul = 1
darken = 0
movetime = 45

[State Corner Push]
type = varset
trigger1 = animelem = 2
fvar(5) = 0

[State 3050, NHB]
type = nothitby
trigger1 = animelemtime(8) < 1
time = 1
value = SCA

[State 3050, hadouken]
type = helper
trigger1 = animelem = 8
helpertype = normal
stateno = 13055
ID = 13055
name = "Hadouken"
postype = p1
pos = 7, -10
ownpal = 1

[State 3050, Snd]
type = playsnd
trigger1 = animelem = 8
value = 4, 0
channel = 0

[State 3050, Snd]
type = playsnd
trigger1 = animelem = 8
value = 5, 0

[State 3050, Vel]
type = velset
trigger1 = animelem = 8
x = -1.5
y = -6

[State 3050, Type]
type = statetypeset
trigger1 = animelemtime(8) > 0
physics = A

;Tenma Gou Zankuu Projectile
[Statedef 13055]
type = A
physics = N
movetype = A
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


[State 3055, HitOverride]
type = hitoverride
trigger1 = 1
time = -1
attr = SCA, AA, AP, AT
stateno = ifelse(var(2) < 8, 13050, 13056)

ignorehitpause = 1
[State 3055, hitby]
type = hitby
trigger1 = 1
time = -1
value = SCA, NP, SP, HP
ignorehitpause = 1

[State 3055, Strength]
type = varset
trigger1 = !time && !prevstateno
var(10) = 5
[State 3055, Anim]
type = changeanim
trigger1 = !time && !prevstateno
value = 13055

[State 3055, hitvar]
type = varadd
trigger1 = !time
var(2) = 1
[State 3055, movehitvar]
type = varset
trigger1 = movecontact && numtarget
trigger1 = !(target, ishelper)
var(3) = 1
ignorehitpause = 1

[State 3055, Vel]
type = velset
trigger1 = 1
x = ifelse((time < 2 && var(2) > 1), 1, 7.4)*0.8
y = ifelse((time < 2 && var(2) > 1), 1, 5.2)*0.8


[State 1005, Trans]
type = Trans
trigger1 = 1
trans = addalpha
alpha = Floor(256 - 32*Abs(Sin(Time/5.0))), Floor(128*Abs(Sin(Time/5.0)))
ignorehitpause = 1

[State 1005, Trans]
type = AngleDraw
trigger1 = 1
value = -45
ignorehitpause = 1

[State 1005, Trans]
type = AssertSpecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 3055, Hit]
type = hitdef
trigger1 = 1
priority = 4, Hit
attr = A, HP
damage = ceil(25 * root, fvar(39)), 4
animtype = Back
hitflag = MAFD
guardflag = M
pausetime = 4 * (var(2) < 8), 6
sparkno = S7001
sparkxy = -15 + Random % 5, 4 - (Random % 5)
guardsound = s2, 0
ground.type = Low
ground.slidetime = 16
ground.hittime = 16
ground.velocity = ifelse(var(2) < 8, -10.52, -4)*0.8, ifelse(var(2) < 8, 0, -2)*0.8
ground.cornerpush.veloff = 0
air.velocity = -4, -2
down.velocity = 0, 0
down.hittime = 20
guard.velocity = -10.52
fall = (var(2) >= 8)
air.fall = 1
fall.recover = 0
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
palfx.sinadd = 64, 64, 64, 4
palfx.mul = 128, 128, 128
palfx.time = 32
p1sprpriority = 4
airguard.ctrltime = 16
airguard.velocity = ifelse((root, var(20)), -4, -8)*0.8, -1.5*0.8
forcestand = 1

[State 3055, End]
type = changestate
trigger1 = movecontact
value = ifelse(var(2) < 8, 13055, 13056)
[State 3055, End]
type = changestate
trigger1 = pos y >= 0
value = 13057
ignorehitpause = 1
[State 3055, End]
type = destroyself
trigger1 = pos x != [ -280, 280]

;Tenma Gou Zankuu GetHit
[Statedef 13056]
type = A
physics = N
movetype = I
anim = 7001
ctrl = 0
velset = 0, 0
sprpriority = 4

[State 1005, Trans]
type = AssertSpecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 3056, End]
type = destroyself
trigger1 = !animtime

;Tenma Gou Zankuu GetHit
[Statedef 13057]
type = A
physics = N
movetype = I
anim = 7006
velset = 0, 0
ctrl = 0
sprpriority = 4

[State 1005, Trans]
type = AssertSpecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 3057, Pos]
type = posset
trigger1 = 1
y = 5

[State 3057, End]
type = destroyself
trigger1 = !animtime

; Messatsu Gou Shoryuu
[Statedef 13100]
type = S
physics = S
movetype = A
ctrl = 0
anim = 13100
velset = 0, 0
juggle = ifelse((prevstateno = [11000, 14999]), 0, 6) * !var(21)
sprpriority = 1
facep2 = 1
poweradd = -1000

[State 2010, PalFx]
type = PalFX
trigger1 = Anim = 13100
trigger1 = AnimElemNo(0) = 1
trigger1 = (Time % 8 = 0)
time = 2
add = 200, 200, 200
mul = 256, 256, 256

[State 2010, Offset]
type = OffSet
trigger1 = Anim = 13100
trigger1 = AnimElemNo(0) = 1
X = (random % 8) - 4
Y = (random % 8) - 4

[State 1001, Dampen]
Type = Varset
Trigger1 = MoveHit
trigger1 = !(target, time) && target, movetype = H
fvar(39) = Fvar(39)*0.85
persistent = 0
ignorehitpause = 1


[State 3100, Strength]
type = varset
trigger1 = var(10) != 5
var(10) = 5

[State 3100, ECreset]
type = palfx
trigger1 = !time
time = 1

[State 3100, Super Pause FX]
type = helper
trigger1 = anim = 13100 && animelemtime(1) = 2
helpertype = normal
stateno = 7000
ID = 7000
name = "Super Charge"
postype = p1
pos = 12, -54
ownpal = 1
persistent = 0
supermovetime = 9999

[State 3100, Super Pause]
type = superpause
trigger1 = anim = 13100 && animelemtime(1) = 2
time = 45
movetime = 45
anim = -1
p2defmul = 1
darken = 0

[State Corner Push]
type = varset
trigger1 = anim = 13100 && animelemtime(1) = 2
fvar(5) = 0

[State 3100, NHB]
type = nothitby
trigger1 = anim = 13100 && animelemtime(4) < 0
time = 1
value = SCA
ignorehitpause = 1

[State 3100, Vel]
type = velset
trigger1 = anim = 13100 && (animelem = 2 || animelem = 14)
x = 12*0.6

[State 3100, Vel]
type = velset
trigger1 = anim = 13100 && animelem = 26
x = 19*0.6

[State 3100, Vel]
type = velset
trigger1 = anim = 13100 && animelemtime(28) = 1
x = 18*0.6
y = -11*0.6

[State 3100, Vel]
type = velmul
trigger1 = vel y < 0
x = 0.86

[State 3100, Vel]
type = velmul
trigger1 = vel y > 0
x = 0

[State 3100, width]
type = width
trigger1 = vel y < 0
edge = 6,6

[State 3100, hitlow]
type = hitdef
trigger1 = animelem = 14 && anim = 13100
attr = S, HA
damage = 33, 7
animtype = Medium
fall.animtype = Medium
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = ifelse((animelem = 24), 18, 6), ifelse((animelem = 24), 18, 6)
sparkno = s7001
sparkxy = -6, -15
ground.type = Low
ground.slidetime = 20
ground.hittime = 20
ground.velocity = -4*0.8, 0
air.velocity = -4*0.8, -2*0.8
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
air.fall = 1
fall.recover = 0
forcestand = 1
airguard.ctrltime = 16
airguard.cornerpush.veloff = 0
airguard.velocity = -8*0.8, -1.5*0.8
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 3100, hitlow2]
type = hitdef
trigger1 = (animelem = 3 || animelem = 15) && anim = 13100
attr = S, HA
damage = 33, 7
animtype = Hard
fall.animtype = Hard
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 6, 6
sparkno = s7001
sparkxy = -6, -17
ground.type = Low
ground.slidetime = 20
ground.hittime = 20
ground.velocity = -4*0.8, 0
air.velocity = -4*0.8, -2*0.8
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
air.fall = 1
fall.recover = 0
forcestand = 1
airguard.ctrltime = 16
airguard.cornerpush.veloff = 0
airguard.velocity = -8*0.8, -1.5*0.8
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 3100, hitlow3]
type = hitdef
trigger1 = animelem = 26 && anim = 13100
attr = S, HA
damage = 33, 7
animtype = Medium
fall.animtype = Medium
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 18, 18
sparkno = s7001
sparkxy = -6, -15
ground.type = Low
ground.slidetime = 20
ground.hittime = 20
ground.velocity = 0.5*0.8, -6*0.8
air.velocity = 0.5*0.8, -6*0.8
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.8
guard.cornerpush.veloff = 0;-12.74
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
fall = 1
fall.recover = 0
forcestand = 1
airguard.ctrltime = 16
airguard.cornerpush.veloff = 0
airguard.velocity = -8*0.8, -1.5*0.8
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 3100, hitlow4]
type = hitdef
trigger1 = animelem = 27 && anim = 13100
attr = S, HA
damage = 33, 7
animtype = Hard
fall.animtype = Hard
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 18, 18
sparkno = s7001
sparkxy = -6, -17
ground.type = Low
ground.slidetime = 20
ground.hittime = 20
ground.velocity = 0.5*0.8, -6*0.8
air.velocity = 0.5*0.8, -6*0.8
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.8
guard.cornerpush.veloff = 0;-12.74
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
fall = 1
fall.recover = 0
forcestand = 1
airguard.ctrltime = 16
airguard.cornerpush.veloff = 0
airguard.velocity = -8*0.8, -1.5*0.8
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 3100, hithigh]
type = hitdef
trigger1 = (animelem = 4 || animelem = 16) && anim = 13100
attr = S, HA
damage = 33, 7
animtype = Hard
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 6, 6
sparkno = s7001
sparkxy = -6, -20
ground.type = High
ground.slidetime = 20
ground.hittime = 20
ground.velocity = -4*0.8, 0
air.velocity = -4*0.8, -2*0.8
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
air.fall = 1
fall.recover = 0
forcestand = 1
airguard.ctrltime = 16
airguard.cornerpush.veloff = 0
airguard.velocity = -8*0.8, -1.5*0.8
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 3100, hitfinal]
type = hitdef
trigger1 = animelem = 28 && anim = 13100
persistent = 0
attr = A, HA
damage = 33, 7
animtype = Back
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 2, 2
sparkno = s7001
sparkxy = -6, -20
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = -4.5*0.8, -8*0.8
air.velocity = -4.5*0.8, -8*0.8
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.8
guard.cornerpush.veloff = 0;-12.74
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 7
fall = 1
fall.recover = 0
airguard.ctrltime = 16
airguard.velocity = ifelse(var(20), -4, -8)*0.8, -1.5*0.8
forcestand = 1
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 3100, statetype]
type = statetypeset
trigger1 = anim = 13100 && animelemtime(28) >= 1
statetype = A
physics = A
[State 3100, Anim]
type = changeanim
trigger1 = anim = 13100 && animelemtime(28) > 2 && vel y > -5.5*0.8
value = 11101

[State Idle]
type = statetypeset
trigger1 = anim = 11101
movetype = I



; Messatsu Gou Rasen
[Statedef 13200]
type = S
physics = S
movetype = A
anim = 13200
ctrl = 0
velset = 0, 0
juggle = ifelse((prevstateno = [11000, 14999]), 0, 6) * !var(21)
sprpriority = 1
facep2 = 1
poweradd = -1000

[State 2010, PalFx]
type = PalFX
trigger1 = Time < 45
trigger1 = (Time % 8 = 0)
time = 2
add = 200, 200, 200
mul = 256, 256, 256

[State 2010, Offset]
type = OffSet
trigger1 = Time < 45
X = (random % 8) - 4
Y = (random % 8) - 4

[State 1001, Dampen]
Type = Varset
Trigger1 = MoveHit
trigger1 = !(target, time) && target, movetype = H
fvar(39) = Fvar(39)*0.85
persistent = 0
ignorehitpause = 1

[State 3200, Strength]
type = varset
trigger1 = var(10) != 5
var(10) = 5

[State 3200, ECreset]
type = palfx
trigger1 = !time
time = 1

[State 3200, Super Pause FX]
type = helper
trigger1 = anim = 13200 && animelem = 2
helpertype = normal
stateno = 7000
ID = 7000
name = "Super Charge"
postype = p1
pos = -32, -8
ownpal = 1
persistent = 0
supermovetime = 9999

[State 3200, Super Pause]
type = superpause
trigger1 = anim = 13200 && animelem = 2
time = 45
anim = -1
p2defmul = 1
darken = 0
movetime = 45

[State Corner Push]
type = varset
trigger1 = anim = 13200 && animelem = 2
fvar(5) = 0

[State 3200, NHB]
type = nothitby
trigger1 = anim = 13200
trigger2 = anim = 13201 && animelemtime(2) < 0
time = 1
value = SCA
ignorehitpause = 1

[State 3200, Vel]
type = velset
trigger1 = anim = 13200 && animelem = 10
x = 0
y = -8*0.8

[State 3200, Vel]
type = velset
trigger1 = anim = 13201 && vel y > 0
y = 0

[State 3200, Vel]
type = veladd
trigger1 = anim = 13201 && vel y < 0
y = 0.14

[State 3200, ctrlvel]
type = veladd
trigger1 = anim = 13201 && (vel x = [ -1.33, 1.33]) && vel y < 0
x = ifelse(command = "holdfwd", 0.15, ifelse(command = "holdback", -.15, 0))

[State 3200, statetype]
type = statetypeset
trigger1 = anim = 13200 && animelemtime(8) > 0
statetype = A
physics = N
[State 3200, Anim]
type = changeanim
trigger1 = anim = 13200 && !animtime
value = 13201
[State 3200, Anim]
type = changeanim
trigger1 = anim = 13201 && !animtime
value = 13205
persistent = 0
[State 3200, statetype]
type = statetypeset
trigger1 = anim = 13205
statetype = A
physics = A

[State 3200, spin]
type = playsnd
triggerall = anim = 13201
trigger1 = animelem = 1 || animelem = 7 || animelem = 13 || animelem = 19 || animelem = 25
trigger2 = animelem = 31 || animelem = 37 || animelem = 43 || animelem = 49 || animelem = 55
value = 1, 5
channel = 1

[State 3200, 1sthit]
type = hitdef
trigger1 = anim = 13200 && animelem = 8
attr = S, HA
damage = 25, 5
animtype = Hard
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 16, 16
sparkno = s7001
sparkxy = -7, -6
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = ifelse(p2bodydist x > 15, 2, 0)*0.8, -6*0.8
air.type = Low
air.velocity = ifelse(p2bodydist x > 15, 2, 0)*0.8, -5*0.8
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.8
guard.cornerpush.veloff = 0;-12.74
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
fall = 1
fall.recover = 0
forcestand = 1
airguard.ctrltime = 16
airguard.cornerpush.veloff = 0
airguard.velocity = -8*0.8, -1.5*0.8
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 3200, mainhits]
type = hitdef
triggerall = anim = 13201
trigger1 = animelem = 2 || animelem = 8 || animelem = 14 || animelem = 20
trigger2 = animelem = 26 || animelem = 32 || animelem = 38 || animelem = 44 || animelem = 50
attr = A, HA
damage = 25, 5
animtype = Up
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 2, 2
sparkno = s7001
sparkxy = -6, -6
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = ifelse(p2bodydist x > 15, 1.5, 0)*0.8, -10*0.8
air.type = Low
air.velocity = ifelse(p2bodydist x > 15, 1.5, 0)*0.8, (vel y - 1.5*0.8)
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.8
guard.cornerpush.veloff = 0;-12.74
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
fall = 1
fall.recover = 0
airguard.ctrltime = 16
airguard.velocity = ifelse(var(21), -4, -8)*0.8, -1.5*0.8
forcestand = 1
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8

[State 3200, mainhitsb]
type = hitdef
triggerall = anim = 13201
trigger1 = animelem = 5 || animelem = 11 || animelem = 17 || animelem = 23
trigger2 = animelem = 29 || animelem = 35 || animelem = 41 || animelem = 47
attr = A, HA
damage = 25, 5
animtype = Up
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 2, 2
sparkno = s7001
sparkxy = -6, -6
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = ifelse(p2bodydist x > 15, 1.5, 0)*0.8, -10*0.8
air.type = Low
air.velocity = ifelse(p2bodydist x > 15, 1.5, 0)*0.8, (vel y - 1.5*0.8)
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.8
guard.cornerpush.veloff = 0;-12.74
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
fall = 1
fall.recover = 0
airguard.ctrltime = 16
airguard.velocity = ifelse(var(21), -4, -8)*0.8, -1.5*0.8
forcestand = 1

[State 3200, lasthit]
type = hitdef
trigger1 = anim = 13201 && animelem = 56
attr = S, HA
damage = 25, 5
animtype = Diagup
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 24, 24
sparkno = s7001
sparkxy = -6, -7
hitsound = s2, 6
guardsound = s2, 0
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = -7*0.8, -2*0.8
air.type = Low
air.velocity = -7*0.8, -2*0.8
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.8
guard.cornerpush.veloff = 0;-12.74
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 7
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
fall = 1
fall.recover = 0
airguard.ctrltime = 16
airguard.velocity = ifelse(var(21), -4, -8)*0.8, -1.5*0.8
forcestand = 1

[State Idle]
type = statetypeset
trigger1 = anim = 13205
movetype = I

; Messatsu Gou Senpuu
[Statedef 13250]
type = A
physics = N
movetype = A
anim = 13250
ctrl = 0
velset = 0, 0
juggle = ifelse((prevstateno = [11000, 14999]), 0, 6) * !var(21)
sprpriority = 1
poweradd = -1000

[State 1001, Dampen]
Type = Varset
Trigger1 = MoveHit
trigger1 = !(target, time) && target, movetype = H
fvar(39) = Fvar(39)*0.85
persistent = 0
ignorehitpause = 1

[State 3250, Strength]
type = varset
trigger1 = var(10) != 5
var(10) = 5

[State 3250, ECreset]
type = palfx
trigger1 = !time
time = 1

[State 3250, Super Pause FX]
type = helper
trigger1 = anim = 13250 && animelem = 3
helpertype = normal
stateno = 7000
ID = 7000
name = "Super Charge"
postype = p1
pos = -34, -63
ownpal = 1
persistent = 0
supermovetime = 9999

[State 3250, Super Pause]
type = superpause
trigger1 = anim = 13250 && animelem = 3
time = 45
movetime = 45
anim = -1
sound = s7, 0
p2defmul = 1
darken = 0

[State 2010, PalFx]
type = PalFX
trigger1 = Time < 45
trigger1 = (Time % 8 = 0)
time = 2
add = 200, 200, 200
mul = 256, 256, 256

[State 2010, Offset]
type = OffSet
trigger1 = Time < 45
X = (random % 8) - 4
Y = (random % 8) - 4


[State Corner Push]
type = varset
trigger1 = anim = 13250 && animelem = 3
fvar(5) = 0

[State 3250, NHB]
type = nothitby
trigger1 = anim = 13250
trigger2 = anim = 13251 && animelemtime(2) < 0
time = 1
value = SCA
ignorehitpause = 1

[State 3250, Vel]
type = velset
trigger1 = anim = 13250
x = 0
y = 0

[State 3250, Vel]
type = velset
trigger1 = anim = 13251 && animelemtime(15) < 0 && pos y < -10
y = ifelse(animelemtime(9) < 0, 0.33, 0.1)*0.8

[State 3250, Vel]
type = velset
trigger1 = anim = 13251 && animelem = 15
x = 0
y = -4

[State 3250, Vel]
type = veladd
trigger1 = anim = 13251 && animelemtime(15) >= 0 && vel y < 0
y = 0.05

[State 3250, ctrlvel]
type = veladd
trigger1 = anim = 13251 && (vel x = [ -1.33, 1.33]) && vel y < 0
x = ifelse(command = "holdfwd", 0.15, ifelse(command = "holdback", -.15, 0))

[State 3250, Anim]
type = changeanim
trigger1 = anim = 13250 && !animtime
value = 13251

[State 3250, Anim]
type = changeanim
trigger1 = anim = 13251 && !animtime
value = 13205

persistent = 0
[State 3250, statetype]
type = statetypeset
trigger1 = anim = 13205
statetype = A
physics = A

[State 3250, mainhits]
type = hitdef
triggerall = anim = 13251
trigger1 = animelem = 2 || animelem = 8 || animelem = 14 || animelem = 20 || animelem = 26
trigger2 = animelem = 32 || animelem = 38 || animelem = 44 || animelem = 50 || animelem = 56
attr = A, HA
damage = 24, 5
animtype = Up
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 2, 2
sparkno = s7001
sparkxy = -7, -6
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = ifelse(p2bodydist x > 15, 1.5, 0)*0.8, -10*0.3
air.type = Low
air.velocity = ifelse(p2bodydist x > 15, 1.5, 0)*0.8, (vel y - 1.5*0.8)
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.8
guard.cornerpush.veloff = 0;-12.74
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 6
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
fall = 1
fall.recover = 0
airguard.ctrltime = 16
airguard.velocity = ifelse(var(21), -4, -8)*0.8, -1.5*0.8
forcestand = 1

[State 3250, lasthit]
type = hitdef
trigger1 = anim = 13251 && animelem = 62
attr = S, HA
damage = 24, 5
animtype = Diagup
guardflag = M
hitflag = MAF
priority = 4, Hit
pausetime = 24, 24
sparkno = s7001
sparkxy = -6, -7
hitsound = s2, 6
guardsound = s2, 0
ground.type = High
ground.slidetime = 16
ground.hittime = 16
ground.velocity = -7*0.8, -2*0.8
air.type = Low
air.velocity = -7*0.8, -2*0.8
ground.cornerpush.veloff = 0
guard.velocity = -10.52*0.8
guard.cornerpush.veloff = 0;-12.74
getpower = 0
givepower = 36, 36
envshake.time = 18
envshake.freq = 120
envshake.ampl = 7
palfx.add = 200, 200, 200
palfx.mul = 256, 256, 256
palfx.time = 8
fall = 1
fall.recover = 0
airguard.ctrltime = 16
airguard.velocity = ifelse(var(21), -4, -8)*0.8, -1.5*0.8
forcestand = 1

[State Idle]
type = statetypeset
trigger1 = anim = 13205
movetype = I


