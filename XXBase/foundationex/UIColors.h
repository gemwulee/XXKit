//
//  UIColors.h
//  VideoEditor
//
//  Created by ai.chuyue on 15/5/18.
//  Copyright (c) 2015年 VideoEditor. All rights reserved.
//

#ifndef VideoEditor_UIColors_h
#define VideoEditor_UIColors_h

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue, a) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:a]

#define STYLE_HEAD_COLOR_BG UIColorFromRGB(0x2C3E50)
#define STYLE_HEAD_COLOR_BG_A UIColorFromRGB(0x358AC5)//顶部导航背景色
#define SELECTED_INDEX_COLOR UIColorFromRGB(0x2976BC)//选择标号的底色
#define TO_HD_PROGRESS_COLOR UIColorFromRGBA(0x000000,0.6)//下载高清的进度背景色
#define VIDEO_EMPTY_TEXT_COLOR UIColorFromRGB(0x000000)//library空界面的文字颜色
#define VIDEO_EMPTY_TEXT_GRAY_COLOR UIColorFromRGB(0x4B4B4B)//library空界面的灰色文字颜色

#define TAB_TEXT_COLOR UIColorFromRGBA(0x000000,0.4)//底部TAB默认文字颜色
#define TAB_TEXT_SELECTED_COLOR UIColorFromRGB(0x358AC5)//底部TAB选中时文字颜色
#define TAB_BACKGROUND_COLOR UIColorFromRGB(0xF7F7F7)//底部TAB背景色
#define TAB_BORDER_COLOR UIColorFromRGBA(0x000000,0.1)//底部TAB背景色
#define CACHE_LINE_COLOR UIColorFromRGB(0xDCDCDC)



#define MAIN_COLOR  [UIColor blackColor]
#define MAIN_HEADER_COLOR  UIColorFromRGB(0xFFFFFF)//通常情况下的导航标题色
#define MAIN_HEADER_COLOR_A  UIColorFromRGBA(0xFFFFFF,0.4)//未选中时的导航标题色

#define MAIN_BLUE_COLOR UIColorFromRGB(0x358AC5)
#define MAIN_SEPARATOR_LINE_COLOR UIColorFromRGB(0xE6E6E6)
//TEXT
#define WHITE_TEXT_COLOR UIColorFromRGB(0xFFFFFF)
#define WHITE_TEXT_COLOR_A UIColorFromRGBA(0xFFFFFF,0.4)
#define BLACK_TEXT_COLOR UIColorFromRGB(0x111111)
#define BLACK_TEXT_COLOR_A UIColorFromRGBA(0x111111,0.4)

#define TEXT_LINK_COLOR UIColorFromRGB(0x358AC5) //链接文本颜色

#define GRAY_TEXT_COLOR UIColorFromRGBA(0xFFFFFF,0.3)
#define LIGHT_GRAY_TEXT_COLOR UIColorFromRGBA(0x000000,0.8)
#define LIGHT_TEXT_SHADOW_COLOR UIColorFromRGBA(0x000000,0.8)
#define RED_TEXT_COLOR UIColorFromRGB(0xFF0000)//for test
#define LIBRARY_TIME_COLOR UIColorFromRGB(0xD2D2D2)

//BUTTON
#define BUTTON_BORDER_COLOR UIColorFromRGB(0x358AC5) //描边按钮
#define BUTTON_CONTENT_COLOR UIColorFromRGB(0x358AC5) //白底按钮文字
#define BUTTON_FILL_COLOR UIColorFromRGB(0x358AC5) //填充按钮
#define BUTTON_HIGHLIGHT_FILL_COLOR UIColorFromRGB(0x358AC5) //highlight填充按钮
#define BUTTON_FILL_COLOR_A UIColorFromRGBA(0x358AC5,0.6) //填充按钮

#define BUTTON_FILL_GRAY_COLOR UIColorFromRGB(0x767676) //灰色填充按钮
#define BUTTON_FILL_DarkBlue UIColorFromRGB(0x33447D) //深蓝色填充按钮

#define SLIDER_CELL_SEPARATOR_COLOR UIColorFromRGB(0x38444B) // 视频编辑操作条切换栏分割线颜色
#define SLIDER_CELL_BG_COLOR UIColorFromRGB(0xF8E71C)   // 视频编辑操作条切换栏背景颜色
#define SLIDER_BUTTON_BLACK_COLOR UIColorFromRGB(0x1E2225) //视频编辑操作条切换栏颜色
#define BUTTON_YELLOW_COLOR UIColorFromRGB(0xF8E81C)
#define MODIYCELL_M_COLOR UIColorFromRGB(0xF8E81C)//选择片段后底部操作背景色

#define TIMESLIDER_BG_COLOR UIColorFromRGB(0x1A1A1A)
#define HEADEREDIT_BG_COLOR UIColorFromRGB(0x222222)
#define EDIT_BOTTON_BG_COLOR UIColorFromRGB(0x333333)//编辑界下半部分的颜色

#define TABLEVIEW_SEPARATOR_COLOR UIColorFromRGB(0xE0E0E0)
#define YELLOW_BUTTON_COLOR UIColorFromRGB(0xF8E71C) //黄色按钮颜色
#define VE_CLIP_BOTTOMBAR_DISABLE_ALPHA (0.3) //disable 时的透明度
#define VE_CLIP_HELP_LABEL_COLOR UIColorFromRGB(0xFF0000) //帮助文字颜色
#define VE_CURRENT_MARK_RED UIColorFromRGB(0xD0021B) //当前时间的红色

#define COLLEGE_CONTENT_TEXT_COLOR UIColorFromRGB(0x9B9B9B) //
#define COLLEGE_NEED_DOWNLOAD_BG UIColorFromRGBA(0x6F6F6F, 0.9)
#define COLLEGE_CONTENT_TITLE_COLOR UIColorFromRGB(0x4A4A4A)
#define COLLEGE_VIDEO_PLACEHOLDER_COLOR UIColorFromRGB(0xF4F4F4)

#define LIBRARY_EDIT_TAB_BTN_COLOR UIColorFromRGB(0x38444B) //编辑器底部tab栏侧边按钮（静音、模板下载）

//未知颜色
#define MAIN_BUTTON_COLOR  [UIColor whiteColor]
#define MAIN_BUTTON_DISABLE_COLOR  UIColorFromRGB(0x435865)

#define TRANSPARENT_COLOR  [UIColor colorWithWhite:0 alpha:0]


#endif