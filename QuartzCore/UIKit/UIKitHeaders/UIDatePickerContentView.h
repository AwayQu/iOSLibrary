//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class UILabel, _UIDatePickerMode;

__attribute__((visibility("hidden")))
@interface UIDatePickerContentView : UIView
{
    struct {
        unsigned int isAmPm:1;
    } _datePickerContentViewFlags;
    _Bool _isModern;
    UILabel *_titleLabel;
    double _titleLabelMaxX;
    long long _titleAlignment;
    _UIDatePickerMode *_mode;
}

@property(retain, nonatomic) _UIDatePickerMode *mode; // @synthesize mode=_mode;
@property(nonatomic) _Bool isModern; // @synthesize isModern=_isModern;
@property(nonatomic) long long titleAlignment; // @synthesize titleAlignment=_titleAlignment;
@property(nonatomic) double titleLabelMaxX; // @synthesize titleLabelMaxX=_titleLabelMaxX;
@property(readonly, nonatomic) UILabel *titleLabel; // @synthesize titleLabel=_titleLabel;
- (void).cxx_destruct;
- (void)layoutSubviews;
@property(nonatomic) _Bool isAmPm;
- (_Bool)_canBeReusedInPickerView;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)initWithMode:(id)arg1;

@end

