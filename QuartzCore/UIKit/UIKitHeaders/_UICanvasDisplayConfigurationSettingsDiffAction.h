//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "_UICanvasSettingsDiffAction.h"

@class NSString, UIApplicationSceneSettingsDiffInspector;

__attribute__((visibility("hidden")))
@interface _UICanvasDisplayConfigurationSettingsDiffAction : NSObject <_UICanvasSettingsDiffAction>
{
    UIApplicationSceneSettingsDiffInspector *_sceneSettingsDisplayConfigurationDiffInspector;
}

@property(retain, nonatomic) UIApplicationSceneSettingsDiffInspector *sceneSettingsDisplayConfigurationDiffInspector; // @synthesize sceneSettingsDisplayConfigurationDiffInspector=_sceneSettingsDisplayConfigurationDiffInspector;
- (void).cxx_destruct;
- (void)performActionsForCanvas:(id)arg1 withUpdatedScene:(id)arg2 settingsDiff:(id)arg3 fromSettings:(id)arg4 transitionContext:(id)arg5;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

