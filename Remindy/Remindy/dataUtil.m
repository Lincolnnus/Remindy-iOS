//
//  dataUtil.m
//  Remindy
//
//  Created by Shaohuan Li on 23/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "dataUtil.h"

static dataUtil* sharedInstance = nil;

@implementation dataUtil
+ (dataUtil*) sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[dataUtil alloc] init];
    }
    return sharedInstance;
}
@end
