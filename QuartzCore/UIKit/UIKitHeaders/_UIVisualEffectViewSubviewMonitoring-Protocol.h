//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class UIView, UIWindow;

@protocol _UIVisualEffectViewSubviewMonitoring <NSObject>
- (void)_view:(UIView *)arg1 willLoseDescendent:(UIView *)arg2;
- (void)_view:(UIView *)arg1 willGainDescendent:(UIView *)arg2;
- (void)_view:(UIView *)arg1 willMoveToWindow:(UIWindow *)arg2;
@end
