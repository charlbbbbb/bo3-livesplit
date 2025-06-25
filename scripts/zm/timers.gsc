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

#using scripts\zm\helpers;

#namespace timers;

function init_hud(x, y, alpha)
{
	hud = NewHudElem();
	hud.alignX = "left";
	hud.alignY = "top";
	hud.horzAlign = "user_left";
	hud.vertAlign = "user_top";
	hud.foreground = false;
	hud.hidewheninmenu = false;
	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.font = "default";
	hud.fontScale = 1.3;
	return hud;
}

function bottom_left_hud(x, y, alpha, fontscale)
{
	hud = NewHudElem();
	hud.alignX = "left";
	hud.alignY = "bottom";
	hud.horzAlign = "user_left";
	hud.vertAlign = "user_bottom";
	hud.foreground = false;
	hud.hidewheninmenu = false;
	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.font = "default";
	hud.fontScale = fontscale;
	return hud;
}

function bottom_right_hud(x, y, alpha)
{
	hud = NewHudElem();
	hud.alignX = "right";
	hud.alignY = "bottom";
	hud.horzAlign = "user_right";
	hud.vertAlign = "user_bottom";
	hud.foreground = false;
	hud.hidewheninmenu = false;
	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.font = "default";
	hud.fontScale = 1;
	return hud;
}

function create_global_timer(x, y, alpha, tenths=false)
{
    timer = init_hud(20, 20, alpha);
    if (!tenths) timer SetTimerUp(0);
    else timer SetTenthsTimerUp(0);
    timer.label = &"^6Time: ^2";
}

function split(hudelm, split_name, start_time, increment=true)
{
	split_time = helpers::ms_to_str(GetTime()-start_time);
	split_text = "^7"+split_name+": ^5"+split_time;
	hudelm SetText(split_text);
	if (increment==true){
		cur_split_num = getDvarInt(level.split_count_dvar);
		setDvar(level.split_count_dvar, cur_split_num+1);
		// Debug
		// iPrintLn("^2Split Completed!");
	}
}
