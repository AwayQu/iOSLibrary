//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "UIDropInteractionDelegate_Private.h"
#import "_UITableViewDropCoordinatorDelegate.h"

@class NSIndexPath, NSMapTable, NSString, UIDropInteraction, UITableView<_UITableViewDropControllerDelegate>, UITableViewDropProposal;

__attribute__((visibility("hidden")))
@interface _UITableViewDropController : NSObject <UIDropInteractionDelegate_Private, _UITableViewDropCoordinatorDelegate>
{
    _Bool _canOnlyHandleReordering;
    UIDropInteraction *_dropInteraction;
    UITableView<_UITableViewDropControllerDelegate> *_tableView;
    unsigned long long _defaultDropOperation;
    NSIndexPath *_targetIndexPath;
    UITableViewDropProposal *_dropProposal;
    id <UIDropSession> _dropSession;
    long long _ignoringDragsCount;
    NSMapTable *_dragItemDropAnimations;
}

@property(retain, nonatomic) NSMapTable *dragItemDropAnimations; // @synthesize dragItemDropAnimations=_dragItemDropAnimations;
@property(nonatomic) long long ignoringDragsCount; // @synthesize ignoringDragsCount=_ignoringDragsCount;
@property(retain, nonatomic) id <UIDropSession> dropSession; // @synthesize dropSession=_dropSession;
@property(retain, nonatomic) UITableViewDropProposal *dropProposal; // @synthesize dropProposal=_dropProposal;
@property(retain, nonatomic) NSIndexPath *targetIndexPath; // @synthesize targetIndexPath=_targetIndexPath;
@property(nonatomic) unsigned long long defaultDropOperation; // @synthesize defaultDropOperation=_defaultDropOperation;
@property(nonatomic) __weak UITableView<_UITableViewDropControllerDelegate> *tableView; // @synthesize tableView=_tableView;
@property(retain, nonatomic) UIDropInteraction *dropInteraction; // @synthesize dropInteraction=_dropInteraction;
@property(nonatomic) _Bool canOnlyHandleReordering; // @synthesize canOnlyHandleReordering=_canOnlyHandleReordering;
- (void).cxx_destruct;
- (_Bool)commitPlaceholderInsertionWithContext:(id)arg1 dataSourceUpdates:(CDUnknownBlockType)arg2;
- (_Bool)deletePlaceholder:(id)arg1;
- (void)insertPlaceholderAtIndexPath:(id)arg1 withContext:(id)arg2 previewParametersProvider:(CDUnknownBlockType)arg3;
- (id)animateDragItem:(id)arg1 toTarget:(id)arg2;
- (id)animateDragItem:(id)arg1 toCell:(id)arg2 withPreviewParameters:(id)arg3;
- (id)animateDragItem:(id)arg1 toRowAtIndexPath:(id)arg2;
- (id)animateDragItem:(id)arg1 intoRowAtIndexPath:(id)arg2 rect:(struct CGRect)arg3;
- (id)defaultAnimatorForDragItem:(id)arg1;
- (long long)_dropInteraction:(id)arg1 dataOwnerForSession:(id)arg2;
- (void)dropInteraction:(id)arg1 concludeDrop:(id)arg2;
- (void)dropInteraction:(id)arg1 item:(id)arg2 willAnimateDropWithAnimator:(id)arg3;
- (id)dropInteraction:(id)arg1 previewForDroppingItem:(id)arg2 withDefault:(id)arg3;
- (void)dropInteraction:(id)arg1 performDrop:(id)arg2;
- (void)dropInteraction:(id)arg1 sessionDidEnd:(id)arg2;
- (void)dropInteraction:(id)arg1 sessionDidExit:(id)arg2;
- (id)dropInteraction:(id)arg1 sessionDidUpdate:(id)arg2;
- (void)dropInteraction:(id)arg1 sessionDidEnter:(id)arg2;
- (void)updateTargetIndexPathAndDropProposalForSession:(id)arg1;
- (void)resetAllDragState;
- (void)resetTrackingState;
@property(readonly, nonatomic) _Bool shouldIgnoreDrags;
- (void)endIgnoringDrags;
- (void)beginIgnoringDrags;
- (void)uninstallFromTableView;
@property(readonly, nonatomic, getter=isTrackingDrag) _Bool trackingDrag;
@property(readonly, nonatomic, getter=isActive) _Bool active;
- (void)setupDragInteraction;
- (id)initWithTableView:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

