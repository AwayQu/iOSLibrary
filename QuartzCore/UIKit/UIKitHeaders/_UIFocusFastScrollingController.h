//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class CADisplayLink, NSArray, NSTimer, UIPanGestureRecognizer, UIScrollView, _UIDynamicAnimationGroup, _UIDynamicValueAnimation, _UIFocusEngineJoystickGestureRecognizer, _UIFocusFastScrollingIndexBarEntry, _UIFocusFastScrollingIndexBarView;

__attribute__((visibility("hidden")))
@interface _UIFocusFastScrollingController : NSObject
{
    UIScrollView *_scrollView;
    UIPanGestureRecognizer *_panGesture;
    NSArray *_pressGestures;
    _UIFocusEngineJoystickGestureRecognizer *_joystickGesture;
    _UIDynamicValueAnimation *_animationX;
    _UIDynamicValueAnimation *_animationY;
    _UIDynamicAnimationGroup *_animationGroup;
    long long _style;
    struct CGPoint _offsetWhenPanStarted;
    NSArray *_displayedEntries;
    double _initialEdgeDigitizerLocation;
    long long _initialIndexEntry;
    long long _highlightedIndexEntry;
    CDStruct_5e2aa800 _initialVelocity;
    unsigned long long _heading;
    unsigned long long _allowedHeadings;
    CADisplayLink *_pressAnimationDisplayLink;
    CDStruct_5e2aa800 _pressAnimationVelocity;
    struct CGVector _pressForce;
    double _scrollHighlight;
    NSTimer *_cooldownTimer;
    struct {
        unsigned int isDragging:1;
        unsigned int isDecelerating:1;
        unsigned int isInTrackingMode:1;
        unsigned int isIndicatingDestination:1;
        unsigned int isAttemptingToStop:1;
        unsigned int isCancellingScrollAnimation:1;
    } _flags;
    NSArray *_indexEntries;
    _UIFocusFastScrollingIndexBarView *_indexBarView;
}

+ (id)controllerWithRequest:(id)arg1;
+ (long long)indexOfEntryNearestToContentOffset:(struct CGPoint)arg1 inDisplayedEntries:(id)arg2;
+ (id)indexBarViewForScrollView:(id)arg1;
@property(readonly, nonatomic) _UIFocusFastScrollingIndexBarView *indexBarView; // @synthesize indexBarView=_indexBarView;
@property(copy, nonatomic) NSArray *indexEntries; // @synthesize indexEntries=_indexEntries;
- (void).cxx_destruct;
- (void)_updateIndexBarIndicator;
- (_Bool)_shouldShowEntriesInIndexBar;
- (void)_cooldownEnded;
- (void)_cancelCooldown;
- (void)_beginCooldownWithDuration:(double)arg1;
- (void)_stopTrackingMode;
- (void)_startTrackingModeIfNecessary;
- (void)_finishDecelerating;
- (void)_attemptToStopDueToExternalEvent:(_Bool)arg1;
- (void)_stopDueToExternalEvent;
- (void)_attemptToStop;
- (void)_start;
- (void)_configureWithRequest:(id)arg1;
- (void)_hideDestinationIndicators;
- (void)_showDestinationIndicators;
- (void)_updateSoftFocusForVelocity:(CDStruct_c3b9c2ee)arg1;
- (void)_stopScrollingAnimation;
- (void)_setContentOffset:(struct CGPoint)arg1 withVelocity:(CDStruct_c3b9c2ee)arg2;
- (CDStruct_c3b9c2ee)_currentScrollViewDecelerationVelocity;
- (void)_startScrollingAnimationWithVelocity:(CDStruct_c3b9c2ee)arg1 friction:(struct CGPoint)arg2;
- (void)_handleAnimationGroupScrollingCompletionWithInitialVelocity:(struct CGPoint)arg1 bounces:(_Bool)arg2;
- (void)_handleAnimationGroupScrollingAnimations;
- (void)_handleJoystickGesture:(id)arg1;
- (void)_resetAllPressGestures;
- (void)_beginDeceleratingAfterPressGesture;
- (void)_pressAnimationHeartbeat:(id)arg1;
- (void)_stopPressDisplayLink;
- (void)_startPressDisplayLink;
- (void)_startPressTrackingWithVelocity:(CDStruct_c3b9c2ee)arg1;
- (void)_handlePressGesture:(id)arg1;
- (void)_endDraggingWithFinalVelocity:(CDStruct_c3b9c2ee)arg1;
- (void)_beginInitialSwipeDeceleration;
- (void)_handleSwipePanEnd:(id)arg1;
- (void)_handleSwipePanChanged:(id)arg1;
- (void)_handleSwipePanBegin:(id)arg1;
- (void)_interpretDigitzerLocation:(struct CGPoint)arg1 toFindEntryIndex:(long long *)arg2 deflection:(double *)arg3;
- (void)_updateEdgeGesture;
- (void)_startEdgeGesture;
- (void)_handleEdgePanEnd:(id)arg1;
- (void)_handleEdgePanChanged:(id)arg1;
- (void)_handleEdgePanBegin:(id)arg1;
- (void)_handlePanEnd:(id)arg1;
- (void)_handlePanChanged:(id)arg1;
- (void)_handlePanBegin:(id)arg1;
- (void)_handlePanGesture:(id)arg1;
@property(readonly, nonatomic) _UIFocusFastScrollingIndexBarEntry *highlightedEntry;
@property(readonly, nonatomic) long long scrollingStyle;
@property(readonly, nonatomic, getter=isScrollingY) _Bool scrollingY;
@property(readonly, nonatomic, getter=isScrollingX) _Bool scrollingX;
@property(readonly, nonatomic, getter=isDecelerating) _Bool decelerating;
@property(readonly, nonatomic, getter=isDragging) _Bool dragging;
- (void)stop;
- (void)start;
@property(readonly, nonatomic) __weak UIScrollView *scrollView;
- (id)initWithRequest:(id)arg1;

@end

