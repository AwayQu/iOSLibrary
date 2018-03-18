//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIView.h>

#import "UIGestureRecognizerDelegate.h"
#import "UIScrollViewDelegate.h"

@class NSArray, NSString, UILongPressGestureRecognizer;

__attribute__((visibility("hidden")))
@interface _UIPreviewActionSheetView : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>
{
    id <_UIPreviewActionSheetViewDelegate> _delegate;
    CDUnknownBlockType _completionHandler;
    NSArray *_actions;
    NSString *_title;
    UILongPressGestureRecognizer *_captureTouchesRecognizer;
    struct UIEdgeInsets _contentInsets;
}

@property(retain, nonatomic) UILongPressGestureRecognizer *captureTouchesRecognizer; // @synthesize captureTouchesRecognizer=_captureTouchesRecognizer;
@property(retain, nonatomic) NSString *title; // @synthesize title=_title;
@property(retain, nonatomic) NSArray *actions; // @synthesize actions=_actions;
@property(copy, nonatomic) CDUnknownBlockType completionHandler; // @synthesize completionHandler=_completionHandler;
@property(nonatomic) __weak id <_UIPreviewActionSheetViewDelegate> delegate; // @synthesize delegate=_delegate;
@property(nonatomic) struct UIEdgeInsets contentInsets; // @synthesize contentInsets=_contentInsets;
- (void).cxx_destruct;
- (void)_performActionForPreviewAction:(id)arg1 interfaceAction:(id)arg2;
- (void)_setupViewHierarchy;
- (id)initWithCoder:(id)arg1;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithFrame:(struct CGRect)arg1 title:(id)arg2 items:(id)arg3 contentInsets:(struct UIEdgeInsets)arg4;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

