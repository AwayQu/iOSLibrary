//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class UIPreviewAction, _UIPreviewActionsController;

@protocol _UIPreviewActionsControllerDelegate <NSObject>
- (void)previewActionsController:(_UIPreviewActionsController *)arg1 didUpdatePlatterTranslation:(struct CGVector)arg2 withVelocity:(struct CGVector)arg3;
- (void)didDismissPreviewActionsController:(_UIPreviewActionsController *)arg1;
- (void)previewActionsController:(_UIPreviewActionsController *)arg1 didCompleteWithSelectedAction:(UIPreviewAction *)arg2;
- (struct CGSize)maximumPreviewActionsViewSizeForPreviewActionsController:(_UIPreviewActionsController *)arg1;
- (struct CGPoint)initialPlatterPositionForPreviewActionsController:(_UIPreviewActionsController *)arg1;
@end

