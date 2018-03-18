//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/_UIDraggingImageSlotOwner.h>

#import "NSProgressReporting.h"
#import "_UIDataTransferMonitorDelegate.h"

@class NSArray, NSMutableSet, NSProgress, NSString, PBItemCollection, UIDragEvent, UIView, UIWindow, _DUIPotentialDrop, _UIApplicationModalProgressController, _UIDataTransferMonitor, _UIDragSetDownAnimation, _UIDropSessionImpl, _UIDruidDestinationConnection, _UIInternalDraggingSessionSource;

__attribute__((visibility("hidden")))
@interface _UIInternalDraggingSessionDestination : _UIDraggingImageSlotOwner <_UIDataTransferMonitorDelegate, NSProgressReporting>
{
    unsigned int _sessionIdentifier;
    unsigned int _touchRoutingPolicyContextID;
    _UIInternalDraggingSessionSource *_sessionSource;
    _Bool _connectedToDruid;
    _Bool _dragInteractionDidEnd;
    NSMutableSet *_enteredDestinations;
    UIView *_dropDestinationView;
    CDUnknownBlockType _dropPerformBlock;
    CDUnknownBlockType _dropCompletionBlock;
    CDUnknownBlockType _postDropAnimationCompletionBlock;
    _UIDragSetDownAnimation *_setDownAnimation;
    PBItemCollection *_droppedItemCollection;
    _UIDataTransferMonitor *_dataTransferMonitor;
    _UIApplicationModalProgressController *_modalProgressAlertController;
    _Bool _dropWasPerformed;
    _DUIPotentialDrop *_lastPotentialDrop;
    _Bool _isAccessibilitySession;
    id <_UIDraggingInfo> _publicSession;
    UIDragEvent *_dragEvent;
    _UIDropSessionImpl *_dropSession;
    UIWindow *_centroidWindow;
    NSArray *_dropItemProviders;
    long long _sourceDataOwner;
    NSArray *_internalItems;
    unsigned long long _outsideAppSourceOperationMask;
    unsigned long long _progressIndicatorStyle;
    _UIDruidDestinationConnection *_druidConnection;
    NSProgress *_progress;
    struct CGPoint _centroid;
}

@property(retain, nonatomic) NSProgress *progress; // @synthesize progress=_progress;
@property(retain, nonatomic) _UIDruidDestinationConnection *druidConnection; // @synthesize druidConnection=_druidConnection;
@property(nonatomic) unsigned long long progressIndicatorStyle; // @synthesize progressIndicatorStyle=_progressIndicatorStyle;
@property(readonly, nonatomic) _Bool isAccessibilitySession; // @synthesize isAccessibilitySession=_isAccessibilitySession;
@property(readonly, nonatomic) unsigned long long outsideAppSourceOperationMask; // @synthesize outsideAppSourceOperationMask=_outsideAppSourceOperationMask;
@property(copy, nonatomic) NSArray *internalItems; // @synthesize internalItems=_internalItems;
@property(readonly, nonatomic) long long sourceDataOwner; // @synthesize sourceDataOwner=_sourceDataOwner;
@property(readonly, nonatomic) NSArray *dropItemProviders; // @synthesize dropItemProviders=_dropItemProviders;
@property(readonly, nonatomic) UIWindow *centroidWindow; // @synthesize centroidWindow=_centroidWindow;
@property(readonly, nonatomic) struct CGPoint centroid; // @synthesize centroid=_centroid;
@property(readonly, nonatomic) _UIDropSessionImpl *dropSession; // @synthesize dropSession=_dropSession;
@property(nonatomic) __weak UIDragEvent *dragEvent; // @synthesize dragEvent=_dragEvent;
@property(readonly, nonatomic) id <_UIDraggingInfo> publicSession; // @synthesize publicSession=_publicSession;
@property(readonly, nonatomic) unsigned int sessionIdentifier; // @synthesize sessionIdentifier=_sessionIdentifier;
- (void).cxx_destruct;
- (unsigned long long)actualDragOperationForProposedDragOperation:(unsigned long long)arg1 destinationDataOwner:(long long)arg2 forbidden:(_Bool *)arg3;
- (void)handOffDroppedItems:(id)arg1;
- (void)setUpDropAnimation:(id)arg1;
- (void)takeVisibleDroppedItems:(id)arg1;
@property(readonly, nonatomic) NSArray *preDropItemProviders;
@property(readonly, nonatomic) unsigned long long sourceOperationMask;
- (void)requestDropOnView:(id)arg1 withOperation:(unsigned long long)arg2 perform:(CDUnknownBlockType)arg3 completion:(CDUnknownBlockType)arg4;
- (void)takePotentialDrop:(id)arg1;
- (void)itemsBecameDirty:(id)arg1;
- (void)enteredDestination:(id)arg1;
- (void)dragDidExitApp;
- (void)updateCentroidFromDragEvent;
- (void)sawDragEndEvent;
- (void)dragInteractionEnding;
@property(readonly, nonatomic) _Bool didRequestDropToBePerformed;
@property(readonly, nonatomic) _Bool hasConnectedToDruid;
- (void)dataTransferMonitorFinishedTransfers:(id)arg1;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (void)dataTransferMonitorBeganTransfers:(id)arg1;
- (void)_removeFromDragManager;
- (void)_sessionDidEndNormally:(_Bool)arg1;
- (void)connect;
- (_Bool)canBeDrivenByDragEvent:(id)arg1;
@property(readonly, nonatomic) _UIInternalDraggingSessionSource *inAppSessionSource;
- (id)initWithDragManager:(id)arg1 dragEvent:(id)arg2;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

