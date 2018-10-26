//
//  JLMImagePicker.h
//  ImageClipTool
//
//  Created by 段乾磊 on 16/7/6.
//  Copyright © 2016年 LazyDuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ImagePickerType)
{
    ImagePickerCamera = 0,
    ImagePickerPhoto = 1
};
@class JLMImagePicker;
@protocol JLMImagePickerDelegate <NSObject>

- (void)imagePicker:(JLMImagePicker *)imagePicker didFinished:(UIImage *)editedImage;
- (void)imagePickerDidCancel:(JLMImagePicker *)imagePicker;
@end
@interface JLMImagePicker : NSObject
@property (nonatomic,strong) void (^imagePickerDidFinished)(UIImage * image);

+ (instancetype) sharedInstance;
- (void)showOriginalImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController allowsEditing:(BOOL)editing;

//选择原图片
- (void)showOriginalImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController;
//scale 裁剪框的高宽比 0~1.5 默认为1
- (void)showImagePickerWithType:(ImagePickerType)type InViewController:(UIViewController *)viewController Scale:(double)scale;
//代理
@property (nonatomic, assign) id<JLMImagePickerDelegate> delegate;
@end
