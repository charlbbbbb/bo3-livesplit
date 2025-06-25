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

#namespace helpers;


// Misc
function IsScenePlaying(scene)
{
    return self scene::is_playing(scene);
}

function WaitFadeIn()
{
    while(!IsDefined(level.n_gameplay_start_time)) wait 0.05;
}

function ShowGlobalTimer()
{
    if (getDvarInt("show_timer") == 1 || getDvarInt("show_splits") == 1)
    {
        return 1;
    }
    return 0;
}

function IsTrue(bool)
{
	if(IsDefined(bool) && bool) return true;
	else return false;
}

// Timer
function ms_to_str(ms)
{
    min = 0;
    sec = 0;
    if(ms >= 60000)
    {
        min = Int(ms / 60000);
        ms -= min * 60000;
    }
    if(ms >= 1000)
    {
        sec = Int(ms / 1000);
        ms -= sec * 1000;
    }
    time = "";
    if(min > 0)
    {
        time += min + ":";
    }
    if(min || sec > 0)
    {
        if(sec < 10 && min) time += "0";
        time += sec + ".";
    }
    if(min || sec || ms > 0)
    {
        if(!min && !sec) time += "0.";
        if(ms <= 50) time += "0";
        ms /= 10;
        time += ms;
    }
    return time;
}
