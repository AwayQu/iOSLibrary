//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIKBRenderFactory.h>

__attribute__((visibility("hidden")))
@interface UIKBRenderFactoryiPhone : UIKBRenderFactory
{
}

- (void)setupLayoutSegments;
- (id)shiftDeleteGlyphTraits;
- (id)shiftLockControlKeyTraits;
- (id)shiftedControlKeyTraits;
- (id)activeControlKeyTraits;
- (id)controlKeyTraits;
- (double)_row4ControlSegmentWidthRight;
- (double)_row4ControlSegmentWidthLeft;
- (id)_traitsForKey:(id)arg1 onKeyplane:(id)arg2;
- (id)variantGeometriesForGeometry:(id)arg1 variantCount:(unsigned long long)arg2 rowLimit:(long long)arg3 annotationIndex:(unsigned long long)arg4;
- (long long)rowLimitForKey:(id)arg1;
- (_Bool)_popupMenuStyleForKey:(id)arg1;
- (_Bool)_popupStyleForKey:(id)arg1;
- (void)_customizeTraits:(id)arg1 forPredictionCellKey:(id)arg2;
- (void)_customizePopupTraits:(id)arg1 forKey:(id)arg2 onKeyplane:(id)arg3;
- (double)dualStringBottomAdditionalOffsetForDisplayContents:(id)arg1;
- (_Bool)isTallPopup;
- (double)popupFontSize;
- (struct CGPoint)popupSymbolTextOffset;
- (struct CGPoint)variantAnnotationTextOffset;
- (struct CGPoint)variantSymbolTextOffset;
- (double)variantWideShadowWeight;
- (struct UIEdgeInsets)variantSymbolFrameInsets;
- (struct UIEdgeInsets)variantDisplayFrameInsets;
- (struct UIEdgeInsets)variantPaddedFrameInsets;
- (struct UIEdgeInsets)wideShadowPopupMenuInsets;
- (struct UIEdgeInsets)wideShadowPaddleInsets;
- (void)_customizeSymbolStyle:(id)arg1 forKey:(id)arg2 contents:(id)arg3;
- (void)_customizeGeometry:(id)arg1 forKey:(id)arg2 contents:(id)arg3;
- (_Bool)iPadFudgeLayout;
- (double)skinnyKeyThreshold;
- (id)shiftLockImageName;
- (id)shiftOnKeyImageName;
- (id)shiftKeyImageName;
- (id)deleteOnKeyImageName;
- (id)deleteKeyImageName;
- (id)muttitapReverseKeyImageName;
- (id)multitapCompleteKeyImageName;
- (id)dictationKeyImageName;
- (id)globalEmojiKeyImageName;
- (id)globalKeyImageName;
- (struct CGPoint)ZWNJKeyOffset;
- (struct CGPoint)secondaryShiftKeyOffset;
- (struct CGPoint)shiftKeyOffset;
- (struct CGPoint)deleteKeyOffset;
- (struct CGPoint)moreABCKeyOffset;
- (struct CGPoint)more123KeyOffset;
- (struct CGPoint)dictationKeyOffset;
- (struct CGPoint)realEmojiKeyOffset;
- (struct CGPoint)internationalKeyOffset;
- (struct CGPoint)zhuyinFirstToneKeyOffset;
- (struct CGPoint)dismissKeyOffset;
- (struct CGPoint)undoKeyOffset;
- (struct CGPoint)boldKeyOffset;
- (struct CGPoint)pasteKeyOffset;
- (struct CGPoint)copyKeyOffset;
- (struct CGPoint)cutKeyOffset;
- (struct CGPoint)rightArrowKeyOffset;
- (struct CGPoint)leftArrowKeyOffset;
- (struct CGPoint)returnKeyOffset;
- (struct CGPoint)stringKeyOffset;
- (double)zhuyinFirstToneKeyFontSize;
- (double)moreABCKeyFontSize;
- (double)moreKeyFontSize;
- (double)assistKeyFontSize;
- (double)returnKeyFontSize;
- (double)hintNoneKeyFontSize;
- (double)shiftKeyFontSize;
- (double)deleteKeyFontSize;
- (double)stringKeyFontSize;
- (long long)lightHighQualityEnabledBlendForm;

@end

