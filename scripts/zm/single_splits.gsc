#using scripts\codescripts\struct;

#using scripts\shared\system_shared;
#using scripts\shared\_burnplayer;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\ai_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\math_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\util_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\aat_shared;

#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\gib;

#using scripts\zm\_zm;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_hero_weapon;
#using scripts\zm\_zm_placeable_mine;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;

// Custom Mod Scripts
#using scripts\zm\helpers;

#namespace single_splits;

// SOE
function WaitZodEnd()
{
    if(GetPlayers().size < 4) level flag::wait_till("ee_boss_defeated");
    else while(!level helpers::IsScenePlaying("cin_zod_vign_summoning_key")) wait 0.05;
}

function WaitRift(str_areaname, str_pos)
{
    portal = GetEntArray(str_areaname + "_portal_" + str_pos, "script_noteworthy");
    portal_trig = GetEntArrayFromArray(portal, "teleport_trigger", "targetname")[0];
    for(;;)
    {
        portal_trig waittill("trigger", portee);
        if(!level clientfield::get("portal_state_" + str_areaname) || !IsPlayer(portee)) continue;
        return;
    }
}

function WaitSword()
{
    WaitRift("canal", "bottom");
}

function WaitFirstRiftSplit()
{
    WaitRift("slums", "top");
    for (;;)
    {
        if (level.players[0].teleporting==1) return;
        else wait 0.05;
    }
}

function WaitFlagPickup()
{
    for (;;)
	{
		if(level clientfield::get("ee_totem_state")!=2) 
		{
				wait 0.05;
		} else {return;}
    }
}

// DE
function WatchPlayerForBow()
{
    level endon("bow_acquired");
    for (;;) {
        self waittill("weapon_give", weapon);
        if (weapon == GetWeapon("elemental_bow")) {
            level notify("bow_acquired");
            return;
        }
    }
}

function WaitBow()
{
    level flag::wait_till("soul_catchers_charged");
    foreach (player in GetPlayers()) {
        player thread WatchPlayerForBow();
    }
    level waittill("bow_acquired");
}

function WaitAnyTP()
{
    for(;;)
    {
        if (level.players[0].b_teleporting==1) {
            return;
        }
        wait 0.05;
    }
}

function WaitCastleRocketTP()
{
    WaitAnyTP();
}

function WaitCastleFirstTP()
{
    for (;;){
        wait 0.05;
        if (!level flag::get("time_travel_teleporter_ready")) continue;
        break;
    }
    WaitAnyTP();
}

function WaitKeyPlaced()
{
    struct::get("vril_generator_family") waittill("trigger_activated");
}

function WaitBossEnter()
{
    level flag::wait_till("boss_fight_begin");
}

function WaitCastleEnd()
{
    while (!level helpers::IsScenePlaying("cin_cas_01_outro_3rd_sh010")) {
        wait 0.05;
    }
}

// ZNS
function WaitBunker()
{
    level flag::wait_till("connect_bunker_exterior_to_bunker_interior");
}

function WaitSkull()
{
    level flag::wait_till("a_player_got_skullgun");
}

function WaitKT()
{
    level flag::wait_till("ww_obtained");
}

function WaitIslandBossEnter()
{
    level waittill("hash_add73e69");
}

function WaitIslandEnd()
{
    level flag::wait_till("flag_play_outro_cutscene");
}

// GK
function WaitFly(area)
{
    switch (area) {
        case "tank": {
            num = 1;
            break;
        }
        case "supply": {
            num = 2;
            break;
        }
        case "dragon": {
            num = 3;
            break;
        }
        default: {
            return;
        }
    }
    while (!level helpers::IsScenePlaying("cin_t7_ai_zm_dlc3_dragon_transport_roost" + num + "_idle_2_pavlovs")) {
        wait 0.05;
    }
}

function WaitFirstFly()
{
    WaitFly("supply");
}

function WaitSecondFly()
{
    WaitFly("tank");
}

function WaitChallenges()
{
    level flag::wait_till("scenario_active");
}

function WaitStalingradBoss()
{
    GetEnt("ee_sewer_to_arena_trig", "targetname") waittill("trigger", player);
}

function WaitStalingradEnd()
{
    level waittill("hash_9b1cee4c");
}

function WaitDownload()
{
    level waittill("hash_8cc49f44");
}

