//
// TeamSpeak 3 Client macOS Plugin
//
// Copyright (c) Sven Paulsen. All rights reserved.
//

/**
 * Returns the name of the plugin.
 */
const char* ts3plugin_name()
{
    return "macOS";
}

/**
 * Returns the version number of the plugin.
 */
const char* ts3plugin_version()
{
    return "1.0.0";
}

/**
 * Returns the author of the plugin.
 */
const char* ts3plugin_author()
{
    return "Sven 'ScP' Paulsen";
}

/**
 * Returns the description of the plugin.
 */
const char* ts3plugin_description()
{
    return "Plugin to enhance the TeamSpeak 3 Client on macOS by using the Cocoa Framework";
}

/**
 * Returns the API version number of the plugin.
 */
int ts3plugin_apiVersion()
{
    return PLUGIN_API;
}

/**
 * Loads the plugin.
 */
int ts3plugin_init()
{
    if(floor(NSAppKitVersionNumber) <= NSAppKitVersionNumber10_8)
    {
        [Log error:@"Failed to initialize plugin; macOS 10.8 or later is required"];
        
        return 1;
    }
    
    [[App instance] hook];
    
    [Log infoFormat:@"Plugin initialized; version %s built on %s %s", ts3plugin_version(), __DATE__, __TIME__];
    
    return 0;
}

/**
 * Unloads the plugin.
 */
void ts3plugin_shutdown()
{
    if([[SDK instance] pluginID])
    {
        [[SDK instance] setPluginID:nil];
    }
    
    [[App instance] unhook];
}

/**
 * Registers TeamSpeak 3 callback functions.
 */
void ts3plugin_setFunctionPointers(const struct TS3Functions functions)
{
    [[SDK instance] setPluginSDK:functions];
}

/**
 * Registers an auto-generated plugin ID used for return codes, commands, menus and hotkeys.
 */
void ts3plugin_registerPluginID(const char* id)
{
    [[SDK instance] setPluginID:[NSString stringWithUTF8String:id]];
}

/**
 * Increases the dock tile count on incoming text messages when the TeamSpeak 3 Client UI is inactive.
 */
int ts3plugin_onTextMessageEvent(uint64 schID, anyID mode, anyID rcvID, anyID srcID, const char* srcName, const char* srcUID, const char* msg, int ignored)
{
    if(!ignored && ![[App instance] isActive])
    {
        [[App instance] increaseTileCount];
    }
    
    return ignored;
}

/**
 * Increases the dock tile count on incoming pokes when the TeamSpeak 3 Client UI is inactive.
 */
int ts3plugin_onClientPokeEvent(uint64 schID, anyID srcID, const char* srcName, const char* srcUID, const char* msg, int ignored)
{
    if(!ignored && ![[App instance] isActive])
    {
        [[App instance] increaseTileCount];
    }
    
    return ignored;
}
