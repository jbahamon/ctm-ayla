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

ignorehitpause = 1
persistent = 0
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

[State 3050, Strength]
type = varset
trigger1 = var(10) != 5
var(10) = 5

[State 3050, Snd]
type = playsnd
trigger1 = animelem = 2
value = 4, 14
channel = 0
volume = 200

[State 3050, ECreset]
type = palfx
trigger1 = !time
time = 1

[State 3050, Super Pause FX]
type = helper
trigger1 = animelem = 2
helpertype = normal
stateno = 7500
ID = 7500
name = "Super Charge"
postype = p1
pos = 61, -51
ownpal = 1
persistent = 0
supermovetime = 9999
[State 3050, Super Pause]
type = superpause
trigger1 = animelem = 2
time = 45
anim = -1
sound = s7, 0
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
pos = 73, -43
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
