//
//  HelloWorldLayer.m
//  App Project
//
//  Created by DUCA on 7/18/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer
	+(CCScene *) scene;
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(void)spriteMoveFinished:(id)sender {
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
}

/*
- (void)starshipsAnimate {
	[super starshipsAnimation];
	NSArray * imageArray = [[NSArray alloc] initWithObjects:
						   [UIImage imageNamed:@"starships01.png"],
						   [UIImage imageNamed:@"starships02.png"],
						   [UIImage imageNamed:@"starships03.png"],
						   [UIImage imageNamed:@"starships04.png"],
						   [UIImage imageNamed:@"starships05.png"],
						   [UIImage imageNamed:@"starships06.png"],
						   nil];
	UIImage * starshipsglow = [[UIImageView alloc] initWithFrame:
						   CGRectMake(100,125,150,130)];
	starshipsglow.animationImages = *.png in imageArray
	starshipsglow.animationDuration = 1.1;
	starshipsglow.contentMode = UIViewContentModeBottomLeft;
	[self.view addSubview:starshipsglo];
	[starshipsglow startAnimating];
}
*/
-(void)addStar {
	
	CCSprite *target2 = [CCSprite spriteWithFile:@"star.png"
										   rect:CGRectMake(0, 0, 75, 75)];
	//determine where to spawn the target along the Y axis
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	int minY = target2.contentSize.height/2;
	int maxY = winSize.height - target2.contentSize.height/2;
	int rangeY = maxY - minY; 
	int actualY = (arc4random() % rangeY) + minY;
	
	//Create the target slightly off-screen alng the right edge,
	//and along a random poition along the  axis as calculated above
	target2.position = ccp(winSize.width + (target2.contentSize.width/2), actualY);
	[self addChild:target2];
	
	//Determine speed of the target
	int minDuration = 0.0;
	int maxDuration = 2.0;
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	
	//Create the actions
	id actionMove = [CCMoveTo actionWithDuration:actualDuration
										position:ccp(-target2.contentSize.width/2, actualY)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self
											 selector:@selector(spriteMoveFinished:)];
	[target2 runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	


}
-(void)addASTERIOD {
	
	CCSprite *target = [CCSprite spriteWithFile:@"asteroid-1.png"
										   rect:CGRectMake(0, 0, 75, 75)];
	//determine where to spawn the target along the Y axis
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	int minY = target.contentSize.height/2;
	int maxY = winSize.height - target.contentSize.height/2;
	int rangeY = maxY - minY; 
	int actualY = (arc4random() % rangeY) + minY;

	//Create the target slightly off-screen alng the right edge,
	//and along a random poition along the  axis as calculated above
	target.position = ccp(winSize.width + (target.contentSize.width/2), actualY);
	[self addChild:target];
	
	//Determine speed of the target
	int minDuration = 2.0;
	int maxDuration = 3.5;
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	
	//Create the actions
	id actionMove = [CCMoveTo actionWithDuration:actualDuration
										position:ccp(-target.contentSize.width/2, actualY)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self
											 selector:@selector(spriteMoveFinished:)];
	[target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	
}
// on "init" you need to initialize your instance
-(id) init
{
	
	if( (self=[super init] )) {
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		CCSprite *player = [CCSprite spriteWithFile:@"saucer.png"
			rect:CGRectMake(0, 0, 96, 80)];
		player.position = ccp(player.contentSize.width/2, winSize.height/2);
		[self addChild:player];
		
		[self schedule:@selector(gameLogic:) interval:1.2];
	
	}
	return self;
}

-(void)gameLogic:(ccTime)dt {
	[self addASTERIOD];
	[self addStar];
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
