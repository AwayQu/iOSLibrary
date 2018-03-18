//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIView.h>

#import "NSCoding.h"
#import "UIScrollViewDelegate.h"
#import "WebPolicyDelegate.h"

@class NSString, NSURLRequest, UIScrollView, UIWebViewInternal;

@interface UIWebView : UIView <WebPolicyDelegate, NSCoding, UIScrollViewDelegate>
{
    UIWebViewInternal *_internal;
}

+ (void)_updatePersistentStoragePaths;
+ (void)_fixPathsForSandboxDirectoryChange;
+ (id)_relativePathFromAbsolutePath:(id)arg1 removingPathComponents:(unsigned long long)arg2;
+ (void)initialize;
- (void)_addShortcut:(id)arg1;
- (void)_share:(id)arg1;
- (void)_define:(id)arg1;
- (void)selectAll:(id)arg1;
- (void)select:(id)arg1;
- (void)copy:(id)arg1;
- (_Bool)canPerformAction:(SEL)arg1 withSender:(id)arg2;
- (id)_networkInterfaceName;
- (void)_setNetworkInterfaceName:(id)arg1;
- (_Bool)_allowsPictureInPictureVideo;
- (void)_setAllowsPictureInPictureVideo:(_Bool)arg1;
- (unsigned long long)_audioSessionCategoryOverride;
- (void)_setAudioSessionCategoryOverride:(unsigned long long)arg1;
- (_Bool)_alwaysDispatchesScrollEvents;
- (void)_setAlwaysDispatchesScrollEvents:(_Bool)arg1;
- (_Bool)_alwaysConstrainsScale;
- (void)_setAlwaysConstrainsScale:(_Bool)arg1;
@property(readonly, nonatomic) unsigned long long pageCount;
- (unsigned long long)_pageCount;
@property(nonatomic) double gapBetweenPages;
- (void)_setGapBetweenPages:(double)arg1;
- (double)_gapBetweenPages;
@property(nonatomic) double pageLength;
- (void)_setPageLength:(double)arg1;
- (double)_pageLength;
@property(nonatomic) long long paginationBreakingMode;
- (void)_setPaginationBehavesLikeColumns:(_Bool)arg1;
- (_Bool)_paginationBehavesLikeColumns;
@property(nonatomic) long long paginationMode;
- (void)_setPaginationMode:(long long)arg1;
- (long long)_paginationMode;
- (void)_setDrawInWebThread:(_Bool)arg1;
- (void)_setWebSelectionEnabled:(_Bool)arg1;
- (void)_setDrawsCheckeredPattern:(_Bool)arg1;
- (void)_setOverridesOrientationChangeEventHandling:(_Bool)arg1;
- (id)_pdfViewHandler;
- (id)_scrollView;
- (id)_documentView;
- (id)_browserView;
- (id)_initWithWebView:(id)arg1;
- (struct CGImage *)newSnapshotWithRect:(struct CGRect)arg1;
- (struct CGImage *)createSnapshotWithRect:(struct CGRect)arg1;
- (void)webView:(id)arg1 didChangeLocationWithinPageForFrame:(id)arg2;
- (_Bool)webView:(id)arg1 resource:(id)arg2 canAuthenticateAgainstProtectionSpace:(id)arg3 forDataSource:(id)arg4;
- (void)webView:(id)arg1 resource:(id)arg2 didCancelAuthenticationChallenge:(id)arg3 fromDataSource:(id)arg4;
- (void)webView:(id)arg1 resource:(id)arg2 didReceiveAuthenticationChallenge:(id)arg3 fromDataSource:(id)arg4;
- (void)webView:(id)arg1 resource:(id)arg2 didFailLoadingWithError:(id)arg3 fromDataSource:(id)arg4;
- (void)webView:(id)arg1 resource:(id)arg2 didFinishLoadingFromDataSource:(id)arg3;
- (id)webView:(id)arg1 identifierForInitialRequest:(id)arg2 fromDataSource:(id)arg3;
- (void)webView:(id)arg1 decidePolicyForGeolocationRequestFromOrigin:(id)arg2 frame:(id)arg3 listener:(id)arg4;
- (id)webView:(id)arg1 runJavaScriptTextInputPanelWithPrompt:(id)arg2 defaultText:(id)arg3 initiatedByFrame:(id)arg4;
- (_Bool)webView:(id)arg1 runJavaScriptConfirmPanelWithMessage:(id)arg2 initiatedByFrame:(id)arg3;
- (void)webView:(id)arg1 runJavaScriptAlertPanelWithMessage:(id)arg2 initiatedByFrame:(id)arg3;
- (id)_makeAlertView;
- (void)webViewClose:(id)arg1;
- (void)alertView:(id)arg1 didDismissWithButtonIndex:(long long)arg2;
- (void)webView:(id)arg1 didFirstLayoutInFrame:(id)arg2;
- (void)webView:(id)arg1 didFailLoadWithError:(id)arg2 forFrame:(id)arg3;
- (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2;
- (void)webView:(id)arg1 didFailProvisionalLoadWithError:(id)arg2 forFrame:(id)arg3;
- (void)webView:(id)arg1 didReceiveServerRedirectForProvisionalLoadForFrame:(id)arg2;
- (void)webView:(id)arg1 didClearWindowObject:(id)arg2 forFrame:(id)arg3;
- (id)webThreadWebView:(id)arg1 resource:(id)arg2 willSendRequest:(id)arg3 redirectResponse:(id)arg4 fromDataSource:(id)arg5;
- (id)webView:(id)arg1 connectionPropertiesForResource:(id)arg2 dataSource:(id)arg3;
- (void)webView:(id)arg1 didReceiveTitle:(id)arg2 forFrame:(id)arg3;
- (void)webView:(id)arg1 didCommitLoadForFrame:(id)arg2;
- (void)webView:(id)arg1 didStartProvisionalLoadForFrame:(id)arg2;
- (void)_updateRequest;
- (void)webViewSupportedOrientationsUpdated:(id)arg1;
- (void)webView:(id)arg1 printFrameView:(id)arg2;
- (void)webView:(id)arg1 exceededApplicationCacheOriginQuotaForSecurityOrigin:(id)arg2 totalSpaceNeeded:(unsigned long long)arg3;
- (void)webView:(id)arg1 frame:(id)arg2 exceededDatabaseQuotaForSecurityOrigin:(id)arg3 database:(id)arg4;
- (void)webView:(id)arg1 unableToImplementPolicyWithError:(id)arg2 frame:(id)arg3;
- (void)webView:(id)arg1 decidePolicyForMIMEType:(id)arg2 request:(id)arg3 frame:(id)arg4 decisionListener:(id)arg5;
- (void)webView:(id)arg1 decidePolicyForNavigationAction:(id)arg2 request:(id)arg3 frame:(id)arg4 decisionListener:(id)arg5;
- (void)webView:(id)arg1 decidePolicyForNewWindowAction:(id)arg2 request:(id)arg3 newFrameName:(id)arg4 decisionListener:(id)arg5;
- (void)_reportError:(id)arg1;
- (void)scrollViewDidChangeAdjustedContentInset:(id)arg1;
- (void)scrollViewDidScroll:(id)arg1;
- (void)scrollViewWasRemoved:(id)arg1;
- (void)scrollViewDidScrollToTop:(id)arg1;
- (void)scrollViewDidEndDecelerating:(id)arg1;
- (void)scrollViewDidEndDragging:(id)arg1 willDecelerate:(_Bool)arg2;
- (void)_didCompleteScrolling;
- (void)scrollViewWillBeginDragging:(id)arg1;
- (void)scrollViewDidEndZooming:(id)arg1 withView:(id)arg2 atScale:(double)arg3;
- (void)scrollViewDidZoom:(id)arg1;
- (void)scrollViewWillBeginZooming:(id)arg1 withView:(id)arg2;
- (id)viewForZoomingInScrollView:(id)arg1;
- (void)_webView:(id)arg1 didChangeAvoidsUnsafeArea:(_Bool)arg2;
- (void)restoreStateFromHistoryItem:(id)arg1 forWebView:(id)arg2;
- (void)saveStateToHistoryItem:(id)arg1 forWebView:(id)arg2;
- (void)webViewMainFrameDidFailLoad:(id)arg1 withError:(id)arg2;
- (void)webViewMainFrameDidFinishLoad:(id)arg1;
- (void)webViewMainFrameDidCommitLoad:(id)arg1;
- (void)webViewMainFrameDidFirstVisuallyNonEmptyLayoutInFrame:(id)arg1;
- (void)_setIsBlankBeforeFirstNonEmptyLayout:(_Bool)arg1;
- (void)_updateScrollerViewForInputView:(id)arg1;
- (void)view:(id)arg1 didSetFrame:(struct CGRect)arg2 oldFrame:(struct CGRect)arg3;
- (id)_webView:(id)arg1 presentationRectsForPreview:(id)arg2;
- (id)_webView:(id)arg1 presentationSnapshotForPreview:(id)arg2;
- (void)_webView:(id)arg1 commitPreview:(id)arg2;
- (void)_webView:(id)arg1 didDismissPreview:(id)arg2 committing:(_Bool)arg3;
- (void)_webView:(id)arg1 willPresentPreview:(id)arg2;
- (id)_webView:(id)arg1 previewViewControllerForURL:(id)arg2;
- (_Bool)_webView:(id)arg1 previewIsAllowedForPosition:(struct CGPoint)arg2;
- (_Bool)_appliesExclusiveTouchToSubviewTree;
- (void)setBackgroundColor:(id)arg1;
- (void)setOpaque:(_Bool)arg1;
- (void)_updateOpaqueAndBackgroundColor;
- (void)setBounds:(struct CGRect)arg1;
- (void)setFrame:(struct CGRect)arg1;
- (void)_frameOrBoundsChanged;
- (void)_rescaleDocument;
- (void)_finishRotation;
- (void)_beginRotation;
- (struct CGSize)sizeThatFits:(struct CGSize)arg1;
- (void)_updateCheckeredPattern;
@property(nonatomic) _Bool suppressesIncrementalRendering;
@property(readonly, nonatomic, getter=canGoForward) _Bool canGoForward;
@property(readonly, nonatomic, getter=canGoBack) _Bool canGoBack;
- (void)goForward;
- (void)goBack;
- (void)stopLoading;
- (void)reload;
@property(readonly, nonatomic) NSURLRequest *request;
- (void)loadData:(id)arg1 MIMEType:(id)arg2 textEncodingName:(id)arg3 baseURL:(id)arg4;
- (void)loadHTMLString:(id)arg1 baseURL:(id)arg2;
- (void)loadRequest:(id)arg1;
@property(readonly, nonatomic) UIScrollView *scrollView;
@property(nonatomic) id <UIWebViewDelegate> delegate;
@property(readonly, nonatomic, getter=isLoading) _Bool loading;
@property(nonatomic) _Bool scalesPageToFit;
@property(nonatomic) _Bool allowsLinkPreview;
@property(nonatomic) _Bool allowsPictureInPictureMediaPlayback;
@property(nonatomic) _Bool mediaPlaybackAllowsAirPlay;
@property(nonatomic) _Bool mediaPlaybackRequiresUserAction;
@property(nonatomic) _Bool allowsInlineMediaPlayback;
@property(nonatomic) unsigned long long dataDetectorTypes;
@property(nonatomic) _Bool detectsPhoneNumbers;
- (id)stringByEvaluatingJavaScriptFromString:(id)arg1;
- (void)dealloc;
- (void)encodeWithCoder:(id)arg1;
- (void)_populateArchivedSubviews:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)initWithFrame:(struct CGRect)arg1;
- (id)_initWithFrame:(struct CGRect)arg1 enableReachability:(_Bool)arg2;
- (void)_webViewCommonInitWithWebView:(id)arg1 scalesPageToFit:(_Bool)arg2;
- (void)_updateBrowserViewExposedScrollViewRect;
- (void)_updateScrollViewInsetAdjustmentBehavior;
- (void)_updateViewSettings;
- (void)_setRichTextReaderViewportSettings;
- (void)_setScalesPageToFitViewportSettings;
- (void)_didRotate:(id)arg1;
@property(nonatomic) _Bool keyboardDisplayRequiresUserAction;
- (void)decodeRestorableStateWithCoder:(id)arg1;
- (void)encodeRestorableStateWithCoder:(id)arg1;
- (_Bool)isElementAccessibilityExposedToInterfaceBuilder;
- (Class)_printFormatterClass;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

