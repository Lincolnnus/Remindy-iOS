//
//  EventModel.m
//  Remindy
//
//  Created by Shaohuan Li on 24/6/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel
@synthesize moduleCode, eventTitle, description, deadline, eventID;

-(id) initWithModuleCode: (NSString *) mc
           andEventTitle: (NSString *) et
          andDescription: (NSString *) desc
             andDeadline: (NSDate *) dead{
    
    if (self = [super init]) {
        moduleCode = mc;
        eventTitle = et;
        description = desc;
        deadline = dead;
    }
    return self;
}

-(void) setEventID:(NSString*)eID{
    eventID = eID;
}


@end
