//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class UIVisualEffect, UIVisualEffectView;

__attribute__((visibility("hidden")))
@interface _UITableViewCellSeparatorView : UIView
{
    _Bool _drawsWithVibrantLightMode;
    UIView *_backgroundView;
    UIView *_overlayView;
    UIVisualEffect *_separatorEffect;
    UIVisualEffectView *_effectView;
}

@property(retain, nonatomic) UIVisualEffect *separatorEffect; // @synthesize separatorEffect=_separatorEffect;
@property(nonatomic) _Bool drawsWithVibrantLightMode; // @synthesize drawsWithVibrantLightMode=_drawsWithVibrantLightMode;
- (void).cxx_destruct;
- (void)layoutSubviews;

@end

