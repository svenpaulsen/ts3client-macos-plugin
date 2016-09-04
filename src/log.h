//
// TeamSpeak 3 Client macOS Plugin
//
// Copyright (c) Sven Paulsen. All rights reserved.
//

@interface Log : NSObject

+ (int) critical:(NSString*)message;
+ (int) criticalFormat:(NSString*)format, ...;
+ (int) error:(NSString*)message;
+ (int) errorFormat:(NSString*)format, ...;
+ (int) warning:(NSString*)message;
+ (int) warningFormat:(NSString*)format, ...;
+ (int) debug:(NSString*)message;
+ (int) debugFormat:(NSString*)format, ...;
+ (int) info:(NSString*)message;
+ (int) infoFormat:(NSString*)format, ...;
+ (int) devel:(NSString*)message;
+ (int) develFormat:(NSString*)format, ...;
+ (int) send:(NSString*) message withLevel:(int)level;

@end
