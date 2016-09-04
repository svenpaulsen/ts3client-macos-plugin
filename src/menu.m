//
// TeamSpeak 3 Client macOS Plugin
//
// Copyright (c) Sven Paulsen. All rights reserved.
//

static Menu* gInstance = nil;

@implementation Menu

/**
 * Returns a singleton instance of the Menu object.
 */
+ (Menu*) instance
{
    if(gInstance == nil)
    {
        @synchronized(self)
        {
            if(gInstance == nil) gInstance = [[super allocWithZone:nil] init];
        }
    }
    
    return gInstance;
}

/**
 * Prevents creation of new objects when calling alloc.
 */
+ (id) allocWithZone:(NSZone*)zone
{
    return [self instance];
}

/**
 * Destroys the object.
 */
+ (void) destroy
{
    gInstance = nil;
}

/**
 * Initializes the object.
 */
+ (void) initialize
{
    gInstance = [[super allocWithZone:nil] init];
}

/**
 * Creates the object.
 */
- (id) init
{
    self = [super init];
    
    return self;
}

/**
 * Returns the TeamSpeak 3 Client connections menu item.
 */
- (NSMenuItem*) connectionsItem
{
    return [[[[App instance] app] mainMenu] itemAtIndex:1];
}

/**
 * Returns the TeamSpeak 3 Client connections menu.
 */
- (NSMenu*) connectionsMenu
{
    return [[self connectionsItem] submenu];
}

/**
 * Returns the TeamSpeak 3 Client bookmarks menu item.
 */
- (NSMenuItem*) bookmarksItem
{
    return [[[[App instance] app] mainMenu] itemAtIndex:2];
}

/**
 * Returns the TeamSpeak 3 Client bookmarks menu.
 */
- (NSMenu*) bookmarksMenu
{
    return [[self bookmarksItem] submenu];
}

/**
 * Returns the TeamSpeak 3 Client self menu item.
 */
- (NSMenuItem*) selfItem
{
    return [[[[App instance] app]  mainMenu] itemAtIndex:4];
}

/**
 * Returns the TeamSpeak 3 Client self menu.
 */
- (NSMenu*) selfMenu
{
    return [[self selfItem] submenu];
}

/**
 * Returns the TeamSpeak 3 Client permissions menu item.
 */
- (NSMenuItem*) permissionsItem
{
    return [[[[App instance] app]  mainMenu] itemAtIndex:4];
}

/**
 * Returns the TeamSpeak 3 Client permissions menu.
 */
- (NSMenu*) permissionsMenu
{
    return [[self permissionsItem] submenu];
}

/**
 * Returns the TeamSpeak 3 Client tools menu item.
 */
- (NSMenuItem*) toolsItem
{
    return [[[[App instance] app] mainMenu] itemAtIndex:5];
}

/**
 * Returns the TeamSpeak 3 Client tools menu.
 */
- (NSMenu*) toolsMenu
{
    return [[self toolsItem] submenu];
}

/**
 * Returns an array containing all items from a specified menu.
 */
- (void) menuItems:(NSMenu*)menu atIndex:(int)index toArray:(NSMutableArray**)array
{
    NSMenuItem* item;
    NSUInteger  count = [[menu itemArray] count];
    
    for(; index < count; index++)
    {
        item = [menu itemAtIndex:index];
        
        if([item submenu] != nil)
        {
            [self menuItems:[item submenu] atIndex:0 toArray:array];
        }
        else
        {
            [*array addObject:item];
        }
    }
}


@end
