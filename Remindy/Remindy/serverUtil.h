//
//  serverUtil.h
//  Remindy
//
//  Created by Zhixing Yang on 6/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"
#import <Parse/Parse.h>

@interface serverUtil : NSObject

// User creates a new event:
+ (void)             user:(NSString *) matricNumber addEvent:(EventModel*) event;

// User clicked "Agree" or "Disagree" button:
+ (void) user:(NSString *) matricNumber agrees: (BOOL) isAgreed EventWithID:(NSString*) eventID;

// Has the user typed "Agree" or "Disagree" button before?
// The return is YES or NO
+ (BOOL) user:(NSString *) matricNumber didAgreeEventWithID:(NSString *)eventID;
+ (BOOL) user:(NSString *) matricNumber didDisagreedEventWithID:(NSString *)eventID;

+ (NSArray*) retrieveAllEventsOfModule:(NSString *) moduleCode;

@end
