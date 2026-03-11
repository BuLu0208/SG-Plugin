#import <UIKit/UIKit.h>

// 1. 核心权限绕过：直接 Hook 消息权限属性
%hook _TtC10Postbox7Message
- (bool)isCopyingRestricted {
    // 强制让所有消息都显示为“不受限”
    return NO;
}
%end

// 2. 频道/群组全局限制绕过
%hook _TtC10Postbox12PeerMessages
- (bool)isCopyingRestricted {
    return NO;
}
%end

// 3. 针对 SwiftGram 菜单项逻辑的 Hook
// 强制让 UI 层认为可以执行保存操作
%hook _TtC11SwiftGramCore15SwiftGramConfig
- (bool)allowSavingRestrictedMedia { return YES; }
- (bool)allowCapturingScreenshots { return YES; }
%end

// 4. 暴力开启长按菜单里的“保存”选项
%hook UIAction
- (NSString *)title {
    NSString *origTitle = %orig;
    // 调试代码：如果是因为权限被隐藏，这里可以尝试强制回调
    return origTitle;
}
%end

// 强制修改 Telegram 底层对“禁止转发”频道的判断逻辑
%hook _TtC10Postbox14CachedPeerData
- (bool)isCopyingRestricted {
    return NO;
}
%end
