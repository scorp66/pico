﻿pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

--init
function _init()
hero = {}
movement = {}
col = {} -- colide position
max_colide_count = 2
hero.hp = 3
hero.is_crouch = false
hero.coins = 0;
hero.x = 2*8
hero.y = 61*8
d_timer = 0
g_time = 1

time_crouch = 0
max_time_crouch = 40
movement.x = hero.x
movement.y = hero.y
dash = 0
dash_sg = 20
levels=
{
 "64x47 81 68x80 , 81 68x5 66 67 68x4 66 67 68x20 81 68x12 81 68x80 , 81 68x2 65x3 82 83 65x3 68 82 83 68x2 65 68x17 81 68x12 81 68x80 , 81 65x3 68x12 65x2 68x12 99 117 68x2 81 68x12 81 68x80 , 81 65x2 68 81 64x11 68 65x2 68x9 81 68 99 117 68x2 81 68x12 81 68x80 , 81 68 65x2 81 68x23 81 68 99 117 68x2 81 68x10 69 68 81 68x80 , 81 68 65 13 81 68x21 64x8 81 68x12 81 68x80 , 81 65x2 68 81 68 65 68x9 81 68x30 81 68x80 , 81 65 68x3 65 68x4 69 68x5 81 68x5 112x3 68x19 81 64x2 81 68x80 , 81 68x3 101 68x2 81 68x8 81 68x27 81 98x2 81 68x80 , 81 68x6 81 68x4 65 68x3 81 112x5 68x3 65x3 68x16 81 68x2 81 68x80 , 81 64x6 81 68x4 65x3 68x8 65x3 69 68 65x3 68x13 81 68x2 81 68x80 , 81 68x4 81 68x8 65x10 68x7 65x2 68x11 81 68x2 81 68x80 , 81 68 118 102 68 81 68x6 65 68x19 65 68x11 81 66 67 81 68x80 , 81 68 118 102 68 81 68x2 112x4 68x32 81 82 83 81 68x80 , 81 68 118 102 68 81 68x2 64x4 68x14 80 68x3 64x2 68x3 28 68x8 81 68 13 81 68x80 , 81 68x4 81 68x7 112x3 64x3 81 68x3 81 64x8 68x6 28 68x5 81 68x2 81 68x80 , 81 68x4 81 68x13 81 68x3 81 68x9 28 68x10 81 68x2 81 68x80 , 81 68x4 81 68x13 81 68 69 68 81 68x9 112x3 68x3 28 65 68x3 81 68x2 81 68x80 , 81 68x4 81 68 65x4 68x8 81 68x3 81 68x16 65x2 68x2 81 68 65 81 68x80 , 81 68x4 81 68 65 68x2 65x2 68x7 81 80x3 81 68x13 112x3 68 65x2 68 81 65x2 81 68x80 , 81 68x4 81 65x2 68x3 65 68x7 81 64x3 81 68x13 64x3 68x2 65 68x2 65 68 81 68x80 , 81 68x4 81 65 68 81 68x2 65 68x9 98 68x18 65x6 68 81 68x80 , 81 68x4 81 65 68 81 68x29 65x3 68x6 81 68x80 , 81 68x4 81 65x2 81 68x5 65x3 68x20 65x2 68x2 81 64x5 81 68x80 , 81 68x4 81 68 65 81 68x3 69 65x2 68x3 69 68 65 68x3 69 68x3 69 68x8 65 68x3 81 98x5 81 68x80 , 81 65x2 68x2 81 68 65 81 68x14 65x2 68x11 81 64x4 81 68x5 81 68x80 , 81 68 65 101 68x2 65x2 81 68x7 80 68x9 80 68x10 98x5 68x5 81 68x80 , 81 68x2 65x4 68 81 68x7 81 68x4 80 68x4 81 68x4 80 68x4 81 80x10 81 68x80 , 81 64x7 81 64x38 81 68x80 , 68x128 , 68x128 ",
 "68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 ",
 "68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x128 , 68x18 81 64x14 81 68x94 , 64x18 81 28 68x12 28 81 64x14 68x80 , 81 28x4 81 98x12 81 28 68x12 28 81 68x13 81 68x80 , 81 68 28 13 68 81 68x12 81 28 68x11 13 28 81 68x13 81 68x80 , 81 68x4 81 68x12 81 64x3 81 68 53 68x4 81 64x3 81 68x13 81 68x80 , 81 68x4 81 68x12 81 98x3 81 68x6 81 98x3 81 68x2 101 68x2 81 68x7 81 68x80 , 81 64x2 68x2 81 84 68x29 13 68x2 81 68x7 81 68x80 , 81 68x4 81 96 68x11 81 64x25 81 68x2 81 68x80 , 81 68x4 81 68x12 81 28 68x24 81 68x2 81 68x80 , 81 68x4 81 68x12 81 28 68x24 81 68x2 81 68x80 , 81 68x4 81 68x12 81 53 68x24 81 68x2 81 68x80 , 81 68x4 81 68x4 99 117 68x6 81 28 68x27 81 68x80 , 81 64x2 68x2 81 68x4 99 117 68x6 81 64x5 81 68x22 81 68x80 , 81 68x4 81 68x4 99 117 68x6 81 68x5 81 64x3 68x13 81 68x5 81 68x80 , 81 68x4 81 64x12 81 68x15 64 56 64x4 68 81 64x2 81 68x2 81 68x80 , 81 68x4 81 98x12 81 68x25 81 80x2 81 68x80 , 81 68x4 81 68x12 81 68x25 81 64x2 81 68x80 , 81 68x4 81x2 68x11 81 68x10 112x3 68x15 81 68x80 , 81 68x5 81 68x11 81 68x10 64x3 68x14 13 81 68x80 , 81 68x2 112x2 81 68x12 81 68x3 81 68x9 80 68x14 81 68x80 , 81 68x9 65x2 68x6 81 68x3 81 56 64x5 68x3 64x5 68x10 81 68x80 ",
 "81 68x10 65x2 68x5 81 68x24 64 68x3 81 68x80 , 81 68x7 65x6 68x4 81 68x21 64x4 68x3 81 68x80 , 81 68x5 65x2 68x3 65x2 68 81 68x3 81 68x28 81 68x80 , 81 68x5 65 68x4 65 68x2 81 68x3 81 64x2 68x26 81 68x80 , 81 64x5 68x3 64x5 81 68 101 68x2 98x2 68x26 81 68x80 , 81 68x8 81 68x14 81 68x4 48 68x3 28 68x4 81 68x8 81 68x80 , 81 68x8 81 68x3 65x2 64x32 81 68x80 , 81 65 68x4 112x2 68 81 68 65x2 68x3 65 68x27 65 68 28 81 68x80 , 81 68x5 65 68x2 81 68 65 68x4 65x2 68x4 65 68x4 65 68x2 69 68x2 65 69 68x3 69 68x3 69 68 65 68 13 81 68x80 , 81 68x8 81 68x18 112 64x18 81 68x80 , 81 68x8 81 68x11 66 67 68x23 65 81 68x80 , 81 68x5 64x3 81 68x4 13 68x3 65x2 68 82 83 68x7 65 68x14 65 68 81 68x80 , 81 64x2 68x44 81 68x80 , 81 68x12 64x6 68x6 64 81 68x20 81 68x80 , 81 68 65x2 68x9 65x2 68x3 56 64x6 68 81 68x20 81 68x80 , 81 65 68x3 65 68x5 65x2 68x3 65 68x5 65x2 68x2 81 65 68x6 65 68x9 65 68x2 81 68x80 , 81 68x4 65x2 68x4 65 68x4 65x2 68x4 65 68 28 68 81 56 64x5 81 68x5 101 68x4 65 68x2 81 68x80 , 81 68x32 81 68x13 81 68x80 , 81 64x2 112x3 64x37 81 68x3 81 68x80 , 81 68x11 81 68x30 81 68x3 81 68x80 , 81 68x8 65 68x2 81 68x4 28 68x15 29 68x9 81 13 68x2 81 68x80 , 81 68x8 65 68x2 81 68x9 53 68x20 81 68x3 81 68x80 , 81 68 65x2 68x4 65x3 68 81 68 65 68x7 53 68 65x2 68x9 65x2 68x4 53 68 81 68x3 81 68x80 , 81 28 68x7 65 68x37 81 68x80 , 81 68x5 64x41 81 68x80 , 81 64x2 68x44 81 68x80 , 81 68x11 65 68x3 65 68x5 65x2 68x3 65 68x16 65 68x2 81 68x80 , 81 68x3 69 68x2 65 68x8 65x2 68 66 67 68 65 68x4 65x2 68x6 65 68x8 65 68x2 81 68x80 , 81 68x15 69 68x2 82 83 68x2 69 68x7 69 68x2 65x3 68x2 69 68x4 118 102 68 81 68x80 , 81 68x7 13 68x26 65 68x6 101 68 118 102 68 81 68x80 , 81 68x11 81 48x2 68x13 81 48 68x5 65 68x2 81 68x2 65 68x2 118 102 68 81 68x80 , 64x3 112x4 64x40 81 68x80 "
}

