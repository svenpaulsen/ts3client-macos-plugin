//
// TeamSpeak 3 Client macOS Plugin
//
// Copyright (c) Sven Paulsen. All rights reserved.
//

static SDK* gInstance = nil;

@implementation SDK

/**
 * Returns a singleton instance of the SDK object.
 */
+ (SDK*) instance
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
    
    if(self)
    {
        _returnCodes = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

@end
