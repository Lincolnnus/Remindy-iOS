//
//  EventModel.h
//  Remindy
//
//  Created by Shaohuan Li on 24/6/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventModel : NSObject

@property (nonatomic) NSString *moduleCode;
@property (nonatomic) NSString *eventTitle;
@property (nonatomic) NSString *description;
@property (nonatomic) NSDate *deadline;

// The following is not compulsory
@property (nonatomic) NSString *eventID;
@property (nonatomic) int numOfAgrees;
@property (nonatomic) int numOfDisagrees;


-(id) initWithModuleCode: (NSString *) mc
           andEventTitle: (NSString *) et
          andDescription: (NSString *) desc
             andDeadline: (NSDate *) dead;

-(void) setEventID:(NSString*)eID;
@end