current_level = 1
endlvl_x = 33*8
endlvl_y = 43*8

hero.sx = 1 -- speed
hero.sy = 1 -- speed
jump_power = 3.9
hero.on_flore = false
gravity = 0.3
time_damage = 1
second_save = 3
save_ef_speed = 21
save_form = false
img = 0
max_frame = 3
speed = 5
last = 0
lov_gr_time = 0
gr_max_time = 70

low_sp_x = 1
low_sp_y = 1

low_g_pow_x = 1.2
low_g_pow_y = 0.1

torch_arr = {}
dash_tail_arr = {}
boss_arr = {}
sprires_heart = {13,14,15}

sprires_enemy = {48,49,50}

sprites_coin = {28,29,30,31}


level_initialiation()
current_level = 1
my_time=0
mm_pos = 0
mm_status = 0
mm_max_button = 3
lm_pos = 0
lm_max_button = 3
tr_str = ""
xpow = 1
action = true
ex_hero = {}
end
current_dial = 0
dialogues = {
"press jump to ⬆️",
"warning! spikes are \n most dangerous",
"springboards make \n your jump better",
"collect heart \n and you're will be \n stronger",
"torches are not \n danger",
"collect coin!",
" ",
"goodbue 😐"}
function level_initialiation()

point_zone = find_point_zone(1)
low_grav_zone = find_point_zone(65)
button_zone = find_point_zone(16) 
button_ex()
chains_zone = find_point_zone(66)
chains_ex()
boss_arr = find_point_zone(36)
boss_arr = normilize(boss_arr)
boss_ex()
torch_arr = find_point_zone(48)
heart_arr = find_point_zone(80)
coin_arr = find_point_zone(96)
dial_arr = find_point_zone(17)
dial_ex()
enemy_arr = find_point_zone(132)
enemy_ex()

end


-->8
--update
function _update()

if mm_status == 0 then 
 main_menu_update()
elseif mm_status == 1 then
 if(stat(16) == -1 and 
 stat(16)== -1 and
 stat(16) == -1) then 
 //music(0)
 end
 game_update()
elseif mm_status == 3 then
 level_menu_update()
else
 game_over_update()
 end
end

function main_menu_update()

if btnp(⬆️) then
sfx"56"
mm_pos = mm_pos <= 0 and mm_max_button-1
                     or mm_pos-1
end

if btnp(⬇️) then
sfx"56"
mm_pos = (mm_pos+1)%mm_max_button
end

if btnp(❎) then
sfx"56"
mm_status = mm_pos+1
end

end


function level_menu_update()

if btnp(⬆️) then
sfx"56"
lm_pos = lm_pos <= 0 and lm_max_button-1
                     or lm_pos-1
end

if btnp(⬇️) then
sfx"56"
lm_pos = (lm_pos+1)%lm_max_button
end

if btnp(❎) then
sfx"56"
if lm_pos == 1 then 
 set_lvl(1)
elseif lm_pos == 2 then 
 set_lvl(2) 
end
 
 mm_status = 1

end
end

function game_update()
key_control()
my_time+=1

if dash_sg < 20 then
 dash_sg += 0.5
end 
check_dt_arr()
if #dash_tail_arr != 0 then
 update_dt_arr()
end

update_enemy(enemy_arr)
update_boss(boss_arr)

--if (flr(hero.x) == flr(endlvl_x) and
--    flr(hero.y) == flr(endlvl_y)) then
--set_lvl(1)
--end
update_enemy(enemy_arr)



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
hero.hp = 3
hero.x = point_zone
           [point_zone.last].x*8
hero.y = (point_zone[
         point_zone.last].y-1)*8
mm_status = 0
go_start = 0
end
end

function go_init()

if go_start == 0 then
go_start = 1
music(-1)
sfx(57)
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
-->8
--movement
function key_control()
crouch = 
      hero.is_crouch and 0 or 1

--save zone
update_ex_h(hero)
col = collide(ex_hero,1,is_b,1,crouch)
if col ~= nil and col.x ~= nil
 then
sfx"62"
off_points(point_zone,101)
update_point(col,point_zone,100,
                    save_method)
end

--low gravity zone
update_ex_h(hero)
col = collide(ex_hero,65,is_b,1,crouch)
if col ~= nil and col.x ~= nil
 then
--sfx(63)
lov_gr_time = 1
off_points(low_grav_zone,87)
update_point(col,low_grav_zone,88,
                    save_method)
end

