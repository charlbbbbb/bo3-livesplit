#using scripts\codescripts\struct;

#using scripts\shared\audio_shared;
#using scripts\shared\clientfaceanim_shared;//DO NOT REMOVE - needed for system registration
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;//DO NOT REMOVE - needed for system registration
#using scripts\shared\footsteps_shared;//DO NOT REMOVE - needed for system registration
#using scripts\shared\load_shared;
#using scripts\shared\music_shared;
#using scripts\shared\_oob;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\archetype_shared\archetype_shared;

//Abilities
#using scripts\shared\abilities\_ability_player;	//DO NOT REMOVE - needed for system registration

#insert scripts\shared\shared.gsh;
#insert scripts\shared\version.gsh;

#using scripts\zm\_destructible;
#using scripts\zm\_callbacks;
#using scripts\zm\_sticky_grenade;
#using scripts\shared\util_shared;

//System registration
#using scripts\zm\_ambient;
#using scripts\zm\_global_fx;
#using scripts\zm\_radiant_live_update;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_traps;
#using scripts\zm\_zm_playerhealth;
#using scripts\zm\gametypes\_weaponobjects;
#using scripts\zm\craftables\_zm_craftables;

//Weapon registration
#using scripts\zm\gametypes\_weaponobjects;

#namespace load;

function levelNotifyHandler(clientNum, state, oldState)
{
	if(state != "")
	{
		level notify(state,clientNum);
	}
}

function warnMissileLocking( localClientNum, set )
{
	/*if ( set && !(self islocalplayerviewlinked(localClientNum)) )
		return;
		
	_helicopter_sounds::play_targeted_sound( set );*/
}

function warnMissileLocked( localClientNum, set )
{
	/*if ( set && !(self islocalplayerviewlinked(localClientNum)) )
		return;

	_helicopter_sounds::play_locked_sound( set );*/
}

function warnMissileFired( localClientNum, set )
{
	/*if ( set && !(self islocalplayerviewlinked(localClientNum)) )
		return;

	_helicopter_sounds::play_fired_sound( set );*/
}

function main()
{
	zm::init();
		
	level thread server_time();
	level thread util::init_utility();

	util::register_system("levelNotify",&levelNotifyHandler);
	
	register_clientfields();
	
	level.createFX_disable_fx = (GetDvarInt("disable_fx") == 1);
	
	//level thread _dogs::init();
	if ( IS_TRUE( level._uses_sticky_grenades ) )
	{
		level thread _sticky_grenade::main();
	}

	system::wait_till( "all" );

	level thread load::art_review();

	level flagsys::set( "load_main_complete" );
}

function server_time()
{
	for (;;)
	{
		level.serverTime = getServerTime( 0 );
		wait( 0.01 );
	}
}

