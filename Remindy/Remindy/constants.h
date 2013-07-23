//
//  constants.h
//  Remindy
//
//  Created by Zhixing Yang on 8/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kAGREED,
    kDISAGREED,
    kUNKNOWN // The user hasn't made the decision yet.
} AgreeType;

@interface constants : NSObject

extern NSString *NOTIF_AGREE_OR_DISAGREE;
extern NSString *NOTIF_EVENT_OF_MODULE_RETRIEVED;
extern NSString *NOTIF_NUM_AGREE_DISAGREE_RETRIEVED;

@end