lov_gr_time = lov_gr_time%
                     gr_max_time

low_sp_x = 1
low_sp_y = 1
if lov_gr_time > 0 then
lov_gr_time+=1
low_sp_x = low_g_pow_x
low_sp_y = low_g_pow_y
end

--end lvl check
update_ex_h(hero)
col = collide(ex_hero,33,is_b,1,1)
if (col ~= nil and
    col.y ~= nil) then
if current_level != lm_max_button then
set_lvl(current_level)
current_level += 1
end
end

--♥eard
update_ex_h(hero)
col = collide(ex_hero,80,is_b,1,crouch)
if col ~= nil and col.x ~= nil
 then
   update_point(col,heart_arr,68,
                    save_method)
   hero.hp +=1 
   sfx"63"     
end  

--coin

update_ex_h(hero)
col = collide(ex_hero,96,is_b,1,crouch)
if col ~= nil and col.x ~= nil
 then
   update_point(col,coin_arr,68,
                    save_method)
   hero.coins +=1
   sfx"54"      
end 

--button zone
if (button_zone[0] ~= nil) then
n = no_map_cols_n(hero,
             button_zone,16,0)
if n ~= nil
 then
button_method(n)
else
action = -1
end

update_chains()
end
--thorns
update_ex_h(hero)
col = dist_to_col(ex_hero,2,is_b2,1,crouch)
if ((col  ~= nil and
col.x <= hero.sx) or
(col  ~= nil and
col.y <= hero.sy))
and not save_form
 then
 hero.hp-=1
 sfx"58"
 save_form = true
end
update_save_form()

jump_s_b = false

--springboards
update_ex_h(hero)
col = dist_to_col(ex_hero,3,is_b2,1,1)
if (col  ~= nil and
col.y <= hero.sy) or 
(col  ~= nil and
col.x <= hero.sx) 
 then
 sfx"59"
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
hero.sy += g_time * gravity*low_sp_y

if coly ~= nil then

 if coly.y <= hero.sy then
 hero.sy = -2*sgn(hero.sy)
else
  hero.y = ((hero.sy ~= 0 and
  coly.y-9 <= 0) and
  not hero.is_crouch) and
       flr(hero.y/8)*8 or hero.y
  
  hero.sy = coly.y-9 <= 0 and 0 
                or coly.y-9
  end
end

        
xd = abs(flr((hero.sx-1)/2)) //kostil


if colx ~= nil and
colx.x <= hero.sx-(12*xd)
 then
if (hero.sy == 0 or 
 hero.is_crouch)
  then
  hero.sx *= -1
  else
  xpow = 0
  end
double_jump() 
end

xpow = (colx == nil or 
 hero.on_flore) and 1 
or xpow
       
update_ex_h(hero)
ex_hero.sy = -1
coly = dist_to_col(ex_hero,1,is_b2,1,1)
if(btnp(⬆️)
 and not hero.is_crouch
 and hero.on_flore)
 and coly == nil then
 sfx"55"
 hero.sy -= jump_power
end



hero.x += hero.sx*xpow*dash*low_sp_x*g_time
hero.y += hero.sy*g_time
--
update_ex_h(hero)
ex_hero.sy = 1
coly = dist_to_col(ex_hero,1,is_b2,1,1)
hero.on_flore = hero.sy == 0 and
 coly ~= nil and coly.y-9 >= 0

--dash
update_ex_h(hero)
ex_hero.sx = sgn(hero.sx)
col = dist_to_col(ex_hero,1,
                     is_b2,1,1)
if dash > 1 and col ~= nil then
hero.sx *= -1
xpow = 1
end


dash = 1
if ((btn(➡️) and hero.sx > 0) or
 (btn(⬅️) and hero.sx < 0))and
 not hero.is_crouch then
dash = d_timer < dash_sg and 4 or 1
d_timer += 1
if dash_sg > 0 then  
 dash_sg -= 2 
end

else
d_timer = 0
end
--
-- crouch
update_ex_h(hero)
ex_hero.sy = -1
col = dist_to_col(ex_hero,1,
                     is_b2,1,0)
hc_p = hero.is_crouch
hero.is_crouch = false
if (g_time>0 and btn(⬇️)) or 
(col ~= nil and abs(col.y) > 1) then
dash_sg = dash_sg > 0 
             and dash_sg-1 or 0

if (dash_sg > 0)or 
(col ~= nil and abs(col.y) > 1)
 then
hero.is_crouch = true
end

end


if hc_p and hero.sy == 0 and 
     hc_p ~= hero.is_crouch then
hero.y -=8    
end

--

end


function double_jump()
update_ex_h(hero)
ex_hero.sy = -1
coly = dist_to_col(ex_hero,1,is_b2,1,1)
if btnp(⬆️)  and hero.sy > 0 and
coly == nil 
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
-- checkers & updaters

--save_zone★
function save_method(zone,i,blk)
  zone[i].is_active = true
  zone.last = i
  mset(zone[i].x,zone[i].y,blk)
end

--button_zone
function button_method(zone)

if action ~= zone+1 then
  action = zone+1
  sfx"61"
  button_zone[zone].is_active = 
           not button_zone[zone].is_active
  chains_method()

end
end


--chains
function chains_method()
local n_b 
local c_b
local j_siz

 for i = 0, #chains_zone, 1 do
 j_siz = #chains_zone[i].b
  j = 0
  while j <= j_siz do

    n_b = chains_zone[i].b[j]
    c_b = button_zone[n_b]

   chains_zone[i].is_active = 
    c_b.is_active
   j = c_b.is_active and j+1
                      or j_siz+1
  end
  
  if chains_zone[i].is_active
   ~= chains_zone[i].buf_st
  then
  chains_zone[i].ch = 0
  sfx"60"
  chains_zone[i].buf_st = 
       chains_zone[i].is_active
  end
  
  
 end
end



function update_chains()

if(chains_zone[0] ~= nil) then
 for i = 0, #chains_zone, 1 do
 
  if(not chains_zone[i].is_active)
   then
    draw_chains(i)
    else
     delete_chains(i)
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
   d.s2 = 116
   end
 return d
end



function draw_chains(i)

local ch_obj = chains_zone[i]
local ch =  ch_obj.ch
local dir_c = ch_obj.d
local n = chains_zone[i].d.s
local n2 = chains_zone[i].d.s2
local x = ch_obj.x+(dir_c.x*ch)                  
local y = ch_obj.y+(dir_c.y*ch)

local a = not (is_b2(x*8,y*8,1) == 1) or
              (x == ch_obj.x and
               y == ch_obj.y)
local a1 = not (is_b2(
            (x+dir_c.x)*8,
            (y+dir_c.y)*8,1) == 1)

if a  then
read_ch(i,x,y)
mset(x,y,
 dir_c.x+dir_c.y==1 and n or n2)
