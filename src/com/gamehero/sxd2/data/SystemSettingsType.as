package com.gamehero.sxd2.data
{
	
	/**
	 * 系统设置枚举
	 * @author xuwenyi
	 * @create 2016-01-07
	 **/
	public class SystemSettingsType
	{
		// 固定的系统设置
		public static const ALL_SOUND:String = "ALL_SOUND";
		public static const MUSIC:String = "MUSIC";
		public static const SOUND:String = "SOUND";
		public static const SHOW_PLAYERS:String = "SHOW_PLAYERS";
		public static const CHANGE_LOG:String = "CHANGE_LOG";
		
		// 消费类提示
		public static const HERO_REBORN:int = 10001;// 伙伴重生
		public static const MAKE_EQUIP:int = 10101;//装备制作
		
		public static const BLACKMARKET_REFRESH:int = 20101;//鬼市刷新
		public static const BLACKMARKET_BUYITEM:int = 20102;//鬼市元宝购买商品
		public static const BLACKMARKET_TRADE_BUY:int = 20103;//黑市交易
		
		
		public static const HURDLE_CLEAROUT_WINDOW:int = 30101;//元宝扫荡
		public static const HURDLE_GOLD_RESERT:int = 30102;//副本界面，炼狱重置
		public static const SEEK_DEVICE : int = 30201;//探灵消耗
		public static const SEEK_DEVICE_REFRESH : int = 30202;//探灵刷新
		public static const MAMMON:int = 30301;// 招财神符元宝消耗
		public static const KILL_EVIL_STAR : int = 30401;//七星封魔
		public static const WORLD_BOSS_BUY_POWER:int = 30501;// 世界boss购买战斗力
		public static const ARENA_BUY_TICKET:int = 30601;// 竞技场门票购买
		public static const TAKE_CARD:int = 30701;// 寻仙
		public static const CONVOY_MESSENGER_GOLD:int = 30801;// 护送取经：元宝获取功德佛
		public static const CONVOY_ROB_CD_CLS:int = 30802;//护送取经：元宝清除抢劫cd
		public static const CONVOY_ROB_ADD:int = 30803;//护送取经：元宝购买抢劫次数
		public static const CONVOY_MESSENGER_REFRESH:int = 30804;//护送取经：消耗元宝刷新品质
		public static const SIX_DESTINES:int = 31101;//六道轮回
		
		public static const TILI:int = 40101;// 体力购买
		public static const EXP_ROOM_CD:int = 31002;// 练功房清除cd
		public static const EXP_ROOM_FIGTH:int = 31001;// 练功房购买挑战次数
		public static const HUNT_FATE:int = 30901;// 猎命元宝购买
		
		public static const WASH_EQUIP_AVTIVE:int = 10201;// 封灵激活
		public static const WASH_EQUIP_SINGLE:int = 10202;// 封灵洗练
		public static const WASH_EQUIP_BATCH:int = 10203;// 封灵批量洗练
		
		
		public static var SKY_LADDER_CLEAR_CD:int = 31201;//比武场清除cd
		public static var SKY_LADDER_BUY_COUNT:int = 31202;//比武场购买体力
		
		public static var ENDLESS_BUY_NUM:int = 31301;//无尽试炼挑战次数
		
		public static var SEND_REDBAG:int = 40201;//发送红包
		
		public static var GIFT_STORE:int = 31401;//礼品铺
		
		public static var VIPCARD_MONTH:int = 40301;//月卡
		public static var VIPCARD_FOREVER:int = 40302;//永久卡
	}
}