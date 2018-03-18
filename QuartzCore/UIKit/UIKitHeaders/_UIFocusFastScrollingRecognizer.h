//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "_UIFocusEnginePanGestureTouchObserver.h"

@class NSMapTable, NSString, NSTimer, UIScrollView, _UIFocusEnginePanGestureRecognizer, _UIFocusFastScrollingTouchSequence;

__attribute__((visibility("hidden")))
@interface _UIFocusFastScrollingRecognizer : NSObject <_UIFocusEnginePanGestureTouchObserver>
{
    _UIFocusEnginePanGestureRecognizer *_panGesture;
    _UIFocusFastScrollingTouchSequence *_currentTouch;
    NSMapTable *_swipeSequences;
    NSTimer *_swipeIntervalTimer;
    UIScrollView *_previewingScrollView;
    NSTimer *_previewingTouchTimer;
    _Bool _enabled;
    id <_UIFocusFastScrollingRecognizerDelegate> _delegate;
}

+ (id)recognizerWithPanGesture:(id)arg1;
@property(nonatomic, getter=isEnabled) _Bool enabled; // @synthesize enabled=_enabled;
@property(nonatomic) __weak id <_UIFocusFastScrollingRecognizerDelegate> delegate; // @synthesize delegate=_delegate;
- (void).cxx_destruct;
- (void)focusEnginePanGesture:(id)arg1 touchCancelledAtDigitizerLocation:(struct CGPoint)arg2;
- (void)focusEnginePanGesture:(id)arg1 touchEndedAtDigitizerLocation:(struct CGPoint)arg2;
- (void)focusEnginePanGesture:(id)arg1 touchMovedToDigitizerLocation:(struct CGPoint)arg2;
- (void)focusEnginePanGesture:(id)arg1 touchBeganAtDigitizerLocation:(struct CGPoint)arg2;
- (void)_deactivatePreviewingScrollViewIfNecessary;
- (void)_activatePreviewingScrollView;
- (void)_activatePreviewingScrollViewAfterDelay;
- (void)_notifyDelegateWithScrollView:(id)arg1 scrollingStyle:(long long)arg2 heading:(unsigned long long)arg3;
- (_Bool)_scrollViewIsEligibleForFastScrolling:(id)arg1 alongHeading:(unsigned long long)arg2;
- (id)_scrollViewsContainingCurrentlyFocusedItem;
- (_Bool)_attemptToImmediatelyRecognizeEdgeGesture;
- (id)_deepestEligibleScrollViewContainingFocusedItem:(unsigned long long)arg1;
- (_Bool)_swipeSequenceCanBeginFastScrolling:(id)arg1;
- (void)_updateActiveSwipeSequencesForScrollViews:(id)arg1;
- (unsigned long long)_bestHeadingForAccumulator:(struct CGVector)arg1;
- (void)_swipeIntervalElapsed:(id)arg1;
- (void)_stopSwipeIntervalTimer;
- (void)_startSwipeIntervalTimer;
- (void)_swipeOccuredAlongHeading:(unsigned long long)arg1;
- (void)_touchSequenceDidEnd:(id)arg1;
- (void)reset;
- (void)_handlePanGesture:(id)arg1;
- (void)joystickMovementWithHeading:(unsigned long long)arg1 didRepeat:(unsigned long long)arg2;
- (void)directionalPressWithHeading:(unsigned long long)arg1 didRepeat:(unsigned long long)arg2;
- (void)_focusDidUpate:(id)arg1;
- (void)dealloc;
- (id)initWithPanGesture:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
