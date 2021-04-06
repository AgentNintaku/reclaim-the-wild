-- LEVEL (LVL) and EXPERIENCE (EXP) counters shown on the game screen.

-- LVL AND EXP  version 1.6
-- from a script (for rupees) by christopho
-- Modified by froGgy for a Zelda-like (ZL) project.
-- v 1.0:  First version posted. It is just a draft.
-- Modified by Kamigousu on 18/07/19.
-- v 1.6:  Updated for use with Solarus 1.6; basic with lots of potential, mostly just froggy77's original draft.
--Modified by D MAS and Kamigousu on 16/01/21.
--v 1.6.4: Updated for clarity and ease of use.

--Additional code and notes are included at the bottom for convenience. Please read them before continuing.

local lvl_and_exp = {}

function lvl_and_exp:new(game)

  local object = {}
  setmetatable(object, self)
  self.__index = self

  object:initialize(game)

  return object
end

function lvl_and_exp:initialize(game)

  self.game = game
  self.surface = sol.surface.create(112, 24)
  self.digits_text_for_lvl = sol.text_surface.create{
    font = "green_digits",
    horizontal_alignment = "left",
  }
  self.digits_text_for_exp = sol.text_surface.create{
    font = "white_digits",
    horizontal_alignment = "left",
  }
  self.digits_text_for_exp_to_levelup = sol.text_surface.create{
    font = "white_digits",
    horizontal_alignment = "left",
  }

  --Set the initial level and experience to 1 and 0 respectively,
  --if they are not all ready set.
  if not self.game:get_level() or self.game:get_level() == 0 then self.game:set_level(1) end
  if not self.game:get_exp() then self.game:set_exp(0) end
 
  self.digits_text_for_lvl:set_text(game:get_level())
  self.digits_text_for_exp:set_text(game:get_exp())
  self.lvl_icon_img = sol.surface.create("hud/lvl_and_exp_icon.png")
  self.exp_icon_img = sol.surface.create("hud/lvl_and_exp_icon.png")
  self.slash_icon_img = sol.surface.create("hud/lvl_and_exp_icon.png")
  self.current_lvl_displayed = self.game:get_level()
  self.current_exp_displayed = self.game:get_exp()
  self.current_exp_displayed_length = string.len(self.current_exp_displayed)

  --Here are two options for setting up the exp_to_levelup table.
  --By default, option 2 is enabled.

  --The first will set up a very basic level up table that requires you
  --to fill in all the fields for each level up. You may stop at whatever
  --level you wish; that level will be the max level. That code is as follows:

  --self.t_exp_to_levelup = {100, 200, 300, 400, 500, 600, 700, 800}
  --self.max_level = #self.t_exp_to_levelup

