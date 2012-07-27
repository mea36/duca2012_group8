// Import the interfaces
#import "HelloWorldScene.h"
#import "SimpleAudioEngine.h"
#import "GameOverScene.h"
#import "GamePlay.h"

enum  {
	kTagBall, //Player
	kTagEnemy, //Asteroids
	kTagStars //Stars
};

//Implementation of GamePlay
@implementation GamePlay
@synthesize layer = _layer;

- (id)init {
	
    if ((self = [super init])) {
        self.layer = [GamePlayS node];
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
@implementation GamePlayS

-(void)spriteMoveFinished:(id)sender {
	
	CCSprite *sprite = (CCSprite *)sender;
	[self removeChild:sprite cleanup:YES];
	
	//if (sprite.tag == 1) { // target
	//[_targets removeObject:sprite];
	
	//GameOverScene * gameOverScene = [GameOverScene node];
	//[gameOverScene.layer.label setString:@""];
	//[[CCDirector sharedDirector] replaceScene:gameOverScene];
	
	//CCSprite * bg = [CCSprite spriteWithFile:@"background3.png"]; //Background of the Game
	//bg.position = ccp(240, 160); //Position
	//[self addChild:bg]; //Add BG

	//} else if (sprite.tag == 2) { // projectile
	//	[_projectiles removeObject:sprite];
	//}
	
}

//Add Asteroids
-(void)addTarget {
	
	CCSprite *target = [CCSprite spriteWithFile:@"asteroid1.png" rect:CGRectMake(0, 0, 60, 60)]; 
	//target.tag = kTagEnemy;
	
	// Determine where to spawn the target along the Y axis
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	int minY = target.contentSize.height/2;
	int maxY = winSize.height - target.contentSize.height/2;
	int rangeY = maxY - minY;
	int actualY = (arc4random() % rangeY) + minY;
	
	// Create the target slightly off-screen along the right edge,
	// and along a random position along the Y axis as calculated above
	target.position = ccp(winSize.width + (target.contentSize.width/2), actualY);
	[self addChild:target];
	
	// speed of the target
	int minDuration = 1.0;
	int maxDuration = 2.0;
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	
	// Create the actions
	id actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(-target.contentSize.width/2, actualY)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
	[target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	//Add to targets array
	target.tag = 1;
	[_targets addObject:target];
	
}

//Add Stars
-(void)addStars {
	
	CCSprite *stars = [CCSprite spriteWithFile:@"star.png" rect:CGRectMake(0, 0, 40, 40)]; //Get Stars and Size of the Stars
	stars.tag = kTagStars;
	
	// Determine where to spawn the target along the Y axis
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	int minY = stars.contentSize.height/2;
	int maxY = winSize.height - stars.contentSize.height/2;
	int rangeY = maxY - minY;
	int actualY = (arc4random() % rangeY) + minY;
	
	// Create the target slightly off-screen along the right edge,
	// and along a random position along the Y axis as calculated above
	stars.position = ccp(winSize.width + (stars.contentSize.width/2), actualY);
	[self addChild:stars];
	
	// Speed of the Stars
	int minDuration = 1.0;
	int maxDuration = 2.0;
	int rangeDuration = maxDuration - minDuration;
	int actualDuration = (arc4random() % rangeDuration) + minDuration;
	
	// Create the actions
	id actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(-stars.contentSize.width/2, actualY)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)];
	[stars runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
	
	// Add to Stars array
	[_stars addObject:stars];
	
	//NSLog(@"Added more stars %f %f", stars.position.x, stars.position.y);
	//NSLog(@"_stars has %f elements", [_stars count]);
	//NSLog(@"_target has %f elements", [_targets count]);

}

//AddAsteriods
-(void)gameLogic:(ccTime)dt {
	
	[self addTarget];
	
} 

//AddStars
-(void)gameLogic1:(ccTime)dt {
	
	[self addStars];
	
} //AddStars

// on "init" you need to initialize your instance
-(id) init
{
	//Super Init
	if( (self=[super init] )) {
		size = [[CCDirector sharedDirector] winSize];
		// Enable touch events
		self.isTouchEnabled = YES;
		
		// Initialize arrays
		_stars = [[NSMutableArray alloc] init];
		_targets = [[NSMutableArray alloc] init];
		_projectiles = [[NSMutableArray alloc] init];
		
		//Another Try of Scrolling
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            space1 = [CCSprite spriteWithFile:@"ipad.png"];
        else
            space1 = [CCSprite spriteWithFile:@"WAYBETTERbg1.png"];


		[space1 setPosition:ccp(size.width / 2, 160)];
		[space1.textureAtlas.texture setAntiAliasTexParameters];
		[self addChild:space1];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            space2 = [CCSprite spriteWithFile:@"ipad.png"];
        else
            space2 = [CCSprite spriteWithFile:@"WAYBETTERbg1.png"];

		[space2 setPosition:ccp(size.width + 240, 160)];
		[space2.textureAtlas.texture setAntiAliasTexParameters];
		[self addChild:space2];
		
		// Get the dimensions of the window for calculation purposes
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		//Main Player
		CCSprite *player = [CCSprite spriteWithFile:@"saucer.png" rect:CGRectMake(0, 0, 100, 65)];
		player.position = ccp(player.contentSize.width/2, winSize.height/2);
		[self addChild:player z:1 tag:kTagBall];
		
		//Score
		starsCollected = 0;
		label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %d", starsCollected] fontName:@"Trebuchet MS" fontSize:24];
		starsCollected++;
		//label.color = ccc3(225, 215, 0);
		label.position = ccp(410,290);
		[self addChild:label];
		
		// Call game logic about every second
		[self schedule:@selector(gameLogic:) interval:1.0];
		[self schedule:@selector(move) interval:.01];
		[self schedule:@selector(gameLogic1:) interval:4.0];
		[self schedule:@selector(scroll:) interval:0.001];
		[self schedule:@selector(move1) interval:.01];
		
		// Start up the background music
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Progessive House Tune.caf"]; //background-music-aac.caf
		
		//Collision Detection Variable
		x = 5;
		y = 5;
	}
	return self;
}

//Collect Stars!
-(void)move1{
	[label setString:[NSString stringWithFormat:@"Score: %d", starsCollected]];
	
	CCNode * stars = [self getChildByTag:kTagStars]; //Get Stars
	if(stars)
	{
	CCNode * player = [self getChildByTag:kTagBall]; //Get Main Player

	
	if (stars.position.x > 480 || stars.position.x < 0) {
		x =-x;
	}
	if (stars.position.y > 320 || stars.position.y < 0) {
		y =-y;
	}
	
	
	//Collision Detection
	float xDif = stars.position.x - player.position.x;
	float yDif = stars.position.y - player.position.y;
	float distance = sqrtf(xDif * xDif + yDif * yDif);
	NSLog(@"x %f y %f dist %f", xDif, yDif, distance);
	
	if(distance < 20) {
		
		//NSLog(@"Adding Points stars x %f y %f", stars.position.x, stars.position.y);
		//NSLog(@"saucer x %f, y %f", player.position.x, player.position.y);
		starsCollected += 100;
		[_stars removeObject:stars];
		[self removeChild:stars cleanup:YES];
		
		[[SimpleAudioEngine sharedEngine] playEffect:@"starpickup.caf"];
	}	
	}
}

//Infinte Scrolling Background
-(void) scroll:(ccTime)dt{
	
	space1.position = ccp( space1.position.x - 1, 160);
	space2.position = ccp( space2.position.x - 1, 160);
	
	//reset it's position if needed
	if (space1.position.x < -240)
	{
		NSLog(@"Reset 1");
		[space1 setPosition:ccp(space2.position.x + size.width -1, 160)];
	}
	if (space2.position.x < -240)
	{
		NSLog(@"Reset 2");
		[space2 setPosition:ccp(space1.position.x + size.width -1, 160)];
	}
}

//Attack by ASTEROIDS! 
-(void) move{
	CCNode * target = [self getChildByTag:kTagEnemy]; //Get Asteroids
	CCNode * player = [self getChildByTag:kTagBall]; //Get Main Player
	
	if (target.position.x < 480 || target.position.x < 0) {
		x =-x;
	}
	if (target.position.y < 320 || target.position.y < 0) {
		y =-y;
	}
	
	//Collision Detection
	float xDif = target.position.x - player.position.x;
	float yDif = target.position.y - player.position.y;
	float distance = sqrtf(xDif * xDif + yDif * yDif);
	
	//Radius of the Player and Asteroids. PlayerRadius + AsteroidsRadius = TotalRadius
	if(distance < 45) {
		//Once Hit, Stop Spawning Asteroids and Stars.
		[[SimpleAudioEngine sharedEngine] playEffect:@"ShipHitByAsteroids.caf"];
		[self unschedule:@selector(move)];
		[self unschedule:@selector(gameLogic:)];
		[self unschedule:@selector(gameLogic1:)];
		
		[[SimpleAudioEngine sharedEngine] stopBackgroundMusic]; //Stops the MUSIC!
		
		[[CCDirector sharedDirector]replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameOverScene node]]];
	}

}

//Alert View
-(void) alertView:(UIAlertView *) alert clickButtonAtIndex:(NSUInteger) buttonIndex{
	if(buttonIndex == 0){
		[[CCDirector sharedDirector] replaceScene:[CCTransitionZoomFlipY transitionWithDuration:1 scene:[GameOverScene node]]];
		//Alert Button
		//Tranitions = CCTransitionZoomFlipAngular
	}
}

//To Paused the Game
- (void)pauseGame {
 NSLog(@"Paused!");
 }

//Began to Touch
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	return;
}

//Move the Player
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *) event{
	UITouch * myTouch = [touches anyObject]; //Able to Touch the Object
	CGPoint point = [myTouch locationInView :[myTouch view]];
	point = [[CCDirector sharedDirector] convertToGL:point];
	
	CCNode * sprite = [self getChildByTag:kTagBall]; //Move
	[sprite setPosition:point]; //Position Set after Moved.
	return;
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	//Release the Targets and the Stars
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
