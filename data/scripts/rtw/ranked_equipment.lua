-- This script lets me pull weapon and armor data and ranks separately, so I don't need to add a value for each rank of each weapon or armor.

-- local weapons = require("scripts/ranked_equipment")

-- Llamazing's suggested code.

-- weapon_class{
--   id = "sword",
--   attack_sprite = "sword_attack",
--   charged_attack_sprite = "sword_charged_attack", --i.e. spin attack
--   damage_modifier = -1,
-- }

-- weapon_class{
--   id = "spear",
--   attack_sprite = "spear_attack",
--   charged_attack_sprite = "spear_charged_attack",
--   damage_modifier = 0,
-- }

-- weapon{
--   id = "simple_sword",
--   class = "sword",
--   damage = {6, 7, 8, 10, 12, 15}, --rank 1 is 6 damage, rank 6 is 15 damage
-- }

-- weapon{
--   id = "legendary_spear",
--   class = "spear",
--   damage = {8, 10, 13, 16}, --rank 1 is 8 damage, rank 4 is 16 damage
-- }

weapon_rank{
  r0 = "3",
  r1 = "6",
  r2 = "9",
  r3 = "12",
  r4 = "15",
  r5 = "20",
}

armor_rank{
  r0 = "0"
  r1 = "1"
  r2 = "2"
  r3 = "3"
  r4 = "4"
  r5 = "5"
}
 
-- Here is armor data.

armor_value{
  clothing = "0",
  light = "1",
  medium = "2",
  heavy = "3",
-- Evasion penalties? Only matters once we introduce status effects.
}

-- Here begins the list of weapon data.
-- Keywords will be true or nil, rather than strings.

weapon_class{
  id = "axe",
  attack_sprite = "axe_attack",
  charged_attack_sprite = "axe_charged_attack",
  accuracy = "2",
  damage_modifier = "3",
  durability_modifier = "0",
  edge = "Sharp",
  hands = "2",
  type = "Melee",
  sweeping = true,
}

weapon_class{
  id = "bat",
  attack_sprite = "bat_attack"
  charged_attack_sprite" = "bat_charged_attack",
  accuracy = "4",
  damage_modifier = "2",
  durability = "-1"
  edge = "Blunt",
  hands = "2",
  type = "Melee",
  sweeping = true
}

weapon_class{
  id = "boomarang"
  attack_sprite = "boomerang_attack"
  charged_attack_sprite = "boomerang_charged_attack",
  accuracy = "4",
  damage_modifier = "-1",
  durability = "-1",
  edge = "Blunt"
  hands = "1",
  type = "Melee",
  returning = true,
}

weapon_class{
  id = "bow",
  attack_sprite = "bow_attack",
  charged_attack_sprite = "bow_charged_attack",
  accuracy = "4",
  damage_modifier = "0",
  durability = "1",
  edge = "Piercing",
  hands = "2",
  type = "Ranged",
}

weapon_class{
  id = "club",
  attack_sprite = "club_attack",
  charged_attack_sprite = "club_charged_attack",
  accuracy = "4",
  damage_modifier = "1",
  durability = "-2",
  edge = "Blunt",
  hands = "1",
  type = "Melee",
}

weapon_class{
  id = "crossbow",
  attack_sprite = "brossbow_attack",
  charged_attack_sprite = "crossbow_charged_attack",
  accuracy = "4",
  damage_modifier = "0",
  durability = "0",
  edge = "Sharp",
  hands = "1",
  type = "Ranged",
}

weapon_class{
  id = "dagger",
  attack_sprite = "dagger_attack",
  charged_attack_sprite = "dagger_charged_attack",
  accuracy = "4",
  damage_modifier = "-1",
  durability = "0",
  edge = "Piercing",
  hands = "1",
  type = "Melee",
}

weapon_class{
  id = "fist",
  attack_sprite = "fist_attack",
  charged_attack_sprite = "fist_charged_attack",
  accuracy = "5",
  damage_modifier = "-2",
  durability = "-1",
  edge = "Blunt",
  hands = "1",
  type = "Melee",
  hands_free = true
}

weapon_class{
  id = "greatsword"
  attack_sprite = "greatsword_attack",
  charged_attack_sprite = "greatsword_charged_attack",
  accuracy = "3",
  damage_modifier = "1",
  durability = "1",
  edge = "Sharp",
  hands = "2",
  type = "Melee",
  sweeping = true,
}

weapon_class{
  id = "hammer",
  attack_sprite = "hammer_attack",
  charged_attack_sprite = "hammer_charged_attack",
  accuracy = "3",
  damage_modifier = "-2",
  durability = "2",
  edge = "Blunt",
  hands = "1",
  type = "Melee",
}

weapon_class{
  id = "handaxe",
  attack_sprite = "handaxe_attack",
  charged_attack_sprite = "handaxe_charged_attack",
  accuracy = "3",
  damage_modifier = "1",
  durability = "-1",
  edge = "Sharp",
  hands = "1",
  type = "Melee",
}

weapon_class{
  id = "rod",
  attack_sprite = "rod_attack",
  charged_attack_sprite = "rod_charged_attack",
  accuracy = "4",
  damage_modifier = "-1",
  durability = "0",
  edge = "Blunt",
  hands = "1",
  type = "Arcane",
  wizardly = true,
}

weapon_class{
  id = "shield",
  attack_sprite = "shield_attack",
  charged_attack_sprite = "shield_charged_attack",
  accuracy = "3",
  damage_modifier = "-2",
  durability = "0",
  edge = "Blunt",
  hands = "1",
  type = "Melee",
  defensive = true,
}

weapon_class{
  id = "sledge",
  attack_sprite = "sledge_attack",
  charged_attack_sprite = "sledge_charged_attack",
  accuracy = "2",
  damage_modifier = "0",
  durability = "3",
  edge = "Blunt",
  hands = "2",
  type = "Melee",
  keywords = "Sweeping",
}

weapon_class{
  id = "spear",
  attack_sprite = "spear_attack",
  charged_attack_sprite = "spear_charged_attack",
  accuracy = "4",
  damage_modifier = "-1",
  durability = "1",
  edge = "Piercing",
  hands = "2",
  type = "Melee",
  long = true,
  sweeping = true,
}

weapon_class{
  id = "staff",
  attack_sprite = "staff_attack",
  charged_attack_sprite = "staff_charged_attack",
  accuracy = "2",
  damage_modifier = "1",
  durability = "1",
  edge = "Blunt",
  hands = "2",
  type = "Arcane",
  wizardly = true,
}

weapon_class{
  id = "sword",
  attack_sprite = "sword_attack",
  charged_attack_sprite = "sword_charged_attack",
  accuracy = "3",
  damage_modifier = "0",
  durability = "0",
  edge = "Sharp",
  hands = "1",
  type = "Melee",
}

-- An attempt at making some specific weapons using this.

weapon{
  id = "travelers_sword",
  rank = "r1"
  class = "sword",
  damage = -- I want something like "weapon_rank(r1)+weapon_class.sword(damage_modifier)", not sure of the language
}
