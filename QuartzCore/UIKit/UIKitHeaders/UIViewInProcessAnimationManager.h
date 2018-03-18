//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "_UIViewInProcessAnimationManagerDriver.h"

@class CADisplayLink, NSHashTable, NSMutableArray, NSObject<OS_dispatch_queue>, NSObject<OS_dispatch_semaphore>, NSObject<OS_dispatch_source>, NSRunLoop, NSString, NSThread, _UIAppCACommitFuture;

@interface UIViewInProcessAnimationManager : NSObject <_UIViewInProcessAnimationManagerDriver>
{
    NSMutableArray *_entries;
    NSMutableArray *_newlyAddedEntries;
    NSMutableArray *_postTickBlocks;
    NSMutableArray *_preTickBlocks;
    NSMutableArray *_preExitBlocks;
    NSMutableArray *_presentationModifierGroupRequestBlocks;
    id <_UIViewInProcessAnimationManagerDriver> _animatorAdvancer;
    double _time;
    double _deltaTime;
    double _refreshInterval;
    NSObject<OS_dispatch_queue> *_tickPrepQueue;
    NSObject<OS_dispatch_queue> *_tickQueue;
    NSObject<OS_dispatch_queue> *_entryLockingQueue;
    NSObject<OS_dispatch_queue> *_preTickLockingQueue;
    NSObject<OS_dispatch_queue> *_animationAdvancerWaitingFlagQueue;
    NSObject<OS_dispatch_queue> *_timerQueue;
    NSObject<OS_dispatch_queue> *_displayLinkAccessQueue;
    NSObject<OS_dispatch_queue> *_backlightQueue;
    NSObject<OS_dispatch_source> *_timerSource;
    NSObject<OS_dispatch_semaphore> *_postTicksDelaySemaphore;
    _Bool _waitingForAnimatorAdvancerToStart;
    NSMutableArray *_animationBlocksToStart;
    _UIAppCACommitFuture *_caCommitFuture;
    CADisplayLink *_displayLink;
    int _screenDimmingNotificationToken;
    _Bool _animationsSuspended;
    _Bool _animationsShouldCompleteImmediately;
    _Bool _skipNextFrame;
    _Bool _displayLinkInvalidated;
    _Bool _screenIsOff;
    unsigned long long _presentationModifierRequestCount;
    NSHashTable *_presentationGroups;
    _Bool _performScheduledBlocksManually;
    _Bool _commitsSynchronously;
    _Bool _usesMainThreadExecution;
    _Bool _advancingOnCommitDisabled;
    unsigned long long _executionMode;
    NSThread *_currentTickThread;
    NSThread *_animationThread;
    NSRunLoop *_animationThreadRunLoop;
    NSObject<OS_dispatch_semaphore> *_animationThreadKeepAliveSemaphore;
}

+ (void)_dispatchAsyncOntoMainBeforeExit:(CDUnknownBlockType)arg1;
+ (void)_cancelPresentationModifierGroupRequest:(id)arg1;
+ (id)_requestPresentationModifierGroup:(CDUnknownBlockType)arg1;
+ (id)sharedManager;
+ (void)_setExternalAnimationDriver:(id)arg1;
@property(retain) NSObject<OS_dispatch_semaphore> *animationThreadKeepAliveSemaphore; // @synthesize animationThreadKeepAliveSemaphore=_animationThreadKeepAliveSemaphore;
@property __weak NSRunLoop *animationThreadRunLoop; // @synthesize animationThreadRunLoop=_animationThreadRunLoop;
@property __weak NSThread *animationThread; // @synthesize animationThread=_animationThread;
@property __weak NSThread *currentTickThread; // @synthesize currentTickThread=_currentTickThread;
@property(nonatomic) _Bool advancingOnCommitDisabled; // @synthesize advancingOnCommitDisabled=_advancingOnCommitDisabled;
@property(nonatomic) unsigned long long executionMode; // @synthesize executionMode=_executionMode;
@property(nonatomic) _Bool usesMainThreadExecution; // @synthesize usesMainThreadExecution=_usesMainThreadExecution;
@property(nonatomic) _Bool commitsSynchronously; // @synthesize commitsSynchronously=_commitsSynchronously;
@property(nonatomic, setter=_setPerformScheduledBlocksManually:) _Bool performScheduledBlocksManually; // @synthesize performScheduledBlocksManually=_performScheduledBlocksManually;
- (void).cxx_destruct;
- (void)finishAdvancingAnimationManager;
- (void)startAdvancingAnimationManager:(id)arg1;
- (double)refreshInterval;
- (void)_displayLinkFire:(id)arg1;
- (_Bool)_shouldKeepAnimationThreadAlive;
- (void)_advanceWithTime:(double)arg1;
- (void)_cancelPresentationModifierGroupRequest:(id)arg1;
- (id)_requestPresentationModifierGroup:(CDUnknownBlockType)arg1;
- (void)performBeforeExiting:(CDUnknownBlockType)arg1;
- (void)performAfterTick:(CDUnknownBlockType)arg1;
- (void)performBeforeTick:(CDUnknownBlockType)arg1;
- (_Bool)_isInvalidated;
- (void)_performWhenInProcessAnimationsTransactionCommits:(CDUnknownBlockType)arg1;
- (void)_setCurrentMediaTime:(double)arg1;
- (void)_setAnimationExecutionParameters;
- (void)_commitSynchronously;
- (void)_runAnimationBlocks;
- (void)startAnimationAdvancerIfNeeded;
- (void)addEntry:(CDUnknownBlockType)arg1;
- (void)scheduleAnimatorAdvancerToStart;
- (void)_performTick:(double)arg1 cancel:(_Bool)arg2 force:(_Bool)arg3 eventName:(id)arg4 entry:(CDUnknownBlockType)arg5 exit:(CDUnknownBlockType)arg6;
- (void)_processTickExitRemovingEntries:(id)arg1;
- (void)_processPresentationModifierRequestsAndFlush;
- (void)_processPostTicks;
- (void)_processPostTicksDelayIfNecessary:(double)arg1;
- (void)_processEntriesCollectingEntriesToRemove:(id)arg1 cancel:(_Bool)arg2;
- (void)_processPreTicks;
- (void)_prepareForTick;
- (void)_applicationBecameActive;
- (void)_applicationResignedActive;
- (void)_cancelAllAnimationsImmediately;
- (void)dealloc;
- (void)setWaitingForAnimatorAdvancerToStart:(_Bool)arg1;
- (_Bool)isWaitingForAnimatorAdvancerToStart;
- (void)_registerBacklightChangedNotification;
- (id)init;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