ch_obj.ch = ch+1
end


if (a and a1) then
read_ch(i,x+dir_c.x,y+dir_c.y)
mset(x+dir_c.x,y+dir_c.y,
 dir_c.x+dir_c.y==1 and n2 or n)
ch_obj.ch = ch+2
end

end

function read_ch(i,x,y)
local ch_obj = chains_zone[i]
ch_obj.a[ch_obj.n] = {}
ch_obj.a[ch_obj.n].i = mget(x,y)
ch_obj.a[ch_obj.n].x = x
ch_obj.a[ch_obj.n].y = y
ch_obj.n +=1
end

b_i = 0
function delete_chains(i)
ch_obj = chains_zone[i]
b_i = ch_obj.a[1] ~= nil and
            ch_obj.a[1].i or b_i
mset(ch_obj.x,
     ch_obj.y,b_i)
if ch_obj.a[ch_obj.n-1] ~= nil then
local i = ch_obj.a[ch_obj.n-1].i
local x = ch_obj.a[ch_obj.n-1].x
local y = ch_obj.a[ch_obj.n-1].y
mset(x,y,i)
del(ch_obj.a,ch_obj.a[ch_obj.n-1])
ch_obj.n -= 1
end
end

function chains_ex()

if(chains_zone[0] ~= nil) then
for i = 0, #chains_zone, 1 do
chains_zone[i].b = {}
chains_zone[i].n = 0
chains_zone[i].a = {}
c_b = mget(chains_zone[i].x,
           chains_zone[i].y)
chains_zone[i].d =chain_dir(c_b)
chains_zone[i].ch = 0
chains_zone[i].buf_st = false
local k = 0
for j = 0, #button_zone, 1 do

if button_zone[j].x/8 == 
        chains_zone[i].x then 
chains_zone[i].b[k] = j
chains_zone[i].is_active = 
       button_zone[j].is_active
k += 1
end

if button_zone[j].y/8 == 
        chains_zone[i].y then 
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

-- thorns

-- save form

function update_save_form()
if save_form and time_damage >= 0 then
time_damage = flr(save_ef_speed*
     (second_save+last- time()))
 save_form = time_damage>= 0
else
 time_damage = save_ef_speed
                    *second_save
last = time()
end
end

-- springboards
cur = {}
cur.x = 0
cur.y = 0
diff = 0

function update_tr(obj,signal)
local x
local y

diff = (signal or diff > 0) and
     diff+1 or diff
   
if diff > 20 then
  diff = 0
end
  
  update_ex_h(hero)
  cur = (signal and diff == 1) and
      collide(ex_hero,3,is_b2,1,1) or cur
  x = cur.x ~= nil and cur.x/8 or x
  y = cur.y ~= nil and cur.y/8 or y   

  if (mget(x,y) == 113
    or mget(x,y) == 112) 
   and cur.x ~= nil and
    cur.y ~= nil then
    
    if(diff < 3 or diff > 17)
    then
   
    mset (x,y,112)
    mset (x,y-1,68)
   
   else 
   
    mset (x,y, 113)
    mset (x,y-1,114) 
    
    end 
  end
                   
end

--dialogue arr
function dial_ex()
if #dial_arr > 0 then
for i = 0, #dial_arr, 1 do

dial_arr[i].img = 
           mget(dial_arr[i].x,
             dial_arr[i].y)
mset(dial_arr[i].x,
             dial_arr[i].y,68)
dial_arr[i].n = i
dial_arr[i].f_ent = 0
current_dial += 1
dial_arr[i].x *=8
dial_arr[i].y *=8
dial_arr[i].d = dialogues[
                   current_dial]

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
   
   local sprite = 
      72+flr(rnd(3))
   
   temp.x = x
   temp.y = hero.y
   temp.spr = sprite
   temp.t = my_time
   
      
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
   
  if del_fl then
  
   for i=1,#dash_tail_arr do
    dash_tail_arr[i-1]=
               dash_tail_arr[i]
               
   end
   dash_tail_arr[ind_dt] = nil 
   ind_dt -= 1
  end 
   
end
-->8
--collide
function collide(obj,n,is_m
                   ,x_lim,y_lim)
x_lim = x_lim == nil and 1 or x_lim
y_lim = y_lim == nil and 1 or y_lim

obj_m = {}
obj_m.x = (obj.x+7)/8
obj_m.y = (obj.y+4)/8

local result = {}
c = {} -- colide position
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

function dist_to_col(obj,n,is_m
                   ,x_lim,y_lim)
local result = {}
local p = {}
p.x = 0
p.y = 0
p = collide(obj,n,is_m,
                    x_lim,y_lim)
xd =flr((obj.sx+1)/2)

if p.x ~= nil and p.y ~= nil then
result.x= abs(p.x-obj.x)-15//+(1*xd)
result.y= abs(p.y-obj.y)-7
else
result = nil
end

return result
end

function is_b(x,y) -- is block
map_n = mget(x/8,y/8)
return fget(map_n)
end

function is_b2(x,y,n) -- is block
map_n = mget(x/8,y/8)
return fget(map_n,n) and n or 9
end

function no_map_col(obj,col,radius,
                      y_param)
return col.x >= obj.x and
    col.x < obj.x+radius and
    col.y >= obj.y-y_param and
    col.y < obj.y+radius+y_param

end

function no_map_cols_n(obj,cols,radius,
                      y_param)

for i = 0,#cols,1 do
if no_map_col(obj,cols[i],radius,
                     y_param) then
  return i                  
end
end

