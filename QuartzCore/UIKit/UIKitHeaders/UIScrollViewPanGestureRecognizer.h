//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIPanGestureRecognizer.h>

@class UIScrollView, UIScrollViewDirectionalPressGestureRecognizer;

__attribute__((visibility("hidden")))
@interface UIScrollViewPanGestureRecognizer : UIPanGestureRecognizer
{
    UIScrollView *_scrollView;
    SEL _scrollViewAction;
    struct CGPoint _reconsideredLockingLocation;
    unsigned int _lastLockingAxis:2;
    unsigned int _lockingAxis:2;
    unsigned int _hasParentScrollView:1;
    unsigned int _caughtDeceleratingScrollView:1;
    unsigned int _directionalLockEnabled:1;
    unsigned int _transfersTrackingFromParentScrollView:1;
    unsigned int _movedAfterCaughtDeceleratingScrollViewButBeganNotYetDelivered:1;
    long long _indirectScrollingState;
    double _translationScaleFactor;
    UIScrollViewDirectionalPressGestureRecognizer *_directionalPressGestureRecognizer;
}

@property(nonatomic) __weak UIScrollViewDirectionalPressGestureRecognizer *directionalPressGestureRecognizer; // @synthesize directionalPressGestureRecognizer=_directionalPressGestureRecognizer;
@property(nonatomic) double translationScaleFactor; // @synthesize translationScaleFactor=_translationScaleFactor;
@property(nonatomic) __weak UIScrollView *scrollView; // @synthesize scrollView=_scrollView;
- (void).cxx_destruct;
@property(readonly, nonatomic, getter=_beganCaughtDeceleratingScrollViewAndMoved) _Bool beganCaughtDeceleratingScrollViewAndMoved;
@property(readonly, nonatomic, getter=_caughtDeceleratingScrollView) _Bool caughtDeceleratingScrollView;
@property(nonatomic, getter=isDirectionalLockEnabled) _Bool directionalLockEnabled;
- (double)_hysteresis;
- (void)_scrollViewDidEndZooming;
- (void)_resetGestureRecognizer;
- (_Bool)canBePreventedByGestureRecognizer:(id)arg1;
- (void)touchesCancelled:(id)arg1 withEvent:(id)arg2;
- (_Bool)_shouldTryToBeginWithEvent:(id)arg1;
- (void)touchesMoved:(id)arg1 withEvent:(id)arg2;
- (struct CGPoint)velocityInView:(id)arg1;
- (struct CGPoint)translationInView:(id)arg1;
- (struct CGPoint)_convertPoint:(struct CGPoint)arg1 fromSceneReferenceCoordinatesToView:(id)arg2;
- (struct CGPoint)_convertPoint:(struct CGPoint)arg1 toSceneReferenceCoordinatesFromView:(id)arg2;
- (void)_centroidMovedTo:(struct CGPoint)arg1 atTime:(double)arg2;
- (struct CGPoint)_adjustSceneReferenceLocation:(struct CGPoint)arg1;
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2;
- (_Bool)_shouldTransferTrackingFromParentScrollViewForCurrentOffset;
- (_Bool)_shouldContinueToWaitToTransferTrackingFromParentScrollView;
- (_Bool)_canTransferTrackingFromParentPagingScrollView;
- (void)setView:(id)arg1;
- (void)setAllowedTouchTypes:(id)arg1;
- (void)removeTarget:(id)arg1 action:(SEL)arg2;
- (void)setDelegate:(id)arg1;
- (_Bool)delaysTouchesBegan;
- (id)initWithTarget:(id)arg1 action:(SEL)arg2;

@end

