

#ifndef __GAME_CONFIG_H
#define __GAME_CONFIG_H

//
// Supported Autorotations:
//		None,
//		UIViewController,
//		CCDirector
//
#define kGameAutorotationNone 0
#define kGameAutorotationCCDirector 1
#define kGameAutorotationUIViewController 2

#ifndef CC_FIX_ARTIFACTS_BY_STRECHING_TEXEL
#define CC_FIX_ARTIFACTS_BY_STRECHING_TEXEL 1
#endif
//
// Define here the type of autorotation that you want for your game
//
#define GAME_AUTOROTATION kGameAutorotationUIViewController


#endif // __GAME_CONFIG_H