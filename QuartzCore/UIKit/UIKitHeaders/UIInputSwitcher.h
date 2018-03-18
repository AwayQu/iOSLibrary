//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSString, UIDelayedAction, UIInputSwitcherView;

__attribute__((visibility("hidden")))
@interface UIInputSwitcher : NSObject
{
    UIDelayedAction *m_keyHoldDelay;
    UIDelayedAction *m_showSwitcherDelay;
    UIDelayedAction *m_hideSwitcherDelay;
    int m_state;
    UIInputSwitcherView *m_switcherView;
    double m_lastGlobeKeyUpTime;
    NSString *_newMode;
    _Bool _isGlobeKeyDown;
    NSString *_loadedIdentifier;
}

+ (id)activeInstance;
+ (id)sharedInstance;
@property(nonatomic) _Bool isGlobeKeyDown; // @synthesize isGlobeKeyDown=_isGlobeKeyDown;
@property(copy, nonatomic) NSString *loadedIdentifier; // @synthesize loadedIdentifier=_loadedIdentifier;
- (_Bool)handleModifiersChangedEvent:(id)arg1;
- (_Bool)handleSwitchingKeyEvent:(id)arg1;
- (void)updateHardwareLayout;
- (_Bool)switchMode:(id)arg1 withHUD:(_Bool)arg2 withDelay:(_Bool)arg3;
- (_Bool)handleSwitchCommand:(_Bool)arg1 withHUD:(_Bool)arg2 withDelay:(_Bool)arg3;
- (_Bool)handleSwitchCommand:(_Bool)arg1;
- (id)inputModeIdentifierWithNextFlag:(_Bool)arg1;
- (_Bool)isVisibleOrHiding;
- (_Bool)isVisible;
- (void)clearKeyHoldTimer;
- (void)touchKeyHoldTimer;
- (void)clearShowSwitcherTimer;
- (void)cancelShowSwitcherTimer;
- (void)touchShowSwitcherTimer;
- (void)showSwitcherWithoutAutoHide;
- (void)showSwitcherWithAutoHide;
- (void)showSwitcherShouldAutoHide:(_Bool)arg1;
- (void)_showSwitcherViewAsHUD;
- (void)clearHideSwitcherTimer;
- (void)touchHideSwitcherTimer;
- (void)hideSwitcher;
- (void)handleRotate:(id)arg1;
- (void)dealloc;
- (id)init;

@end

