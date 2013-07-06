//
//  serverUtil.h
//  Remindy
//
//  Created by Zhixing Yang on 6/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface serverUtil : NSObject

// User creates a new event:
+ (void)             user:(NSString *) matricNumber
        addEventForModule:(NSString*) moduleCode
                withTitle:(NSString*) title
          withDescription:(NSString*) description
             withDeadline:(NSDate*) deadline;

// User clicked "Agree" or "Disagree" button:
+ (void) user:(NSString *) matricNumber agreesEventWithID:(NSString*) eventID;
+ (void) user:(NSString *)matricNumber disagreesEventWithID:(NSString *)eventID;

// Has the user typed "Agree" or "Disagree" button before?
// The return is YES or NO
+ (BOOL) user:(NSString *)matricNumber didAgreeEventWithID:(NSString *)eventID;
+ (BOOL) user:(NSString *)matricNumber didDisagreedEventWithID:(NSString *)eventID;

@end
