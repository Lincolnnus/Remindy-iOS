//
//  IVLELoginViewController.h
//  IVLELogin
//
//  Created by Yasmin Musthafa on 5/27/11.
//  Copyright 2011 NUS. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface IVLELoginViewController : UIViewController <UIWebViewDelegate>{
	
	UIWebView *webView;


}


@property (nonatomic, retain) IBOutlet UIWebView *webView;


-(void)checkForAccessToken:(NSString *)urlString;



@end

