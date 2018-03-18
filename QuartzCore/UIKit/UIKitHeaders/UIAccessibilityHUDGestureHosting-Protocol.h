//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

@class UIAccessibilityHUDGestureManager, UIAccessibilityHUDItem, UIGestureRecognizer;

@protocol UIAccessibilityHUDGestureHosting
- (_Bool)_accessibilityHUDGestureManager:(UIAccessibilityHUDGestureManager *)arg1 shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)arg2;
- (void)_accessibilityHUDGestureManager:(UIAccessibilityHUDGestureManager *)arg1 gestureLiftedAtPoint:(struct CGPoint)arg2;
- (UIAccessibilityHUDItem *)_accessibilityHUDGestureManager:(UIAccessibilityHUDGestureManager *)arg1 HUDItemForPoint:(struct CGPoint)arg2;

@optional
- (void)_dismissAccessibilityHUDForGestureManager:(UIAccessibilityHUDGestureManager *)arg1;
- (void)_accessibilityHUDGestureManager:(UIAccessibilityHUDGestureManager *)arg1 showHUDItem:(UIAccessibilityHUDItem *)arg2;
- (_Bool)_accessibilityHUDGestureManager:(UIAccessibilityHUDGestureManager *)arg1 shouldTerminateHUDGestureForOtherGestureRecognizer:(UIGestureRecognizer *)arg2;
@end

