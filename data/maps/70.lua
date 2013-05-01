local map = ...
-- Broken gem house

local function give_flippers()
  hero:start_treasure("flippers", 1, "b157")
end

function game_1_man:on_interaction()

  if not map:get_game():get_value("b156") then
    map:start_dialog("gem_house_broken.help_us_left")
  elseif not map:get_game():get_value("b157") then
    map:start_dialog("gem_house_broken.thanks", give_flippers)
  else
    map:start_dialog("gem_house_broken.thanks_again")
  end
end

function game_2_man:on_interaction()

  if not map:get_game():get_value("b156") then
    map:start_dialog("gem_house_broken.help_us_middle")
  elseif not map:get_game():get_value("b157") then
    map:start_dialog("gem_house_broken.thanks", give_flippers)
  else
    map:start_dialog("gem_house_broken.thanks_again")
  end
end

function game_3_man:on_interaction()

  if not map:get_game():get_value("b156") then
    map:start_dialog("gem_house_broken.help_us_right")
  elseif not map:get_game():get_value("b157") then
    map:start_dialog("gem_house_broken.thanks", give_flippers)
  else
    map:start_dialog("gem_house_broken.thanks_again")
  end
end

