//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/_UIViewVisitor.h>

@class UIView;

__attribute__((visibility("hidden")))
@interface _UITintColorVisitor : _UIViewVisitor
{
    unsigned long long _reasons;
    UIView *_originalVisitedView;
    UIView *_changedSubview;
}

- (_Bool)_prepareVisitor:(id)arg1 toVisitView:(id)arg2 changedSubview:(id)arg3 previousWindow:(id)arg4 previousSuperview:(id)arg5;
- (_Bool)_visitView:(id)arg1;
- (id)initWithNotificationReasons:(unsigned long long)arg1;
- (id)initWithTraversalDirection:(unsigned long long)arg1;

@end

