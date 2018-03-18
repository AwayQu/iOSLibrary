//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class NSArray, NSString, NSURL, UILabel;

@interface UIURLDragPreviewView : UIView
{
    UILabel *_titleLabel;
    UILabel *_urlLabel;
    NSArray *_titleAndUrlConstraints;
    NSArray *_urlOnlyConstraints;
    NSString *_title;
    NSURL *_url;
    NSString *_urlText;
}

+ (void)initialize;
+ (id)_urlFont;
+ (id)_titleFont;
+ (id)viewWithURLText:(id)arg1;
+ (id)viewWithTitle:(id)arg1 URLText:(id)arg2;
+ (id)viewWithURL:(id)arg1;
+ (id)viewWithTitle:(id)arg1 URL:(id)arg2;
@property(copy, nonatomic) NSString *urlText; // @synthesize urlText=_urlText;
@property(copy, nonatomic) NSURL *url; // @synthesize url=_url;
@property(copy, nonatomic) NSString *title; // @synthesize title=_title;
- (void).cxx_destruct;
- (void)updateConstraints;
- (id)initWithFrame:(struct CGRect)arg1;

@end

