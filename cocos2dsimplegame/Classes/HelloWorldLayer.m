//
//  HelloWorldLayer.m
//  cocos2dsimplegame
//
//  Created by DUCA on 7/13/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer
NSMutableArray *_targets;

+(CCScene *) scene
{
	NSLog(@"i'm at the beginning of scene in helloworldlayer");
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	NSLog(@"i'm at the beginning of layer in helloworldlayer");
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	NSLog(@"i'm at the end of layer in helloworld");
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(void)spriteMoveFinished:(id)sender {
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
	if (sprite.tag == 1) {
		[_targets removeObject:sprite];
		NSLog(@"i'm at the end of scene in helloworldlayer");

	}
}


-(void)addTarget{
	NSLog(@"i'm that the beginning of target in helloworldlayer");
	CCSprite *target = [CCSprite spriteWithFile:@"asteriod-2.png"rect:CGRectMake(0, 0, 40, 40)]; 
	NSLog(@"i'm at the beginning of target spawn in helloworldlayer");
	// Determine where to spawn the target along the Y axis
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	int minY = target.contentSize.height/2;
	int maxY = winSize.height - target.contentSize.height/2;
	int rangeY = maxY - minY;
	int actualY = (arc4random() % rangeY) + minY;
	target.tag = 1;
	[_targets addObject:target];
	NSLog(@"i'm at the end of target spawn in helloworldlayer");
	NSLog(@"i'm at the beginning of target creation in helloworldlayer");
	// Create the target slightly off-screen along the right edge,
	// and along a random position along the Y axis as calculated above
	target.position = ccp(winSize.width + (target.contentSize.width/2), actualY);
	[selfil addChild:target];
	NSLog(@"i'm at the end of target creation in helloworldlayer");
	NSLog(@"i'm at the beginning of speed in helloworldlayer");
	// Determine speed of the target
	int minDuration = 4.0;
	int maxDuration = 6.0;
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	NSLog(@"i'm at the end of speed in helloworldlayer");
	NSLog(@"i'm at the beginning of actions in helloworldlayer");
	// Create the actions
	id actionMove = [CCMoveTo actionWithDuration:actualDuration 
										position:ccp(-target.contentSize.width/2, actualY)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self 
											 selector:@selector(spriteMoveFinished:)];
	[target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	NSLog(@"i'm at the end of actions in helloworldlayer");
	NSLog(@"i'm at the end of target in helloworldlayer");
}

-(void)gameLogic:(ccTime)dt {
	
	[self addTarget];

}
// on "init" you need to initialize your instance
-(id) init
{
	NSLog(@"i'm at the beginning of init in helloworldlayer");
	[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"random.aif"];
	[self schedule:@selector(gameLogic:) interval:2.0];

	
	CCSprite* background = [CCSprite spriteWithFile:@"background1.png"];
	background.tag = 1;
	background.anchorPoint = CGPointMake(0,0);
	[self addChild:background];
	_targets = [[NSMutableArray alloc] init];

	//	if( (self=[super initWithColor:ccc4(0,0,0,0)] )) {
	if( (self=[super init] )) {
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		CCSprite *player = [CCSprite spriteWithFile:@"cursorsmall.png" 
			rect:CGRectMake(0, 0, 40, 40)];
		player.position = ccp(player.contentSize.width/2, winSize.height/2);
		[self addChild:player];
		
		[self schedule:@selector(update:)];
		NSLog(@"i'm at the beginning of init in helloworldlayer");
		
	}

	return self;
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_targets release];
	_targets = nil;
	// don't forget to call "super dealloc"
	[super dealloc];
}
	
@end
