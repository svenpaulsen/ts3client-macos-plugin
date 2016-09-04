//
// TeamSpeak 3 Client macOS Plugin
//
// Copyright (c) Sven Paulsen. All rights reserved.
//

@interface Menu : NSObject <NSMenuDelegate>

+ (Menu*)       instance;
+ (id)          allocWithZone:(NSZone*)zone;
+ (void)        initialize;
+ (void)        destroy;

- (id)          init;
- (NSMenuItem*) connectionsItem;
- (NSMenuItem*) bookmarksItem;
- (NSMenuItem*) selfItem;
- (NSMenuItem*) permissionsItem;
- (NSMenuItem*) toolsItem;
- (NSMenu*)     connectionsMenu;
- (NSMenu*)     bookmarksMenu;
- (NSMenu*)     selfMenu;
- (NSMenu*)     permissionsMenu;
- (NSMenu*)     toolsMenu;
- (void)        menuItems:(NSMenu*)menu atIndex:(int)index toArray:(NSMutableArray**)array;

@end
