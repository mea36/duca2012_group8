

#import "cocos2d.h"

@interface GameOverLayer : CCColorLayer {
	CCLabelTTF *_label;
}

@property (nonatomic, retain) CCLabelTTF *label;

@end

@interface GameOverScene : CCScene {
	GameOverLayer *_layer;
}

@property (nonatomic, retain) GameOverLayer *layer;

@end