return nil
end
-->8
--웃nemy
function update_enemy(pz)
if(#pz > 0) then
 for i = 0, #pz, 1 do
  pz[i].speed = 0.3
  pz[i].is_active = true
  
  if pz[i].undergr then
  undrgr_enemy(pz[i])
  else
  fly_walk_enemy(pz[i])
  end
  
  pz[i].x += pz[i].sx * g_time 
                * pz[i].speed
  
  spike = (pz[i].undergr and 
         not pz[i].is_active ) 
                    and 8 or 0
  
  --damage
  if no_map_col(hero,pz[i],16
                         ,spike)
    and pz[i].is_live
    and not save_form then
 hero.hp-=1
 sfx"58"
 save_form = true
  end
end
end
end

function undrgr_enemy(enemy)

enemy.sy = 0
col = dist_to_col(enemy,1,is_b2,0,0)
if col == nil then
enemy.sx *= -1
end

update_ex_h(enemy)
col = dist_to_col(ex_hero,1,is_b2,0,0)
if col == nil and my_time > 100 then
enemy.is_live = false
end

enemy.is_active = true
if(abs(hero.x-enemy.x) <= 15) then
enemy.speed = 0
enemy.is_active = 
   not (abs(hero.x-enemy.x) <= 6)
end

end

function fly_walk_enemy(enemy)
 update_ex_h(enemy)
 ex_hero.sy = 1
 ex_hero.sx = enemy.sx
  col2 = dist_to_col(ex_hero,1,is_b2,0,0)
 update_ex_h(enemy)
 ex_hero.sy = 0
 ex_hero.sx = enemy.sx
  col = dist_to_col(ex_hero,1,is_b2,0,0)
  
  if(col ~= nil or
   (col2 == nil 
   and not enemy.flyaible))
   then 
  enemy.sx *= -1
  end
  
  update_ex_h(enemy)
  ex_hero.sy = 1
  col = dist_to_col(ex_hero,1,is_b2,0,0)
  
  if(col == nil) then 
    if (my_time > 100
     and not enemy.flyaible)
     then 
     enemy.y += gravity
    end
  else
  enemy.y = ceil((enemy.y)/8)*8
  end
end

function enemy_ex()
if #enemy_arr > 0 then
for i = 0, #enemy_arr, 1 do

enemy_arr[i].img = 
           mget(enemy_arr[i].x,
             enemy_arr[i].y)
mset(enemy_arr[i].x,
             enemy_arr[i].y,68)
enemy_arr[i].x *= 8
enemy_arr[i].y *= 8
enemy_arr[i].sx = 1
enemy_arr[i].sy = 0
enemy_arr[i].is_live = true
col2 = dist_to_col(
enemy_arr[i],1,is_b2,0,0)
enemy_arr[i].flyaible = 
      enemy_arr[i].img == 53
enemy_arr[i].undergr = 
      enemy_arr[i].img == 56
enemy_arr[i].max_f = 
           enemy_arr[i].flyaible 
                      and 2 or 3
enemy_arr[i].sy = 0
enemy_arr[i].sx = 1
end
end
end

--boss
function boss_ex()
 
 if #boss_arr > 0 then
 
  for i=1,#boss_arr do
   mset(boss_arr[i].x,
        boss_arr[i].y,
        68)
  end
  
 end
end


function update_boss(arr)
 for i = 1,# arr do
  if (do_damage(arr[i].x,
                arr[i].y) or
      do_damage(arr[i].x+1,
                arr[i].y) or
      do_damage(arr[i].x+1,
                arr[i].y-1) or
      do_damage(arr[i].x,
                arr[i].y-1))then
    hero.hp-=1
    sfx"58"
    save_form = true
  end

  diff_x = hero.x - arr[i].x*8
  diff_y = hero.y - arr[i].y*8
  if(abs(diff_x) >= abs(diff_y)) then
   arr[i].x += diff_x/abs(diff_x)/10 
  else
   arr[i].y += diff_y/abs(diff_y)/20   
  end

 end
end

function do_damage(x,y)
  if x*8 >= hero.x and
     x*8 < hero.x+16 and
     y*8 >= hero.y and
     y*8 < hero.y+16
    and not save_form then
    return true
  else 
    return false
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
--map parser
function get_sumb_index(
           str,start_sub,sumb)
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
m += 1
end

end

end

return result
end

function off_points(pz,blk)

for i = 0, #pz, 1 do
pz[i].is_active = false
mset(pz[i].x,pz[i].y,blk)
end

end




-->8
--draw
function _draw()
cls()
camera(hero.x-64,hero.y-64)
if mm_status == 0 then
 main_menu()
 elseif mm_status == 1 then
 level_draw()
 elseif mm_status == 3 then
 level_menu_draw()
 else 
 game_over()
 end
end

function game_over()
print('game over',hero.x,
                    hero.y+40,8)
end

function main_menu()
print(mm_pos==0 and'❎start'or
 'start',hero.x+16,hero.y,
         mm_pos == 0 and 3 or 7)
print(mm_pos==1 and'❎about'or
 'about',hero.x+16,hero.y+10,
       mm_pos == 1 and 3 or 7)
print(mm_pos== 2 and'❎levels'or
 'levels',hero.x+16,hero.y-10,
       mm_pos == 2  and 3 or 7)              
end

function level_menu_draw()
print(lm_pos==0 and'❎level 1'or
 'level 1',hero.x+16,hero.y,
         lm_pos == 0 and 3 or 7)
print(lm_pos==1 and'❎level 2'or
 'level 2',hero.x+16,hero.y+10,
       lm_pos == 1 and 3 or 7)
print(lm_pos==2 and'❎level 3'or
 'level 3',hero.x+16,hero.y+20,
       lm_pos == 2 and 3 or 7)       
end

function level_draw()

map(0,0,0,0,100,100)

if time_damage%2 == 0 then
pal(10,1)
else
pal()
end



draw_hero_coins()
_draw_hero()

draw_button(84)

draw_hero_hp()

draw_arr(torch_arr,10,69,3)

draw_arr(heart_arr,5,13,3)

draw_arr(coin_arr,5,28,4)
draw_dash_tail()
_draw_enemy(enemy_arr)
_draw_boss(boss_arr)
draw_strength()
end

function _draw_enemy(arr)

if(#arr > 0) then
for i=0,#arr,1 do
if arr[i].is_live then
spr(
flr(arr[i].img + (my_time/4)
                 %arr[i].max_f),
arr[i].x,arr[i].y,1,1,
sgn(arr[i].sx) == 1,
false)
end

if not arr[i].is_active and
   arr[i].is_live  then
spr(59,
arr[i].x,
arr[i].y - sgn(arr[i].y-hero.y)*8,
1,1,
false,
sgn(arr[i].y-hero.y) < 0)

end

end
end

end

function draw_button(blk)
if button_zone[0] ~= nil then
for i = 0, #button_zone, 1 do
local x = button_zone[i].x
local y = button_zone[i].y
spr( button_zone[i].is_active
            and blk+1 or blk,
      x,
      y,1,1,
      is_b(x+8,y) == 2)
end
end
end

function _draw_boss(arr)

if(#arr > 0) then

 for i=1,#arr do
 
 if my_time%8 == 0 then
  temp_rnd = flr(rnd(3))+1
   spr_1 = 8
   if (temp_rnd == 1) then
    spr_1 = 10
   elseif (temp_rnd == 2) then
    spr_1 = 26  
   end
  temp_rnd = flr(rnd(3))+1
   spr_2 = 9
   if (temp_rnd == 1) then
    spr_2 = 11
   elseif (temp_rnd == 2) then
    spr_2 = 27 
   end 
 end  
  spr(24,arr[i].x*8,arr[i].y*8)
  spr(25,arr[i].x*8+8,arr[i].y*8)
  spr(spr_1,arr[i].x*8,arr[i].y*8-8)
  spr(spr_2,arr[i].x*8+8,arr[i].y*8-8)
 end

end
end

function _draw_hero()
img += 1/speed
frame = 0
if hero.sy==0 then
frame = flr(img) % max_frame
end
draw_dialogue(4,2)
//n = no_map_cols_n(hero,button_zone,16,0)
--local xx = button_zone[1].x
--local yy = button_zone[1].y
--n = no_map_cols_n(hero,
--             button_zone,16,0,n)
--ch_obj = chains_zone[0]
--if ch_obj.a[0] ~= nil then
--print(ch_obj.a[0],
--hero.x-16,
--hero.y-16)
--
--print( ch_obj.a[0],
--hero.x-16,
--hero.y-8)
--end
--print( ch_obj.n,
--hero.x-16,
--hero.y)

if hero.is_crouch then

sspr (48,8*(frame%2),
16,8,
hero.x+3,
hero.y + 3 + (frame%2),16,8,
sgn(hero.sx) == -1,false)
else

sspr (frame*16,0,
16,16,
hero.x+3,
hero.y-((2-frame)*2)
,16,16,
sgn(hero.sx) == -1,false)
end

if img >= max_frame then
 img = 0
 end
end

--dialogue

function draw_dialogue(dist_x,
                         dist_y)
if #dial_arr > 0 then
g_time = 1
for i=0,#dial_arr,1 do
if (no_map_col(hero,dial_arr[i],
                    32,-8)  or
 dial_arr[i].f_ent > 0) and
 dial_arr[i].f_ent < 56 
 then
 
g_time = 0
print(dial_arr[i].d,
hero.x-24,
hero.y-16)
dial_arr[i].f_ent += 1
end

end
end
end

--hp
function draw_hero_hp()
  for i = 1,hero.hp do
  spr(12,hero.x-64+i*8+1*i,
               hero.y-56)
  end
end

function map_parse(str_map, st_y)
x=0
y=st_y
 while str_map!="" do
  index = get_sumb_index(
      str_map, 0, ' ')
  sub_str = sub(str_map,
             0,index-1)
 
  str_map = sub(str_map,index+1)
                    
  if #sub_str == 1 then
  
    x = 0
    y += 1
    
  elseif #sub_str == 2 then
  
   local s1 = sub(sub_str,1,2)
   mset(x,y,s1)
   x += 1
  
  elseif #sub_str == 3 then
  
   local s1 = sub(sub_str,1,3)
   mset(x,y,s1)
   x += 1 
   
  else
  
   x_sym = get_sumb_index(
      sub_str, 0, 'x')    
   amount = sub(sub_str,x_sym+1,
             #sub_str)
             
   for j = 0,amount-1 do
    local s3 = sub(sub_str,0,
                x_sym-1)
    mset(x,y,s3)
    x += 1
   end
   
  end     
 end
end



function set_lvl(lvl_num)

 map_parse(levels[lvl_num*2-1],0)
 map_parse(levels[lvl_num*2],32)

 level_initialiation()
 startl = find_point_zone(32)[0]
 hero.x = startl.x*8 - 8
 hero.y = startl.y*8 - 8


 endl = find_point_zone(33)[0]
 endlvl_x = endl.x*8
 endlvl_y = endl.y*8 - 8
 

end




function draw_hero_coins()
  print(hero.coins
  ,hero.x-56,
               hero.y-46,9)
  
end

function draw_arr(array,spd,ind,
                  spr_am)
 for i = 0, #array, 1 do
  mset(array[i].x,
       array[i].y,array[i].is_active
       and 68 or
       ind+flr(my_time/spd
      +flr(array[i].x))%spr_am)
 end                        
end

--dash_tail

function draw_dash_tail()
 if #dash_tail_arr != 0 then
 
  for i = 0,4 do
   if dash_tail_arr[i] != nil then
   spr(dash_tail_arr[i].spr,
       dash_tail_arr[i].x,
       dash_tail_arr[i].y)
   end    
  end
  
 end
end

function draw_strength()
 local length = dash_sg/4
 for i = 0,length do
  spr(32, hero.x-56 + i*5,
                   hero.y-40)  
 end
end
__gfx__
0000882200000000000a000000000000000000000000000000000288800900000000000000000000000000000000000008800880088008800000000000000000
0008288888090000000088220000000000000000000000000000888889900000000000000000000000000000000000008e8888888e8888881101110111011101
00a0208889900000000908888800000000008822000000000008288fbf000000000000000000000000000000000000008ee888888ee888881181180111011101
0000908fbf0000000000008889990000000288888809000000a020ff3fe0000000000000000000000000000000000000888888888888888818e8888111811801
000000ff3fe000000000008fbf00000000908088899000000000977777770000000000000000000000000000000000008888888a888888880888888008e88880
000000ffff000000000000ff3fe000000000a08fbf00000000008a88aaa8000000000000000000000000000000000000088888a0088888810188881108888881
0000777777070000000000ffff000000000000ff3fe000000008aa88aaaa80000000000000000000000000000000000000888a00018888110118801101888811
00000777777000000000777777000000000000ffff000000000666ff66666000000000000000000000000000000000000008a000011880110111101101188011
00008a88aa8000000000077777770000000077777707000000000000000000000000000000000000000000000000000000770000000000000000000000000000
00008a88aaa8000000008a88aa800000000007777770000000000288800900000000000000000000000000000000000017977701110977011109700111079001
0008aa88aaaa800000008a88aaa8000000008a88aa80000000008888899000000000000000000000000000000000000079944970109777011109700110799901
000006ff666000000008aa88aaaa800000008a88aaa800000008288fbf0000000000000000000000000000000000000009499790107779011109770110974901
0000600000060000000006ff666000000008aa88aaaa800000a020ff3fe000000000000000000000000000000000000009499790077479000009770000979970
00000666666000000000600000060000000006ff6660000000009777777700000000000000000000000000000000000004977990074999010107701100999471
0000600000060000000006666660000000006000000600000008aa88aaaa80000000000000000000000000000000000000444401010490110177701101094711
000666666666600000066666666660000006666666666000000666ff666660000000000000000000000000000000000001000011011000110110001101177011
00000000000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
00000000000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
03333330000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
3b77bbb3000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
3bbbbbb3000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
03333330000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006060606
00000000000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066060666
00000000000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666
000808000808008000800800000000000000000000000000000000000000000000900900000000000000000000000000000000000000000000000000dddddddd
008080080080088080080008000000000000000000050500000000000000000009999990000000000090090000000000000000000000000000000000dddddddd
0808088008808088080088800000000000000000005656600055000000000000009009000000000000000000000b0000000000000000000000000000dddddddd
8888888888888880888888880000000000000000059566000595550000000000033003b00000000000b33b0000030000000000000000000000000000dddddddd
86886888888888888688688800000000000000000555000005556660000000003d3333d3033003b003dffdb000033000000000000000000000000000dddddddd
06886880068868800688688000000000000000000055500000555000000000003fdffdfb3f3333fb3fdffdfb00333000000000000000000000000000dddddddd
008888000088880000888800000000000000000000055000000550000000000003dffdb003dffd3003ffffb00033b300000000000000000000000000dddddddd
00088000000880000008800000000000000000000000000000000000000000000003b00000d33d0000333b0003333b00000000000000000000000000dddddddd
55550555000000000000000000000000000000000000c0000000c000000000c00000000000000000666666660000000000000000000000000000000000000000
55550555110dd101010100dddd00101011011101110c110111011c0111011c010000000000000000000000000000000000000000000000000000000000000000
000000001101110100100d0dd0d0010011011101110cc101110ccc011101ccc10000000000000000000000000000000000000000000000000000000000000000
50555555110111010100d00dd00d001011011101110ccc011101ccc1110cccc10000000000000000000000000000000000000000000000000000000000000000
5055555500000000010d000dda00d0100000000000ccdc00000cdcc0000cdc006666666600000000000000000000000000000000000000000000000000000000
000000000dd11011010d00dddda0d01001111011011c5c1101115c1101115c110000000000000000000000000000000000000000000000000000000000000000
555555550111d011010d0d0dd0d0d010011110110111501101115011011150110000000000000000000000000000000000000000000000000000000000000000
5555555501111011010dd00dd00dd010011110110111501101115011011150110000000066666666000000000000000000000000000000000000000000000000
0000000005550550010d000dd000d0100000000000000000dddddddd000000000000000000000000000000000000000000000000000000000000000000000000
1100110100000000010da0add000d0106628000069a0000066666666110111011101110100000000000000000000000000000000000000000000000000000000
1107010105505550010d00dddd00d010628880009aaa000066666666150c15011506150100000000000000000000000000000000000000000000000000000000
1106010105505550010d0d0dd0d0d010628880009aaa000066666666115c51011156510100000000000000000000000000000000000000000000000000000000
0076600000000000010dd00dd00dd010628880009aaa000066666666000500000005000000000000000000000000000000000000000000000000000000000000
0076601105555050010d000dd000d010628880009aaa000066666666011510110115101100000000000000000000000000000000000000000000000000000000
0766660100000000010d000dd000d0106628000069a0000066666666011510110115101100000000000000000000000000000000000000000000000000000000
06666601055505500110dddddddd01100000000000000000dddddddd011510110115101100000000000000000000000000000000000000000000000000000000
00000000000000000666660042424277000000000000000077242424000000000000000000000000000000000000000000000000000000000000000000000000
11066666666660110766660142424277110111011101110177242424000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001076600142424277110191011101910177242424000000000000000000000000000000000000000000000000000000000000000000000000
66660111011066661076600156565277110999011109c90177555555000000000000000000000000000000000000000000000000000000000000000000000000
6666011101106666000600005555527700999990009c8c9077555555000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000107001142424277011999110119c91177242424000000000000000000000000000000000000000000000000000000000000000000000000
01066666666660110110101142424277011190110111901177242424000000000000000000000000000000000000000000000000000000000000000000000000
01100000000001110111101142424277011110110111101177242424000000000000000000000000000000000000000000000000000000000000000000000000
88888888060000608888888800066000060000604424424444244244000000000000000000000000000000000000000000000000000000000000000000000000
06666660060000601601116111066001060110604424424444244244000000000000000000000000000000000000000000000000000000000000000000000000
66666666666666661601116100066000060110604424424444244244000000000000000000000000000000000000000000000000000000000000000000000000
50555555505555551166660106066060060000605565565555555555000000000000000000000000000000000000000000000000000000000000000000000000
50555555505555550600006006000060060660605555555555555555000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000611106106011060000660004424424444244244000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555550166661106011060010660114424424444244244000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555550611106106011060010660114424424444244244000000000000000000000000000000000000000000000000000000000000000000004444
15444444441544444444154444444444444415444444444444444444444444040404040404040404040404040404040444040404040404040404040404040404
04040404040404040404040483440404040404040404040415444444154444444415070715444444444444444444444444444444444444444444444444444444
15444444441544444444154444444444444415444444444444444454444444264444154444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444415444444154444444415444415444444444444444444444444444444444444444444444444444444
15444444441544444444154444444444444415050544444444444444444444444444154444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444415444444154444444415070715444444444444444444444444444444444444444444444444444444
154444444415444444441514444454444444150404040404040404040404040444441544444444444444444444c1444444444444444444444444444444444444
44444444444444444444444444444444444444444444444415444444154444444415444415444444444444444444444444444444444444444444444444444444
15444414441544444444151414144444444415444444444444444444243444444444154444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444415444444154444444415444415444444444444444444444444444444444444444444444444444444
154444144415444444441544441444444444154444444444444444442535d0444444154444444444444444444444444444444444444444444444444444444444
c1444444444444444444444444c1444444444444444444c115070707154444444415444415444444444444444444444444444444444444444444444444444444
15444414441544444444154444444444444415444444444444444447444444444445154444444444444444444444444444444444444444444444444444444444
4444444444444444444444444444444444444444444444c115444444154444447515070715444444444444444444444444444444444444444444444444444444
15444414441544444444154444445444444415444444444444444404040404040404154444444444444444444444444444444444444444544444444444444444
44444444444444444444444444444444444444444444444415444444154444444415444415444444444444444444444444444444444444444444444444444444
15444414441544444444154444444444444415444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444415444444154444444415444415444444444444444444444444444444444444444444444444444444
15441414441544444444154444444444444415444444444444444444444444445444444444444444444454444444444444444444444444444444444444444444
44444444444444444444444444444444445444444444444415444444154444444415444415444444444444444444444444444444444444444444444444444444
15441414441544444444154444444444444415444444444444444444444444444444444444444444444444444444444444444444440707074444444444444444
44444444444444444444040404444444444444444444444415444444154444444415070715444444444444444444444444444444444444444444444444444444
15441414441544444444154444445444444415444444444444444444444444444444444444444444444444444444444444444444444444444444444444070707
44444444444444444444444444444444444444444444444415444444154444444415444415444444444444444444444444444444444444444444444444444444
15141414441544444444154444444444444415444444444444444444444444444444444444444444440707074444444444447544444444444444444444444444
44444444040404444444444444444444444444444444444415444444154444444415070715444444444444444444444444444444444444444444444444444444
15141414441544444444154444444444444415444444444444444444444444444444444444444444444444444444444444444444444444445444444444444444
44445444444444444444444444444444444444444444444444444444154444444415444415444444444444444444444444444444444444444444444444444444
15141414441544444444154444444444444415444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444154444444444444444157544444415444415444444444444444444444444444444444444444444444444444444
15144414441544444444154444445444444415070707070744444444444444444444444444754415444444444444444444440544444405444444440544444444
44440544444444444405444444444405447544154444444444444444154444444415070715444444444444444444444444444444444444444444444444444444
15144414441544444444154444444444444415040404040404040404040404040404040404040404440404040483040483040483040404048304040404040483
04830404830404040404830404048304040444040404040404040404154444444415444415444444444444444444444444444444444444444444444444444444
15144414441544444444154444444444444444444444444444262626262626262626262626262626262626262644262644262644262626264426262626262644
26442626442626262626442626264426262644262626262626262626154444444415444415444444444444444444444444444444444444444444444444444444
15144414441544444444154444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444444444444154444444415444415444444444444444444444444444444444444444444444444444444
151444144415444444441544444454444444444444444444444444444444444444c1444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444444444444444444447515070715444444444444444444444444444444444444444444444444444444
15441414441544444444150444044404440444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444444444444444444444415444415444444444444444444444444444444444444444444444444444444
1544141444154444444415444444c144444444445644444444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444444444444d04444444415444415444444444444444444444444444444444444444444444444444444
15441414441544444444154444444444444444444444441544444444444444444444444444444444444444444444444444150303444444444444444444444444
03444444444444444444444444444403444444444444444444034415444444444415070715444444444444444444444444444444444444444444444444444444
15441414441544444444150404040404040404040404040404040407070707070404040707070707040404070707070404040404040404040407070704040404
04040404040404070707040404040404040407070704040404040404040404040415444415444444444444444444444444444444444444444444444444444444
15441414441544444444444444154444444444444444444444440404040404040404040404040404040404040404040404444444444404040404040404044444
44444444040404040404040404044444440404040404444444444444444444444415444415444444444444444444444444444444444444444444444444444444
15441414441544444444444444154444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444444444444444403444415070715444444444444444444444444444444444444444444444444444444
15441414441544444444444444154444444444444444444444444444034444444444444444444444444444444444034444444444444403444444444444444444
44444444444444444444444444444444440344444444444444444444444403444415444415444444444444444444444444444444444444444444444444444444
15444444441544444444444444154444444444444444444444444444444444444444444444444444c14444444444444444444444444444034444444444444444
4444444444444444444444d0444444444444444444440344444444c1444444034415444415444444444444444444444444444444444444444444444444444444
15443657441544444444444444154444154444444444444444444444444444444444444444444444444444444444444444444444444444440344444444444444
44444444440344444444444444444444444444444444444444444444444444444415070715444444444444444444444444444444444444444444444444444444
1544365744154444444415444444d044154444444444444444444444444444444444034444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444444444444444444444444444415444444444444444444444444444444444444444444444444444444
15443657441507070707154444444444150344444444444444444403030344444444444444444444444444444444444444444403034444444444444444154444
44034444444444444444444444030344444444444444444444034444444444444444444415444444444444444444444444444444444444444444444444444444
15040404041504040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404
04040404040404040404040404040404040404040404040404040404040404040404040415444444444444444444444444444444444444444444444444444444
__gff__
0000000000000000000000000050505000000000000000000000000060606060000000000000000000000000000000048400000000840000840000040000000202000000003020200000000000000000040200001010114100000000000000004242042100012000000000000000000008080042420000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444243444444444243444444444444444444444444444444444444444451444444444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444141415253414141445253444441444444444444444444444444444444444451444444444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5141414144444444444444444444444441414444444444444444444444446375444451444444444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5141414451404040404040404040404044414144444444444444444451446375444451444444444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144414151444444444444444444444444444444444444444444444451446375444451444444444444444444444544514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144414451441c44444444444444444444444444444444444444404040404040404051444444444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5141414451444144444444444444444451444444444444444444444444444444444444444444444444444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5141444444414444444445444444444451444444444470707044444444444444444444444444444444444444514040514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444465444451444444444444444451444444444444444444444444444444444444444444444444444444516262514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444444451444444444144444451707070707044444441414144444444444444444444444444444444511c1c514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5140404040404051444444444141414444444444444444414141454441414144444444444444444444444444514444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514444444444444444414141414141414141414444444444444441414444444444444444444444514444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144766644514444444444444144444444444444444444444444444444440d44414444444444444444444444514243514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144766644514444707070704444444444444444444444444444444444444444444444444444444444444444515253514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144766644514444404040404444444444444444444444444444504444444040444444444444444444444444514444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514444444444444470707040404051444444514040404040404040444444444444444444444444514444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514444444444444444444444444451444444514444444444444444444444444444444444444444514444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514444444444444444444444444451444544514444444444444444447070704444444441444444514444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514441414141444444444444444451444444514444444444444444444444444444444441414444514441514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514441444441414444444444444451505050514444444444444444444444444470707044414144514141514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514141444444414444444444444451404040514444444444444444444444444440404044444144444144514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514144514444414444444444444444446244444444444444444444444444444444444441414141414144514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514144514444444444444444444444444444444444444444444444444444444444414141444444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514141514444444444414141444444444444444444444444444444444444444441414444514040404040514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444444514441514444444541414444444544414444444544444445444444444444444441444444516262626262514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5141414444514441514444444444444444444444444444414144444444444444444444445140404040514444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
51444165444441415144444444444444504444444444444444445044444444444444441c4462626262624444444444514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5144444141414144514444444444444451444444445044444444514444444450444444445150505050505050505050514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
5140404040404040514040404040404040404040404040404040404040404040404040404040404040404040404040514444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
4444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
__sfx__
010e000007732077320770007700167320773207700077000a7300a7200a7300a7200a7300a7200a7300a72016722077420770007700077320773207700077000a7320a7200a7320a7200b5220b7300b7320b720
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
0119000030040300453003530025000000000030040320402f0402f0452f0352f02500000000002f040300402d0402d0452d0352d025000000000000000000003405034015320503201530050300152f05030050
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010200002d0322d0372d0302d02532022320123201232012320123201232012320123201232012320123201524002240020000200002000020000200002000020000200002000020000200002000020000200002
0102000008560085600856008050090500a5500a5500b0500b0500b0400c7400c7400d7400d0300d0200d01000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100001856018560185501854018720187100050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
01080000140501b750165500b1201105018750125500a12010050167500e550091200d05014750081200555008550075500855007550085500755008550075500855008550085500855008550085500855008550
0104000013030101300e1300c14009140090400715006150031500315003150041500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0002000004062077600a7500c7500f047130471b5321f532270212972029720297202972000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010500000c1500c1400d130131301512015120131300d120081200c02008040070500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000500001752016540165401655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01040000260202652226520260222d7222d7222d5222d525000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01020000290102901029010295102e0102e0102e0102e0102e5102e510330103301033010335103351038010380103801038510385103a0103a0103a0103a5103a50000000000000000000000000000000000000
__music__
00 01004244
00 01000244
01 01000344
00 01000444
00 01000544
00 01000644
00 01000744
00 01000844
00 01000944
02 01000a44

