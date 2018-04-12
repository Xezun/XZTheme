//
//  XZThemeState.h
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import <UIKit/UIKit.h>

#ifdef XZKIT_FRAMEWORK
#import <XZKit/XZThemeDefines.h>
#else
#import "XZThemeDefines.h"
#endif

UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateNormal;
UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateSelected;
UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateHighlighted;
UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateDisabled;
UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateFocused;

