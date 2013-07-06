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
+ (void)             user:(NSString *) matricNumber addEvent:(EventModel*) event{
    
}

// User clicked "Agree" or "Disagree" button:
+ (void) user:(NSString *) matricNumber agreesEventWithID:(NSString*) eventID{
    
}
+ (void) user:(NSString *) matricNumber disagreesEventWithID:(NSString *)eventID{
    
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

+ (void) testServerUtil{
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
}

@end
