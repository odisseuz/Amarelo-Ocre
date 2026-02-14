function _init()
 scene = "menu"
	music(0)
 setup_player()
 setup_items()
 variables()
end

function _update()
 if scene == "menu" then
  update_menu()
 elseif scene == "game" then
  update_game()  
 end
end

function _draw()
 cls() 
 if scene == "menu" then
  draw_menu()
 elseif scene == "game" then
  draw_game()
 end
end

function update_menu()
 if btnp(5) or btnp(4) then
  scene = "game"
 end
end

function draw_menu()
 print("pressione x para iniciar", 28, 60, 12)
end

function update_game()
 move_player()
 update_items()
 update_timer()
end

function draw_game()
 map(0, 0, 0, 0, 16, 16) 
 draw_items()
 draw_player()
 print("gold: "..gold, 2, 2, 14)
 print("tempo: "..flr(time_left), 85, 2, 7)
end

function setup_player()
 player = {}
 player.x = 64
 player.y = 64
 player.spd = 1.5 
end

function move_player()
 if btn(0) then player.x -= player.spd end 
 if btn(1) then player.x += player.spd end 
 if btn(2) then player.y -= player.spd end 
 if btn(3) then player.y += player.spd end 
end

function draw_player()
 sspr(7, 0, 16, 16, player.x, player.y)
end

function setup_items()
 golds = {}
 for i=1,3 do
  spawn_gold()
 end
end

function spawn_gold()
 local g = {}
 g.x = rnd(100) + 10
 g.y = rnd(100) + 10
 add(golds, g)
end

function update_items()
 for g in all(golds) do
  if player.x < g.x+12 and
     player.x+12 > g.x and
     player.y < g.y+12 and
     player.y+12 > g.y then
     
     del(golds, g)
     gold += 1
 				time_left += 1
     sfx(3)
     spawn_gold()
  end
 end
end

function draw_items()
 for g in all(golds) do
  sspr(24, 0, 16, 16, g.x, g.y)
 end
end

function update_timer()
 if time_left > 0 then
  time_left -= 1/30
 end
end

function variables()
 gold = 0
 time_left = 30
end
