
#import "GameOverScene.h"
#import "HelloWorldScene.h"
#import "SimpleAudioEngine.h"

@implementation GameOverScene
@synthesize layer = _layer;

- (id)init {

	if ((self = [super init])) {
		self.layer = [GameOverLayer node];
		[self addChild:_layer];
	}
	return self;
}

- (void)dealloc {
	[_layer release];
	_layer = nil;
	[super dealloc];
}

@end

@implementation GameOverLayer
@synthesize label = _label;

-(id) init
{
	if( (self=[super init] )) {
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gameoverfx.caf"];
		CCSprite * bg1 = [CCSprite spriteWithFile:@"gameoversmack.png"]; //Background of the Game
		bg1.position = ccp(240, 160); //Position
		[self addChild:bg1]; //Add BG
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		self.label = [CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:32];
		_label.color = ccc3(0,0,0);
		_label.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:_label];
		
		
		[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:5],[CCCallFunc actionWithTarget:self selector:@selector(gameOverDone)], nil]];
		
	}	
	return self;
}

- (void)gameOverDone {

	[[CCDirector sharedDirector] replaceScene:[[[HelloWorldScene alloc] init] autorelease]];
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];	
}

- (void)dealloc {
	[_label release];
	_label = nil;
	[super dealloc];
}

@end
