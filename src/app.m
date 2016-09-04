//
// TeamSpeak 3 Client macOS Plugin
//
// Copyright (c) Sven Paulsen. All rights reserved.
//

static App* gInstance = nil;

@implementation App

/**
 * Returns a singleton instance of the App object.
 */
+ (App*) instance
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
 * Registers for delegate callbacks.
 */
- (void) hook
{
    _app = [NSApplication sharedApplication];
    _ico = [_app dockTile];
    _del = [_app delegate];
    
    [_app setDelegate:self];
}

/**
 * Unregisters from delegate callbacks.
 */
- (void) unhook
{
    [_app setDelegate:nil];
}

/**
 * Finds the main window used in the TeamSpeak 3 Client UI, tweaks some settings and saves it 
 * for later use.
 */
- (void) setupMainWindow
{
    for(NSWindow* win in [_app windows])
    {
        if([win.title isEqualToString:@"TeamSpeak 3"])
        {
            _win = win;
        }
    }
    
    // re-enable close button
    [_win setStyleMask:[_win styleMask] | NSClosableWindowMask];
    [_win setReleasedWhenClosed:NO];
    
    // override close button behaviour
    [[_win standardWindowButton:NSWindowCloseButton] setTarget:self];
    [[_win standardWindowButton:NSWindowCloseButton] setAction:@selector(hideMainWindow)];
    
    // re-enable fullscreen mode
    [_win setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
}

/**
 * Hides the main window (called when clicking the close button).
 */
- (void) hideMainWindow
{
    [_win orderOut:self];
}

/**
 * Returns true if the TeamSpeak 3 Client UI is active (has focus).
 */
- (bool) isActive
{
    return [_app isActive];
}

/**
 * Returns the current tile counter value.
 */
- (int) getTileCount
{
    return (int) [[_ico badgeLabel] integerValue];
}

/**
 * Increases the current tile counter value by 1.
 */
- (int) increaseTileCount
{
    int tileCount = [self getTileCount];
    
    [_ico setBadgeLabel:[NSString stringWithFormat:@"%d", tileCount]];
    
    if(tileCount < INT16_MAX)
    {
        tileCount++;
    }
    
    [_ico setBadgeLabel:[NSString stringWithFormat:@"%d", tileCount]];
    
    return tileCount;
}

/**
 * Decreases the current tile counter value by 1.
 */
- (int) decreaseTileCount
{
    int tileCount = [self getTileCount];
    
    if(tileCount > 0)
    {
        tileCount--;
    }
    
    if(!tileCount)
    {
        [self resetTileCount];
    }
    else
    {
        [_ico setBadgeLabel:[NSString stringWithFormat:@"%d", tileCount]];
    }
    
    return tileCount;
}

/**
 * Resets the current tile counter value.
 */
- (void) resetTileCount
{
    [_ico setBadgeLabel:nil];
}

/**
 * Handles notifications when the TeamSpeak 3 Client dock menu is opened.
 */
- (NSMenu*) applicationDockMenu:(NSApplication*)sender
{
    NSMenu* dockMenu = [[NSMenu alloc] initWithTitle:@"TeamSpeak 3"];
    
    [dockMenu addItem:[[[Menu instance] connectionsItem] copy]];
    [dockMenu addItem:[[[Menu instance] bookmarksItem] copy]];
    [dockMenu addItem:[[[Menu instance] permissionsItem] copy]];
    [dockMenu addItem:[[[Menu instance] toolsItem] copy]];
    
    return dockMenu;
}

/**
 * Intercepts notifications when the TeamSpeak 3 Client dock icon is clicked.
 */
- (BOOL) applicationOpenUntitledFile:(NSApplication*)sender
{
    [_win makeKeyAndOrderFront:self];
    
    return YES;
}

/**
 * Intercepts notifications when the TeamSpeak 3 Client finished launching.
 */
- (void) applicationDidFinishLaunching:(NSNotification*)notification
{
    [Log debugFormat:@"App finished launching; plugin API version %d", PLUGIN_API];
    
    [self setupMainWindow];
    
    [_del applicationDidFinishLaunching:notification];
}

/**
 * Intercepts notifications when the TeamSpeak 3 Client UI became active (got focus).
 */
- (void) applicationDidBecomeActive:(NSNotification*)notification
{
    [self resetTileCount];
    
    [_del applicationDidBecomeActive:notification];
}

/**
 * Intercepts notifications when the TeamSpeak 3 Client should be terminated.
 */
- (NSApplicationTerminateReply) applicationShouldTerminate:(NSApplication*)sender
{
    [self unhook];
    
    return [_del applicationShouldTerminate:sender];
}

@end
