// Import the interfaces
#import "HelloWorldScene.h"
#import "SimpleAudioEngine.h"
#import "GameOverScene.h"
#import "GamePlay.h"


enum  {
	kTagBall,
	kTagEnemy
};

@implementation HelloWorldScene
@synthesize layer = _layer;

- (id)init {

    if ((self = [super init])) {
        self.layer = [HelloWorld node];
        [self addChild:_layer];
    }
	
	return self;
}

- (void)dealloc {
    self.layer = nil;
    [super dealloc];
}

@end


// HelloWorld implementation
@implementation HelloWorld
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		CCSprite * bg = [CCSprite spriteWithFile:@"alienopenscreen.png"]; //Background for Main
		bg.position = ccp(240, 170); //Position of the Background
		[self addChild:bg]; //Add the Background
		
		[CCMenuItemFont setFontName:@"Trebuchet MS"]; //Type of Font + Aimation
		[CCMenuItemFont setFontSize:20]; //Font Size
		CCMenuItem * item1 = [CCMenuItemFont itemFromString:@"START" target:self selector:@selector(start:)]; //Text on Screen
		item1.position = ccp(0,-35);
		CCMenu * menu = [CCMenu menuWithItems:item1, nil]; //Created new Menu
		[self addChild:menu]; // Created new Menu
		
		/*[CCMenuItemFont setFontName:@"Trebuchet MS"]; //Type of Font + Aimation
		[CCMenuItemFont setFontSize:20]; //Font Size
		CCMenuItem * item2 = [CCMenuItemFont itemFromString:@"OPTIONS" target:self selector:@selector(start1:)]; //Text on Screen
		item2.position = ccp(0,-65);
		CCMenu * menu1 = [CCMenu menuWithItems:item2, nil]; //Created new Menu
		[self addChild:menu1]; // Created new Menu*/
		
		//[[SimpleAudioEngine sharedEngine] playEffect:@"mainmenuhouse.caf"];
	}
	sleep(3);
	return self;
}
-(void) start: (id) sender{ //New Method Class
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:1.0 scene:[GamePlay node]]];
	//[[SimpleAudioEngine sharedEngine] stopBackg
	//[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	//Send to GamePlay
}
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	
	return;
}
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *) event{
	UITouch * myTouch = [touches anyObject];
	CGPoint point = [myTouch locationInView :[myTouch view]];
	point = [[CCDirector sharedDirector] convertToGL:point];
	
	CCNode * sprite = [self getChildByTag:kTagBall];
	[sprite setPosition:point];
	return;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[_targets release];
	_targets = nil;
	
	[_stars release];
	_stars = nil;
	//[_projectiles release];
	//_projectiles = nil;
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
