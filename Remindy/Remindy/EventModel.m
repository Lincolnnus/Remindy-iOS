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

- (NSComparisonResult)compare:(EventModel *)otherObject {
    if ([otherObject.deadline compare:[NSDate date]] == NSOrderedDescending &&
        ([self.deadline compare:[NSDate date]] == NSOrderedDescending)) {
        // if both not outdated
        NSNumber* selfScore = [NSNumber numberWithInt:self.numOfAgrees - self.numOfDisagrees];
        NSNumber* otherScore = [NSNumber numberWithInt:otherObject.numOfAgrees - otherObject.numOfDisagrees];
        return [otherScore compare:selfScore];
    } else {
        return [otherObject.deadline compare:self.deadline];
    }
}

@end
