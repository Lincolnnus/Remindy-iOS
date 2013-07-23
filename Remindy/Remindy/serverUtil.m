//
//  serverUtil.m
//  Remindy
//
//  Created by Zhixing Yang on 6/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "serverUtil.h"
#import "constants.h"

@implementation serverUtil

// User creates a new event:
+ (void) user:(NSString *) matricNumber addEvent:(EventModel*) event{
    
    PFObject *newEvent = [PFObject objectWithClassName:@"event"];
    
    [newEvent setObject:event.moduleCode forKey:@"moduleCode"];
    [newEvent setObject:event.deadline forKey:@"deadline"];
    [newEvent setObject:event.eventTitle forKey:@"eventTitle"];
    [newEvent setObject:event.description forKey:@"description"];
    
    [newEvent saveInBackground];
}

// User clicked "Agree" or "Disagree" button:
+ (void) user:(NSString *)matricNumber agrees: (BOOL)isAgreed EventWithID:(NSString*)eventID completeHandler:(NetworkCompleteHandler)completeHandler {
    
    [serverUtil user:matricNumber cancelAgreeOrDisagreeOfEvent:eventID completeHandler:completeHandler];
    NSLog(@"In server util, the user %@ agrees: %d with event: %@", matricNumber, isAgreed, eventID);
    PFObject *newAgreeOrDisagree = [PFObject objectWithClassName:@"agreeAndDisagree"];
    [newAgreeOrDisagree setObject:matricNumber forKey:@"matricNumber"];
    [newAgreeOrDisagree setObject:[NSNumber numberWithBool:isAgreed] forKey:@"isAgreed"];
    [newAgreeOrDisagree setObject:eventID forKey:@"eventID"];
    [newAgreeOrDisagree saveInBackground];
}

// Has the user typed "Agree" or "Disagree" button before?
// The return is YES or NO

/* The way to do it Register for the notification center:
 
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivesAgreementNotification:) name:NOTIF_AGREE_OR_DISAGREE object:nil];
 
 - (void) receivesAgreementNotification:(NSNotification *) notification
 
 NSDictionary *userInfo = notification.userInfo;
 MyObject *myObject = [userInfo objectForKey:@"eventID"];
 }
 
 *
*/

+ (void) user:(NSString *) matricNumber isAgreeWithEventWithID:(NSString *)eventID completeHandler:(NetworkCompleteHandler)completeHandler{
    
    PFQuery *query = [PFQuery queryWithClassName:@"agreeAndDisagree"];
    
    [query whereKey:@"matricNumber" equalTo:matricNumber];
    [query whereKey:@"eventID" equalTo: eventID];
        
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            // The find succeeded.
            
            // Create a dictionary to be passed around:
            if (objects.count > 1){
                NSLog(@"More than one item per user in agreeAndDisagree");
            }
            
            else if (objects.count == 0){
                // The user doesn't specify "Agree" or "Disagree" yet.
                // Later, retrieve this way: AgreeType agree = [[list objectAtIndex:0] intValue];
                completeHandler ([NSNumber numberWithInt:kUNKNOWN],nil);
            }
            
            else {
                PFObject *object = objects[0];
                if ([object objectForKey:@"isAgreed"] == [NSNumber numberWithBool:YES]){
                    completeHandler([NSNumber numberWithInt:kAGREED],nil);
                } else if ([object objectForKey:@"isAgreed"] == [NSNumber numberWithBool:NO]){
                    completeHandler([NSNumber numberWithInt:kDISAGREED],nil);
                } else {
                    NSLog(@"Unknown type of isAgreed field");
                }
            }
            
        } else {
            // Log details of the failure
            completeHandler(nil,error);
        }
    }];
}

