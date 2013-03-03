local map = ...
-- Smith cave

local sword_price = 75

-- Function called when the player wants to talk to a non-playing character.
function smith:on_interaction()

  -- smith dialog
  if not map:get_game():get_value("b30") then
    -- the player has no sword yet
    map:start_dialog("smith_cave.without_sword", function(answer)
      -- the dialog was the question to buy the sword

      if answer == 1 then
        -- the player does not want to buy the sword
        map:start_dialog("smith_cave.not_buying")
      else
        -- wants to buy the sword
        if map:get_game():get_money() < sword_price then
          -- not enough money
          sol.audio.play_sound("wrong")
          map:start_dialog("smith_cave.not_enough_money")
        else
          -- enough money: buy the sword
          map:get_game():remove_money(sword_price)
          sol.audio.play_sound("treasure")
          hero:start_treasure("sword", 1, "b30" function()
            map:start_dialog("smith_cave.thank_you")
          end)
        end
      end
    end)
  else
    -- the player already has the sword
    map:start_dialog("smith_cave.with_sword")
  end
end