--============================================

  --The second will set up a basic level up table that will fill in the experience
  --required for each level based on the total number of levels you would like.
  --This requires you to define the max level yourself and input the experience
  --required to level up to level 2 into the exp_to_levelup table.

  self.max_level = 20
  self.t_exp_to_levelup = {150}
  for key, value in ipairs(self.t_exp_to_levelup) do
    local next_key = key + 1
    if next_key <= self.max_level - 1 then
      self.t_exp_to_levelup[next_key] = math.ceil((self.t_exp_to_levelup[1] * next_key) + ((value * next_key) / 100))
      --Uncomment the print lines below to see the level and required experience to levelup in the console.
      --print(#self.t_exp_to_levelup)
      --print(self.t_exp_to_levelup[next_key])
    else
      break
    end
  end

  self.digits_text_for_exp_to_levelup:set_text(self.t_exp_to_levelup[self.current_lvl_displayed])
  self:rebuild_surface()
  self:check()
end

--Whenenever a game over is completed, the timer for this counter
--must be restarted.
function lvl_and_exp:on_started()
  self:rebuild_surface()
  self:check()
end

function lvl_and_exp:check()

  local need_rebuild = false
  local current_level = self.game:get_level()
  local current_exp = self.game:get_exp()
  local exp_to_levelup = self.t_exp_to_levelup[current_level]
  if exp_to_levelup == nil then
	 self.current_exp_displayed = self.t_exp_to_levelup[self.max_level - 1]
	 self.current_exp_displayed_length = string.len(self.current_exp_displayed)
   exp_to_levelup = self.t_exp_to_levelup[self.max_level - 1]
  end
  local difference = 0

	-- Current LVL.
	if current_level <= self.max_level then
	  if current_level ~= self.current_lvl_displayed then
		  need_rebuild = true
		  local increment
		  if current_level > self.current_lvl_displayed then
		    increment = 1
		  else
		    increment = -1
		  end
		  self.current_lvl_displayed = self.current_lvl_displayed + increment
		  -- Play a sound if we have just reached the final value.
		  if self.current_lvl_displayed == current_level then
		    if increment == 1 then
		    	sol.audio.play_sound("victory")
		    	sol.audio.play_sound("treasure")
		    else
		    	sol.audio.play_sound("switch")
		    	sol.audio.play_sound("hero_falls")
		    end
		  end
	  end
	end

	-- Current XP.
	if current_level <= self.max_level - 1 then
	  if current_exp ~= self.current_exp_displayed then
		need_rebuild = true
		local increment
    local difference = math.abs(current_exp - self.current_exp_displayed)
		  if current_exp > self.current_exp_displayed then
        if difference >= 1000 then
		      increment = 321
        elseif difference>= 100 then
          increment = 32
        else if difference >= 10 then
          increment = 3
        else
          increment = 1
        end
		  else
        if difference >= 1000 then
		      increment = -321
        elseif difference >= 100 then
          increment = -32
        else if difference >= 10 then
          increment = -3
        else
          increment = -1
        end
		  end
		  self.current_exp_displayed = self.current_exp_displayed + increment
		  self.current_exp_displayed_length = string.len(self.current_exp_displayed)
	  end

	-- Level up
	  if self.current_exp_displayed >= exp_to_levelup then
		self.game:add_level(1)
      if self.game:get_level() ~= self.max_level then
		    difference = current_exp - exp_to_levelup
		    self.game:set_value("current_exp", difference)
		    current_exp = self.game:get_value("current_exp")
		    self.current_exp_displayed = 0
		    self.current_exp_displayed_length = string.len(self.current_exp_displayed)
      end
	  end
	end

  -- Redraw the surface only if something has changed.
  if need_rebuild then
    self:rebuild_surface()
  end

  -- Schedule the next check.
  local timer = sol.timer.start(self.game, 10, function()
    self:check()
  end)
  timer:set_suspended_with_map()
end

function lvl_and_exp:rebuild_surface()

  self.surface:clear()

  -- LVL (icon).
  self.lvl_icon_img:draw_region(0, 0, 12, 12, self.surface)

  -- XP (icon).
  self.exp_icon_img:draw_region(12, 0, 12, 12, self.surface, 27, 0)
 
  -- SLASH (icon).
  self.slash_icon_img:draw_region(24, 0, 8, 12, self.surface, 40 + (8 * self.current_exp_displayed_length), 4)

    -- Current LVL (counter).
  if self.current_lvl_displayed == self.max_level then
    self.digits_text_for_lvl:set_font("green_digits")
  else
    self.digits_text_for_lvl:set_font("white_digits")
  end
  self.digits_text_for_lvl:set_text(self.current_lvl_displayed)
  self.digits_text_for_lvl:draw(self.surface, 12, 6)
 
  -- Current XP (counter).
  if self.current_lvl_displayed < self.max_level then
    self.digits_text_for_exp:set_font("white_digits")
    self.digits_text_for_exp:set_text(self.current_exp_displayed)
    self.digits_text_for_exp_to_levelup:set_font("white_digits")
	  self.digits_text_for_exp_to_levelup:set_text(self.t_exp_to_levelup[self.current_lvl_displayed])
  else
    self.digits_text_for_exp:set_font("green_digits")
    self.digits_text_for_exp:set_text(self.current_exp_displayed)
    self.digits_text_for_exp_to_levelup:set_font("green_digits")
	  self.digits_text_for_exp_to_levelup:set_text(self.t_exp_to_levelup[self.max_level - 1])
  end
  self.digits_text_for_exp:draw(self.surface, 40, 6)
  self.digits_text_for_exp_to_levelup:draw(self.surface, 48 + (8 * self.current_exp_displayed_length), 12)
end

function lvl_and_exp:set_dst_position(x, y)
  self.dst_x = x
  self.dst_y = y
end

function lvl_and_exp:on_draw(dst_surface)

  local x, y = self.dst_x, self.dst_y
  local width, height = dst_surface:get_size()
  if x < 0 then
    x = width + x
  end
  if y < 0 then
    y = height + y
  end

  self.surface:draw(dst_surface, x, y)
end

return lvl_and_exp



--[[********************************NOTES and CODE********************************

This script assumes you have the green and white digits fonts from the ALttP resource pack.
It also assumes you have the "victory", "treasure", "switch", and "hero_falls" sounds from that resource pack.
You may change these in the script to customise the sounds and digits for your game.


You must have a file named lvl_and_exp_icon.png in the sprites/hud folder or you must change the file name in this script to correspond with your own custom file.
If you use the file provided in the top comment on the forum page for this script (http://forum.solarus-games.org/index.php/topic,1362.msg8050.html#msg8050)
then you will not need to modify the script. If you use your own custom file, you will, more likely than not, need to modify this script at lines 178, 181, and 184
to draw the new image properly.
You DO NOT need to create sprites for this script to run. You only need to have the png image named correctly and in the proper folder.


The following must be put into your hud_config script, in the table with the rest of your hud elements;
unless you are putting the exp and lvl display in an inventory screen or some other menu, in which case you will have to require it in the proper lua file.

  --Level and Experience Counter
  {
    menu_script = ("scripts/hud/lvl_and_exp"),
    x = 210,    --X and Y can be changed to wherever you would like the exp counter displayed.
    y = 16,
  },


You must also add the functions game:get_level/exp(), set_level/exp(), and add_level/exp() to your game. 
In a seperate file named game.lua (or wherever you have a game metatable available) add the following:

--The line below can be omitted if you are putting the following function in a file with the metatable all ready defined.
local game_meta = sol.main.get_metatable("game")


function game_meta:get_level()
  return self:get_value("current_level")
end

function game_meta:set_level(level)
  return self:set_value("current_level", level)
end

function game_meta:add_level(level)
  local level = level
  local c_level = self:get_level()
  local level_up = c_level + level
  return self:set_value("current_level", level_up)
end

function game_meta:get_exp()
  return self:get_value("current_exp")
end

function game_meta:set_exp(exp)
  return self:set_value("current_exp", exp)
end

function game_meta:add_exp(exp)
  local exp = exp
  local c_exp = self:get_exp()
  local exp_up = c_exp + exp
  return self:set_value("current_exp", exp_up)
end

If you are using the standard features.lua script, it is recommended to require the file that holds the code above in that script.
--]]