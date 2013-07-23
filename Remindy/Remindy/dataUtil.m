//
//  dataUtil.m
//  Remindy
//
//  Created by Shaohuan Li on 23/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "dataUtil.h"
#import "CacheManager.h"

#define TOKEN_CACHE_KEY @"token"
#define UID_CACHE_KEY @"uid"

static dataUtil* sharedInstance = nil;
@implementation dataUtil
+ (dataUtil*) sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[dataUtil alloc] init];
    }
    return sharedInstance;
}

- (BOOL) isLoggedIn {
    return self.token && self.uid;
}


- (void) logout {
    [[CacheManager sharedManager] clearCacheForKey:TOKEN_CACHE_KEY];
    [[CacheManager sharedManager] clearCacheForKey:UID_CACHE_KEY];
}

- (NSString*)token {
    return (NSString*)[[CacheManager sharedManager] objectForKey:TOKEN_CACHE_KEY];
}

- (NSString*)uid {
    return (NSString*)[[CacheManager sharedManager] objectForKey:UID_CACHE_KEY];
}

- (void)setToken:(NSString *)token {
    [[CacheManager sharedManager] cacheObjectForKey:TOKEN_CACHE_KEY object:token];
}

- (void)setUid:(NSString *)uid {
    [[CacheManager sharedManager] cacheObjectForKey:UID_CACHE_KEY object:uid];
}

@end
