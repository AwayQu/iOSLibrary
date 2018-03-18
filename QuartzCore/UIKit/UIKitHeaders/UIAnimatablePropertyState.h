//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSObject<OS_dispatch_queue>, UIViewInProcessAnimationState, UIViewRunningAnimationEntry;

__attribute__((visibility("hidden")))
@interface UIAnimatablePropertyState : NSObject
{
    NSObject<OS_dispatch_queue> *_animationEntryLockingQueue;
    UIViewRunningAnimationEntry *_animationEntry;
    id <UIVectorOperatable> _pendingTargetVelocity;
    id <UIVectorOperatable> _pendingVelocity;
    int _ownershipCount;
    id <UIViewAnimationComposing> _composer;
    UIViewInProcessAnimationState *_animationState;
    CDUnknownBlockType _invalidationCallback;
}

@property(copy, nonatomic) CDUnknownBlockType invalidationCallback; // @synthesize invalidationCallback=_invalidationCallback;
@property(nonatomic) int ownershipCount; // @synthesize ownershipCount=_ownershipCount;
@property(nonatomic) __weak UIViewInProcessAnimationState *animationState; // @synthesize animationState=_animationState;
@property(retain, nonatomic) id <UIViewAnimationComposing> composer; // @synthesize composer=_composer;
- (void).cxx_destruct;
- (id)velocityTarget:(_Bool)arg1;
- (void)setVelocity:(id)arg1 target:(_Bool)arg2;
@property(retain, nonatomic) UIViewRunningAnimationEntry *animationEntry;
- (void)invalidateIfPossible;
- (id)initWithInvalidationCallback:(CDUnknownBlockType)arg1;
- (_Bool)animatePropertyWithCurrentValue:(id)arg1 targetValueGetter:(CDUnknownBlockType)arg2 preTickShouldRemoveCallback:(CDUnknownBlockType)arg3 newValueCallback:(CDUnknownBlockType)arg4 removedCallback:(CDUnknownBlockType)arg5;

@end

