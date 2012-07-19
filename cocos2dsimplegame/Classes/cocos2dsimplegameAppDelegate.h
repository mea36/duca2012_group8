//
//  cocos2dsimplegameAppDelegate.h
//  cocos2dsimplegame
//
//  Created by DUCA on 7/13/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface cocos2dsimplegameAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
