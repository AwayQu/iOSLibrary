//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/_UIStatusBarItem.h>

@class NSArray, NSString, _UIStatusBarImageView;

__attribute__((visibility("hidden")))
@interface _UIStatusBarIndicatorItem : _UIStatusBarItem
{
    NSArray *_currentImageNamePrefixes;
    _UIStatusBarImageView *_imageView;
}

+ (id)indicatorDisplayIdentifier;
@property(readonly, nonatomic) _UIStatusBarImageView *imageView; // @synthesize imageView=_imageView;
@property(copy, nonatomic) NSArray *currentImageNamePrefixes; // @synthesize currentImageNamePrefixes=_currentImageNamePrefixes;
- (void).cxx_destruct;
- (id)applyUpdate:(id)arg1 toDisplayItem:(id)arg2;
- (id)viewForIdentifier:(id)arg1;
- (id)imageForUpdate:(id)arg1;
- (id)imageNameForUpdate:(id)arg1;
@property(readonly, nonatomic) _Bool isTemplateImage;
@property(readonly, nonatomic) NSString *indicatorEntryKey;
- (id)init;
- (id)dependentEntryKeys;

@end

