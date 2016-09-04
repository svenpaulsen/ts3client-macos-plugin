//
// TeamSpeak 3 Client macOS Plugin
//
// Copyright (c) Sven Paulsen. All rights reserved.
//

#define EXPORT __attribute__ ((visibility("default")))

// required functions
EXPORT const char* ts3plugin_name();
EXPORT const char* ts3plugin_version();
EXPORT const char* ts3plugin_author();
EXPORT const char* ts3plugin_description();
EXPORT int         ts3plugin_apiVersion();
EXPORT int         ts3plugin_init();
EXPORT void        ts3plugin_shutdown();
EXPORT void        ts3plugin_setFunctionPointers(const struct TS3Functions functions);

// optional functions
EXPORT void        ts3plugin_registerPluginID(const char* pluginID);

// messaging functions
EXPORT int         ts3plugin_onTextMessageEvent(uint64 schID, anyID mode, anyID rcvID, anyID srcID, const char* srcName, const char* srcUID, const char* msg, int ignored);
EXPORT int         ts3plugin_onClientPokeEvent(uint64 schID, anyID srcID, const char* srcName, const char* srcUID, const char* msg, int ignored);