// REV
function WaitKeeperStart()
{
    while(!IsDefined(level.ai_companion)) wait 0.05;
    for(;;)
    {
        while(IsAlive(level.ai_companion) && !level.ai_companion helpers::IsScenePlaying("cin_zm_dlc4_keeper_prtctr_ee_idle")) wait 0.05;
        if(level.ai_companion helpers::IsScenePlaying("cin_zm_dlc4_keeper_prtctr_ee_idle")) return;
        while(!IsAlive(level.ai_companion)) wait 0.05;
        wait 0.05;
    }
}

function WaitSquidLeave()
{
	for(;;)
	{
		while(!helpers::IsTrue(level.players[0].var_5aef0317)) wait 0.05;
        while(!helpers::IsTrue(level.players[0].streamer_hint)) wait 0.05;
		zone = zm_zonemgr::get_zone_from_position(level.players[0].streamer_hint.origin + VectorScale((0, 0, 1), 32), 0);
		if(zone == "zm_castle_power_zone") break;
		while(helpers::IsTrue(level.players[0].var_5aef0317)) wait 0.05;
	}
}

function WaitHouse()
{
    level flag::wait_till("teleporter_on");
}


function WaitBoss1()
{
    level flag::wait_till("rift_entrance_open");
}

function WaitBasketball()
{
    level waittill("hash_f81a82d1");
	while(!level.players[0].b_teleporting) wait 0.05;
}

function WaitBoss2(split_name)
{
    level flag::wait_till("toys_collected");
    level waittill("exploderee_teleporter_fx");
}

function WaitGenesisEnd()
{
    while(!level helpers::IsScenePlaying("genesis_ee_sams_room")) wait 0.05;
    wait 0.3;
}

// Origins
function WaitStaffCraft(split_name)
{
    name = StrTok(split_name, " ")[0];
    switch (name) {
        case "ice": {
            staff = "water";
            break;
        }
        case "wind": {
            staff = "air";
            break;
        }
        case "fire":
        case "lightning": {
            staff = ToLower(name);
            break;
        }
        default: {
            return;
        }
    }
    level waittill("elemental_staff_" + staff + "_crafted", player);
}

function WaitTombTP(split_name)
{
    switch (StrTok(split_name, " ")[0]) {
        case "Ice": {
            num = 4;
            break;
        }
        case "Lightning": {
            num = 3;
            break;
        }
        case "Wind": {
            num = 2;
            break;
        }
        case "Fire": {
            num = 1;
            break;
        }
        default: {
            return;
        }
    }

    if (IsSubStr(split_name, "Enter")) {
        for (;;) {
            level waittill("player_teleported", e_player, script_int);
            if (num == script_int) {
                return;
            }
        }
    }
    name = StrTok(split_name, " ")[0];
    switch (name) {
        case "Ice":
        case "Fire": {
            staff = ToLower(name);
            break;
        }
        case "Wind": {
            staff = "air";
            break;
        }
        case "Lightning": {
            staff = "electric";
            break;
        }
        default: {
            return;
        }
    }
    flag = "portal_exit_frame_" + staff + "_building";
    level flag::wait_till(flag);
    level flag::wait_till_clear(flag);
    portal = level.a_teleport_exits[num];
    radius_sq = 120 * 120;
    for (;;) {
        foreach(player in GetPlayers()) {
			dist_sq = DistanceSquared(player.origin, portal.origin);
			if(dist_sq < radius_sq && player GetStance() != "prone" && !(helpers::IsTrue(player.teleporting))) {
				return;
			}
		}
        wait 0.05;
    }
}

function WaitIceCraft()
{
    WaitStaffCraft("ice");
}

function WaitFireEnter()
{
    WaitTombTP("Fire Enter");
}

function WaitLightningCraft()
{
    WaitStaffCraft("lightning");
}

function WaitIceLeave()
{
    WaitTombTP("Ice");
}

function WaitUpgrade()
{
    WaitTombTP("Wind");
}

function WaitKills()
{
    WaitTombTP("Wind Enter");
}

function WaitTombEnd()
{
    level.players[0] waittill("_screen_fade_starting_ee_screen");
}

// Moon
function WaitSamanthaSays(){

    level flag::wait_till("ss1");

}

function WaitHack(){

    level waittill("sq_osc_over");

}

function WaitVrilSphere(){

    level flag::wait_till("complete_be_1");

}

function WaitCanister1(){

    level flag::wait_till("first_tanks_charged");

}

function WaitCanister2(){

    level flag::wait_till("second_tanks_charged");

}

function WaitBigBang(){

    level waittill("moon_sidequest_big_bang_achieved");

}