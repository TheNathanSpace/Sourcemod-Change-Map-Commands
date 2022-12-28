#include <sourcemod>

public Plugin myinfo =
{
	name = "Change Map Commands",
	author = "Nathan",
	description = "Commands to switch to next/random map",
	version = "1.0",
	url = "http://github.com/TheNathanSpace"
};

ArrayList g_MapList;
int g_mapListSize = 0;

public void OnPluginStart()
{
	int arraySize = ByteCountToCells(PLATFORM_MAX_PATH);
	g_MapList = new ArrayList(arraySize);
	g_mapListSize = g_MapList.Length;
	int serial = -1;
	ReadMapList(g_MapList, serial, "default", 0);
	RegAdminCmd( "fof_rm", Command_Random, ADMFLAG_GENERIC );
	RegAdminCmd( "fof_nm", Command_Next, ADMFLAG_GENERIC );
	PrintToServer("Change Map Commands plugin loaded.");
}

// Random map command
public Action:Command_Random(caller, args)
{
	SwitchToRandom();
	return Plugin_Handled;
}

public SwitchToRandom() {
	new randomMapIndex = GetRandomInt(0, g_mapListSize);
	char nextMap[PLATFORM_MAX_PATH];
	GetArrayString(g_MapList, randomMapIndex, nextMap, PLATFORM_MAX_PATH)
	ForceChangeLevel(nextMap, "Switching to random map");
}

// Next map command
public Action:Command_Next(caller, args)
{
	SwitchToNext();
	return Plugin_Handled;
}

public SwitchToNext() {
	char nextMap[PLATFORM_MAX_PATH];
	GetNextMap(nextMap, sizeof(nextMap));
	ForceChangeLevel(nextMap, "Switching to next map");
}