function register_clientfields()
{
	//clientfield::register( "missile", "cf_m_proximity", VERSION_SHIP, 1, "int", &callback::callback_proximity, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	//clientfield::register( "missile", "cf_m_emp", VERSION_SHIP, 1, "int", &callback::callback_emp, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	//clientfield::register( "missile", "cf_m_stun", VERSION_SHIP, 1, "int", &callback::callback_stunned, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	
	//clientfield::register( "scriptmover", "cf_s_emp", VERSION_SHIP, 1, "int", &callback::callback_emp, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	//clientfield::register( "scriptmover", "cf_s_stun", VERSION_SHIP, 1, "int", &callback::callback_stunned, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	
	//clientfield::register( "world", "sndPrematch", VERSION_SHIP, 1, "int", &audio::sndMPPrematch, CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	//clientfield::register( "toplayer", "sndMelee", VERSION_SHIP, 1, "int", &audio::weapon_butt_sounds, CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );
	//clientfield::register( "toplayer", "sndEMP", VERSION_SHIP, 1, "int", &audio::sndEMP, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );	
	
	clientfield::register( "allplayers", "zmbLastStand", VERSION_SHIP, 1, "int", &zm::Laststand, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );

	clientfield::register( "clientuimodel", "zmhud.swordEnergy", VERSION_SHIP, 7, "float", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "clientuimodel", "zmhud.swordState", VERSION_SHIP, 4, "int", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	clientfield::register( "clientuimodel", "zmhud.swordChargeUpdate", VERSION_SHIP, 1, "counter", undefined, !CF_HOST_ONLY, !CF_CALLBACK_ZERO_ON_NEW_ENT );
	//clientfield::register( "toplayer", "zmbLastStand", VERSION_SHIP, 1, "int", &zm_audio::sndZmbLaststand, !CF_HOST_ONLY, CF_CALLBACK_ZERO_ON_NEW_ENT );

}

function autoexec fix_bgb_textures()
{

	level thread change_gum_texture( "zm_bgb_aftertaste", "rounds", "speckled");
	level thread change_gum_texture( "zm_bgb_board_games", "rounds", "speckled");
	level thread change_gum_texture( "zm_bgb_board_to_death", "time", "speckled");
	level thread change_gum_texture( "zm_bgb_burned_out", "event", "speckled");
	level thread change_gum_texture( "zm_bgb_crawl_space", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_dead_of_nuclear_winter", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_disorderly_combat", "time", "speckled");
	level thread change_gum_texture( "zm_bgb_ephemeral_enhancement", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_fatal_contraption", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_flavor_hexed", "event", "speckled");
	level thread change_gum_texture( "zm_bgb_idle_eyes", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_im_feelin_lucky", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_immolation_liquidation", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_licensed_contractor", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_mind_blown", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_phoenix_up", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_eye_candy", "activated", "pinwheel");
	level thread change_gum_texture( "zm_bgb_pop_shocks", "event", "speckled");
	level thread change_gum_texture( "zm_bgb_respin_cycle", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_slaughter_slide", "event", "speckled");
	level thread change_gum_texture( "zm_bgb_tone_death", "event", "pinwheel");
	level thread change_gum_texture( "zm_bgb_unbearable", "event", "speckled");
	level thread change_gum_texture( "zm_bgb_unquenchable", "event", "speckled");
	level thread change_gum_texture( "zm_bgb_whos_keeping_score", "activated", "speckled");
	level thread change_gum_texture( "zm_bgb_bullet_boost", "activated", "shiny");
	level thread change_gum_texture( "zm_bgb_cache_back", "activated", "shiny");
	level thread change_gum_texture( "zm_bgb_crate_power", "event", "shiny");
	level thread change_gum_texture( "zm_bgb_extra_credit", "activated", "shiny");
	level thread change_gum_texture( "zm_bgb_fear_in_headlights", "activated", "shiny");
	level thread change_gum_texture( "zm_bgb_kill_joy", "activated", "shiny");
	level thread change_gum_texture( "zm_bgb_on_the_house", "activated", "shiny");
	level thread change_gum_texture( "zm_bgb_soda_fountain", "event", "shiny");
	level thread change_gum_texture( "zm_bgb_temporal_gift", "rounds", "shiny");
	level thread change_gum_texture( "zm_bgb_undead_man_walking", "time", "shiny");
	level thread change_gum_texture( "zm_bgb_wall_power", "event", "shiny");
	level thread change_gum_texture( "zm_bgb_head_drama", "rounds", "swirl");
	level thread change_gum_texture( "zm_bgb_killing_time", "activated", "swirl");
	level thread change_gum_texture( "zm_bgb_near_death_experience", "rounds", "swirl");
	level thread change_gum_texture( "zm_bgb_perkaholic", "event", "swirl");
	level thread change_gum_texture( "zm_bgb_power_vacuum", "rounds", "swirl");
	level thread change_gum_texture( "zm_bgb_profit_sharing", "time", "swirl");
	level thread change_gum_texture( "zm_bgb_reign_drops", "activated", "swirl");
	level thread change_gum_texture( "zm_bgb_round_robbin", "activated", "swirl");
	level thread change_gum_texture( "zm_bgb_secret_shopper", "time", "swirl");
	level thread change_gum_texture( "zm_bgb_self_medication", "event", "swirl");
	level thread change_gum_texture( "zm_bgb_shopping_free", "time", "swirl");
	level thread change_gum_texture( "zm_bgb_projectile_vomiting", "rounds", "pinwheel");
	level thread change_gum_texture( "zm_bgb_newtonian_negation", "time", "pinwheel");

}

function change_gum_texture( bgb, color, texture )
{
	camo = "tag_gumball_"+color+"_"+texture;

	while( !isDefined( level.bgb ) ) wait 0.05;
	while( !isDefined( level.bgb[ bgb ] ) ) wait 0.05;
	while( !isDefined( level.bgb[ bgb ].var_ece14434 ) ) wait 0.05;
	wait 0.5;

	level.bgb[ bgb ].var_ece14434 =  camo;
}
