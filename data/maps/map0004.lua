local map = ...
-- Outside world B3

-- Function called when the map starts
function map:on_started(destination_point)

  -- game ending sequence
  if destination_point:get_name() == "from_ending" then
    map:get_hero():freeze()
    map:get_hero():set_visible(false)
    map:get_game():set_hud_enabled(false)
    map:set_entities_enabled("enemy", false)
    sol.audio.play_music("fanfare")
    map:set_entities_eneabled("broken_rupee_house", false)
  else
    -- enable dark world
    if map:get_game():get_boolean(905) then
      sol.audio.play_music("dark_world")
      map:set_tileset(13)
    else
      sol.audio.play_music("overworld")
    end

    -- broken rupee house
    if map:get_game():get_boolean(155) then
      to_rupee_house:set_enabled(false)
      rupee_house_door:set_enabled(false)
    else
      to_broken_rupee_house:set_enabled(false)
      broken_rupee_house:set_enabled(false)
    end
  end

  local m = sol.movement.create("random_path")
  m:set_speed(32)
  chignon_woman:start_movement(m)
  chignon_woman:get_sprite():set_animation("walking")

  -- remove Tom's cave door if open
  if map:get_game():get_boolean(36) then
    remove_village_cave_door()
  end

  -- remove the stone lock if open
  if map:get_game():get_boolean(159) then
    remove_stone_lock()
  end

  -- NPC
  if map:get_game():is_dungeon_finished(1) then
    cliff_man:remove()
  end
end

function map:on_opening_transition_finished(destination_point)

  if destination_point:get_name() == "from_ending" then
    map:start_dialog("credits_2")
    map:move_camera(184, 80, 25, function() end, 1e6)
  end
end

-- Function called when the player presses the action key
-- while facing an interactive entity
function tom_cave_door:on_interaction()

  -- open the door if the player has the clay key
  if map:get_game():has_item("clay_key") then
    sol.audio.play_sound("door_open")
    sol.audio.play_sound("secret")
    map:get_game():set_boolean(36, true)
    remove_village_cave_door()
  else
    map:start_dialog("outside_world.village.clay_key_required")
  end
end

function stone_lock:on_interaction()

  -- open the door if the player has the stone key
  if map:get_game():has_item("stone_key") then
    sol.audio.play_sound("door_open")
    sol.audio.play_sound("secret")
    map:get_game():set_boolean(159, true)
    remove_stone_lock()
  else
    map:start_dialog("outside_world.stone_key_required")
  end
end

function chignon_woman:on_interaction()

  if map:get_game():is_dungeon_finished(2) then
    map:start_dialog("outside_world.village.chignon_woman_dungeons")
  else
    map:start_dialog("outside_world.village.chignon_woman")
  end
end

function remove_village_cave_door()
  tom_cave_door:remove()
  tom_cave_door_tile:set_enabled(false)
end

function remove_stone_lock()
  stone_lock:remove()
  map:set_entities_enabled("stone_lock_tile", false)
end

function waterfall_sensor:on_activated()

  map:get_hero():start_jumping(6, 288, true)
  sol.audio.play_sound("jump")
end

function map:on_hero_still_on_sensor(sensor_name)

  -- entrances of houses
  local entrances = {
    "rupee_house", "lyly"
  }
  for i = 1, #entrances do
    if sensor_name == entrances[i] .. "_door_sensor" then
      if map:get_hero():get_direction() == 1
          and map:tile_is_enabled(entrances[i] .. "_door") then
        map:tile_set_enabled(entrances[i] .. "_door", false)
        sol.audio.play_sound("door_open")
      end
      break
    end
  end
end

function map:on_dialog_finished(dialog_id)

  if dialog_id == "credits_2" then
   sol.timer.start(2000, ending_next)
  end
end

function ending_next()
  map:get_hero():teleport(56, "from_ending")
end

