//
//  serverUtil.m
//  Remindy
//
//  Created by Zhixing Yang on 6/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "serverUtil.h"

#define NOTIF_AGREED @"NOTIF_AGREED"
#define NOTIF_DISAGREED @"NOTIF_DISAGREED"
#define NOTIF_UNKNOWN @"NOTIF_UNKNOWN"

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

/* TODO Register for the notification center:
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(user:AgreedWithEventID:) name:NOTIF_AGREED object:nil];
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(user:DisagreedWithEventID:) name:NOTIF_DISAGREED object:nil];
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(user:UnknownWithEventID:) name:NOTIF_UNKNOWN object:nil];

 *
*/
+ (void) user:(NSString *) matricNumber isAgreeWithEventWithID:(NSString *)eventID{
    
    PFQuery *query = [PFQuery queryWithClassName:@"agreeAndDisagree"];
    
    [query whereKey:@"matricNumber" equalTo:matricNumber];
    [query whereKey:@"eventID" equalTo: eventID];
        
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            if (objects.count > 1){
                NSLog(@"More than one item per user in agreeAndDisagree");
            }
            
            else if (objects.count == 0){
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_UNKNOWN object:eventID];
            }
            
            else {
                PFObject *object = objects[0];
                if ([object objectForKey:@"isAgreed"] == [NSNumber numberWithBool:YES]){
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_AGREED object:eventID];
                } else if ([object objectForKey:@"isAgreed"] == [NSNumber numberWithBool:NO]){
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_DISAGREED object:eventID];
                } else {
                    NSLog(@"Unknown type of isAgreed field");
                }
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


+ (NSArray*) retrieveAllEventsOfModule:(NSString *) moduleCode{
    
    return NULL;
}

+ (int) getNumOfAgreesOfEvent: (NSString *) eventID{
    
    return 0;
}

+ (int) getNumOfDisagreesOfEvent: (NSString *) eventID{
    
    return 0;
}

@end
