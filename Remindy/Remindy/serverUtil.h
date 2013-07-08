//
//  serverUtil.h
//  Remindy
//
//  Created by Zhixing Yang on 6/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "constants.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "EventModel.h"

@interface serverUtil : NSObject

// User creates a new event:
+ (void) user:(NSString *)matricNumber addEvent:(EventModel*)event;

// User clicked "Agree" or "Disagree" button:
+ (void) user:(NSString *)matricNumber agrees: (BOOL)isAgreed EventWithID:(NSString*)eventID;

// Has the user typed "Agree" or "Disagree" button before?
// The return is YES or NO
+ (void) user:(NSString *)matricNumber isAgreeWithEventWithID:(NSString *)eventID;

+ (void) retrieveAllEventsOfModule:(NSString *) moduleCode withViewer:(NSString*) matricNumber;

+ (void) getNumOfAgreesAndDisagreesOfEvent: (NSString *) eventID;

+ (void) user: (NSString*)matricNumber cancelAgreeOrDisagreeOfEvent: (NSString*)eventID;

@end
