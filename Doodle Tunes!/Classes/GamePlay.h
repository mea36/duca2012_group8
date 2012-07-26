//
//  GamePlay.h
//  Cocos2DSimpleGame
//
//  Created by DUCA on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

/*#import <Foundation/Foundation.h>


@interface GamePlay : NSObject {

}

@end*/


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameOverScene.h"
#import <Foundation/Foundation.h>

// HelloWorld Layer
@interface GamePlayS : CCColorLayer
{
	int x, y;
	NSMutableArray *_stars;
	NSMutableArray *_targets;
	NSMutableArray *_projectiles;
	int _projectilesDestroyed;
	
	//Score
	CCLabelTTF * label;
	int starsCollected;
	
	//Infinite Scrolling
	CGSize size;
	
	CCSprite * space1;
	CCSprite * space2;
}

- (void)pauseGame;


@end

@interface GamePlay : CCScene
{
    GamePlayS *_layer;
}
@property (nonatomic, retain) GamePlayS *layer;
@end

