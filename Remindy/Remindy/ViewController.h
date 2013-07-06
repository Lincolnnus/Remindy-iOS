//
//  ViewController.h
//  Remindy
//
//  Created by Shaohuan Li on 23/6/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventModel.h"
#import "serverUtil.h"

@interface ViewController : UIViewController<UIWebViewDelegate,NSURLConnectionDelegate>

@property (nonatomic) NSCache *myCache;

@property (strong, nonatomic) IBOutlet UIWebView *loginView;

-(void)checkForAccessToken:(NSString *)urlString;
-(void)getUid;
-(void)getModules;

@end
