
//  JLMParam.h
//  JLMShop
//
//  Created by yangshuai on 2017/8/24.
//  Copyright © 2017年 daniel. All rights reserved.
//

#ifndef JLMParam_h
#define JLMParam_h

#define kToken       [JLMUserLoginModel account].token == nil?@"":[JLMUserLoginModel account].token //用户标识
#define kUserId      [JLMUserLoginModel account].userid  //用户id
//#define SERVER                           @"http://47.94.13.13/jlm-cli-api/"//服务
#define SERVER                           @"https://app.jilemept.com/cli/jlm-cli-api/"    //https地址
#define treatyServer                     @"http://admin.jilemept.com/jlm-biz-cms/"//协议地址
//#define KeepAlive                        @"39.105.22.221"//正式
#define KeepAlive                        @"47.94.13.13"//测试
#define kBuglyID                         @"29e6cbfcaa"
#define kBuglyKey                        @"94296f10-f647-4516-926e-ca35877145df"
#define kAMapKey                         @"fd3bf5a4-60c9-42f8-8a22-802523ecd13b"
#define USHARE_DEMO_APPKEY               @"5bd32906f1f55612fd00040c"
#define kChangePassSendSms               @"customer/sendSms"//修改密码发送验证码
#define KRegister                        @"customer/register" //注册
#define kLogin                           @"customer/login"//登录
#define kLoginFast                       @"customer/loginFast"//登录
#define kBinding                         @"customer/binding"//绑定
#define kCustomerCard                    @"customer/card"//我的会员卡

#define KTansfer                         @"customer/transfer"//设置交易密码
#define KFind                            @"customer/find"//获取客户积分
#define KChangePass                      @"customer/changePass" //忘记密码
#define Klogout                          @"customer/logout" //退出登录
#define KRevisePass                      @"customer/revisePass" //修改密码
#define KSetPass                         @"customer/setPass" //设置密码


#pragma mark ----- 首页接口

#define kConfirmPayment                  @"order/payment"   //确认支付
#define kSaveOrder                       @"order/saveOrder"        //首页扫码方式提交预订
#define kForgetTradePass                 @"customer/forgetTradePass" //修改支付密码
#define kSelectMerchantByRecommend       @"merchant/selectMerchantByRecommend"//扫码查询用户绑定信息
#define kBindPrivateCustomer             @"customer/bindPrivateCustomer"//确认绑定商铺
#pragma mark ----- 商城接口


#define kCommodityInfo(id)                [NSString stringWithFormat:@"%@%@?id=%@",SERVER,@"commodity/commodityInfo",id]   //商城商品详情页
#define kServceAdd(parameter)             [NSString stringWithFormat:@"%@%@",SERVER,parameter]
#define kSelectOrderList                 @"order/selectOrderList"//查询订单列表
#define kSelectOrderDetails @"order/selectOrderDetails"//查询订单详情
#define kOrderMyself @"order/myself"//查询订单详情
#define krefund @"order/refund"//申请退款



#define kCustomerl @"customer" //我的查看用户/页面首页
#define kCustomerNews @"customerNews" //我的消息列表
#define KRechargeRoles @"rechargeRoles"
#define kLoginDeal  [NSString stringWithFormat:@"%@html/agreement.html",treatyServer]//用户协议网页
#define kRechargeDeal  [NSString stringWithFormat:@"%@html/recharge.html",treatyServer]//用户协议网页
//app版本是否更新
#define kForcedUpdat  @"appVersion/forcedUpdat"

#endif /* JLMParam_h */
