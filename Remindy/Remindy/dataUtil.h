//
//  dataUtil.h
//  Remindy
//
//  Created by Shaohuan Li on 23/7/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataUtil : NSObject
@property (nonatomic,strong) NSString* uid;
@property (nonatomic,strong) NSString* token;
@property (nonatomic,strong) NSString* moduleCode;
@property (nonatomic,strong) NSArray* modules;
+ (dataUtil*) sharedInstance;
- (BOOL)isLoggedIn;
- (void) logout;
@end
