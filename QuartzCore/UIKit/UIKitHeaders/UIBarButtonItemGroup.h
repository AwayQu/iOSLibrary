//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSCoding.h"

@class NSArray, NSMutableArray, UIBarButtonItem, _UIButtonGroupViewController;

@interface UIBarButtonItemGroup : NSObject <NSCoding>
{
    NSMutableArray *_barButtonItems;
    _Bool _locked;
    _Bool _sendActionsBeforeDismiss;
    _Bool _hidden;
    float _priority;
    UIBarButtonItem *_representativeItem;
    id <_UIBarButtonItemGroupOwner> _owner;
    _UIButtonGroupViewController *_representativeUI;
    double _minimumLeadingSpace;
    double _minimumTrailingSpace;
}

@property(nonatomic, getter=_minimumTrailingSpace, setter=_setMinimumTrailingSpace:) double minimumTrailingSpace; // @synthesize minimumTrailingSpace=_minimumTrailingSpace;
@property(nonatomic, getter=_minimumLeadingSpace, setter=_setMinimumLeadingSpace:) double minimumLeadingSpace; // @synthesize minimumLeadingSpace=_minimumLeadingSpace;
@property(nonatomic, getter=_isHidden, setter=_setHidden:) _Bool hidden; // @synthesize hidden=_hidden;
@property(nonatomic, getter=_sendActionsBeforeDismiss, setter=_setSendActionsBeforeDismiss:) _Bool sendActionsBeforeDismiss; // @synthesize sendActionsBeforeDismiss=_sendActionsBeforeDismiss;
@property(nonatomic, getter=_isLocked, setter=_setLocked:) _Bool locked; // @synthesize locked=_locked;
@property(retain, nonatomic, getter=_representativeUI, setter=_setRepresentativeUI:) _UIButtonGroupViewController *representativeUI; // @synthesize representativeUI=_representativeUI;
@property(nonatomic, getter=_owner, setter=_setOwner:) __weak id <_UIBarButtonItemGroupOwner> owner; // @synthesize owner=_owner;
@property(nonatomic, getter=_priority, setter=_setPriority:) float priority; // @synthesize priority=_priority;
@property(retain, nonatomic) UIBarButtonItem *representativeItem; // @synthesize representativeItem=_representativeItem;
- (void).cxx_destruct;
- (void)_validateAllItems;
@property(readonly, nonatomic, getter=_items) NSArray *items;
- (id)description;
@property(readonly, nonatomic, getter=isDisplayingRepresentativeItem) _Bool displayingRepresentativeItem;
@property(copy, nonatomic) NSArray *barButtonItems;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)initWithBarButtonItems:(id)arg1 representativeItem:(id)arg2;
- (id)init;
- (void)_removeRepresentative:(id)arg1;
- (void)_removeBarButtonItem:(id)arg1;

@end

