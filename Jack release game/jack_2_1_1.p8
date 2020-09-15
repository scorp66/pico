pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
hero = {}
dbg = false
movement = {}
col = {} 
max_colide_count = 2
hero.hp = 3
cartdata ( "jack" )
maxlvc = dget(1)
record_score = dget(0)
hero.is_crouch = false
hero.coins = 0;
hero.s = 0
hero.x = 2*8
hero.y = 23*8
str_game = false
power_f= dget(2)==1
startl = {}
startl.x = hero.x
startl.y = hero.y
finstr = {}
finstr.x = 2
finstr.y = 61
last_h = {}
last_h.hp = 3
last_h.coins = 0
last_h.s = 0
skil_rest = 0
d_timer = 0
g_time = 1
start_mode = 0
movement.x = hero.x
movement.y = hero.y
dash = 0
dash_sg = 20
hero.sx = 1
hero.sy = 1 
jump_power = 3.9
hero.on_flore = false
time_damage = 1
second_save = 3
save_ef_speed = 21
save_form = false
img = 0
max_frame = 3
last = 0
ft_lvl = {{}}
for x=0,38,1 do
ft_lvl[x]= {}
for y=0,25,1 do
ft_lvl[x][y]=mget(x,y)
end
end
levels=
{"64x114 , 81 68x18 81 68x93 81 , 81 68x18 81 68x93 81 , 81 68x18 81 68x93 81 , 81 68 69 118 102 69 68x13 81 68x93 81 , 81 68x2 118 102 68x14 81 68x93 81 , 81 68x2 118 102 68x9 80 68x4 81 68x52 64x5 68x3 80 68x32 81 , 64x16 68x3 81 68x52 81 68x4 64x4 68x32 81 , 0x15 81 68x3 81 28 13 28 68x28 64x4 68x17 81 68x8 64x4 68x3 80 68x24 81 , 0x15 81 68x3 64x6 68x4 64x5 68x24 64x4 68x3 64x5 68x2 81 68x12 64x4 68x3 80 68x18 28 68 81 , 0x15 81 68x13 98x4 81 68x4 64x6 68x28 81 68x16 64x4 68x3 80 68x13 28 68 28 81 , 0x15 81 68x17 81 68x13 64x3 68x22 81 68x20 64x4 68x14 28 68 81 , 0x15 81 68x17 81 68x38 81 68x24 64x8 68x4 64x5 , 0x15 81 68x17 81 68x38 81 68x31 81 68x4 81 , 0x15 81 68x17 81 68x38 81 68x31 81 68x4 81 , 0x15 81 68x13 80x4 81 68x7 81 68x12 81 68x6 80 68x10 81 68x31 81 68x4 81 , 0x15 64x10 112x3 64x6 112x2 64x69 68x4 81 , 0x33 81 68x33 81 68x41 81 , 0x33 81 68x33 81 68x41 81 , 0x33 81 68x33 81 68x41 81 , 0x33 81 68x33 81 68x41 81 , 0x33 81 68x33 81 68x41 81 , 0x33 81 68 69 99 117 69 68x70 81 , 0x33 81 68x2 99 117 68x33 64x5 80x3 64x4 80x2 64x3 80x3 64x3 80x2 64x2 80x3 64x9 , 0x33 81 68x2 99 117 68x6 81 68x31 64x27 , 0x33 64x17 68x26 81 , 0x49 81 68x23 28 13 28 81 , 0x49 81 68x23 13 28 13 81 , 0x49 81 68x21 64x6 , 0x49 81 68x21 81 , 39x49 81 80 68x3 80x1 68x4 80x2 68x3 80x2 68x3 80x2 81 , 39x49 64x2 112x3 64x7 112x3 64x2 112x3 64x3 ",
"64x43 , 81 68x7 81 68x13 81 68x19 81 , 81 68x7 81 68x4 65x3 69 68x4 69 81 68x2 69 68 65 68 69 68 65 68 65 68x2 69 68x3 69 68 81 , 81 68x7 81 68x3 65x2 68 65x2 68x5 81 68x9 65x4 68x6 81 , 81 68x7 81 68x3 65 68x4 65 68 65x2 68 81 68x4 69 68x3 69 99 117 69 65 68x6 81 , 81 69 118 102 69 68x3 81 68x2 65x2 68x5 65 68x2 65 81 68x9 99 117 65x3 68x5 81 , 81 68 118 102 68x4 81 68x4 28 68 80 68 28 65 80 68x2 81 68x6 80x3 99 117 65 68x4 28 69 68 81 , 81 68 118 102 68x4 81 68x3 81 64x6 81 68 65 81 68x2 81 68x3 81 64x8 81 68x3 81 , 81 64x3 81 68x3 81 68x3 81 68x6 81 68 65 81 68x2 81 68x3 81 68x8 81 68x3 81 ,81 68 28 68 81 68x3 81 68x3 81 68x4 66 67 81 68 65 68x3 81 68x3 81 68x8 81 68x2 28 81 , 81 28x3 81 68 69 68 81 68 69 68 81 68 69 68x2 82 83 81 68 69 68x3 81 68x3 81 68x3 10 68x2 65x2 68x2 69 33 81 , 81 68x3 81 68x3 81 68x3 81 68x6 81 68 65 68x3 81 68x3 81 64x8 81 68x3 81 , 81 68x3 81 68x3 81 68x3 81 68x6 33 68 65 68x3 81 68x12 81 68x3 81 , 81 68x3 81 68x3 81 68x3 81 68x4 66 67 68x2 65 68x3 81 68x12 81 68x3 81 , 81 68x3 81 68 69 68 81 68 69 68 81 68 69 68x2 82 83 68x2 69 68x2 33 81 68x7 69 68x2 65x2 81 68 69 28 81 , 81 68x3 81 68x3 81 68x3 81 68x3 64x3 81 68x5 81 68x10 65x2 81 68x3 81 , 81 68x3 81 68x3 81 68x3 81 68x4 28 68 81 68x2 81 68x2 81 68x10 65 68 81 68x3 81 , 81 68x3 81 68x3 81 68x3 81 68x4 28 68 81 68x5 81 64x9 68x3 81 65 68x2 81 , 81 68 69 68 81 68 69 68 81 68x3 81 64x4 68x2 81 68 69 68x3 81 68x12 81 68 69 68 81 , 81 68x3 81 68x3 81 68x3 81 68x6 81 68x5 81 68x11 65 81 28 68x2 81 , 81 68x3 81 68x3 81 68x3 81 68x6 81 68x5 81 68 65 68x4 69 68x5 81 68x3 81 , 81 68x3 81 68x3 81 68x3 81 68x6 81 68x5 81 68x5 64x7 81 68x3 81 , 81 68 69 68x7 69 68x6 69 68 81 68 69 68x3 81 68x12 81 68 69 68 81 , 81 68x14 86 68x3 81 68x2 86 68x15 81 68x3 81 , 81 64x15 68x3 81 64x11 81 68x2 65 68x3 81 68x3 81 , 81 68x9 65 68x8 81 68x11 81 65x3 68x7 81 , 81 68x9 65 68x8 81 68x11 81 65x3 68x7 81 , 81 68x9 65 68x8 81 68x11 81 65x3 68x7 81 , 81 68x9 65 68x8 65 68x11 81 65x3 68x7 81 , 81 68x4 69 68x7 69 33 68x9 81 68x3 68 86 68 81 65 68x4 65x2 68 65 68 81 , 81 68x2 13 68x20 81 69 87 69 81 64 81x2 68x6 86 68x3 81 , 81 64x26 81x2 64 81x2 64x10 81 ",
"81 , 81 68x33 81 , 81 68x5 66 67 68x4 66 67 68x2 65 68x17 81 , 81 68x5 82 83 68x4 82 83 68x2 65x2 68x12 69 99 117 69 81 , 81 65 68x2 64x12 68 65x2 68x9 81 68x2 99 117 68 81 , 81 65x3 81 39x3 94 95 39x3 78 79 39 68x12 81 68x2 99 117 68 81 , 81 68 65 68 81 39x8 94 95 39 68x10 64x9 , 81 65x2 68 81 39x11 81 68x8 , 81 68 65 68 81 39x11 81 68x5 112x3 , 81 68 65x2 81 39x11 81 68x5 39x3 , 81 68 65 68 81 39x11 64 112x5 39x3 , 81 68 65 68 81 39x20 , 81 68 65x2 81 39x20 , 81 65x3 81 39x20 , 81 68 65 68 81 39x20 , 81 65 68 65 68 39x19 78 79 78 79 39x16 81 64x2 81 , 81 68x2 65 101 39x2 81 39x16 94 95 94 95 39x16 81 98x2 81 , 81 68x4 39x2 81 39x14 78 79 78 79 39x18 81 28x2 81 , 81 64x7 39x8 78 79 78 79 78 79 94 95 94 95 39x18 81 68x2 81 , 81 68x4 81 39x10 94 95 94 95 94 95 39x22 81 68x2 81 , 81 68 118 102 68 81 39x38 81 66 67 81 , 81 68 118 102 68 81 39x2 112x4 39x32 81 82 83 81 , 81 68 118 102 68 81 39x2 64x4 39x14 75 39x3 64x2 39x12 81 68x2 81 , 81 68x4 81 39x7 112x3 64x4 39x3 64x9 39x5 78 79 78 79 39x3 81 68x2 81 , 81 68x4 81 39x7 78 79 78 79 94 95 81 39x3 81 39x13 94 95 94 95 78 79 78 81 68x2 81 , 81 68x4 81 39x7 94 95 94 95 39x2 81 39x3 81 39x9 112x3 39x5 94 95 94 81 68x2 81 , 81 68x4 81 39x13 81 39x3 81 39x20 81 68 65 81 , 81 68x4 81 39x13 81 75x3 81 39x10 78 79 78 112x2 39x5 81 65x2 81 , 81 68x4 81 39x13 64x5 39x10 94 95 94 64x2 39x5 68 65 68 81 , 81 68x4 81 68x2 81 39x12 91 39x22 65x2 68 81 , 81 68x4 81 68x2 81 39x35 68x3 81 , 81 68x4 81 68x2 81 39x32 64x6 81 , 81 68x4 81 68 65 81 39x32 81 91x5 81 , 81 65x2 68x2 81 68 65 81 39x10 74 39x3 78 79 39x11 64x6 39x5 81 , 81 68 65 101 68x2 65x2 81 39x2 74 39x4 75 39x6 94 95 39 75 39x10 91x5 39x5 81 , 81 68x2 65x4 68 81 39x5 78 79 81 39x2 78 79 75 39x4 81 39x4 75 39x4 81 75x10 81 , 64x48 ",
"81 39x23 81 39x7 81 39x7 81 39x7 81 39x13 81 , 81 39x23 81 39x3 74 39x3 81 39 78 79 39x4 81 39x4 74 39x2 81 39x13 81 , 81 39x4 78 79 39x3 74 39x3 74 39x2 78 79 39x5 81 39x7 81 39 94 95 39 74 39x2 81 39x7 81 39x9 74 39x3 81 , 81 39x2 74 39 94 95 39x10 94 68 69 68 39 74 39 81 68x3 69 68x3 81 39x7 81 68x7 81 39 78 79 39 74 39x8 81 , 81 78 79 39x4 74 39x3 74 39x6 69 68 69 39x3 81 65x2 68x3 65x2 81 39x2 74 39x4 81 68x7 81 39 94 95 39x8 74 39 81 , 81 94 95 39x11 69 86 68 39 69 119 69 39x3 81 68x2 28 65 68 65 68 81 39x7 81 68x7 81 39x13 81 , 81 68x6 39x7 68x3 39 81 64 81 39x3 68x4 65x2 68x3 39x7 68x9 39 74 39x3 90 39x7 81 , 81 68 69 118 102 69 68 65 68x3 64x48 39x3 81 , 81 68x2 118 102 101 65x2 68x3 81 68x5 81 68x40 81 39x3 81 , 81 68x2 118 102 68x8 28 13 28 68 81 68x40 81 39x3 81 , 64x59 39x3 81 , 68x23 81 68x11 81 68x4 81 39x5 81 68x6 81 39x8 81 , 68x23 81 68 65x2 68x5 65x2 68 81 68 65x2 68 81 39 74 78 79 39 81 68x3 65x2 68 81 39x4 78 79 39x2 81 , 68x23 81 68x3 28 68 69 68x3 65 68 81 65 69 68 65 81 39x2 94 95 39 81 65x2 69 68 65 68 81 39x2 74 39 94 95 39x2 81 , 68x23 81 68 65 68x5 65x2 68x2 81 65 68x3 81 39x3 74 39 81 65 68x5 81 39x2 78 79 39x4 81 , 68x23 81 65x2 68x3 65x2 68 65 33 68 81 68x2 28 68 81 39x5 81 68x3 28 68x2 81 39x2 94 95 39 74 39x2 81 , 68x23 81 68 65x2 68x9 65 68x4 39x5 68x8 39x8 81 , 68x23 81 68x3 64x75 , 68x23 81 68x4 65 68x3 81 68x6 81 68x6 81 68x14 65x2 81 68x5 65x3 68 81 68x7 81 68 65x2 68x4 81 68x4 65x2 68x5 81 , 68x23 81 68x5 65x2 68 81 68x3 65x3 81 68x2 65x3 68 81 68 65x2 68x2 65 68 65x2 68x5 65 68 81 68x9 81 65 68x3 65x2 68 81 65x4 68x3 81 68x2 65x2 68x7 81 , 68x23 81 65x2 68x2 69 68x3 81 68 65x2 69 68x2 81 68 65x2 69 68x2 81 68x3 69 68 65 68 69x2 68 65x2 68 69 68x2 81 68x4 28 68x2 65 68 81 68x3 28 68 65 68 81 68x3 28 68x3 81 68x4 69 68x2 28 68x3 81 , 68x23 81 65 68x7 81 68x6 81 68x6 81 68 65 68x4 69 68x2 69 68 65 68x4 81 68 65x2 68x6 81 68x6 65 81 68x5 65x2 81 68 65 68x7 65x2 81 , 68x23 81 68x4 65 68x3 98 68x2 28 68x2 65 98 68x2 28 68x3 98 68x3 13 68x3 69x2 68x2 65x3 68x2 98 68 65x2 68x3 65 68x2 98 68 65x2 68x4 98 68x3 80 68x3 98 68x3 13 68x3 65x2 68 65 81 , 68x23 81 68x8 65x2 68x21 86 68x8 65x2 68x2 80 68 65x2 68x5 80 68x7 81 68x15 81 , 68x23 64x75 68x3 81 , 64x6 68x91 81 68x2 65 81 , 81 65x2 68x2 81 68x91 81 65 68x2 81 , 81 69 65x2 69 81 68x73 64x18 81 68x2 65 81 , 81 68 99 117 68 81 64x26 68x5 52 64x8 68x2 64x3 68x6 64x22 68x2 65x2 68x2 81 68x2 65x2 68x2 81x2 65x3 68x3 65 81 , 81 65 99 117 65x2 68x2 13 68 65x2 68 98 68x4 98 68x4 98 68x2 65x2 68 65 68x2 64x6 68x3 65x2 68x3 64x2 68x3 64x6 68x2 65x2 68 65 68x3 98x3 68 65x2 68 65 68x4 81 68x6 98 68x2 65 68x3 98x2 68x2 65 68 101 68x2 81 , 81 68 99 117 68x7 65 68x3 65 68x3 65 68 65x2 68x10 65 68x2 13 68x2 65x2 68x4 65 68x2 65 86 65x2 68x2 65x2 68x7 65 68x7 65x3 68x5 65 68x2 65 68x4 65x2 68x8 65 68x3 81 , 64x102 " ,
"0x18 64x16 , 81 64x4 81 64x12 81 28 68x12 28 81 64x14 , 81 68x4 81 98x12 81 28 68x12 28 81 68x13 81 , 81 28x2 13 28 81 68x12 81 28 68x11 13 28 81 68x13 81 , 81 68x4 81 68x12 81 64x4 68 33 68x4 64x4 81 68x13 81 , 81 68x4 81 68x15 98 81 68x6 81 98x2 68x4 101 68x2 81 68x7 81 , 81 64x2 68x2 81 84 68x32 81 68x7 81 , 81 68x4 81 96 68x11 64x26 81 68x2 81 , 81 68x4 81 68x12 81 28 68x24 81 68x2 81 , 81 68x4 81 68x12 81 28 68x24 81 68x2 81 , 81 68x4 81 68x12 81 68x28 81 , 81 68x4 81 68x4 99 117 68x6 81 28 68x27 81 , 81 64x2 68x2 81 68x4 99 117 68x6 81 64x5 81 68x22 81 , 81 68x4 81 68x4 99 117 68x6 81 68x5 81 64x3 68x13 81 68x5 81 , 81 68x4 81 64x12 81 68x14 52 64x10 81 68x2 81 , 81 68x4 81 98x12 81 68x25 81 80x2 81 , 81 68x4 81 68x12 81 68x25 81 64x2 81 , 81 68x4 81 68x12 81 68x10 112x3 68x15 81 , 81 68x4 81 68x23 64x3 68x14 13 81 , 81 68x3 112 81 68x16 81 68x9 80 68x14 81 , 81 68x9 65x2 68x4 64x2 81 68x2 52 81 64x6 68x3 64x5 68x10 81 , 81 68x10 65x2 68x5 81 68x24 64 68x3 81 , 81 68x7 65x6 68x4 81 68x21 64x4 68x3 81 , 81 68x5 65x2 68x3 65x2 68 81 68x3 81 68x28 81 , 81 68x5 65 68x4 65 68x2 81 68x3 81 64x5 81 68x22 81 , 81 64x5 68x3 64x5 81 68 101 68x2 98x2 68x2 13 81 68x22 81 , 81 68x8 81 68x14 81 68x4 48 68x3 28 68x4 81 68x8 81 , 81 68x8 81 68x3 65x2 64x32 81 , 81 65 68x7 81 68 65x2 68x3 65 68x27 65 68x2 81 , 81 68x6 112x2 81 68 65 68x4 65x2 68x4 65 68x4 65 68x16 65 68x2 81 , 81 68x8 81 68x37 81 , 81 68x8 81 68x11 66 67 68x23 65 81 , 81 68x4 64x4 81 68x8 65x2 68 82 83 68x7 65 68x14 65 68 81 , 81 68x46 81 , 81 68x12 64x6 68x6 64 81 68x20 81 , 81 68x12 65x2 68x3 52 64x6 68 81 68x20 81 , 81 68x4 65 68x5 65x2 68x3 65 68x5 65x2 68x2 81 65 68x6 65 68x9 65 68x2 81 , 81 68x4 65x2 68x4 65 68x4 65x2 68x4 65 68 28 68 81 52 64x5 81 68x5 101 68x4 65 68x2 81 , 81 68x25 81 68x6 81 68x13 81 , 64 112x3 64x39 81 68x3 81 , 81 64x11 81 68x30 81 68x3 81 , 81 68x8 65 68x2 81 68x4 28 68x15 29 68x9 81 68x3 81 , 81 68x8 65 68x2 81 68x9 33 68x20 81 68x3 81 , 81 68x7 65x3 68 81 68 65 68x7 34 68 65x2 68x9 65x2 68x4 33 68 81 68x3 81 , 81 68x8 65 68x37 81 , 81 68x3 64x43 81 , 81 68x46 81 , 81 68x11 65 68x3 65 68x5 65x2 68x3 65 68x16 65 68x2 81 , 81 68x6 65 68x8 65x2 68 66 67 68 65 68x4 65x2 68x6 65 68x8 65 68x2 81 , 81 68x15 69 68x2 82 83 68x2 69 68x7 69 68x2 65x3 68x2 69 68x4 118 102 68 81 , 81 68x7 13 68x26 65 68x6 101 68 118 102 68 81 , 81 68x11 81 48x2 68x13 81 48 68x5 65 68x2 81 68x2 65 68x2 118 102 68 81 , 81 112x2 64x44 81 ",
"64x76 , 81 68x38 65x2 68x4 65 68x25 65x2 68 65 81 , 81 68 65x2 68x6 65 68x8 65x2 68x4 65x2 68x11 65x3 68x7 65x2 68x8 65x2 68x12 65x3 81 , 81 65x5 68x5 65x3 68x4 65 68 65x3 68x3 65x2 68x9 65 68x9 65 68x9 65 68x7 65 68x9 81 , 81 68x12 65 69 68x5 69 65 68x5 65 68x5 69 68x9 69 68x4 65x2 68 69 68x2 65x3 68x2 69 68x4 65 68x3 69 68x3 13 68x2 81 , 81 68x6 69 118 102 69 68x4 69 68x3 69 68x13 65 68x3 65 68x26 65x3 68x8 81 68x52 , 81 68x7 118 102 68x2 86 68x3 69 103 69 68x11 65x4 68x7 65x3 68x22 65 68x8 81 68x52 , 81 68x7 118 102 68x6 81 64 81 68x6 80x4 68x8 80x4 68x5 80x4 68x4 80x4 68x3 80x4 68x9 65 81 68x52 , 64x71 68 65 68 65 81 68x52 , 68x70 81 68 65x2 68 81 68x52 , 68x70 81 68x2 69 68 81 68x52 , 68x70 81 68x4 81 68x52 , 64x71 68x3 65 81 68x52 , 81 68x2 65x2 68x5 81 68 65x2 68x4 65x3 68x5 81 68x7 81 65 68x6 81 68x2 65 68x3 98x3 68x3 98x3 65 68x3 98x3 68x9 65 81 68x52 , 81 68 65x2 68x6 81 68 65 68 65 68x5 65 68x5 81 68x5 65x2 81 68 65 68 69 68x3 81 68 65x4 68x10 65 68x7 65 68x7 65 81 68x52 , 81 65 68x4 65x2 68x2 81 68 65 69 65 68x3 69 68 65 46 68 69 68x2 81 68x3 69 68 65 68 81 68x7 81 68 65 68x12 65x2 68x4 65 68x2 65 68x5 65 68x2 81 68x52 , 81 65 68 13 68 69 68 65 68x2 81 68x10 65 68x4 81 68x7 81 68 69 65x2 68 69 68 81 68x3 69 68x6 69 68 65 68x4 69 68x2 65x2 68x3 69 68x3 65 68x2 81 68x52 , 81 68x5 65x2 68x2 81 68x11 65x3 68 81 68 65 68 13 68x3 81 68x3 65 68x3 81 68x8 65x2 68x22 81 68x52 , 81 68x7 65 68 98 68x4 80x2 68x3 80x2 68x4 98 68 65x2 68x4 98 68x3 80 68x3 98 68 65 68x4 80x3 65 68x2 80x3 68x4 80x3 68x8 65x2 81 68x52 , 81 68x10 65x2 68x2 81x2 68x3 81x2 68x8 65x3 68x5 81 68x4 65x2 68x4 81x3 65x2 68 81x3 68x4 81x3 68x9 65 81 68x52 , 81 68x4 64x71 68x52 , 81 68 65 68x2 81 68x122 , 81 68 65 69 68 81 68x83 64x30 68x9 , 81 68x4 81 68x79 64x4 68 65x2 68x5 65 68x21 64x2 68x7 , 81 68x2 65 68 64x80 68 65 68x4 65x2 68x14 65x3 68x4 65 68 65x2 68x3 64x7 , 81 68 65 68x15 65x2 68x12 65x2 68x16 65 68x2 65 68x8 65 68 65x2 68x2 81 68x16 65x2 68x4 69 68x8 69 65 68x7 65 68 69 68x3 65x2 68x7 65 68x2 81 , 81 65x3 68x15 65x2 68x9 65x2 68x17 65 68x3 65x2 68x9 69 68 69 68 81 68x6 65x2 68x15 65x2 68x4 65x3 68x5 65 68x8 65 68x4 65x2 68x3 65x2 81 , 81 68x2 65 68 65 68x3 69 68 65 68x4 65x4 68 69 68x24 65x2 68 65 68x9 65x2 68x6 65 81 68x4 65x4 68x6 69 68x8 65 68x13 65x2 68x13 65 68x4 65 81 , 81 68x4 65x3 68 65x4 68x10 65 68x16 65 68x15 65x2 68 65 68x3 28 13 28 13 28 81 68x4 65x5 68x5 65x4 68x20 65x2 68x13 69 99 117 69 68 81 , 81 68 65 68x4 65 68x4 65x2 68x9 65x2 68x7 69 68x6 65x4 68x20 64x6 68x8 69 68x7 65 68x3 64x4 68x3 65 68 64x5 68x6 64x5 68x4 13x3 68x2 99 117 68x2 81 , 81 68 65x2 68x20 65 68x8 65 68x3 65x7 68x51 65x2 68x5 65 68x20 99 117 65 68 81 , 64x12 68x6 64x8 80x4 68x10 69 68 65x2 68x8 65x2 68x2 80x4 68x11 69 68x10 64x3 68x10 65 68x5 65x2 68x14 64x11 , 68x11 81 65 68x2 65 68x2 81 68x7 64x4 68x22 65 68x3 64x4 68x9 65x3 68x22 65 68x22 81 68x10 , 68x11 81 68x3 65x2 68 81 68x11 64x3 80x5 68x7 65x2 68x6 65x2 68x8 65 68x5 65 68x5 64x4 68 65 68x7 65 68x18 65x2 68 65x2 68x4 65 81 68x10 , 68x11 81 68x4 65x2 81 68x14 64x5 68x8 65x3 69 68x8 69 68x5 65x2 68x14 65x4 68x3 65 69 65 68x5 69 68x4 65x3 69 68x4 65x3 68 69 68x4 81 68x10 , 68x11 81 84 68x5 81 68x19 64x3 80x5 68 65x2 68x7 65x2 68x3 65 68x7 64x4 68x28 65x3 68x13 81 68x10 , 68x11 81 96 68x5 81 68x22 64x5 68x3 65 68x5 65 68x5 65x2 68x4 65x2 68x26 65x2 68x16 65 68x3 81 68x10 , 86 68x10 81 68 65x2 68x3 81 68x26 81 68x12 81 68x9 65x2 68x13 80x4 68x2 65 80x4 68 65 68 80x4 68x5 80x5 68 65x2 68x3 81 68x10 , 68x11 64x5 112x2 64 68x26 64x8 112x2 64x60 112x2 64 ", 
"64x88 , 81 68x63 81 68x4 65x2 68x11 65x3 68x2 81 , 81 68x63 81 68x2 65x2 68x15 65 68x2 81 , 81 68x63 81 68x13 69 68x4 13 28 13 65 81 , 81 68x63 81 68 69 118 102 69 68x5 65 68x2 65x3 68x2 28 13 28 65 81 , 81 68x63 81 65 68 118 102 68x3 65x2 68 65 68x6 64x6 68x40 , 81 68x63 81 68x2 118 102 68x4 65x2 68x7 81 68x45 , 81 64x42 81 64x33 68x2 65x2 68 81 68x45 , 81 68 28 65 81 68 65 68 65x3 68x13 65 68x18 81 65 68x4 65 68x28 65x2 68x2 81 68x45 , 81 28 13 28 81 68x19 65x3 68x6 65x3 68 65x2 68x3 84 81 68 65 68x4 65x3 68x4 65x3 68x5 65x2 68x2 65 68x7 65 68x4 81 68x45 , 81 28 13 28 81 68x8 69 65x3 68 65x2 68x3 69 68 65x3 68x3 69 68x5 65x2 68x4 81 68x7 66 67 68x2 65x3 69 65 68x9 66 67 68x5 69 68x5 81 68x45 , 81 65 28 68 81 68x11 65x3 68x12 65x2 68x6 65 68x2 64x2 68x7 82 83 68x8 65x2 68x6 82 83 68 65x2 68x6 65 68 81 68x45 , 81 65x2 68 81 68x2 13 68x15 65 68x7 65x2 68x15 65 68x22 65x2 68x7 65x2 81 68x45 , 81 68 65 68 81 68 65x3 68x2 80x3 68x4 80x4 68x2 65 68x2 80x3 68x4 80x4 68x3 65x3 68x2 81 68x8 48x3 81 68x5 81 48x2 68x9 81 68x5 81 68x45 , 81 68 65x2 64x34 68x4 97 64x40 68x45 , 81 68x9 81 65 68 65 68x3 81 68 65x3 68x3 65 81 65x2 68x3 28 81 68x8 65 81 68x84 , 81 68x3 69 65 68x4 81 68x2 65x3 68 81 68 28 68x2 69 68x3 81 68x3 65 68 65 81 68x4 69 68 65x2 68 81 68x84 , 81 68x3 65x2 68x4 98 68x2 65x2 68x2 81 33 68x5 65x2 81 68x5 81 98 68x2 65x3 68x4 81 68x84 , 81 65 68x3 65x2 68x15 65x2 68x12 65 68x6 81 68x84 , 81 68x3 64x40 68x84 , 81 68x3 81 68x123 , 81 65x2 68 81 68x123 , 81 68 65x2 81 68x123 , 81 68 69 68 81 68x123 , 81 68x3 81 68x123 , 81 68x3 81 68x123 , 81 68 65x2 81 64x46 68x77 , 81 68x3 81 68x4 98x35 68x3 65x2 68 81 68x77 , 81 68x3 81 65x2 68x40 65 68 65 81 68x77 , 81 65 68x2 81 68x6 65x2 68 65x2 68x12 65x3 68x10 65x4 68x5 81 68x77 , 81 65x2 68 81 68x6 69 65x3 68x5 69 68x6 65x2 69 68x2 65x2 68x6 69 65x4 68x2 13 68x2 81 68x77 , 81 68 69 68 81 68x2 65 68x3 65 68 65x2 68x5 65x2 68x5 65x3 68x6 65x2 68x12 81 68x77 , 81 68x5 65x2 68x12 65x3 68x2 65x3 68x9 65x3 68x10 81 68x77 , 81 68x21 65 68x25 65 68 81 68x77 , 64x9 112x5 64x2 112x5 64x3 112x6 64x2 112x5 64x2 112x5 64x3 68x2 65 81 68x77 , 68x46 81 68 65x2 81 68x77 , 68x46 81 68 69 68 81 68x77 , 68x46 81 68x3 81 68x77 , 68x25 64x21 81 68x3 64x78 , 68x25 81 68x19 65 81 68 65 68x5 81 68x6 65 68x2 81 68x7 81 68x6 81 68x4 65 81 68x5 81 68x7 81 68x7 81 68x4 65x2 68x2 81 68x10 81 , 68x25 81 84 68 65x2 68x2 65x2 68x10 65 68 115 68 65 68x4 65 81 68 65x2 68x6 81 68x3 65 68x3 81 65x2 68x3 65 81 68x3 65x2 81 68 65 68x2 65 81 68x6 65 81 68 65 68 69 68 65 68 81 68 65x3 69 68x3 81 68 65 68 65x2 68x4 65 81 , 68x25 81 68x3 69 68x3 65 68x8 69 68x10 65 81 68x2 65 68 69 68x2 65 68 81 68x3 69 68 65x2 81 68 65x2 69 65x2 81 68x2 69 65 68 81 68 65 69 68x2 81 65 68x3 65x2 68 81 68x2 65 68x4 81 68 65x5 68x2 81 68 65x3 69 68 13 68x2 65 81 , 68x25 81 65x2 68x13 65 68 65 68x8 65x2 81 68x3 65x2 68x4 81 68 65x2 68x4 81 68x2 65 68x3 81 68x5 81 68x2 65 68x2 81 68x2 66 67 68x3 81 68x2 65x2 68x3 81 68x3 65 68x4 81 68x3 65x2 68x4 65 81 , 68x25 81 68 65x2 68x4 65x5 68x2 65x2 68 65x2 68x4 65x2 68x3 81 68x8 85 81 68 65 68x4 85 81 68x5 84 81 68 65 68x2 84 81 68x4 84 81 68x2 82 83 68x3 98 68x3 80 68x2 65 98 68x3 80x2 68x3 98 68x3 65x2 68x3 65x2 81 , 68x25 81 68 65x2 68x6 65x2 68x11 65x5 68x13 65 68x14 65x2 68x12 65 68x7 81 68x2 65x2 68x3 81x2 68x11 65 68x2 81 , 68x25 64x7 68x2 69 68x5 64x20 68x3 97 64x5 52 68 97 64x4 68x2 97 64x4 68 97 64x4 68 97 64x32 68x4 81 , 68x31 81 68x32 81 68x7 81 68x6 81 68x5 81 68x6 81 68x29 81 68x2 69 68 81 , 68x31 81 68x12 65x2 68x10 65x2 68x6 81 68x2 65 68x4 81 68x6 81 65 68x4 81 65x3 68x3 81 68x29 81 65 68 65x2 81 , 68x31 64x6 68x12 65x2 68x13 81 68x5 65 68 81 68x4 65x2 81 65 68x2 65 68 81 68x3 65 68x2 81 68x14 64x16 68x4 81 , 68x36 81 68x11 65x2 68x4 65x3 68 65x2 68x4 81 68x5 65 68 81 68x4 65 68 81 65x2 68 65 68 81 68 65x2 68x3 81 68x14 81 68 65 68x15 65x2 81 , 68x36 81 68x2 65x4 68x3 65x3 68x10 65 68x4 81 68 65x2 69 68x3 81 65x2 68 69 68x2 81 68x2 69 68x2 81 68 65 69 68 65 68 81 68x14 81 68 65x2 68x3 65 68x4 65 68x7 81 , 68x36 81 68x3 65x3 66 67 68 65x2 68x2 66 67 65 68x4 66 67 68x2 65x2 68 81 68x3 65 68x3 81 68 65x3 68x2 81 68x2 65x2 68 81 68x3 65x2 68 81 68x14 81 68x7 65 68 28 68x2 65 28 68 65x2 68x2 81 , 68x36 81 68x6 82 83 68x5 82 83 65x3 68x2 82 83 68x2 65 68x2 81 68x7 81 68x2 65x3 68 81 68x3 65 68 81 68x6 81 68x14 81 68 69 99 117 69 68x8 65x3 68x3 81 , 68x36 81 68x13 65 68x7 65x3 68x3 81 68x5 65x2 81 68x6 81 68x5 81 68x5 65 81 68x14 81 65 68 99 117 68x3 28 65x2 68 28 68x3 28 68x3 81 , 68x36 81 68x31 65 68x16 65 68x4 65x2 81 68x14 81 65 68 99 117 68x3 65x2 68x8 65x2 81 , 68x36 64 112x3 64x53 68x14 64x21 ",
"28 68x14 39x71 78 79 39x26 , 68x15 81 78 79 74 39x3 74 39x3 74 39x2 78 79 39x8 74 39x5 78 79 39x2 74 39x3 78 79 39x5 74 39x4 78 79 39x3 74 39x9 74x2 39x4 94 95 39 74 39x3 74 39 74 39x6 78 79 39x3 74 39x2 74 39x2 81 , 68x15 81 94 95 39x11 94 95 39x3 74 39x10 94 95 39x6 94 95 39x8 78 79 94 95 39x7 78 79 39x5 78 79 74 39x5 78 79 74 39x8 78 79 94 95 39x2 74 39 78 79 39x3 81 , 68x15 81 39x3 68x5 39 78 79 39x2 68x5 39x2 78 79 39 68x5 39x4 78 68x5 39x5 68x5 95 39x2 74 39 68x5 94 95 39x3 68x5 39x5 68x5 78 79 39x3 68x5 39x4 94 68x4 81 , 68x15 81 39 74 39 68x5 39 94 95 39 74 68x5 39x2 94 95 39 68x5 39 74 39x2 94 68x5 39x2 74 39x2 68x5 39 74 39x3 68x5 39x5 68x5 39x5 68x5 94 95 39 74 39 68x5 39x2 78 79 39 68x4 81 , 68x15 81 39x3 68x5 39x5 68x5 39x5 68x5 39x5 68x5 39x5 68x5 39x5 68x5 79 39x4 68x5 39x5 68x5 39x3 78 79 68x5 39x2 94 95 39 68x4 81 , 68x15 81 68x97 81 , 68x15 81 68x97 81 , 68x15 81 68x6 81 85 68x60 81 84 68x27 81 , 68x6 64x16 81 96 68x82 64x8 , 68x6 81 68x15 115 68x82 84 81 , 68x6 81 68x45 69 68x26 69 68x26 81 , 68x6 81 33 68x6 33 68x6 33 68x84 81 , 68x6 81 68 13 68x20 81 85 68x75 81 , 68x6 64x23 81 96 68x68 64x8 , 68x29 81 68x69 81 , 68x29 81 68x69 81 , 68x29 81 68x61 85 81 68x6 81 , 68x29 64x8 68x21 56 68x32 97 81 64x7 , 68x36 81 68x55 81 , 68x36 81 68x55 81 , 68x36 81 68x6 81 85 68x47 81 , 68x36 64x7 81 96 68x40 64x8 , 68x43 81 68 118 102 68x3 66 67 68x6 66 67 68x7 66 67 68x6 66 67 68x8 115 69 99 117 69 81 , 68x43 81 68 118 102 68x3 82 83 68x2 33 68x3 82 83 68x7 82 83 68x6 82 83 68x10 99 117 68 81 , 68x43 81 68 118 102 68x10 49 68x29 99 117 68 81 , 68x42 52 64x48 , "}
current_level = 2
torch_arr = {}
dash_tail_arr = {}
boss_arr = {}
fboss_arr = {}
fboss_fir1 = {}
fboss_fir2 = {}
sprires_heart={13,14,15}
sprires_enemy = {48,49,50}
sprites_coin = {28,29,30,31}
walk_enemy = 48
walk_spr_count = 2
fly_enemy = 33
fly_spr_count = 2
undergr_enemy = 52
undergr_spr_count = 3
spike_spr = 55
level_initialiation()
my_time=0
mm_pos = 0
mm_status = 0
mm_max_button = 4
lm_pos = 0
lm_max_button = 11
xpow = 1
action = true
ex_hero = {}
mode = 0
end
current_dial = 0
dialogues = {
{"press ⬆️ or 🅾️\nto jump",
"beware of spikes",
"try to jump",
"collect hearts",
"torches are not \ndangerous",
"collect coins!"},
{},
{
"this castle is\ncrawling with all\nsorts of creatures.\nbe on the alert",
"sometimes you'll\nneed to choose a\nplace to jump from",
"this is a new\nability! hold the\n⬆️ key to bounce\noff walls",
"i dare you to\ncollect all the\ncoins"
},
{},
{
"your spring is well\noiled now,\nhold ⬇️ to duck",
"beware!",
"your spring gets\ntired, spend it\nwisely",
"only the most adept\nwill be able to\npass it!"
},
{},
{
"",
"beware of the cursed \n cup! tap ➡️ or \n ⬅️ to escape the \n curse"
},
{},{}}
function level_initialiation()
if(current_level < 11) then
point_zone = find_point_zone(1)
buff_arr = find_point_zone(240)
buff_ex()
button_zone = find_point_zone(16)
button_ex()
chains_zone = find_point_zone(66)
chains_ex()
boss_arr = find_point_zone(36)
boss_arr = normilize(boss_arr)
boss_ex()
fboss_arr = find_point_zone(37)
if fboss_arr[0] ~= nil then
mset(fboss_arr[0].x,fboss_arr[0].y,68)
end
fboss_arr =normilize(fboss_arr)
torch_arr =find_point_zone(48)
heart_arr =find_point_zone(80)
coin_arr =find_point_zone(96)
dial_arr =find_point_zone(17)
current_dial= 0
dial_ex()
enemy_arr =find_point_zone(132)
enemy_ex()
else
fboss_arr = {}
for i=0,127,1 do
for j=0,57,1 do
mset(i,j,39)
end
end
end
end
-->8
function _update()
if mm_status == 0 then 
if(stat(16) == -1 and stat(17)== -1 and stat(18) == -1) then
music(0) 
end
main_menu_update()
elseif mm_status == 1 then
if(stat(16) == -1 and stat(17)== -1 and stat(18) == -1 and 
current_level < 11) then 
music(current_level == 10 and 8 or (skil_rest == 3 and current_level == 8 and 28 or 18))
end
start_mode= 1
game_update()
elseif mm_status == 2 then
if(stat(16) == -1)then
music(36)
end
if btnp(5) then
mm_status = 0
end
elseif mm_status == 3 then
level_menu_update()
elseif mm_status == 4 then
dset(0,0)
hero.hp = 3
hero.coins = 0
hero.s = 0
for i=9,45,1 do
dset(i,0)
end
current_level = 2
record_score = 0
mm_status = 0
sfx"55"
else
game_over_update()
end
end
function main_menu_update()
if(mm_pos == 0 and not str_game and (dbg or maxlvc >8))then
if btnp(➡️) then
mode = (mode+1)%3
end
if btnp(⬅️) then
mode=mode<= 0 and 2 or mode-1
end
end
if btnp(⬆️) then
sfx"53"
mm_pos = mm_pos <= 0 and mm_max_button-1or mm_pos -1
end
if btnp(⬇️) then
sfx"53"
mm_pos = (mm_pos+1)%mm_max_button
end
if btnp(❎) then
sfx"53"
music(-1)
if(maxlvc > 0 and mm_pos+1 == 3) or mm_pos+1 ~= 3 or dbg then
mm_status = mm_pos+1
if mm_status==1 then
if(not str_game) then
set_lvl(1)
end
str_game= true
if mode > 1 and current_level > 2 then
c_l = current_level-1
b_p_z = point_zone.last
set_lvl(c_l)
hero.hp = last_h.hp
hero.coins = last_h.coins
hero.s = last_h.s
point_zone.last = b_p_z
set_p()
else
hero.hp = mode==1 and 1 or hero.hp
end
end
end end
end
function level_menu_update()
lm_pos = lm_pos == 0 and 1 or lm_pos 
mode = 0
if btnp(⬅️) then
mm_status = 0
end
if btnp(⬆️) then
sfx"53"
lm_pos = lm_pos<=1 and (dbg and lm_max_button-1 or maxlvc)or lm_pos-1
end
if btnp(⬇️)then
sfx"53"
lm_pos = lm_pos >= (dbg and lm_max_button-1 or maxlvc) and 1or lm_pos+1
end
if btnp(❎) then
music"-1"
sfx"53"
str_game=true
start_mode= 1
set_lvl(lm_pos)
hero.hp = dget(31+lm_pos)
hero.hp = hero.hp==0 and 3 or hero.hp
hero.coins = dget(9+lm_pos)
hero.s = dget(20+lm_pos)
current_level = lm_pos+1
skil_rest = current_level < 5 and 0 or (current_level < 7 and 1 or (current_level < 9 and 2 or (current_level < 11 and 3 or 0)))
mm_status = 1
end
end
function game_update()
key_control()
my_time+=1
check_dt_arr()
if #dash_tail_arr != 0 then
update_dt_arr()
end
update_buff()
update_enemy(enemy_arr)
update_boss(boss_arr)
update_fboss(fboss_arr)
update_enemy(enemy_arr)
update_fboss_fir1(fboss_fir1)
update_fboss_fir2(fboss_fir2)
if hero.hp <= 0 then
mm_status = 9
end
end
go_start = 0
go_st_time = 0
go_time = 0
function game_over_update()
go_init()
go_time = time()-go_st_time
if go_time == 3 then
hero.hp = mode==1 and 1 or 3
set_p()
mm_status = 0
go_start = 0
end
end
function set_p()
if point_zone[point_zone.last] ~= nil then
hero.x = point_zone[point_zone.last].x*8
hero.y = (point_zone[point_zone.last].y-1)*8
else
hero.x = startl.x*8
hero.y = startl.y*8
if current_level == 10 then
set_lvl(9)
end
end
end
function go_init()
if go_start == 0 then
go_start = 1
music(-1)
sfx(54)
go_st_time = time()
end
end
function cell_in_arr(cell,arr)
local temp = false
for i = 1,#arr do
if(cell == arr[i]) then
temp = true
end
end
return temp
end
function update_fboss_fir2(arr)
for i = 1,# arr do
if do_damage(arr[i].x,arr[i].y) then
hero.hp -= 1
sfx"55"
save_form = true
end
if my_time-arr[i].time > 80 then
del_fboss_fir2(i,fboss_fir2)
end
end
end
function update_fboss_fir1(arr)
for i = 1,# arr do
diff_x = arr[i].ax- arr[i].x*8
diff_y = arr[i].ay- arr[i].y*8
if do_damage(arr[i].x,arr[i].y) then
hero.hp -= 1
sfx"55"
save_form = true
end
if(abs(diff_x) < 5 and abs(diff_y) < 5) then del_fboss_fir1(i) add_fboss_fir2(arr[i].x,arr[i].y,my_time)          
end
if(abs(diff_x) >= 5) then
arr[i].x += diff_x/abs(diff_x)/3
else
arr[i].y += diff_y/abs(diff_y)/4  
end      
end
end
function add_fboss_fir1(x,y,ax,ay)
local temp ={}
temp.x = x
temp.y = y
temp.ax = ax
temp.ay = ay
fboss_fir1[#fboss_fir1+1]= temp
end
function add_fboss_fir2(x,y,ttime)
local temp = {}
temp.x = x
temp.y = y
temp.time = ttime
fboss_fir2[#fboss_fir2+1]= temp
end
function del_fboss_fir1(index)
local temp = {}
local ind = 1
for i = 1,#fboss_fir1 do
if i != index then
temp[ind] = fboss_fir1[i]
ind += 1
end
end
fboss_fir1 = temp
end
function del_fboss_fir2(index)
local temp = {}
local ind = 1
for i = 1,#fboss_fir2 do
if i != index then
temp[ind] = fboss_fir2[i]
ind += 1
end
end
fboss_fir2 = temp
end
-->8
function key_control()
if (btnp(5) and current_level== 11) or fin_t > 440 then
mm_status = 0
fin_t = 0
end
crouch=hero.is_crouch and 0 or 1
update_ex_h(hero)
col = collide(ex_hero,1,is_b,1,crouch)
if col ~= nil and col.x ~= nil then
sfx"60"
off_points(point_zone,101)
update_point(col,point_zone,100,save_method)
end
update_ex_h(hero)
col = collide(ex_hero,33,is_b,1,1)
if (col ~= nil and
col.y ~= nil) then
if current_level < lm_max_button then
c_lel = current_level-2
last_h.hp = hero.hp
last_h.coins = hero.coins
last_h.s = hero.s
if mode == 0 then
dset(c_lel+33,hero.hp)
dset(c_lel+11,hero.coins)
dset(c_lel+22,hero.s)
end
if(dget(0) < hero.s) then
dset(0,hero.s)
record_score = hero.s
end
maxlvc= maxlvc+2==current_level and maxlvc+1 or maxlvc
dset(1,maxlvc+1)
set_lvl(current_level)
end
end
update_ex_h(hero)
col = collide(ex_hero,80,is_b,1,crouch)
if col ~= nil and col.x ~= nil then
update_point(col,heart_arr,68,save_method)
hero.s+=50
if mode != 1 then
hero.hp +=1
else
save_form = true
last = time()
end
sfx"59"
end
update_ex_h(hero)
col = collide(ex_hero,96,is_b,1,crouch)
if col ~= nil and col.x ~= nil then
update_point(col,coin_arr,68,save_method)
hero.coins +=1
hero.s+=10*(mode+1)
sfx"51"
end
if (button_zone[0] ~= nil) then
n = no_map_cols_n(hero,button_zone,16,0)
if n ~= nil then
button_method(n)
else
action = -1 end
update_chains()
end
update_ex_h(hero)
col = dist_to_col(ex_hero,2,is_b2,1,crouch)
if ((col  ~= nil and col.x <= hero.sx) or (col  ~= nil and col.y <= hero.sy)) and not save_form then
hero.hp-=1
sfx"55"
save_form = true
end
update_save_form()
jump_s_b = false
update_ex_h(hero)
col = dist_to_col(ex_hero,3,is_b2,1,1)
if (col  ~= nil and col.y <= hero.sy) or (col  ~= nil and col.x <= hero.sx) then
sfx"56"
hero.sy = 0 - (jump_power*1.55)
jump_s_b = true
end
update_tr(hero,jump_s_b)
hero_move()
end
function hero_move()
update_ex_h(hero)
ex_hero.sx = sgn(hero.sx)
colx = dist_to_col(ex_hero,1,is_b2,1,crouch)
update_ex_h(hero)
ex_hero.sy = sgn(hero.sy)
coly = dist_to_col(ex_hero,1,is_b2,1,crouch)
hero.sy += g_time * 0.3
if coly ~= nil then
if coly.y <= hero.sy then
hero.sy = -2*sgn(hero.sy)
else
hero.y = ((hero.sy ~= 0 and
coly.y-9 <= 0) and not hero.is_crouch) and
flr(hero.y/8)*8 or hero.y
hero.sy = coly.y-9 <= 0 and 0or coly.y-9
end
end
xd = abs(flr((hero.sx-1)/2))
if colx ~= nil and colx.x <= hero.sx-(12*xd) then
if (hero.sy==0 or hero.is_crouch)then
hero.sx *= -1
else
xpow = 0
end
double_jump()end
xpow =(colx == nil or
hero.on_flore) and 1 or xpow
update_ex_h(hero)
ex_hero.sy = -1
coly = dist_to_col(ex_hero,1,is_b2,1,1)
if( (btnp(⬆️)or btnp(4)) and not hero.is_crouch
and hero.on_flore)
and coly == nil then
sfx"52"
hero.sy -= jump_power
end
hero.x+= hero.sx*xpow*dash*g_time
hero.y+= hero.sy*g_time
update_ex_h(hero)
ex_hero.sy = 1
coly = dist_to_col(ex_hero,1,is_b2,1,1)
hero.on_flore = hero.sy == 0 and
coly ~= nil and coly.y-9 >= 0
update_ex_h(hero)
ex_hero.sx = sgn(hero.sx)
col = dist_to_col(ex_hero,1,is_b2,1,1)
if dash > 1 and col ~= nil then
hero.sx *= -1
xpow = 1
end
dash = 1
if ((btn(➡️) and hero.sx > 0) or
(btn(⬅️) and hero.sx < 0))
and skil_rest > 2 and
not hero.is_crouch then
if dash_sg > 0 then
if btnp(➡️) or btnp(⬅️) then
sfx"61"
end
dash =4
dash_sg= power_f and dash_sg-0.85 or dash_sg-2
else
dash = 1
dash_sg = 0
end
elseif dash_sg<20 then
dash_sg += 0.5
end
update_ex_h(hero)
ex_hero.sy = -1
col = dist_to_col(ex_hero,1,is_b2,1,0)
hc_p =hero.is_crouch
hero.is_crouch = false
if(g_time>0 and btn(⬇️)and skil_rest > 1) or
(col ~= nil and abs(col.y) > 1)then
dash_sg =(power_f or dash_sg <= 0) and dash_sg-0 or dash_sg-1
if(dash_sg >0)or
(col ~= nil and abs(col.y) > 1)then
hero.is_crouch = true
end
end
if hc_p and hero.sy == 0 and hc_p ~=hero.is_crouch then
hero.y -=8
end end
function double_jump()
update_ex_h(hero)
ex_hero.sy = -1
coly = dist_to_col(ex_hero,1,is_b2,1,1)
if (btnp(⬆️)or btnp(4))and hero.sy>0 and
coly== nil and skil_rest >0
and not hero.is_crouch
then
hero.sy -= jump_power*1.25
hero.sx *= -1
xpow = 1
end
end
function update_ex_h(obj)
ex_hero.x = obj.x
ex_hero.y = obj.y
ex_hero.sx = 0
ex_hero.sy = 0
end
-->8
function save_method(zone,i,blk)
zone[i].is_active = true
zone.last = i
mset(zone[i].x,zone[i].y,blk)
end
function button_method(zone)
if action ~= zone+1 then
action = zone+1
button_zone[zone].is_active = not button_zone[zone].is_active
sfx(button_zone[zone].is_active
and 58 or 57)
chains_method()
end
end
function chains_method()
local n_b 
local c_b
local j_siz
for i = 0, #chains_zone, 1 do
j_siz=#chains_zone[i].b
j = 0
while j <= j_siz do
n_b =chains_zone[i].b[j]
if(button_zone[n_b]~= nil) then
c_b = button_zone[n_b]
chains_zone[i].is_active =
c_b.is_active
j = c_b.is_active and j+1 or j_siz+1
else j+=1
end end
if chains_zone[i].is_active~= chains_zone[i].buf_st then
chains_zone[i].ch = 0
chains_zone[i].buf_st =chains_zone[i].is_active
end
end
end
function update_buff()
if buff_arr ~= nil and buff_arr[0] ~= nil then
for i=0,#buff_arr,1 do
if (no_map_col(hero,buff_arr[i],12,0) and buff_arr[i].is_active)
then
buff_arr[i].is_active= false sfx"60"
skil_rest+=1
if buff_arr[i].ico ==10 then
power_f = true
end
hero.s += 200*mode
if(skil_rest==3) then music(-1)end
end 
end 
end
end
function update_chains()
local d
if(chains_zone[0] ~= nil) then
for i = 0, #chains_zone, 1 do
if(not chains_zone[i].is_active)
then
d = chains_zone[i].d
draw_chains(chains_zone[i],d.s,d.s2)
else
draw_chains(chains_zone[i],68,68)
end
end
end
end
function chain_dir(c_b)
local d = {}
d.x = 0
d.y = 0
d.s = 68
d.s2 = 68
if c_b == 96 then
d.x = 1
d.s = 96
d.s2 = 97
elseif c_b == 97 then
d.x = -1
d.s = 96
d.s2 = 97
elseif c_b == 115 then
d.y = 1
d.s = 115
d.s2 = 116
elseif c_b == 116 then
d.y = -1
d.s = 115
d.s2 = 116 end
return d
end
ch_time = 0
function draw_chains(ch_obj,n,n2)
local ch =  ch_obj.ch
local dir_c = ch_obj.d
ch_time = ch_time >= 1 and 0or ch_time
local x = ch_obj.x+(dir_c.x*ch)                  
local y = ch_obj.y+(dir_c.y*ch)
local a = not (is_b(x*8,y*8) ==2)
local a1 = not (is_b((x+dir_c.x)*8,(y+dir_c.y)*8) ==2)
if a and ch_time == 0 then
mset(x,y,dir_c.x+dir_c.y==1 and n or n2)
ch_obj.ch = a and ch+1 or ch
end
if (a and a1) and ch_time == 0 then
mset(x+dir_c.x,y+dir_c.y,
dir_c.x+dir_c.y==1 and n2 or n)
ch_obj.ch = a1 and ch+2 or ch
end
ch_time+=1
end
function chains_ex()
if(chains_zone[0] ~= nil and button_zone[0] ~= nil ) then
for i = 0, #chains_zone, 1 do
chains_zone[i].b = {}
c_b = mget(chains_zone[i].x,chains_zone[i].y)
chains_zone[i].d =chain_dir(c_b)
chains_zone[i].ch = 0
chains_zone[i].buf_st = false
local k = 0
for j = 0, #button_zone, 1 do
if button_zone[j].x/8 ==chains_zone[i].x then 
chains_zone[i].b[k] = j
chains_zone[i].is_active=button_zone[j].is_active
k += 1
end
if button_zone[j].y/8==chains_zone[i].y then 
chains_zone[i].b[k] = j
k += 1
end
end
end
chains_method()
end
end
function button_ex()
if button_zone[0] ~= nil then
for i = 0, #button_zone, 1 do
button_zone[i].is_active = 
mget(button_zone[i].x,
button_zone[i].y) == 85
mset(button_zone[i].x,
button_zone[i].y,68)
button_zone[i].x*=8
button_zone[i].y*=8
end
end
end
function update_point(col,pz,blk,method)
for i = 0, #pz, 1 do
if pz[i].x == col.x/8 and 
pz[i].y == col.y/8 then
method(pz,i,blk)
end
end
end
function update_save_form()
if save_form and time_damage >= 0 then
time_damage = flr(save_ef_speed*
(second_save+last- time()))
save_form = time_damage>= 0
else
time_damage = save_ef_speed*second_save
last = time()
end
end
cur = {}
cur.x = 0
cur.y = 0
diff = 0
function update_tr(obj,signal)
local x
local y
diff =(signal or diff > 0) and diff+1 or diff
if diff > 20 then
diff = 0
end
update_ex_h(hero)
cur = (signal and diff == 1) and
collide(ex_hero,3,is_b2,1,1) or cur
x = cur.x ~= nil and cur.x/8 or x
y = cur.y ~= nil and cur.y/8 or y   
if (mget(x,y) == 113or mget(x,y) == 112) 
and cur.x ~= nil and cur.y ~= nil then
if(diff < 3 or diff > 17)then
mset(x,y,112)
mset (x,y-1,mget(x,y-2))
else 
mset(x,y,113)
mset (x,y-1,mget(x+1,y-1)==68 and 114 or 107) 
end 
end
end
function dial_ex()
if dial_arr ~= nil and 
dial_arr[0] ~= nil then
for i = 0, #dial_arr, 1 do
dial_arr[i].img = mget(dial_arr[i].x,
dial_arr[i].y)
dial_arr[i].n = i
current_dial += 1
dial_arr[i].x *=8
dial_arr[i].y *=8
dial_arr[i].d = dialogues[current_level-1][current_dial]
end
end
end
function buff_ex()
if buff_arr ~= nil and buff_arr[0] ~= nil  then
for i = 0, #buff_arr, 1 do
buff_arr[i].is_active = true
buff_arr[i].ico = mget(buff_arr[i].x,buff_arr[i].y)
buff_arr[i].x *=8
buff_arr[i].y *=8
end
end
end
ind_dt = 0
function check_dt_arr()
if dash > 1 and ind_dt < 4 then
local temp = {}
local x = hero.x
if hero.sx < 0 then
x += 16
end
temp.x =x
temp.y = hero.y+rnd(15)
temp.spr=72
temp.t=my_time
dash_tail_arr[ind_dt] = temp
ind_dt += 1
end
end
function update_dt_arr()
local del_fl = false
for i=0,4 do
local temp = dash_tail_arr[i]
if temp != nil then
local diff = abs(temp.t-my_time)
if diff > 4 then
del_fl = true
end
end
end
if del_fl then for i=1,#dash_tail_arr do
dash_tail_arr[i-1]=dash_tail_arr[i]
end
dash_tail_arr[ind_dt] = nil
ind_dt -= 1
end
end
-->8
function collide(obj,n,is_m,x_lim,y_lim)
x_lim = x_lim == nil and 1 or x_lim
y_lim = y_lim == nil and 1 or y_lim
obj_m = {}
obj_m.x = (obj.x+7)/8
obj_m.y = (obj.y+4)/8
local result = {}
c = {}
c.x= 8*flr(obj_m.x)+(obj.sx*8)
c.y= 8*flr(obj_m.y)+(obj.sy*8)
for j=0,y_lim,1 do
for i=0,x_lim,1 do
if is_m(c.x+(8*i),c.y+(8*j),n) == n
then
result.x= c.x+(8*i)
result.y= c.y+(8*j)
return result
end
end
end
return result
end
function dist_to_col(obj,n,is_m,x_lim,y_lim)
local result ={}
local p = {}
p.x = 0
p.y =0
p =collide(obj,n,is_m,x_lim,y_lim)
xd =flr((obj.sx+1)/2)
if p.x ~= nil and p.y ~= nil then
result.x=abs(p.x-obj.x)-15
result.y=abs(p.y-obj.y)-7
else
result =nil
end
return result
end
function is_b(x,y)
map_n =mget(x/8,y/8)
return fget(map_n)
end
function is_b2(x,y,n)
map_n =mget(x/8,y/8)
return fget(map_n,n) and n or 9
end
function no_map_col(obj,col,radius,y_param)
return col.x >= obj.x and col.x < obj.x+radius and col.y >= obj.y-y_param and col.y < obj.y+radius+y_param
end
function no_map_cols_n(obj,cols,radius,y_param)
for i = 0,#cols,1 do
if no_map_col(obj,cols[i],radius,y_param) then
return i
end
end
return nil
end
-->8
function update_enemy(pz)
if(#pz > 0) then
for i = 0, #pz, 1 do
pz[i].speed = 0.3
pz[i].is_active = true
if pz[i].undergr then
undrgr_enemy(pz[i])
else
fly_walk_enemy(pz[i]) end pz[i].x += pz[i].sx * g_time * pz[i].speed
spike = (pz[i].undergr and not pz[i].is_active ) and 8 or 0
if no_map_col(hero,pz[i],16,spike)and not save_form then
hero.hp-=1
sfx"55"
save_form = true
end end
end
end
function undrgr_enemy(enemy)
enemy.sy = 0
col = dist_to_col(enemy,1,is_b2,0,0)
if col == nil then
enemy.sx *= -1
end
enemy.is_active = true
if(abs(hero.x-enemy.x) <= 15) then
enemy.speed = 0
enemy.is_active =not (abs(hero.x-enemy.x) <= 6)
end
end
function fly_walk_enemy(enemy)
enemy.sy = 1
col2 = dist_to_col(enemy,1,is_b2,0,0)
enemy.sy = 0
col = dist_to_col(enemy,1,is_b2,0,0)
if(col ~= nil or (col2 == nil and not enemy.flyaible)) then 
enemy.sx *= -1
end
end
function enemy_ex()
local f,i
if #enemy_arr > 0 then
for j = 0, #enemy_arr, 1 do
i = mget(enemy_arr[j].x,enemy_arr[j].y)
enemy_arr[j].img = i
mset(enemy_arr[j].x,enemy_arr[j].y,68)
f = i == walk_enemy or i == fly_enemy or i == undergr_enemy
enemy_arr[j].img = f and i or i-1         
enemy_arr[j].x *= 8
enemy_arr[j].y *= 8
enemy_arr[j].sx = 1
enemy_arr[j].sy = 0
col2 = dist_to_col(
enemy_arr[j],1,is_b2,0,0)
enemy_arr[j].flyaible =enemy_arr[j].img == fly_enemy
enemy_arr[j].undergr=enemy_arr[j].img == undergr_enemy
enemy_arr[j].max_f=enemy_arr[j].flyaible 
and fly_spr_count or
(enemy_arr[j].undergr and
undergr_spr_count or
walk_spr_count)
enemy_arr[j].sy = 0
enemy_arr[j].sx = f and -1 or 1
end
end
end
function boss_ex()
if #boss_arr > 0 then
for i=1,#boss_arr do mset(boss_arr[i].x,boss_arr[i].y,68)
end
end
end
function update_boss(arr)
for i = 1,# arr do
if (do_damage(arr[i].x,arr[i].y) or do_damage(arr[i].x+1,arr[i].y) or do_damage(arr[i].x+1,arr[i].y-1) or do_damage(arr[i].x,arr[i].y-1))then
hero.hp-=1
sfx"55"
save_form = true
end
diff_x = hero.x - arr[i].x*8
diff_y = hero.y - arr[i].y*8
if(skil_rest >= 3) then
if(abs(diff_x) >= abs(diff_y)) then
arr[i].x += diff_x * g_time/abs(diff_x)/10 
else
arr[i].y += diff_y * g_time/abs(diff_y)/20   
end
end
end
end
function do_damage(x,y)
if x*8 >= hero.x and x*8 < hero.x+16 and
y*8 >= hero.y and y*8 < hero.y+16 and not save_form then
return true
else
return false
end
end
fboss_blast = 0
fboss_fly = 1
function update_fboss(arr)
for i = 1,# arr do
local diff_x = hero.x - (i-1)*80 - arr[i].x*8
local diff_y = hero.y - arr[i].y*8
if my_time%40 == 0 then
local temp_rnd = flr(rnd(3))+1
if temp_rnd > 2 then
fboss_blast = 10
sfx"62"
add_fboss_fir1(arr[i].x,arr[i].y,hero.x+hero.sx*100,hero.y+16)
end
end
if my_time%16 == 0 then
fboss_fly = 0 - fboss_fly
end
if fboss_blast > 0 then
fboss_blast -= 1
end
if diff_y < 32 then
arr[i].y -= 1/8
elseif diff_y > 40 then
arr[i].y += 1/8 else
arr[i].y += fboss_fly/16
end
if diff_x < -30 then
arr[i].x -= 1/4
end
if diff_x > -45 then
arr[i].x += 1/4
end
if diff_x < -35 then
arr[i].x -= 1/8
end
if diff_x > -40 then
arr[i].x += 1/8
end
end
end
function normilize(arr)
local temp = {}
for i=1,#arr+1 do
temp[i] = arr[i-1]
end
return temp
end

-->8
function get_sumb_index(str,start_sub,sumb)
result = -1
for i=start_sub, #str do
local s = sub(str,i,i)
if s == sumb then
result = i 
break
end 
end
return result
end
function find_point_zone(flag)
local result = {}
result.last = 0
m = 0
for i = 0, 127,1 do
for j = 0, 63,1 do
if  fget(mget(i,j)) == flag then
local examp = {}
examp.x = i
examp.y = j
examp.is_active = false
result[m] = examp
m += 1end
end end
return result
end
function off_points(pz,blk)
for i = 0, #pz, 1 do
pz[i].is_active = false
mset(pz[i].x,pz[i].y,blk)
end end
-->8
function _draw()
cls()
camera(0,0)
if mm_status == 0 or
mm_status == 4
then
main_menu()
elseif mm_status == 1 then
camera(hero.x-64,hero.y-64)
level_draw()
elseif mm_status == 2 then
print("press ❎",40,0)
for i = 2,5,1 do
print(end_ct[i],10,i*10)end
elseif mm_status == 3 then
level_menu_draw()
else
game_over()
end
end
function game_over()
print('game over',60,40,8)
end
t_mm = 0 sky = 0
mod = 1
function draw_start_logo()
t_mm = t_mm > 20 and 0 or t_mm+1
sky = t_mm == 20 and sky+mod or sky
mod = t_mm == 20 and abs(sky) == 8 and
mod*-1 or mod
sspr(48,70,32,28,35,0,64,54)
sspr(80,61,48,48,20,44,96,96)
palt(0,false)
spr(39,20,43)
spr(39,28,43)
palt(0,true)
for i=0,4,1 do
sky_add((i*20)%41,i*16)
end
m_y =48
end
function sky_add(x,y)
sspr(112,32,16,16,x+sky,y,32,32)
end
function main_menu()
if start_mode == 0 then
draw_start_logo()
end
draw_rect(14,m_y,6,7)
if mm_pos==0 and (dbg or maxlvc>8) then
print("choose mod:\n".."⬅️"..(mode==0
and "normal" or(mode==1 and
"one hearth" or "two mages")).."➡️",16,84)
end
button_m(str_game and "continue" or "start",0,16,5,mm_pos)
button_m("about",1,16,5,mm_pos)
button_m("levels",2,16,5,mm_pos)
sstt = mm_pos == 3 and "\n reset memory" or ""            
button_m("record:"..record_score..sstt,3,16,20,mm_pos)
end
function button_m(name,pos,x,y,cont)
print(cont== pos and'❎'..name or name,x,(10*pos)+m_y+y,cont == pos  and 11 or 7)
end
function level_menu_draw()
draw_rect(8,10,5,12)
print("normal mode",10,0)
for i = 1,dbg and lm_max_button or maxlvc,1 do
button_m("level "..tostr(i),i,10,-45,lm_pos)
end
print("⬅️main menu",10,105,3)
end
function draw_rect(x,y,xw,yw)
sspr(72,48,8,8,x,y,8,8)
sspr(72,48,8,8,x+(xw*8),y,8,8,true)
for i = 1, xw-1,1 do
sspr(80,48,8,8,x + (i*8),y,8,8)
sspr(80,48,8,8,x + (i*8),y+(yw*8),8,8,false,true)
end
for i = 1, yw-1,1 do
sspr(72,56,8,8,x,y + (i*8),8,8)
sspr(72,56,8,8,x+(xw*8),y+ (i*8),8,8,true)
end
for i = 1, xw-1, 1 do
for j = 1, yw-1, 1 do
sspr(80,56,8,8,x + (i*8),y + (j*8))
end
end
sspr(72,48,8,8,x,y+(yw*8),8,8,false,true)
sspr(72,48,8,8,x+(xw*8),y+(yw*8),8,8,true,true)
end
function level_draw()
map(0,0,0,0,128,200)
if time_damage%2 == 0 then
pal(10,1) else pal()
end
print("score: "..hero.s,hero.x-55,hero.y-55)
draw_hero_coins() 
draw_button(84)
draw_hero_hp()
draw_arr(torch_arr,10,69,3)
draw_arr(heart_arr,5,13,3)
draw_arr(coin_arr,5,28,4)
draw_dash_tail()
_draw_enemy(enemy_arr)
_draw_boss(boss_arr)
_draw_fboss(fboss_arr)
draw_fboss_fir(fboss_fir1)
draw_fboss_fir(fboss_fir2)
_draw_hero()
draw_strength()
end
function _draw_enemy(arr)
if(#arr > 0) then
for i=0,#arr,1 do
spr(flr(arr[i].img + (my_time/4)%arr[i].max_f),arr[i].x,arr[i].y,1,1,sgn(arr[i].sx) == 1,false)
if not arr[i].is_active then
spr(spike_spr,arr[i].x,arr[i].y - sgn(arr[i].y-hero.y)*8,1,1,false,sgn(arr[i].y-hero.y) < 0)
end
end
end end
function draw_button(blk)
if button_zone[0] ~= nil then
for i = 0, #button_zone, 1 do
local x = button_zone[i].x
local y = button_zone[i].y
spr( button_zone[i].is_active and blk+1 or blk,x,y,1,1,is_b(x+8,y) == 2)
end end end
ntt= 0
function _draw_boss(arr)
ntt = my_time%5 == 0 and 16*(my_time%3) or ntt
for i=1,#arr do
sspr(112,16,16,8,arr[i].x*8,arr[i].y*8)
sspr(48 + ntt,8,16,8,arr[i].x*8,arr[i].y*8-8)
end end
function _draw_fboss(arr)
for i=1,#arr do
tsd = flr((my_time%20)/10)*2
if fboss_blast > 0 then tsd = 4 end
sspr(64+(tsd*8),16,16,16,arr[i].x*8,arr[i].y*8,16,16,i==2)
end
end
function _draw_hero()
if current_level==11then
final_cut() end img+=0.2
frame = 0
if hero.sy==0 then
frame =flr(img)%max_frame
end
draw_buf()
if hero.is_crouch then
rt = frame%2
sspr ((power_f and 24 or 48)+16*rt,(power_f and 16 or 0),16,8, hero.x+3,hero.y +4 - rt,16,8,
sgn(hero.sx) == -1,false)
else
rt =power_f and frame%2 or frame
sspr ((power_f and 96 or 0)+16*rt,(power_f and 48 or 0),16,16, hero.x+3,hero.y-(power_f and 2 or 4)+2*rt,16,16,sgn(hero.sx) == -1,false)
end
draw_dialogue()
img =img>=max_frame and 0or img end
function draw_dialogue()
if #dial_arr > 0 then
for i=0,#dial_arr,1 do
if dial_arr[i].is_active then
draw_rect(hero.x-32,hero.y-30,10,5)
print(dial_arr[i].d,hero.x-24,
hero.y-16)
end
if no_map_col(hero,dial_arr[i],32,0) then
print(dial_arr[i].is_active and "" or"press ❎ to read", hero.x-16,hero.y-24)           
if (dial_arr[i].is_active and(btnp(5) or btnp(1)or btnp(2)or btnp(3)or btnp(4) or btnp(0)) or(btnp(5) and not dial_arr[i].is_active)) then
g_time = g_time == 0 and 1 or 0
dial_arr[i].is_active = not dial_arr[i].is_active
end end end
end
end
ch_t = 0
p=0
function draw_buf()
if buff_arr ~= nil and buff_arr[0] ~= nil then
ch_t+=1
if(ch_t > 20) then
p+=1
for i=0,#buff_arr,1 do
mset( buff_arr[i].x/8, buff_arr[i].y/8 ,buff_arr[i].is_active and buff_arr[i].ico + (p)%2 or 68) end
ch_t = 0
end
end end
function draw_hero_hp()
if current_level < 11 then
for i = 1,hero.hp do
spr(12,hero.x-64+9*i,hero.y-46)
end
if mode==1 and save_form then
print(time_damage,hero.x-40,hero.y-44)
end
end
end
function map_parse(str_map, st_y)
x=0
y=st_y
while str_map!="" do
index = get_sumb_index(str_map, 0, ' ')
sub_str = sub(str_map,0,index-1)
str_map = sub(str_map,index+1)
if #sub_str == 1 then
x = 0
y += 1
elseif #sub_str == 2 or #sub_str == 3 then
local s1 = sub(sub_str,1,#sub_str)
mset(x,y,s1)
x += 1
else
x_sym = get_sumb_index(sub_str, 0, 'x')amount = sub(sub_str,x_sym+1,#sub_str)
for j = 0,amount-1 do
local s3 = sub(sub_str,0,x_sym-1)
mset(x,y,s3)
x += 1
end
end
end
end
function clean()
for i = 0, 128, 1 do
for j = 0, 52, 1 do
mset(i,j,39)
end
end
end
function set_lvl(lvl_num)
if(lvl_num > 1 and lvl_num < 10) then
clean()
map_parse(levels[lvl_num-1],0)
else
for x=0,38,1 do
for y=0,25,1 do
mset(x,y,ft_lvl[x][y])
end
end
end
if mode==2 then
mset(1,1,56)
skil_rest = 3
end
music(-1)
second_save = mode==1 and 9 or 3
current_level = lvl_num+1
level_initialiation()
startl = find_point_zone(32)[0]
if lvl_num ==1 then
hero.x = 2*8
hero.y = 23*8
elseif lvl_num < 10 then
hero.x = startl ~= nil and startl.x*8 - 8 or hero.x
hero.y = startl ~= nil and startl.y*8 - 8 or hero.y
else
music(36)
str_game = false
hero.x = finstr.x*8
hero.y = finstr.y*8
dset(2,power_f and 1 or 0)
chains_zone = {}
skil_rest = mode != 2 and 0 or skil_rest
end
end
function draw_hero_coins()
if current_level < 11 then
spr(51,hero.x-55,hero.y-30)
print(hero.coins,hero.x-45,hero.y-28,9)
end
end
function draw_arr(array,spd,ind,spr_am)
if(array ~= nil and array[0] ~= nil) then
for i = 0, #array, 1 do
mset(array[i].x,array[i].y,array[i].is_active and 68 or ind+flr(my_time/spd+flr(array[i].x))%spr_am)
end
end
end
function draw_dash_tail()
if #dash_tail_arr != 0 then
for i = 0,4 do
if dash_tail_arr[i] != nil then
spr((power_f and 123 or 72),dash_tail_arr[i].x,dash_tail_arr[i].y)
end
end
end
end
function draw_strength()
local length = dash_sg/4
if( skil_rest > 1) then
for i = 0,length do
spr(32, hero.x-56 + i*5,hero.y-38)  
end
end
end
function draw_fboss_fir(arr)
for i = 1,# arr do
temp_rnd = flr((my_time%19)/10)
spr(62+temp_rnd,arr[i].x*8,arr[i].y*8)
end
end
function a_text(ll,ul,tet) if fin_t > ll and fin_t<ul then print(tet,hero.x-64,hero.y-40) end end
fin_t=0
end_ct={"thanks for game!","producer: stanislav skorb","programmer: koti4 and gate", "designer: vikat and danny", "composer: pavvl", "you open 2 mod!"}
function final_cut()
fin_t += 1 for i = 0,5,1 do
a_text(i*90,80*(i+1),end_ct[i+1])
a_text(400,425,end_ct[6]) end end
__gfx__
0000882200000000000a000000000000000000000000000000000000000000000000028880090000c0000005d000000308800880088008800000000000000000
000828888809000000008822000000000000000000000000000002888009000000008888899000001cd115510d5005308e8888888e8888881101110111011101
00a02088899000000009088888000000000088220000000000008888899000000008288fbf00000011d6d5111055d5018ee888888ee888881181180111011101
0000908fbf000000000000888999000000028888880900000008288fbf00000000a020ff3fe000001c0d6051050d5030888888888888888818e8888111811801
000000ff3fe000000000008fbf000000009080888990000000a020ff3fe00000000097777777000000d6dd00005dd5008888888a888888880888888008e88880
000000ffff000000000000ff3fe000000000a08fbf000000000097777777000000008a88aaa800000c00005105000030088888a0088888810188881108888881
0000777777070000000000ffff000000000000ff3fe000000008aa88aaaa80000008aa88aaaa800001d00d110050050100888a00018888110118801101888811
00000777777000000000777777000000000000ffff000000000666ff66666000000666ff666660000116d011010050110008a000011880110111101101188011
00008a88aa8000000000077777770000000077777707000000556666566660000055666656666000005566665666600000770000000000000000000000000000
00008a88aaa8000000008a88aa800000000007777770000005566686656866000556666665666600055666666566660017977701110977011109700111079001
0008aa88aaaa800000008a88aaa8000000008a88aa80000056686866656686805668666665666680566668666566860079944970109777011109700110799901
000006ff666000000008aa88aaaa800000008a88aaa8000056666886665886605668888666568880566668866656886009499790107779011109770110974901
0000600000060000000006ff666000000008aa88aaaa800056568888666888605656888866688860565688886668886009499790077479000009770000979970
00000666666000000000600000060000000006ff6660000055668555666855665566855566685566556685556668556604977990074999010107701100999471
00006000000600000000066666600000000060000006000056665000566500565666500056650056566650005665005600444401010490110177701101094711
00066666666660000006666666666000000666666666600056665080566580565666508056658056566650805665805601000011011000110110001101177011
000000000000000000000000000000000000000000088882200000000000000000004006666600000000000000000000b0bb0b06666600005666655566665566
0000000000050500000000000008888220000000008888888880000000000000004400666666600000004006666600000b77b066666660000555666666006666
033333300056566000550000008888888880000008022888b500000000000000047b00ffff6660000044006666666000b77b7bffff6660000566566660606660
3b77bbb3059566000595550008022888b5000000002005c5d55000000000000004bbb0cffcf66000047b00ffff666000b7bb7bcffcf660000056566666666660
3bbbbbb30555000005556660002005c5d550000000088ddcdcdd00000000000004bb40f66fff600004bbb0cffcf660000b77b0f66fff60000005656666666660
03333330005550000055500000088ddddddd000000822933999200000000000000440068866f600004bb40f66fff6000b0bb0b68866f60000000556666666600
00000000000550000005500000822933999200000820293399992000000000000004006666f6600000440068866f60000004006666f660000000005656565600
000000000000000000000000082066556666600000006655666660000000000000400366666360000004006666f6600000400366666360000000000505050500
0006666000066666000666600000000055955955500500050555555000000000000f3366663336000040036666636000000f336666333600000b000000000b00
00666606006666000066660600977700599999950555555005955950000000000004003663363600000f33666633360000040036633636000b0bb0b000b0bb00
06666660066666600666666009944970559559550555555005555550000b0000000400363636f0600004003666363060000400363636f0600bb7bbb00bbbb7b0
0d6d6660056566600d6d666009499790533553b55555555505b33b50000300000004003363366600000400336366f60000040033633666003b777b7b3b7b777b
056566600565666005656660094997903d3333d3533553b553dffdb5000330000004003336336060000400333633606600040033363360603b77777b3b77777b
056566600565666005656660049779903fdffdfb3f3333fb3fdffdfb003330000000400333333606000400033363360000004003333336063b7777b33b7777b3
0606660006666660060666000044440053dffdb553dffd3553ffffb50033b30000000003333033600000400333330366000000033330336003bbbb3003bbbb30
006060600606060000606060000000000553b55005d33d5005333b5003333b000000000030330300000000000303300000000000303303000033330000333300
55550555000000000000000000000000000000000000c0000000c000000000c06666666600000000000000000000000000000000000000000000000000000000
55550555110dd101010100dddd00101011011101110c110111011c0111011c010000000011000000000000000000000000000000000000000000000000000000
000000001101110100100d0dd0d0010011011101110cc101110ccc011101ccc10000000011000100000000000007000000000000000000000000000000000000
50555555110111010100d00dd00d001011011101110ccc011101ccc1110cccc10000000011011000000a00000006000000000000000000000000000505000000
5055555500000000010d000dda00d0100000000000ccdc00000cdcc0000cdc000000000000000000000000000076600000000000000000000000005050500000
000000000dd11011010d00dddda0d01001111011011c5c1101115c1101115c110000000001111000000000000076600000000000000000000505000505050500
555555550111d011010d0d0dd0d0d010011110110111501101115011011150110000000001111010000000000766660000000000000000005050505050505050
5555555501111011010dd00dd00dd010011110110111501101115011011150110000000001111010000000000666660000000000000000000505050505050505
0000000005550550010d000dd000d010000000000000000099999999000000000000000000000000999999990666660000000000000000005050505000505050
1100110100000000010da0add000d0106628110169a111011f5555f11101110111011101000000000f5555f00766660000000000000000000505000005050500
1107010105505550010d00dddd00d010628881019aaa11011ffffff1160a91511509a161000000010ffffff00076600000000000000000000050000000505000
1106010105505550010d0d0dd0d0d010628881019aaa11011f5555f11166550111556601000000010f5555f00076600000000000000000000000000000000000
0076600000000000010dd00dd00dd010628880009aaa10000ffffff006aaa95005999a60000000000ffffff00006000000000000000000000000000000000000
0076601105555050010d000dd000d010628880119aaa10110ff555f10166551101556611001110110ff555f00007000000000000000000000000000000000000
0766660100000000010d000dd000d0106628101169a110110ffffff1061a90510519a061011110110ffffff00000000000000000000000000000000000000000
06666601055505500110dddddddd0110011110110111101101111011011110110111101101111011000000000000000000000000000000000000000000000000
00000000000000000666660042424277000000000000000077242424666655555555555c99099999999990998888888800088822000000000000000000000000
11066666666660110766660142424277110111011101110177242424168652511525cec194444444440444440600006000888888880000000000000000000000
00000000000000001076600142424277110191011101910177242424160821511502e1c190444444444444440600006008002888888800000008882200000000
66660111011066661076600156565277110999011109c90177555555116655011155cc0194404440444444440066660000022885b50000000088888888000000
6666011101106666000600005555527700999990009c8c9077555555006825000052ec00944444444444444406000060000205c5d55000000800288888880000
00000000000000000107001142424277011999110119c91177242424011820110112e0119444444444444444060000600000005c5c00000000022885b5000000
01066666666660110110101142424277011190110111901177242424011650110115c0119444444404444444006666000000dddddd0d0000000205c5d5500000
01100000000001110111101142424277011110110111101177242424011110110111101194444444444444400600006000000dddddd000000000005c5c000000
88888888060000608888888800066000060000604424424444244244000000000000000094444444444444440002222000008233992000000000dddddd0d0000
06666660060000601601116111066001060110604424424444244244111c30111113101194444444444444440888eee2000829339992000000000dddddd00000
666666666666666616011161000660000601106044244244442442441166d51111dd551194444444444444400008e62200822933999920000000823399200000
5055555550555555116666010606606006000060556556555555555516cd5351163d51519444444444444444008e666808202655666000000008293399920000
505555555055555506000060060000600606606055555555555555550066dd0000d5550090444444444444440008e62200006000000600000082293399992000
00000000000000000611106106011060000660004424424444244244061c3051061310519444444044444444088e666200000666666000000820265566600000
555555555555555501666611060110600106601144244244442442440166dd1101dd551104444444444444440082ee6800000060060000000000666666660000
555555555555555506111061060110600106601144244244442442440116d011011d501194044444440444440008222000000006600000000000000660000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffb00b331133113b77fb333300000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffbb3b3331111111bfbbf333300000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bb33333311111111bfffb3333000a000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333311111111ffbbb3330000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000033330111111111bbb33333000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000003301111111111b333333000000000000
000000000000000000000000000000000000000000000000000000000a000000000000000000000000000a000000000000011c11c11c11333333000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111333300000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000011111111111333333330000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011c11c11c11333333333300a00000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111111333333333300000000
000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000a0000000011111111111333333333333300000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000011111111111333333333333333300
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001111111111111113333333333333333
00000000000000000000000000000000000000000000000000a000000000000666666600000000000000000000000000011c111111111c113333333333333333
00000000000000000000000000000000000000000000000000000000000006666666666600000000000000000000000001111c1c1c1c11113333333333333330
000000000000000000000000000000000000000000000000000000000000666666d66666660000000000000000010101c11111111111111c1131313333000000
0000000000000000000000000000000000000000000000000000000a0006666ddd666666d6d660000000000000011111cc111111111111c11111113333333300
00000000000000000000000000000000000000000000000000000000006666d66666666d6d6d00000000000000011111ccc111111111111cc111113333300a00
0000000000000000000000000000000000000000000000000000000000066fffffff66d666d60000000000000001111ccc11118a821111ccc111113333300000
000000000000000000000000000000000000000000000000000000000066fdddfdddf6666d6600000000a00000011111c11111889299111c1111113330000000
000000000000000000000000000000000000000000000000000000000066ffcfffcff66d66d6d0000000000000011c111711112882111116111c113333000000
000000000000000000000000000000000000000000000000000000000066fffffffff666d66dd0000000000000011111171111ffff1111161111113333000000
00000000000000000000000000000000000000000000000000b000000006ff66666ff66666d00000000000000001111117111777671111161111110033300000
0000000000000000000000000000000000000000000000000b0000000006f66eee66f666dd0000000000000000011c111711117677111116111c110000000000
00000000000000000000000000000000000000000000000000b0000000006666666666dd00000000000000101011111117118668866211161111110101010000
000000000000000000000000000000000000000000000000bbb0b00000006666666b666dd0000000000000111111111117118aa8899911161111111111110000
0000000000000000000000000000000000000000000000000b7b0b000000b6666b6b6666dd000000000001111111111117182288828821161111111111110000
000000000000000000000000000000000000000000000000bb77b00b000b3b6666bbbb666d000000000001111111111117182888822821161111111111111000
0000000000000000000000000000000000000000000000000b7770bb00b3336666677b666d0000000000111111111111175ff5666d5ff5161111111111111000
000000000000000000000000000000000000000000000000b7ff7b000b33333666b77bb666600000555555555555555557555565555555565555555555555555
000000000000000000000000000000000000000000000000bf7ff000b3333333b3b777b6666000005555555555555555555556666dd555555555555555555555
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444444444444444444444144444441414444444444444444444444444444414141414441414445444444444444444444444444444444444444444
44444444444444444454444444444444444444444444444444444444444444444444444444444444000000000000000000000000000000000000000000000000
44444444729444444444444444441414141444141444444444447272727272727272724444444444141444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444444444444444444444444444444444444000000000000000000000000000000000000696979899900
15444444727272941444444444444444444472944444444444449472727272727272727272727272727244144444444444444444447214444444444444947272
72727272727272721444444444444444444472144444444444449472727272727272727272727244000000000000000000000000000000000000006a7a8a9a00
15444444947272727272445424727244444472727294444454444494727272727272727272727272727272727244542472724444447272724444445444449472
72727272727272727272445424727244444472727244444454444494727272727272727272727272000000000000000000000000000000000000006b7b8b9b00
15446767449472727272444425729544444494727272444444444444947272727295447295444444947272727244442572444444449472727244444444444494
72727272954444447272444425724444444494727272444444444444947272727295444444947272000000000000000000000000000000000000a8b8c8d8e8f8
15955757444444441444444444441444444444444444444444444444449472729544449544444444444444144444444444144444444444444444444444444444
94727295444444441444444444441444444444444444444444444444449472729544444444444444000000000000000000000000000000000000a9b9c9d9e9f9
15446767444444444444144444444444444444444444444444444444444494954444444444444444444444444414444444444444444444444444444444444444
44949544444444444444144444444444444444444444444444444444444494954444444444444444000000000000000000000000000000000000aabacadaeafa
15040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
04040404040404040404040404040404040404040404040404040404040404040404040404040404000000000000000000000000000000000000abbbcbdbebfb
__label__
00000000000000000000000000000000000000000000000000000aa0000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000aa0000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000005500550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000005500550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000550055005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000550055005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
50000005500550055005500000000000000000000000000000000000000000000000000000000000000aa0000000000000000000000000000000000000000000
50000005500550055005500000000000000000000000000000000000000000000000000000000000000aa0000000000000000000000000000000000000000000
05500550055005500550055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05500550055005500550055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
50055005500550055005500550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
500550055005500550055005500000000000000aa000000000000000000000000666666666666660000000000000000000000000000000000000000000000000
055005500000055005500550000000000000000aa000000000000000000000000666666666666660000000000000000000000000000000000000000000000000
05500550000005500550055000000000000000000000000000000000000006666666666666666666666000000000000000000000000000000000000000000000
50000000000550055005500000000000000000000000000000000000000006666666666666666666666000000000000000000000000000000000000000000000
50000000000550055005500000000000000000000000000000000000000666666666666dd6666666666666600000000000000000000000000000000000000000
00000000000005500550000000000000000000000000000000000000000666666666666dd6666666666666600000000000000000000000000000000000000000
0000000000000550055000000000000000000000000000000aa00000066666666dddddd666666666666dd66dd666600000000000000000000000000000000000
0000000000000000000000000005500550000000000000000aa00000066666666dddddd666666666666dd66dd666600000000000000000000000000000000000
000000000000000000000000000550055000000000000000000000066666666dd6666666666666666dd66dd66dd0000000000000000000000000000000000000
000000000000000000000000055005500550000000000000000000066666666dd6666666666666666dd66dd66dd0000000000000000000000000000000000000
0000000000000000000000000550055005500000000000000000000006666ffffffffffffff6666dd666666dd660000000000000000000000000000000000000
0000000000000005500550000005500550055005500000000000000006666ffffffffffffff6666dd666666dd660000000000000000000000000000000000000
00000000000000055005500000055005500550055000000000000006666ffddddddffddddddff66666666dd66660000000000000000000000000000000000000
00000000000005500550055005500550055005500550000000000006666ffddddddffddddddff66666666dd66660000000000000000000000000000000000000
00000000000005500550055005500550055005500550000000000006666ffffccffffffccffff6666dd6666dd66dd00000000000000000000000000000000000
00000000000000055005500550055005500550055005500000000006666ffffccffffffccffff6666dd6666dd66dd00000000000000000000000000000000000
00000000000000055005500550055005500550055005500000000006666ffffffffffffffffff666666dd6666dddd00000000000000000000000000000000000
00000000000005500550055005500000055005500550000000000006666ffffffffffffffffff666666dd6666dddd00000000000000000000000000000000000
000000000000055005500550055000000550055bb550000000000000066ffff6666666666ffff6666666666dd000000000000000000000000000000000000000
00000000000000055005500000000005500550055000000000000000066ffff6666666666ffff6666666666dd000000000000000000000000000000000000000
0000000000000005500550000000000550055bb55000000000000000066ff6666eeeeee6666ff666666dddd00000000000000000000000000000000000000000
00000000000000000550000000000000055005500000000000000000066ff6666eeeeee6666ff666666dddd00000000000000000000000000000000000000000
000000000000000005500000000000000550055bb00000000000000000066666666666666666666dddd000000000000000000000000000000000000000000000
000000000000000000000000000000000000000bb00000055005500000066666666666666666666dddd000000000000000000000000000000000000000000000
00000000000000000000000000000000000bbbbbb00bb0055005500000066666666666666bb666666dddd0000000000000000000000000000000000000000000
00000000000000000000000000000000000bbbbbb00bb5500550055000066666666666666bb666666dddd0000000000000000000000000000000000000000000
0000000000000000000000000000000000000bb77bb0055005500550000bb66666666bb66bb66666666dddd00000000000000000000000000000000000000000
0000000000000000000000000000000000055bb5577bb0055bb550055bb55bb66666666bbbbbbbb666666dd00000000000000000000000000000000000000000
0000000000000000000000000000000000055bb5577bb0055bb550055bb55bb66666666bbbbbbbb666666dd00000000000000000000000000000000000000000
00000000000000000000000000000000055005577557755bb550055bb55335566666666667777bb666666dd00000000000000000000000000000000000000000
00000000000000000000000000000000055005577557755bb550055bb55335566666666667777bb666666dd00000000000000000000000000000000000000000
00000000000000000000000000000000000557755ff55bb550055bb5533553355666666bb7777bbbb66666666000000000000000000000000000000000000000
00000000000000000000000000000000000557755ff55bb550055bb5533553355666666bb7777bbbb66666666000000000000000000000000000000000000000
000000000000000000000000000000000550b557755ff550000bb55335533553333bb33bb777777bb66666666000000000000000000000000000000000000000
000000000000000000000000000000000550b557755ff550000bb55335533553333bb33bb777777bb66666666000000000000000000000000000000000000000
0000000000000000000000000000000000055ff55fffbb0000b5533551155333111133bb7777ffbb333333330000000000000000000000000000000000000000
0000000000000000000000000000000000055ff55fffbb0000b5533551155333111133bb7777ffbb333333330000000000000000000000000000000000000000
000000000000000000000000000000000000055fffbbbb33bb33355315511111111111bbffbbbbff333333330000000000000000000000000000000000000000
000000000000000000000000000000000000055fffbbbb33bb33355315511111111111bbffbbbbff333333330000000000000000000000000000000000000000
0000000000000000000000000055005500000000bbbb3333333333331111111111111111bbffffffbb33333333000000aa000000000000000000000000000000
0000000000000000000000000055005500000000bbbb3333333333331111111111111111bbffffffbb33333333000000aa000000000000000000000000000000
00000000000000000000000055005500550000000000333333333333331111111111111111ffffbbbbbb33333300000000000000000000000000000000000000
00000000000000000000000055005500550000000000333333333333331111111111111111ffffbbbbbb33333300000000000000000000000000000000000000
0000000000000055005500000055005500550055000000003333333300111111111111111111bbbbbb3333333333000000000000000000000000000000000000
0000000000000055005500000055005500550055000000003333333300111111111111111111bbbbbb3333333333000000000000000000000000000000000000
000000000000550055005500550055005500550055000000000033330011111111111111111111bb333333333333000000000000000000000000000000000000
000000000000550055005500550055005500550055000000000033330011111111111111111111bb333333333333000000000000000000000000000000000000
00000000000000550055005500550055005500550055000000000000001111cc1111cc1111cc1111333333333333000000000000000000000000000000000000
00000000000000550055005500550055005500550055000000000000001111cc1111cc1111cc1111333333333333000000000000000000000000000000000000
00000000000055005500550055000000550055005500000000000000001111111111111111111111333333330000000000000000000000000000000000000000
00000000000055005500550055000000550055005500000000000000001111111111111111111111333333330000000000000000000000000000000000000000
00000000000000550055000000000055005500550000aa0000000000001111111111111111111111333333333333333300000000000000000000000000000000
00000000000000550055000000000055005500550000aa0000000000001111111111111111111111333333333333333300000000000000000000000000000000
00000000000000005500000000000000550055000000000000000000001111cc1111cc1111cc1111333333333333333333330000aa0000000000000000000000
00000000000000005500000000000000550055000000000000000000001111cc1111cc1111cc1111333333333333333333330000aa0000000000000000000000
00000000000000000000000000000000000000000000005500550000001111111111111111111111333333333333333333330000000000000000000000000000
00000000000000000000000000000000000000000000005500550000001111111111111111111111333333333333333333330000000000000000000000000000
0000000000000000000000000000000000000000aa00550055005500001111111111111111111111333333333333333333333333330000000000000000000000
0000000000000000000000000000000000000000aa00550055005500001111111111111111111111333333333333333333333333330000000000000000000000
000000000000000000000000aa000000005500550000005500550055005511111111111111111111333333333333333333333333333333330000000000000000
000000000000000000000000aa000000005500550000005500550055005511111111111111111111333333333333333333333333333333330000000000000000
00000000000000000000000000000000550055005500550055005511551155111111111111111111111133333333333333333333333333333333000000000000
00000000000000000000000000000000550055005500550055005511551155111111111111111111111133333333333333333333333333333333000000000000
000000000000000000000000000000000055005500550055005500551155115511111111111111cc111133333333333333333333333333333333000000000000
000000000000000000000000000000000055005500550055005500551155115511111111111111cc111133333333333333333333333333333333000000000000
00000000000000000000000000000000550055005500550000005511551155cc11cc11cc11cc1111111133333333333333333333333333333300000000000000
00000000000000000000000000000000550055005500550000005511551155cc11cc11cc11cc1111111133333333333333333333333333333300000000000000
0000000000000000000000000000000000550055001100110055cc5511551111111111111111111111cc11113311331133333333000000000000000000000000
0000000000000000000000000000000000550055001100110055cc5511551111111111111111111111cc11113311331133333333000000000000000000000000
000000000000000000000000000000000000550000111111111155cc551111111111111111111111cc1111111111111133333333333333330000000000000000
000000000000000000000000000000000000550000111111111155cc551111111111111111111111cc1111111111111133333333333333330000000000000000
0000000000000000000000000000000000000000001111111111cccccc111111111111111111111111cccc111111111133333333330000aa0000000000000000
0000000000000000000000000000000000000000001111111111cccccc111111111111111111111111cccc111111111133333333330000aa0000000000000000
00000000000000000000000000000000000000000011111111cccccc1111111188aa882211111111cccccc111111111133333333330000000000000000000000
00000000000000000000000000000000000000000011111111cccccc1111111188aa882211111111cccccc111111111133333333330000000000000000000000
0000000000000000000000000000aa0000000000001111111111cc1111111111888899229999111111cc11111111111133333300000000000000000000000000
0000000000000000000000000000aa0000000000001111111111cc1111111111888899229999111111cc11111111111133333300000000000000000000000000
0000000000000000000000000000000000000000001111cc111111771111111122888822111111111166111111cc111133333333000000000000000000000000
0000000000000000000000000000000000000000001111cc111111771111111122888822111111111166111111cc111133333333000000000000000000000000
0000000000000000000000000000000000000000001111111111117711111111ffffffff11111111116611111111111133333333000000000000000000000000
0000000000000000000000000000000000000000001111111111117711111111ffffffff11111111116611111111111133333333000000000000000000000000
00000000000000000000000000000000000000000011111111111177111111777777667711111111116611111111111100003333330000000000000000000000
00000000000000000000000000000000000000000011111111111177111111777777667711111111116611111111111100003333330000000000000000000000
0000000000000000000000000000000000000000001111cc111111771111111177667777111111111166111111cc111100000000000000000000000000000000
0000000000000000000000000000000000000000001111cc111111771111111177667777111111111166111111cc111100000000000000000000000000000000
00000000000000000000000000000000110011001111111111111177111188666688886666221111116611111111111100110011001100000000000000000000
00000000000000000000000000000000110011001111111111111177111188666688886666221111116611111111111100110011001100000000000000000000
00000000000000000000000000000000111111111111111111111177111188aaaa88889999991111116611111111111111111111111100000000000000000000
00000000000000000000000000000000111111111111111111111177111188aaaa88889999991111116611111111111111111111111100000000000000000000
00000000000000000000000000000011111111111111111111111177118822228888882288882211116611111111111111111111111100000000000000000000
00000000000000000000000000000011111111111111111111111177118822228888882288882211116611111111111111111111111100000000000000000000
00000000000000000000000000000011111111111111111111111177118822888888882222882211116611111111111111111111111111000000000000000000
00000000000000000000000000000011111111111111111111111177118822888888882222882211116611111111111111111111111111000000000000000000
0000000000000000000000000000111111111111111111111111117755ffff55666666dd55ffff55116611111111111111111111111111000000000000000000
0000000000000000000000000000111111111111111111111111117755ffff55666666dd55ffff55116611111111111111111111111111000000000000000000
00000000000000000000444444444444444444444444444444445577444444446655444444444444556644444444444444444444444444444444000000000000
00000000000000000000444444444444444444444444444444445577444444446655444444444444556644444444444444444444444444444444000000000000
0000000000000000000044444444444444444444444444444444444444445566666666dddd554444444444444444444444444444444444444444000000000000
0000000000000000000044444444444444444444444444444444444444445566666666dddd554444444444444444444444444444444444444444000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
00000000000000000000f0f0005050500000000000008484848484846060606000848400000000000000000084842484848484008484000025000000000000000200000000300000000000040000000004020000101011f0f00011040000000042420421000120f0f00000000000000008080042420000f0f000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4040404040404040404040404040404040404040404040404040404040404040404040404040404444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444444444444444444444444444444444444444444444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444444444441414144444444444444444144444444414444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444444444141444141454444414145414144454441414141444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444444444144444444414441444144414441444141444145446375444544514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
514444444444444444444441414444444444414444445644444441444444440d416375414144514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
511c444444444444444444564444445044444144504441445044414450514444446375444141514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444440404040404040404040404040404040404040404040404040404040404040514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5140404044444444444444444444444444444444444444444444444444444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444444444444444444444444444444444444444444444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444544444444444444454444444444454444444445444444444444414141444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444444444444444444444444444444444444444444444444414144444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444444444444444444444444444444444444444444444444414441444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444444444451444444564444444444444444444444444444444444414444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5140404070707070404040404040444440404044444440404044444040404040444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
51444444444444444444444444444444444444444444444444444444444444444441441c4444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444444444444444444444444444444444441444445444444444444445644514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444444444444444444444444444444454444444444414144444440404040514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444441444444444444454441444441444444444441444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444141414444444141444444444444444444414444444040404444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444444444441444444444144444444444156444440404044444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444446544444441444444444444444440404040444444444444444144444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
51444444444444444444414444404040404444414444444444444444414141444444444444445144444444444444444444444444444444aeaf4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
51444444444440444444444444444444444444444444444441414444414444444441414441445144444444444444444444444444444444bebf4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444456444040404044444444444444444444444444444444444444444440444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
4040404040404040404040404040404040404040404040404040404040404040404040404040404444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
__sfx__
010a0000070520704207735070002b525000002b51500000070520704207735130052b52500000370150000005052050420572200000295250000027515000000305203042037250000002052020422651500000
010a0000070500704007035000002b525000003701500000070500704007035000002b52500000370150000005050050400502500000295250000035015000000205002050020250305003050030250505005025
010500000275202752027520274202742027320272202725265250070000700007002b5250070000700007000275202752027420274202722027250070000700265253c70018700007002b525007000070000700
010a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a0501a0250000000000
010a00001f0301f0221f0150000000000000003202500000370150000000000000001d0321d02500000000001d0321d0251b0321b0251a0321a0250000000000320150000000000000001a0321a0250000000000
010a00001f0301f0221f0250000000000000003202500000370150000000000000001d0321d02500000000001d0321d0251b0321b0251a0321a02500000000001a0301a0221a0151b0301b0221b0151d0301d022
010a00001f0301f0321f0250000000000000003202500000370150000000000000001d0321d02500000000001d0321d0251b0321b0251a0321a02500000000001f0301f0321f0250000020032200250000000000
010a00001f0301f0321f0250000000000000003202500000370150000000000000001d0321d02500000000001d0321d0251b0321b0251a0321a02500000000001a040000001b040000001d040000000000000000
010500001a0411a0411a0311a0211a0411a0411a0311a025370250000000000000000000000000000001a0001a0411a0411a0311a0211a0411a0411a0311a0253702500000000000000000000000000000000000
010a00000205002025000000000026515000003701500000020500202500000030500302505050050250000002050020250000000000265150000037015000000205002025000000305003025050500502500000
010a00000205002025000000305003025000000505005025020500202500000030500302500000050500502502050020250000003000265250500005000000000205002025000000000026525000000000000000
010a00001a0401a0251800000000320150000000000000001a0401a025180001b0401b0251d0401d025180001a0301a0251800018000320151800018000180001a0301a025180001b0301b0251d0301d02518000
010a00001a0401a025180001b0401b025180001d0401d0251a0401a025180001b0401b025180001d0301d0251a0301a0251800018000330151800018000180001a0301a025180001800032015000000000000000
01090000020500204002030020250e0500e0200e01500000030500304003030030250f0500f0200f01500000020500204002030020250e0500e0200e01500000030500304003030030250f0500f0200f01500000
01090000020500204002030020250e0500e0200e01500000030500304003030030250f0500f0200f01500000020500204002030020250e0500e0200e015000000505005040050300502511050110201101500000
010900001f0321f0321f0250000000000000001a0321a025000000000000000000001a0321a0321a02500000000000000000000000001b0321b0251b005000001d0421d0251b0321b0251a0321a0250000000000
0109000000000000001a0321a0251b0321b02500000000001d0321d02500000000001b0321b02500000000001f0301f0221f025000001d0321d0250000000000200302002220025000001f0301f0221f02500000
010900001f0321f0321f0250000000000000001a0321a025000000000000000000001b0301b0321b025000001a0301a0321a025000001d0321d02500000000001d0421d0251b0321b0251a0321a0250000000000
0109000000000000001a0421a0251b0321b02500000000001d0321d02500000000001b0321b025000000000020032200251f0321f0251e0321e0251f0321f02522042220251f0321f02520032200251f0321f025
01090000020500204002030020250e0500e0200e01500000030500304003030030250f0500f0200f0150000008050080400803008025140501402014015000000705007040070300702513050130201301500000
01090000020500204002030020250e0500e0200e01500000030500304003030030250f0500f0200f01500000020500204002030020250e0500e0200e015000000305003040030300302503050030200301500000
01090000020500204002030020250e0500e0200e01500000030500304003030030250f0500f0200f01500000020500204002030020250e0500e0200e015000000505005050050400503505050050400503500000
010900000000000000260222602527030270252602026025290202902500000000002702227025000000000029020290250000000000270222702500000000000f0500f0400f0300f0250f0500f0200f01500000
0109000000000000002602226025270302702526020260252b0202b02500000000002902029025000000000029030290250000000000270222702500000000001105011050110401103511050110401103500000
010900000000000000260222602527030270252602026025290202902500000000002b0202b02500000000002c0302c02500000000002b0202b02500000000000f0500f0400f0300f0250f0500f0200f01500000
010900000000000000260222602527030270252602026025290202902500000000002b0202b025000000000014050140501404014035140501404014035000001305013050130401303513050130401303500000
01090000020500204002030020250e0500e0200e01500000030500304003030030250f0500f0200f0150000008050080400803008025080500802008015000000705007040070300702507050070200701500000
010900000c0531370213732137252741513705000003c0000c053000001173211725274151170503502000000c053000000f7220f725274151300000000000000c053000000e7120e7150c0530e7050350200000
010a00000c053075150010503001270250000002515000000c053075150000000000270250000002515000000c053075150000000000270250000002515000000c0530751500000000000c053021050251500000
010e000007742077420770007700167420774207700077000a7400a7200a7400a7200a7300a7200a7300a72016722077420770007700077420774207700077000a7420a7300a7420a7300b5220b7300b7320b730
010e00000c053006000000000000274150000000000000000c05300000000000000027415000000c063000000c053000000000000000165321552213522000000c05300000000000000016532155221352200000
010e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a032
010e00001f0301f0221f0151f0001f000000000000000000000000000000000000002103021022210150000022030220222201500000000000000000000000002403024022240152203022022220152103221025
010e0000220302202222015000000000000000000000000000000000000000000000000000000021030220302103021022210150000000000000001f030210301f0301f0221f015000000000000000000001a030
010e00001f0301f0221f0150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001d0301d0221d0151b0301b0201b0151a0301a025
010e00001a0301a0221a015000000000000000000000000000000000000000000000000000000000000000001d0301d0201d0151b0301b0201b0151a0301a0251f0301f0201f0221f0121b0301b0201b0221b015
010e00001a0301a0201a0221a01200000000000000000000000000000000000000000000000000000002603027030270202701200000000000000000000000002603026020260220000000000000000000024030
010e00002603026022260150000000000000000000000000240302402224015000000000000000000002203024030240222401500000000000000000000000002603026020260122203022022220151f03000000
010e00001f0301f0221f0150000000000000000000000000240302402224015220302202222015210300000021030210202102221012000000000000000000002603026020260122403024022240152203000000
010e00002203022020220222201500000000000000000000260302602026012270302702027012260302601224030240222401526030260202601224030240152203022022220152103022030220152103021015
010a00001f0101f0151a5321a0151b5321d0151a5221a0151d5321b0151a0101a0151b0101b0151a0101a0151b5321b0151a5321a0151b0101b0151a0101a0151d0101d0151a0101a0151b0101b0151a0101a015
010a00001f0101f0151a5321a0151b5321d0151a5321a0151d5321b0151a0101a0151b0101b0151a0101a015205321b0151f5321a0151b0101b0151a0101a015200202001520020200152002020010200151a005
010a00000c053000000c053137050c0531a5051a531000000c053000000f7020f7050c0531a5051a521000000c053000000e7020f7050c0531a5051a511000000c053000000c053277020c053000002740500000
010a0000070500702513030130150505005025110301101503050030250f0300f01502050020250e0300e01503050030250f0300f01502050020250e0300e0150505005025110301101503050030250f0300f015
010a0000070500702513030130150505005025110301101503050030250f0300f01502050020250e0300e01503050030250f0300f01502050020250e0300e0150805008025080300802508050080400802000000
010a00000c0530000000003137050c0531a5051a521262000c053000000f7020f7050c0531a5051a5211a5050c053000000e7020f7050c0531a5051a5211a5050c053000000c053277020c0531a5052740500000
010a00001f0101f0151a5421a0151d5421d0151a0201a0151b5421b0151a0201a0151b0301b0151a0301a0151654216532165251a005145421453214525140051354213532135251a00014041140321402514000
010b0000070500000013030000000504000000110300000003040000000f0400000002050000000e050000000a5420a5321652502005085420853214525140050754207532135250e10008041080320802500000
011c00000c0631f000285150473518615000001d0000c0530c0531b0002851504735186151b0001a0001a0000c0631650026515027351861514500000000c0530c05313500265150273518615140001400000000
011c000028720287123c7051a7001351010511135251a000135151a7011d705000002b7202b7123c7050070026720267123c7051a700115100e5111152514700115151a7011d7051a70024720247123c70500700
011c00000903009022100201001209010090151072010012000000300010020100150903009022107201001507030070220e7200e01207010070150e0200e01214000070000e7200e01507030070220e7200e015
010200002d0322d0372d0302d02532022320123201232012320123201232012320123201232012320123201524002240020000200002000020000200002000020000200002000020000200002000020000200002
0102000008560085600856008050090500a5500a5500b0500b0500b0400c7400c7400d7400d0300d0200d01000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100001856018560185501854018720187100050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
01080000140501b750165500b1201105018750125500a12010050167500e550091200d05014750081200555008550075500855007550085500755008550075500855008550085500855008550085500855008550
0104000013030101300e1300c14009140090400715006150031500315003150041500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010d000020031290212d0112700029700297002970029700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500001e1331b5320c13214542080320e552060420a551051450a56000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000000
00050000191330a543071320e54208032145420a0321b5510f1451b56000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01040000260202652226520260222d7222d7222d5222d525000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01020000290102901029010295102e0102e0102e0102e0102e5102e510330103301033010335103351038010380103801038510385103a0103a0103a0103a5103a50000000000000000000000000000000000000
010200001f0101f51500000000000000000000000000000018010185150000000000000000000000000000001f0101f5150000000000000000000000000000000000000000000000000000000000000000000000
011000001b1431b1331b1231b11300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 00424344
00 00031c44
01 00041c44
00 00061c44
00 00071c44
00 01051c44
00 090b1c44
02 0a0c1c44
00 0d4c1b44
00 0e421b44
01 0d0f1b44
00 0e101b44
00 0d111b55
00 13121b44
00 14161b44
00 15171b44
00 14181b44
02 1a191b44
00 1e1d4344
00 1e1d1f44
01 1e1d2044
00 1e1d2144
00 1e1d2244
00 1e1d2344
00 1e1d2444
00 1e1d2544
00 1e1d2644
02 1e1d2744
00 41422b44
00 41422c44
01 282d2b44
00 292a2c44
00 282d2b44
00 292a2c44
00 2e2d2f44
02 2e2a2f44
<<<<<<< HEAD
03 30313244

=======
03 30313244
>>>>>>> upstream/master
