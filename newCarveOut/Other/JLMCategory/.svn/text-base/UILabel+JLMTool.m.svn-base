//
//  UILabel+jlmAttributed.m
//  CrowdFunding
//
//  Created by yangshuai on 2017/7/21.
//  Copyright © 2017年 lxl. All rights reserved.
//

#import "UILabel+JLMTool.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>
@implementation JLMAttributeModel

@end
@implementation UILabel (JLMTool)
/**
 *  字间距
 *
 *  @return 字间距
 */
- (CGFloat)wordSpace
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
- (void)setWordSpace:(CGFloat)wordSpace
{
    objc_setAssociatedObject(self, @selector(wordSpace), @(wordSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  行间距
 *
 *  @return 行间距
 */
- (CGFloat)lineSpace
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
- (void)setLineSpace:(CGFloat)lineSpace
{
    objc_setAssociatedObject(self, @selector(lineSpace), @(lineSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  特殊字
 *
 *  @return 特殊字
 */
- (NSString *)specialWord
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSpecialWord:(NSString *)specialWord
{
    objc_setAssociatedObject(self, @selector(specialWord), specialWord, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)specialWordColor
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSpecialWordColor:(UIColor *)specialWordColor
{
    objc_setAssociatedObject(self, @selector(specialWordColor), specialWordColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)specialWordFont
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSpecialWordFont:(UIFont *)specialWordFont
{
    objc_setAssociatedObject(self, @selector(specialWordFont), specialWordFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)underlineWord
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setUnderlineWord:(NSString *)underlineWord
{
    objc_setAssociatedObject(self, @selector(underlineWord), underlineWord, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)underlineWordColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setUnderlineWordColor:(UIColor *)underlineWordColor
{
    objc_setAssociatedObject(self, @selector(underlineWordColor), underlineWordColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)getHeightForWidth:(CGFloat)width
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, self.text.length)];
    
    //字间距
    if (self.wordSpace > 0) {
        long number = self.wordSpace;
        CFNumberRef numberRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
        [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)numberRef range:NSMakeRange(0, self.text.length)];
        CFRelease(numberRef);
    }
    
    //行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    if (self.lineSpace > 0) {
        [paragraphStyle setLineSpacing:self.lineSpace];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    }
    
    //特殊字啊
    if (self.specialWord) {
        NSRange range = [self.text rangeOfString:self.specialWord];
        if (self.specialWordFont) {
            [attributedString addAttribute:NSFontAttributeName value:self.specialWordFont range:range];
        }
        if (self.specialWordColor) {
            [attributedString addAttribute:NSForegroundColorAttributeName value:self.specialWordColor range:range];
        }
    }
    
    //下划线
    if (self.underlineWord) {
        NSRange range = [self.text rangeOfString:self.underlineWord];
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
        if (self.underlineWordColor) {
            
            [attributedString addAttribute:NSUnderlineColorAttributeName value:self.underlineWordColor range:range];
        }
    }
    
    self.attributedText = attributedString;
    
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    CGFloat height = ceil(rect.size.height);
    return height;
}
#pragma mark - AssociatedObjects

- (NSMutableArray *)attributeStrings
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAttributeStrings:(NSMutableArray *)attributeStrings
{
    objc_setAssociatedObject(self, @selector(attributeStrings), attributeStrings, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)effectDic
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEffectDic:(NSMutableDictionary *)effectDic
{
    objc_setAssociatedObject(self, @selector(effectDic), effectDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isTapAction
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsTapAction:(BOOL)isTapAction
{
    objc_setAssociatedObject(self, @selector(isTapAction), @(isTapAction), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(NSString *, NSRange, NSInteger))tapBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTapBlock:(void (^)(NSString *, NSRange, NSInteger))tapBlock
{
    objc_setAssociatedObject(self, @selector(tapBlock), tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id<JLMAttributeTapActionDelegate>)delegate
{
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)enabledTapEffect
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setEnabledTapEffect:(BOOL)enabledTapEffect
{
    objc_setAssociatedObject(self, @selector(enabledTapEffect), @(enabledTapEffect), OBJC_ASSOCIATION_ASSIGN);
    self.isTapEffect = enabledTapEffect;
}

- (BOOL)isTapEffect
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsTapEffect:(BOOL)isTapEffect
{
    objc_setAssociatedObject(self, @selector(isTapEffect), @(isTapEffect), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setDelegate:(id<JLMAttributeTapActionDelegate>)delegate
{
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - mainFunction
- (void)jlm_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick
{
    [self jlm_getRangesWithStrings:strings];
    
    if (self.tapBlock != tapClick) {
        self.tapBlock = tapClick;
    }
}

- (void)jlm_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                    delegate:(id <JLMAttributeTapActionDelegate> )delegate
{
    [self jlm_getRangesWithStrings:strings];
    
    if (self.delegate != delegate) {
        self.delegate = delegate;
    }
}

#pragma mark - touchAction
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.isTapAction) {
        return;
    }
    
    if (objc_getAssociatedObject(self, @selector(enabledTapEffect))) {
        self.isTapEffect = self.enabledTapEffect;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    __weak typeof(self) weakSelf = self;
    
    [self jlm_getTapFrameWithTouchPoint:point result:^(NSString *string, NSRange range, NSInteger index) {
        
        if (weakSelf.tapBlock) {
            weakSelf.tapBlock (string , range , index);
        }
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(jlm_attributeTapReturnString:range:index:)]) {
            [weakSelf.delegate jlm_attributeTapReturnString:string range:range index:index];
        }
        
        if (self.isTapEffect) {
            
            [self jlm_saveEffectDicWithRange:range];
            
            [self jlm_tapEffectWithStatus:YES];
        }
        
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isTapAction) {
        if ([self jlm_getTapFrameWithTouchPoint:point result:nil]) {
            return self;
        }
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - getTapFrame
- (BOOL)jlm_getTapFrameWithTouchPoint:(CGPoint)point result:(void (^) (NSString *string , NSRange range , NSInteger index))resultBlock
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    
    CGMutablePathRef Path = CGPathCreateMutable();
    
    CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    CFRange range = CTFrameGetVisibleStringRange(frame);
    
    if (self.attributedText.length > range.length) {
        
        UIFont *font ;
        
        if ([self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil]) {
            
            font = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil];
            
        }else if (self.font){
            font = self.font;
            
        }else {
            font = [UIFont systemFontOfSize:17];
        }
        
        CGPathRelease(Path);
        
        Path = CGPathCreateMutable();
        
        CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font.lineHeight));
        
        frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    if (!lines) {
        CFRelease(frame);
        CFRelease(framesetter);
        CGPathRelease(Path);
        return NO;
    }
    
    CFIndex count = CFArrayGetCount(lines);
    
    CGPoint origins[count];
    
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    CGAffineTransform transform = [self jlm_transformForCoreText];
    
    CGFloat verticalOffset = 0;
    
    for (CFIndex i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        
        CGRect flippedRect = [self jlm_getLineBounds:line point:linePoint];
        
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        rect = CGRectInset(rect, 0, 0);
        
        rect = CGRectOffset(rect, 0, verticalOffset);
        
        NSParagraphStyle *style = [self.attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
        
        CGFloat lineSpace;
        
        if (style) {
            lineSpace = style.lineSpacing;
        }else {
            lineSpace = 0;
        }
        
        CGFloat lineOutSpace = (self.bounds.size.height - lineSpace * (count - 1) -rect.size.height * count) / 2;
        
        rect.origin.y = lineOutSpace + rect.size.height * i + lineSpace * i;
        
        if (CGRectContainsPoint(rect, point)) {
            
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            
            CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
            
            CGFloat offset;
            
            CTLineGetOffsetForStringIndex(line, index, &offset);
            
            if (offset > relativePoint.x) {
                index = index - 1;
            }
            
            NSInteger link_count = self.attributeStrings.count;
            
            for (int j = 0; j < link_count; j++) {
                
                JLMAttributeModel *model = self.attributeStrings[j];
                
                NSRange link_range = model.range;
                if (NSLocationInRange(index, link_range)) {
                    if (resultBlock) {
                        resultBlock (model.str , model.range , (NSInteger)j);
                    }
                    CFRelease(frame);
                    CFRelease(framesetter);
                    CGPathRelease(Path);
                    return YES;
                }
            }
        }
    }
    CFRelease(frame);
    CFRelease(framesetter);
    CGPathRelease(Path);
    return NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isTapEffect) {
        
        [self performSelectorOnMainThread:@selector(jlm_tapEffectWithStatus:) withObject:nil waitUntilDone:NO];
        
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isTapEffect) {
        
        [self performSelectorOnMainThread:@selector(jlm_tapEffectWithStatus:) withObject:nil waitUntilDone:NO];
        
    }
}

- (CGAffineTransform)jlm_transformForCoreText
{
    return CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
}

- (CGRect)jlm_getLineBounds:(CTLineRef)line point:(CGPoint)point
{
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + fabs(descent) + leading;
    
    return CGRectMake(point.x, point.y , width, height);
}

#pragma mark - tapEffect
- (void)jlm_tapEffectWithStatus:(BOOL)status
{
    if (self.isTapEffect) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        NSMutableAttributedString *subAtt = [[NSMutableAttributedString alloc] initWithAttributedString:[[self.effectDic allValues] firstObject]];
        
        NSRange range = NSRangeFromString([[self.effectDic allKeys] firstObject]);
        
        if (status) {
            [subAtt addAttribute:NSBackgroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, subAtt.string.length)];
            
            [attStr replaceCharactersInRange:range withAttributedString:subAtt];
        }else {
            
            [attStr replaceCharactersInRange:range withAttributedString:subAtt];
        }
        self.attributedText = attStr;
    }
}

- (void)jlm_saveEffectDicWithRange:(NSRange)range
{
    self.effectDic = [NSMutableDictionary dictionary];
    
    NSAttributedString *subAttribute = [self.attributedText attributedSubstringFromRange:range];
    
    [self.effectDic setObject:subAttribute forKey:NSStringFromRange(range)];
}

#pragma mark - getRange
- (void)jlm_getRangesWithStrings:(NSArray <NSString *>  *)strings
{
    if (self.attributedText == nil) {
        self.isTapAction = NO;
        return;
    }
    
    self.isTapAction = YES;
    
    self.isTapEffect = YES;
    
    __block  NSString *totalStr = self.attributedText.string;
    
    self.attributeStrings = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    
    [strings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSRange range = [totalStr rangeOfString:obj];
        
        if (range.length != 0) {
            
            totalStr = [totalStr stringByReplacingCharactersInRange:range withString:[weakSelf jlm_getStringWithRange:range]];
            JLMAttributeModel *model = [JLMAttributeModel new];
            model.range = range;
            model.str = obj;
            [weakSelf.attributeStrings addObject:model];
        }
    }];
}

- (NSString *)jlm_getStringWithRange:(NSRange)range
{
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < range.length ; i++) {
        
        [string appendString:@" "];
    }
    return string;
}
//添加中划线
- (void)jlm_labelAddCenterLineWith:(NSString*)string{
    NSDictionary *dic = @{NSStrikethroughStyleAttributeName:
                              [NSNumber numberWithInteger:NSUnderlineStyleSingle],
                          NSFontAttributeName:kFont(12),
                          NSForegroundColorAttributeName:kColor(152, 152, 152)
                          };
    NSMutableAttributedString *oldPriceAtt = [[NSMutableAttributedString alloc] initWithString:string attributes:dic];
    self.attributedText = oldPriceAtt;
    
}
//添加AttributedString
- (void)jlm_labelAddAttributedString:(NSString*)string withRangeString:(NSString*)rangeString{
    NSRange range = [string rangeOfString:rangeString];//匹配得到的下标
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:kSubtitleColor range:NSMakeRange(0,range.location)];
    [str addAttribute:NSForegroundColorAttributeName value:kTitleColor range:NSMakeRange(range.location,string.length-range.location)];
    
    [str addAttribute:NSFontAttributeName value:kFont(12) range:NSMakeRange(0,range.location)];
    [str addAttribute:NSFontAttributeName value:kFont(14) range:NSMakeRange(range.location,string.length-range.location)];
    self.attributedText = str;
}
-(CGFloat)getSpaceLabelHeight:(NSString *)str withWidh:(CGFloat)width withFontSize:(CGFloat)font{
    NSMutableParagraphStyle *paragphStyle=[[NSMutableParagraphStyle alloc]init];
    paragphStyle.lineSpacing=5;//设置行距为0
    paragphStyle.firstLineHeadIndent=0.0;
    paragphStyle.hyphenationFactor=0.0;
    paragphStyle.paragraphSpacingBefore=0.0;
    NSDictionary *dic=@{
                        NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paragphStyle, NSKernAttributeName:@1.0f
                        
                        };
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
    
}
@end
