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

#using scripts\zm\single_splits;
#using scripts\zm\helpers;
#using scripts\zm\timers;

#namespace map_splits;

function ZodSplits()
{
    split_array = Array(&single_splits::WaitFirstRiftSplit, &single_splits::WaitSword, &single_splits::WaitFlagPickup, &single_splits::WaitZodEnd);
    split_name_array = Array("Rift", "Sword", "Flag", "Egg End");
    return Array(split_array, split_name_array);
}

function CastleSplits()
{
    split_array = Array(&single_splits::WaitBow, &single_splits::WaitCastleRocketTP, &single_splits::WaitCastleFirstTP, &single_splits::WaitKeyPlaced, &single_splits::WaitBossEnter, &single_splits::WaitCastleEnd);
    split_name_array = Array("Bow", "Rocket Test TP", "Time Travel 1", "Key Placed", "Boss Enter", "Egg End");
    return Array(split_array, split_name_array);
}

function IslandSplits()
{
    split_array = Array(&single_splits::WaitBunker, &single_splits::WaitSkull, &single_splits::WaitKT, &single_splits::WaitIslandBossEnter, &single_splits::WaitIslandEnd);
    split_name_array = Array("Bunker", "Skull", "KT-4", "Boss Enter", "Egg End");
    return Array(split_array, split_name_array);
}

function StalingradSplits()
{
    split_array = Array(&single_splits::WaitFirstFly, &single_splits::WaitSecondFly, &single_splits::WaitChallenges, &single_splits::WaitDownload, &single_splits::WaitStalingradBoss, &single_splits::WaitStalingradEnd);
    split_name_array = Array("Fly 1", "Fly 2", "Challenge Start", "Download", "Sewer", "Egg End");
    return Array(split_array, split_name_array);
}

function GenesisSplits()
{
    split_array = Array(&single_splits::WaitKeeperStart, &single_splits::WaitSquidLeave, &single_splits::WaitHouse, &single_splits::WaitBoss1, &single_splits::WaitBasketball, &single_splits::WaitBoss2, &single_splits::WaitGenesisEnd);
    split_name_array = Array("Keeper", "Squid Leave", "House", "Boss 1", "Basketball", "Boss 2", "Egg End");
    return Array(split_array, split_name_array);
}

function TombSplits()
{
    split_array = Array(&single_splits::WaitIceCraft, &single_splits::WaitFireEnter, &single_splits::WaitLightningEnter, &single_splits::WaitLightningCraft, &single_splits::WaitIceLeave, &single_splits::WaitUpgrade, &single_splits::WaitKills, &single_splits::WaitTombEnd);
    split_name_array = Array("Ice Craft", "Fire Enter", "Lightning Enter", "Lightning Craft", "Ice Leave", "Upgrade", "100 Kills", "Egg End");
    return Array(split_array, split_name_array);
}

function MoonSplits()
{
    split_array = Array(&single_splits::WaitSamanthaSays, &single_splits::WaitHack, &single_splits::WaitVrilSphere, &single_splits::WaitCanister1, &single_splits::WaitCanister2, &single_splits::WaitBigBang);
    split_name_array = Array("Samantha Says", "Hack Complete", "Ball", "Canister 1", "Canister 2", "Egg End");
    return Array(split_array, split_name_array);
}

function RunSplitSetup(split_information)
{
    // Unpack Split Information
    split_array = split_information[0];
    split_name_array = split_information[1];
    // Wait For Match Start
    helpers::WaitFadeIn();
    // Create Global Timer
    timers::create_global_timer(20, 20, helpers::ShowGlobalTimer(), false);
    level.start_time = GetTime();
    // Initialise Splits
    split_hud_array = [];
    for (i=0; i<split_array.size; i++) {
        split_hud_array[i] = timers::init_hud(20, (20+((i+1)*15)), GetDvarInt("show_splits"));
        split_hud_array[i] SetText("^7"+split_name_array[i]+":^5");
        [[split_array[i]]]();
        timers::split(split_hud_array[i], split_name_array[i], level.start_time);
    }
}
