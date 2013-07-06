//
//  serverUtil.m
//  Remindy
//
//  Created by Zhixing Yang on 6/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "serverUtil.h"

@implementation serverUtil

// User creates a new event:
+ (void) user:(NSString *) matricNumber addEvent:(EventModel*) event{
    
    PFObject *newEvent = [PFObject objectWithClassName:@"EventModel"];
    
    [newEvent setObject:event.moduleCode forKey:@"moduleCode"];
    [newEvent setObject:event.deadline forKey:@"deadline"];
    [newEvent setObject:event.eventTitle forKey:@"eventTitle"];
    [newEvent setObject:event.description forKey:@"description"];
    
    [newEvent saveInBackground];
}

// User clicked "Agree" or "Disagree" button:
+ (void) user:(NSString *) matricNumber agrees: (BOOL) isAgreed EventWithID:(NSString*) eventID{
    
    PFObject *newAgreeOrDisagree = [PFObject objectWithClassName:@"event"];
    
    [newAgreeOrDisagree setObject:matricNumber forKey:@"matricNumber"];
    [newAgreeOrDisagree setObject:[NSNumber numberWithBool:isAgreed] forKey:@"isAgreed"];
    [newAgreeOrDisagree setObject:eventID forKey:@"eventID"];
   
    [newAgreeOrDisagree saveInBackground];
}

// Has the user typed "Agree" or "Disagree" button before?
// The return is YES or NO
+ (BOOL) user:(NSString *) matricNumber didAgreeEventWithID:(NSString *)eventID{
    return YES;
}
+ (BOOL) user:(NSString *) matricNumber didDisagreedEventWithID:(NSString *)eventID{
    return NO;
}

+ (NSArray*) retrieveAllEventsOfModule:(NSString *) moduleCode{
    return NULL;
}

@end
