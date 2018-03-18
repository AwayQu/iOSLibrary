//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSArray, NSAttributedString, UITargetedDragPreview, UITextPosition, UITextRange, UIView;

@protocol UITextDraggableGeometry <NSObject>
@property(nonatomic) long long geometryOptions;
- (UITargetedDragPreview *)previewForDroppingText:(NSAttributedString *)arg1 toPosition:(UITextPosition *)arg2 inContainerView:(UIView *)arg3;
- (NSArray *)draggableObjectsForTextRange:(UITextRange *)arg1;
- (UITextRange *)textRangeForAttachmentInTextRange:(UITextRange *)arg1 atPoint:(struct CGPoint)arg2;
- (NSArray *)textRangesForAttachmentsInTextRange:(UITextRange *)arg1;
@end

