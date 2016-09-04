//
// TeamSpeak 3 Client macOS Plugin
//
// Copyright (c) Sven Paulsen. All rights reserved.
//

@interface SDK : NSObject

@property struct TS3Functions  pluginSDK;
@property NSString*            pluginID;
@property NSMutableDictionary* returnCodes;

+ (SDK*) instance;
+ (id)   allocWithZone:(NSZone*)zone;
+ (void) initialize;
+ (void) destroy;

- (id)   init;

@end
