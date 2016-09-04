//
// TeamSpeak 3 Client macOS Plugin
//
// Copyright (c) Sven Paulsen. All rights reserved.
//

@implementation Log

/**
 * Writes a critical message to the client log file and stops the application.
 */
+ (int) critical:(NSString*)message
{
    return [self send:message withLevel:LogLevel_CRITICAL];
}

/**
 * Writes a critical message with parameters to the client log file and stops the application.
 */
+ (int) criticalFormat:(NSString*)format, ...
{
    va_list args;
    va_start(args, format);
    
    NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    return [self critical:message];
}

/**
 * Writes an error message to the client log file.
 */
+ (int) error:(NSString*)message
{
    return [self send:message withLevel:LogLevel_ERROR];
}

/**
 * Writes an error message with parameters to the client log file.
 */
+ (int) errorFormat:(NSString*)format, ...
{
    va_list args;
    va_start(args, format);
    
    NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    return [self error:message];
}

/**
 * Writes a warning message to the client log file.
 */
+ (int) warning:(NSString*)message
{
    return [self send:message withLevel:LogLevel_WARNING];
}

/**
 * Writes a warning message with parameters to the client log file.
 */
+ (int) warningFormat:(NSString*)format, ...
{
    va_list args;
    va_start(args, format);
    
    NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    return [self warning:message];
}

/**
 * Writes a debug message to the client log file.
 */
+ (int) debug:(NSString*)message
{
    return [self send:message withLevel:LogLevel_DEBUG];
}

/**
 * Writes a debug message with parameters to the client log file.
 */
+ (int) debugFormat:(NSString*)format, ...
{
    va_list args;
    va_start(args, format);
    
    NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    return [self debug:message];
}

/**
 * Writes an informational message to the client log file.
 */
+ (int) info:(NSString*)message
{
    return [self send:message withLevel:LogLevel_INFO];
}

/**
 * Writes an informational message with parameters to the client log file.
 */
+ (int) infoFormat:(NSString*)format, ...
{
    va_list args;
    va_start(args, format);
    
    NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    return [self info:message];
}

/**
 * Writes a development message to the log file (will not appear in release mode).
 */
+ (int) devel:(NSString*)message
{
    return [self send:message withLevel:LogLevel_DEVEL];
}

/**
 * Writes a development message with parameters to the client log file (will not appear in release mode).
 */
+ (int) develFormat:(NSString*)format, ...
{
    va_list args;
    va_start(args, format);
    
    NSString* message = [[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    return [self devel:message];
}

/**
 * Writes a message to the log file using a specified log level.
 */
+ (int) send:(NSString*)message withLevel:(int)level
{
    [[SDK instance] pluginSDK].logMessage(message.UTF8String, level, ts3plugin_name(), [[SDK instance] pluginSDK].getCurrentServerConnectionHandlerID());
    
    return level;
}

@end
