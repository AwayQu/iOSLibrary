//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIInputViewSetPlacement.h>

#import "NSSecureCoding.h"

__attribute__((visibility("hidden")))
@interface UIInputViewSetPlacementAssistantOnScreen : UIInputViewSetPlacement <NSSecureCoding>
{
}

+ (_Bool)supportsSecureCoding;
- (struct CGRect)remoteIntrinsicContentSizeForInputViewInSet:(id)arg1 includingIAV:(_Bool)arg2;
- (_Bool)inputViewWillAppear;
- (_Bool)accessoryViewWillAppear;
- (_Bool)showsInputViews;
- (id)verticalConstraintForInputViewSet:(id)arg1 hostView:(id)arg2 containerView:(id)arg3;
- (Class)applicatorClassForKeyboard:(_Bool)arg1;

@end

