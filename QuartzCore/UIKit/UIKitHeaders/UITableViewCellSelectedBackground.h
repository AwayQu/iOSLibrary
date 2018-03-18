//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class UIColor;

__attribute__((visibility("hidden")))
@interface UITableViewCellSelectedBackground : UIView
{
    long long _selectionStyle;
    UIColor *_multiselectBackgroundColor;
    UIColor *_selectionTintColor;
    UIColor *_noneStyleBackgroundColor;
    _Bool _multiselect;
}

@property(retain, nonatomic) UIColor *noneStyleBackgroundColor; // @synthesize noneStyleBackgroundColor=_noneStyleBackgroundColor;
@property(retain, nonatomic) UIColor *selectionTintColor; // @synthesize selectionTintColor=_selectionTintColor;
@property(retain, nonatomic) UIColor *multiselectBackgroundColor; // @synthesize multiselectBackgroundColor=_multiselectBackgroundColor;
@property(nonatomic) long long selectionStyle; // @synthesize selectionStyle=_selectionStyle;
- (void).cxx_destruct;
- (void)drawRect:(struct CGRect)arg1;
@property(nonatomic, getter=isMultiselect) _Bool multiselect;

@end

