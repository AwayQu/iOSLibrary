//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIInterfaceActionConcreteVisualStyle.h>

#import "UIInterfaceActionConcreteVisualStyleImpl.h"

@class NSString;

__attribute__((visibility("hidden")))
@interface UIInterfaceActionConcreteVisualStyle_iOS : UIInterfaceActionConcreteVisualStyle <UIInterfaceActionConcreteVisualStyleImpl>
{
}

- (id)_preferredActionFont;
- (id)_regularActionFont;
- (id)newSectionSeparatorViewForGroupViewState:(id)arg1;
- (id)newActionSeparatorViewForGroupViewState:(id)arg1;
- (id)newGroupBackgroundViewWithGroupViewState:(id)arg1;
- (id)newActionBackgroundViewForViewState:(id)arg1;
- (id)actionTitleLabelColorForViewState:(id)arg1;
- (id)actionTitleLabelFontForViewState:(id)arg1;
- (_Bool)selectionFeedbackEnabled;
- (double)verticalImageContentSpacing;
- (double)horizontalImageContentSpacing;
- (struct UIEdgeInsets)contentMargin;
- (double)contentCornerRadius;
- (id)defaultScreen;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end
