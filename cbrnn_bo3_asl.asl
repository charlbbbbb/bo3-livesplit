state("blackops3")
{
    byte round_counter : 0xA55BDEC;
    int level_time : 0xA6424FC;
    string13 map_name : 0x179DF840;
    int split : 0x17B3C3C8; // 0x17B3C3A8;
}

startup
{
    vars.time_offset = 0;
    timer.CurrentTimingMethod = TimingMethod.GameTime;

    vars.split_names = new Dictionary<string, Dictionary<int, string>>()
    {
        {
            "zm_zod", new Dictionary<int, string>()
            {
                {0, "Rift"},
                {1, "Sword"},
                {2, "Flag"},
                {3, "SOE Egg End"}
            }
        },
        {
            "zm_castle", new Dictionary<int, string>()
            {
                {0, "Bow"},
                {1, "Rocket Test TP"},
                {2, "First TP"},
                {3, "Key Place"},
                {4, "DE Boss Enter"},
                {5, "DE Egg End"}
            }
        },
        {
            "zm_island", new Dictionary<int, string>()
            {
                {0, "Bunker"},
                {1, "Skull"},
                {2, "KT-4"},
                {3, "ZNS Boss Enter"},
                {4, "ZNS Egg End"}
            }
        },
        {
            "zm_stalingrad", new Dictionary<int, string>()
            {
                {0, "Fly 1"},
                {1, "Fly 2"},
                {2, "Challenge Start"},
                {3, "Keycard Lockdown"},
                {4, "Button Press"},
                {5, "GK Egg End"}
            }
        },
        {
            "zm_genesis", new Dictionary<int, string>()
            {
                {0, "Keeper Start"},
                {1, "Squid Leave"},
                {2, "House"},
                {3, "Boss 1"},
                {4, "Basketball"},
                {5, "Boss 2"},
                {6, "Rev Egg End"}
            }
        },
        {
            "zm_tomb", new Dictionary<int, string>()
            {
                {0, "Ice Craft"},
                {1, "Fire Enter"},
		{2, "Lightning Enter"},
                {3, "Lightning Craft"},
                {4, "Ice Leave"},
                {5, "Upgrade"},
                {6, "Fists"},
                {7, "Origins Egg End"}
            }
        },
	{
            "zm_moon", new Dictionary<int, string>()
            {
                {0, "Samantha Says"},
                {1, "Hack Complete"},
                {2, "Ball"},
                {3, "Canister 1"},
                {4, "Canister 2"},
                {5, "Moon Egg End"}
            }
        }
    };

	foreach(var map in vars.split_names.Keys) {
		settings.Add(map, true, map);
        var splitDict = vars.split_names[map];
        // Cant get for loops to work when logic is sound here. Going with this instead
        for (var i=0;i<splitDict.Count;i++) {
            settings.Add(splitDict[i], true, splitDict[i], map);
        }
        
    };       
}

start
{
	if(current.round_counter == 1 && current.round_counter > old.round_counter)
    {
        vars.time_offset = current.level_time;
        return true;
    }
}

split
{
    var split_map = vars.split_names[current.map_name];
    var current_split_name = split_map[old.split];
    if (settings[current_split_name] && current.split > old.split) {
        return true;
    }
    return false;
}

gameTime
{
    return new TimeSpan(0, 0, 0, 0, current.level_time - vars.time_offset);
}

reset
{
    return (current.round_counter == 0 && old.round_counter != 0 || current.split == 0 && old.split != 0 || current.map_name.Equals("core_frontend"));
}

isLoading
{
    return true;
}