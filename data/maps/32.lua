local map = ...
-- Telepathic booth

function hint_stone:on_interaction()

  if not map:get_game():is_dungeon_finished(1) then
    map:start_dialog("telepathic_booth.not_working")
  elseif not map:get_game():has_item("bow") then
    map:start_dialog("telepathic_booth.go_sahasrahla")
    map:set_dialog_variable("telepathic_booth.go_sahasrahla", map:get_game():get_player_name())
  elseif not map:get_game():is_dungeon_finished(2) then
    map:start_dialog("telepathic_booth.go_twin_caves")
    map:set_dialog_variable("telepathic_booth.go_twin_caves", map:get_game():get_player_name())
  elseif not map:get_game():get_item("gem_bag"):has_variant(2) then
    map:start_dialog("telepathic_booth.dungeon_2_not_really_finished")
    map:set_dialog_variable("telepathic_booth.dungeon_2_not_really_finished", map:get_game():get_player_name())
  elseif not map:get_game():is_dungeon_finished(3) then
    map:start_dialog("telepathic_booth.go_master_arbror")
    map:set_dialog_variable("telepathic_booth.go_master_arbror", map:get_game():get_player_name())
  elseif not map:get_game():is_dungeon_finished(4) then
    map:start_dialog("telepathic_booth.go_billy")
    map:set_dialog_variable("telepathic_booth.go_billy", map:get_game():get_player_name())
  else
    map:start_dialog("telepathic_booth.shop")
    map:set_dialog_variable("telepathic_booth.shop", map:get_game():get_player_name())
  end
end

