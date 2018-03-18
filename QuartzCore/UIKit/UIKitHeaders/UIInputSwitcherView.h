//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIKeyboardMenuView.h>

@class NSArray, NSMutableArray, UIInputSwitcherGestureState;

__attribute__((visibility("hidden")))
@interface UIInputSwitcherView : UIKeyboardMenuView
{
    NSMutableArray *m_inputModes;
    NSArray *m_inputSwitcherItems;
    _Bool m_isForDictation;
    _Bool m_didTypeWithinDisplayTimer;
    UIInputSwitcherGestureState *m_gestureState;
    _Bool _messagesWriteboardFromSwitcher;
    _Bool _fileReportFromSwitcher;
    _Bool _showsSwitches;
}

+ (id)activeInstance;
+ (id)sharedInstance;
@property(nonatomic) _Bool showsSwitches; // @synthesize showsSwitches=_showsSwitches;
@property(nonatomic) _Bool fileReportFromSwitcher; // @synthesize fileReportFromSwitcher=_fileReportFromSwitcher;
@property(nonatomic) _Bool messagesWriteboardFromSwitcher; // @synthesize messagesWriteboardFromSwitcher=_messagesWriteboardFromSwitcher;
@property(readonly, nonatomic) NSArray *inputModes; // @synthesize inputModes=m_inputModes;
- (void)buttonPressed:(id)arg1 withEvent:(id)arg2 location:(struct CGPoint)arg3 isForDictation:(_Bool)arg4 tapAction:(CDUnknownBlockType)arg5;
- (_Bool)didHitDockItemWithinTypingWindow;
- (_Bool)_isHandBiasSwitchVisible;
- (void)switchAction;
- (void)customizeCell:(id)arg1 forItemAtIndex:(unsigned long long)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (id)subtitleFontForItemAtIndex:(unsigned long long)arg1;
- (id)subtitleForItemAtIndex:(unsigned long long)arg1;
- (id)fontForItemAtIndex:(unsigned long long)arg1;
- (id)localizedTitleForItemAtIndex:(unsigned long long)arg1;
- (id)titleForItemAtIndex:(unsigned long long)arg1;
- (unsigned long long)defaultSelectedIndex;
- (id)defaultInputMode;
- (id)_itemWithIdentifier:(id)arg1;
- (struct CGSize)preferredSize;
- (unsigned long long)numberOfItems;
- (void)willFadeForSelectionAtIndex:(unsigned long long)arg1;
- (void)willFade;
- (void)willShow;
- (_Bool)shouldShow;
- (void)showAsPopupForKey:(id)arg1 inLayout:(id)arg2;
- (void)selectPreviousInputMode;
- (id)previousInputMode;
- (void)selectNextInputMode;
- (id)nextInputMode;
- (void)didSelectItemAtIndex:(unsigned long long)arg1;
- (_Bool)shouldSelectItemAtIndex:(unsigned long long)arg1;
- (void)updateSelectionWithPoint:(struct CGPoint)arg1;
- (void)_segmentControlValueDidChange:(id)arg1;
- (void)selectInputMode:(id)arg1;
- (void)setInputMode:(id)arg1;
- (void)selectRowForInputMode:(id)arg1;
- (long long)_indexOfInputSwitcherItemWithIdentifier:(id)arg1;
- (_Bool)shouldShowSelectionExtraViewForIndexPath:(id)arg1;
- (id)selectedInputMode;
- (void)_reloadInputSwitcherItems;
- (void)reloadInputModes;
- (void)dealloc;
- (id)initWithFrame:(struct CGRect)arg1;

@end