+ (void) retrieveAllEventsOfModule:(NSString *) moduleCode withViewer:(NSString*) matricNumber completeHandler:(NetworkCompleteHandler)completeHandler {
    PFQuery *query = [PFQuery queryWithClassName:@"event"];
    [query whereKey:@"moduleCode" equalTo:moduleCode];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            NSMutableArray *eventList = [[NSMutableArray alloc]init];
            for (PFObject *object in objects) {
                EventModel *newEvent = [[EventModel alloc] initWithModuleCode:moduleCode
                                                                andEventTitle:[object objectForKey:@"eventTitle"]
                                                               andDescription:[object objectForKey:@"description"]
                                                                  andDeadline:[object objectForKey:@"deadline"]];
                newEvent.eventID = object.objectId;
                
                // Get Number of agrees:
                PFQuery *query = [PFQuery queryWithClassName:@"agreeAndDisagree"];
                [query whereKey:@"isAgreed" equalTo:[NSNumber numberWithBool:YES]];
                [query whereKey:@"eventID" equalTo:newEvent.eventID];
                
                [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
                    newEvent.numOfAgrees = number;
                    PFQuery *query = [PFQuery queryWithClassName:@"agreeAndDisagree"];
                    [query whereKey:@"isAgreed" equalTo:[NSNumber numberWithBool:NO]];
                    [query whereKey:@"eventID" equalTo:newEvent.eventID];
                    
                    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
                        newEvent.numOfDisagrees = number;
                        // Check whether the viewer agrees or disagrees with this event:
                        PFQuery *query = [PFQuery queryWithClassName:@"agreeAndDisagree"];
                        
                        [query whereKey:@"matricNumber" equalTo:matricNumber];
                        [query whereKey:@"eventID" equalTo: newEvent.eventID];
                        
                        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                            NSLog(@"object coutn: %d", objects.count);
                            
                            if (objects.count > 1){
                                NSLog(@"More than one item per user in agreeAndDisagree");
                            }
                            
                            else if (objects.count == 0){
                                // The user doesn't specify "Agree" or "Disagree" yet.
                                newEvent.isCurrentViewerAgrees = kUNKNOWN;
                                NSLog(@"In server util, the user %@ unknowns the event %@", matricNumber, newEvent.eventID);
                            }
                            
                            else {
                                PFObject *object = objects[0];
                                if ([object objectForKey:@"isAgreed"] == [NSNumber numberWithBool:YES]){
                                    NSLog(@"In server util, the user %@ agrees the event %@", matricNumber, newEvent.eventID);
                                    
                                    newEvent.isCurrentViewerAgrees = kAGREED;
                                    
                                } else if ([object objectForKey:@"isAgreed"] == [NSNumber numberWithBool:NO]){
                                    NSLog(@"In server util, the user %@ disagrees the event %@", matricNumber, newEvent.eventID);
                                    
                                    newEvent.isCurrentViewerAgrees = kDISAGREED;
                                    
                                } else {
                                    NSLog(@"Unknown type of isAgreed field");
                                }
                            }
                            newEvent.agreement = object;
                            [eventList addObject:newEvent];
                            completeHandler(eventList,nil);
                        }];
                    }];
                    
                   
                }];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completeHandler(nil,error);
        }
    }];
}
/*
+ (void) getNumOfAgreesAndDisagreesOfEvent: (NSString *) eventID completeHandler:(NetworkCompleteHandler)completeHandler{
    
    PFQuery *query = [PFQuery queryWithClassName:@"agreeAndDisagree"];
    [query whereKey:@"isAgreed" equalTo:[NSNumber numberWithBool:YES]];
    [query whereKey:@"eventID" equalTo:eventID];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            NSLog(@"In server Util: The event of ID %@ has %d agrees", eventID, count);
            
            // Create a dictionary to be passed around:
            NSArray *values = [[NSArray alloc] initWithObjects: eventID, [NSNumber numberWithInt:count], nil];
            NSArray *keys = [[NSArray alloc] initWithObjects:@"eventID", @"agreeCount", nil];
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithObjects:values forKeys:keys];
            PFQuery *query = [PFQuery queryWithClassName:@"agreeAndDisagree"];
            [query whereKey:@"isAgreed" equalTo:[NSNumber numberWithBool:NO]];
            [query whereKey:@"eventID" equalTo:eventID];
            
            [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
                if (!error) {
                    // The count request succeeded. Log the count
                    NSLog(@"In server util: The event of ID %@ has %d disagrees", eventID, count);
                    
                    [userInfo setObject: [NSNumber numberWithInt: count] forKey:@"disagreeCount"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_NUM_AGREE_DISAGREE_RETRIEVED object:nil userInfo:userInfo];
                } else {
                    NSLog(@"Query of counting disagrees failed");
                }
            }];
            
        } else {
            NSLog(@"Query of counting agrees failed");
        }
    }];
}

+ (void) addNumOfDisagreesOfEvent: (NSString *) eventID toDictionary: (NSMutableDictionary *) userInfo{
   
}


+ (void) getNumOfAgreesAndDisagreesOfEvent: (NSString *) eventID{
    
    PFQuery *query = [PFQuery queryWithClassName:@"agreeAndDisagree"];
    [query whereKey:@"isAgreed" equalTo:[NSNumber numberWithBool:YES]];
    [query whereKey:@"eventID" equalTo:eventID];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            NSLog(@"In server Util: The event of ID %@ has %d agrees", eventID, count);
            
            // Create a dictionary to be passed around:
            NSArray *values = [[NSArray alloc] initWithObjects: eventID, [NSNumber numberWithInt:count], nil];
            NSArray *keys = [[NSArray alloc] initWithObjects:@"eventID", @"agreeCount", nil];
            NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithObjects:values forKeys:keys];
            
            [self addNumOfDisagreesOfEvent: eventID toDictionary:userInfo];
            
        } else {
            NSLog(@"Query of counting agrees failed");
        }
    }];
}

*/

+ (void) user: (NSString*)matricNumber cancelAgreeOrDisagreeOfEvent: (NSString*)eventID completeHandler:(NetworkCompleteHandler)completeHandler {
    PFQuery *query = [PFQuery queryWithClassName:@"agreeAndDisagree"];
    [query whereKey:@"matricNumber" equalTo:matricNumber];
    [query whereKey:@"eventID" equalTo:eventID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (PFObject *object in objects) {
            [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error) {
                    completeHandler(nil,error);
                }
            }];
        }

    }];
}

@end
