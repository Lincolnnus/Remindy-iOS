//
//  EventModel.m
//  Remindy
//
//  Created by Shaohuan Li on 24/6/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel
@synthesize title;
-(id) initWith:(NSString *)t{
    if (self = [super init]) {title = t;}
    return self;
}
@end
