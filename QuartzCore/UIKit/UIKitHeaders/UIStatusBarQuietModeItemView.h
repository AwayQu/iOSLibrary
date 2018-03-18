//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIStatusBarIndicatorItemView.h>

#import "CAAnimationDelegate.h"

@class NSString;

__attribute__((visibility("hidden")))
@interface UIStatusBarQuietModeItemView : UIStatusBarIndicatorItemView <CAAnimationDelegate>
{
    _Bool _hideForAction;
    _Bool _registeredForNotifications;
    _Bool _inactive;
}

- (id)accessibilityHUDRepresentation;
- (void)setVisible:(_Bool)arg1;
- (double)_visibleAlpha;
- (void)setVisible:(_Bool)arg1 frame:(struct CGRect)arg2 duration:(double)arg3;
- (void)_triggerAction:(id)arg1;
- (void)animationDidStop:(id)arg1 finished:(_Bool)arg2;
- (_Bool)updateForNewData:(id)arg1 actions:(int)arg2;
- (void)dealloc;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

