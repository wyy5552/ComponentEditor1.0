package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	/**
	 * @author zhangxueyou
	 * 创建时间：2015-9-28
	 * 
	 */
	public class NoticeSkin
	{
		/**
		 * 提示一号区关闭按钮
		 */		
		public static var NOTICEAREA_CLOSEBTN_UP:BitmapData;//关闭按钮UP状态
		public static var NOTICEAREA_CLOSEBTN_DOWN:BitmapData;//关闭按钮DOWN状态
		public static var NOTICEAREABG:BitmapData;//背景
		/**
		 * 提示三号区域 
		 */		
		public static var NOTIAREA3BTNDOWN:BitmapData;//按钮down状态
		public static var NOTIAREA3BTNOVER:BitmapData;//按钮over状态
		public static var NOTIAREA3BTNUP:BitmapData;//按钮up状态
		public static var NOTIAREA3MAIL:BitmapData;//邮件信封图标
		public static var NOTIAREA3MAILCOUNT:BitmapData;//邮件数据底
		public static var NOTIAREA3FATE:BitmapData;//命途
		public static var NOTIAREA3CHAT:BitmapData;//私聊
		public static var NOTIAREA3FRIEND:BitmapData;//好友
		public static var NOTIAREA3SEEKDEVICE:BitmapData;//探灵
		public static var NOTIAREA3CONVOYBATTLE:BitmapData;//护送战斗
		public static var NOTIAREA3CONVOYRESULT:BitmapData;//护送结果
		public static var NOTIAREA3MAMMONPOOL:BitmapData;//招财神符
		public static var NOTIAREA3SUPLLY:BitmapData;//酒足饭饱
		public static var ACTIVITYHINTBG:BitmapData;//限时活动底
		public static var NOTIAREA3FLOWER:BitmapData;//送花
		public static var NOTIAREA3GUILDVS:BitmapData;//领地攻防战
		public static var NOTIAREA3SKYLADDER:BitmapData;//比武场通知
		public static var NOTIAREA3ALERT:BitmapData;//警告通知
		public static var NOTIAREA3REDBAG:BitmapData;//红包通知
		
		public function NoticeSkin()
		{
		}
		
			
		public static var EQUIPED:BitmapData;
		
		public static function init(res:MovieClip):void
		{
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			/*一号区域*/
			NOTICEAREA_CLOSEBTN_UP = global.getBD(domain,"noticeCloseBtnUp");
			NOTICEAREA_CLOSEBTN_DOWN = global.getBD(domain,"noticeCloseBtnDown");
			NOTICEAREABG = global.getBD(domain,"noticeBG");
			
			/*三号区域*/
			NOTIAREA3BTNDOWN = global.getBD(domain,"notiArea3BtnDown");
			NOTIAREA3BTNOVER = global.getBD(domain,"notiArea3BtnOver");
			NOTIAREA3BTNUP = global.getBD(domain,"notiArea3BtnUp");
			NOTIAREA3MAIL = global.getBD(domain,"notiArea3Mail");
			NOTIAREA3MAILCOUNT = global.getBD(domain,"notiArea3MailCount");
			NOTIAREA3FATE = global.getBD(domain,"notiArea3Fate");
			NOTIAREA3CHAT = global.getBD(domain,"notiArea3Chat");
			NOTIAREA3FRIEND = global.getBD(domain,"notiArea3Friend");
			NOTIAREA3SEEKDEVICE = global.getBD(domain,"notiArea3SeekDevice");
			NOTIAREA3CONVOYBATTLE = global.getBD(domain,"notiArea3ConvoyBattle");
			NOTIAREA3CONVOYRESULT = global.getBD(domain,"notiArea3ConvoyResult");
			NOTIAREA3MAMMONPOOL = global.getBD(domain,"notiArea3MammonPool");
			NOTIAREA3SUPLLY = global.getBD(domain,"notiArea3Suplly");
			ACTIVITYHINTBG = global.getBD(domain,"activityHintBG");
			NOTIAREA3FLOWER = global.getBD(domain,"notiArea3Flower");
			NOTIAREA3GUILDVS = global.getBD(domain,"notiArea3GuildVS");
			NOTIAREA3SKYLADDER = global.getBD(domain,"notiArea3SkyLadder");
			NOTIAREA3ALERT = global.getBD(domain,"notiArea3Alert");
			NOTIAREA3REDBAG = global.getBD(domain,"notiArea3RedBag");
		}
	}
}
