//
// TeamSpeak 3 Client macOS Plugin
//
// Copyright (c) Sven Paulsen. All rights reserved.
//

@interface App : NSObject <NSApplicationDelegate>

@property (readonly) NSApplication*            app;
@property (readonly) NSWindow*                 win;
@property (readonly) NSDockTile*               ico;
@property (readonly) id<NSApplicationDelegate> del;

+ (App*)                        instance;
+ (id)                          allocWithZone:(NSZone*)zone;
+ (void)                        destroy;
+ (void)                        initialize;

- (id)                          init;
- (void)                        hook;
- (void)                        unhook;
- (void)                        setupMainWindow;
- (void)                        hideMainWindow;
- (bool)                        isActive;
- (int)                         getTileCount;
- (int)                         increaseTileCount;
- (int)                         decreaseTileCount;
- (void)                        resetTileCount;
- (NSMenu*)                     applicationDockMenu:(NSApplication*)sender;
- (void)                        applicationDidFinishLaunching:(NSNotification*)notification;
- (void)                        applicationDidBecomeActive:(NSNotification*)notification;
- (NSApplicationTerminateReply) applicationShouldTerminate:(NSApplication*)sender;

@end
