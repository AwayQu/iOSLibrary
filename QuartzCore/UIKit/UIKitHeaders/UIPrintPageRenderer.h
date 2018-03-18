//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSArray, NSMutableArray;

@interface UIPrintPageRenderer : NSObject
{
    double _headerHeight;
    double _footerHeight;
    struct CGRect _paperRect;
    struct CGRect _printableRect;
    NSMutableArray *_printFormatters;
    struct CGContext *_printContext;
    long long _cachedPageCount;
}

@property(copy, nonatomic) NSArray *printFormatters; // @synthesize printFormatters=_printFormatters;
@property(nonatomic) struct CGRect printableRect; // @synthesize printableRect=_printableRect;
@property(nonatomic) struct CGRect paperRect; // @synthesize paperRect=_paperRect;
@property(nonatomic) double footerHeight; // @synthesize footerHeight=_footerHeight;
@property(nonatomic) double headerHeight; // @synthesize headerHeight=_headerHeight;
- (void).cxx_destruct;
- (void)_endPrintContext:(id)arg1 success:(_Bool)arg2;
- (void)_drawPage:(long long)arg1;
- (void)_endSaveContext;
- (void)_startSaveContext:(struct CGContext *)arg1;
- (_Bool)_startPrintContext:(id)arg1 printSettings:(id)arg2;
- (void)drawFooterForPageAtIndex:(long long)arg1 inRect:(struct CGRect)arg2;
- (void)drawContentForPageAtIndex:(long long)arg1 inRect:(struct CGRect)arg2;
- (void)drawHeaderForPageAtIndex:(long long)arg1 inRect:(struct CGRect)arg2;
- (void)drawPrintFormatter:(id)arg1 forPageAtIndex:(long long)arg2;
- (void)drawPageAtIndex:(long long)arg1 inRect:(struct CGRect)arg2;
- (void)prepareForDrawingPages:(struct _NSRange)arg1;
@property(readonly, nonatomic) long long numberOfPages;
- (long long)_numberOfPages;
- (_Bool)_numberOfPagesIsCached;
- (long long)_maxFormatterPage;
- (void)_removePrintFormatter:(id)arg1;
- (id)printFormattersForPageAtIndex:(long long)arg1;
- (void)addPrintFormatter:(id)arg1 startingAtPageAtIndex:(long long)arg2;
- (void)dealloc;

@end

