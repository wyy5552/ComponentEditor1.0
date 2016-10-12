package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	
	/**
	 * 通用组件皮肤
	 * @author xuwenyi
	 * @create 2015-08-20
	 **/
	public class CommonSkin
	{
		
		private static var RESOURCE:MovieClip;
		
		// 窗口
		static public var windowInner1Bg:BitmapData;	// 窗口内背景
		static public var windowInner2Bg:BitmapData;	// 窗口内背景2
		static public var windowInner3Bg:BitmapData;	// 窗口内背景3
		static public var windowInner4Bg:BitmapData;	// 窗口内背景4
		
		static public var windowDeepBg:BitmapData;//2级深色
		
		// ScaleBitmap 九宫格
		static public var windowInner1BgScale9Grid:Rectangle = new Rectangle(115, 42, 1, 1);
		static public var windowInner2BgScale9Grid:Rectangle = new Rectangle(31, 31, 2, 2);
		static public var windowInner3BgScale9Grid:Rectangle = new Rectangle(31, 115, 2, 2);
		static public var windowInner4BgScale9Grid:Rectangle = new Rectangle(10, 16, 1, 1);
		static public var windowInner5BgScale9Grid:Rectangle = new Rectangle(14, 16, 1, 1);
		
		static public var windowDeepBgScale9Grid:Rectangle = new Rectangle(3, 3, 2, 2);
		
		
		// 蓝色按钮们
		static public var blueButton1Down:BitmapData;
		static public var blueButton1Over:BitmapData;
		static public var blueButton1Up:BitmapData;
		static public var blueButton1Disable:BitmapData;
		
		//蓝色页签按钮
		static public var blueButton2Down:BitmapData;
		static public var blueButton2Over:BitmapData;
		static public var blueButton2Up:BitmapData;
		
		// 2字小蓝色按钮
		static public var blueButton3Down:BitmapData;
		static public var blueButton3Over:BitmapData;
		static public var blueButton3Up:BitmapData;
		
		// 大蓝色按钮们
		static public var blueBigButton3Down:BitmapData;
		static public var blueBigButton3Over:BitmapData;
		static public var blueBigButton3Up:BitmapData;
		static public var blueBigButton3Disable:BitmapData;
		
		static public var tBlueBtn1Up:BitmapData;
		static public var tBlueBtn1Over:BitmapData;
		static public var tBlueBtn1Down:BitmapData;
		
		// 红色按钮们
		static public var tRedBtn1Up:BitmapData;
		static public var tRedBtn1Over:BitmapData;
		static public var tRedBtn1Down:BitmapData;
		
		// X按钮
		static public var windowCloseBtnUp:BitmapData;
		static public var windowCloseBtnDown:BitmapData;
		static public var windowCloseBtnOver:BitmapData;
		static public var windowCloseBtnDisable:BitmapData;
		
		// 多选按钮
		static public var checkboxSelectUp:BitmapData;
		static public var checkboxSelectOver:BitmapData;
		static public var checkboxUp:BitmapData;
		static public var checkboxOver:BitmapData;
		
		//圆形勾选框
		static public var checkboxSelectUp1:BitmapData;
		static public var checkboxSelectOver1:BitmapData;
		static public var checkboxUp1:BitmapData;
		static public var checkboxOver1:BitmapData;
		
		// 滚动条
		static public var scbDownButtonDownSkin:BitmapData;
		static public var scbDownButtonUpSkin:BitmapData;
		static public var scbDownButtonOveSkin:BitmapData;
		static public var scbUpButtonDownSkin:BitmapData;
		static public var scbUpButtonUpSkin:BitmapData;
		static public var scbUpButtonOveSkin:BitmapData;
		static public var scbThumbDownSkin:BitmapData;
		static public var scbThumbUpSkin:BitmapData;
		static public var scbThumbOverSkin:BitmapData;
		static public var scbTrackSkin:BitmapData;
		static public var scbTrackIconSkin:BitmapData;
		
		//新滚动条
		static public var scbDownButtonDownSkin1:BitmapData;
		static public var scbDownButtonUpSkin1:BitmapData;
		static public var scbDownButtonOveSkin1:BitmapData;
		static public var scbUpButtonDownSkin1:BitmapData;
		static public var scbUpButtonUpSkin1:BitmapData;
		static public var scbUpButtonOveSkin1:BitmapData;
		static public var scbThumbDownSkin1:BitmapData;
		static public var scbThumbUpSkin1:BitmapData;
		static public var scbThumbOverSkin1:BitmapData;
		static public var scbTrackSkin1:BitmapData;
		static public var scbTrackIconSkin1:BitmapData;
		
		//menupanel
		static public var MENU_SELECTED_BG:BitmapData;
		static public var MENU_SELECTED_BG_GRID:Rectangle = new Rectangle(2, 2, 51, 13);
		static public var MENU_BG:BitmapData;
		static public var MENU_BG_GRID:Rectangle = new Rectangle(2, 2, 57, 19);
		
		//步进器
		static public var NUMBER_INPUT_BG:BitmapData;
		
		static public var LeftStepper_Down:BitmapData;
		static public var LeftStepper_Over:BitmapData;
		static public var LeftStepper_Up:BitmapData;
		static public var MaxStepper_Down:BitmapData;
		static public var MaxStepper_Over:BitmapData;
		static public var MaxStepper_Up:BitmapData;
		static public var MinStepper_Down:BitmapData;
		static public var MinStepper_Over:BitmapData;
		static public var MinStepper_Up:BitmapData;
		static public var RightStepper_Down:BitmapData;
		static public var RightStepper_Over:BitmapData;
		static public var RightStepper_Up:BitmapData;
		
		static public var ARROW:BitmapData;
		
		public static var panelBtnClass:Class; //面板通用按钮
		public static var spanelBtnClass:Class; //小号面板通用按钮
		
		public static var sPayBtnClass:Class; //小号消费通用按钮
		
		public static var WINDOW_LINE:BitmapData;//一级界面分隔线
		public static var WINDOW_LINE2:BitmapData;//二级界面分隔线
		
		static public var Head_Up:BitmapData;
		static public var Head_Over:BitmapData;
		
		public static var RADIO_UP:BitmapData;//radiobutton
		public static var RADIO_DOT:BitmapData;
		
		public static var payBtnClass:Class;
		
		public static var OVER_MC:Class;
		
		/**活动关闭按钮*/
		public static var CLOSE_BTN:Class;
		
		/**活动问号按钮*/
		public static var INTERROGATION_BTN:Class;
		
		//提示红点
		public static var ACT_RED_POINT:BitmapData;
		
		//性别女
		public static var WOMAN_BD:BitmapData;
		//性别男
		public static var MAN_BD:BitmapData;
		//全屏玩法顶部
		public static var BANNER:BitmapData;
		//无人上榜
		public static var NONE_HAVE_RANK:BitmapData;
		
		//输入框背景
		public static var INPUT_BG:BitmapData;
		/** 改名按钮 */
		public static var RENAMEBTNDOWN:BitmapData;
		public static var RENAMEBTNOVER:BitmapData;
		public static var RENAMEBTNUP:BitmapData;
		
		public static var CHATBTN_UPICON:BitmapData;
		public static var CHATBTN_DOWNICON:BitmapData;
		
		//永久卡 小
		public static var FOREVER_CARD_S_BD:BitmapData;
		//月卡    小
		public static var MONTH_CARD_S_BD:BitmapData;
		
		
		public static var COMBOBOX_UP_BD:BitmapData;
		public static var COMBOBOX_DOWN_BD:BitmapData;
		public static var COMBOBOX_OVER_BD:BitmapData;
		
		/** 活动窗口通用确认按钮 */
		public static var ACTIVITY_OK_BUTTON_DOWN:BitmapData;
		public static var ACTIVITY_OK_BUTTON_OVER:BitmapData;
		public static var ACTIVITY_OK_BUTTON_UP:BitmapData;
		
		public static var SKILL_BG:BitmapData;
		public function CommonSkin()
		{
		}
		
		
		
		
		// 初始化
		public static function init(res:MovieClip):void
		{
			RESOURCE = res;
			
			var domain:ApplicationDomain = res.loaderInfo.applicationDomain;
			var global:Global = Global.instance;
			
			// Window Skin
			windowInner1Bg = global.getBD(domain , "WINDOW_INNER1_BG");
			windowInner2Bg = global.getBD(domain , "WINDOW_INNER2_BG");
			windowInner3Bg = global.getBD(domain , "WINDOW_INNER3_BG");
			windowInner4Bg = global.getBD(domain , "GREY_BG");
			
			windowDeepBg = global.getBD(domain,"WINDOW_DEEP_BG");
			
			// 蓝色按钮
			blueButton1Up = global.getBD(domain , "BLUE_BTN_1_UP");
			blueButton1Down = global.getBD(domain , "BLUE_BTN_1_DOWN");
			blueButton1Over= global.getBD(domain , "BLUE_BTN_1_OVER");
			blueButton1Disable = global.getBD(domain , "BLUE_BTN_1_DISABLE");
			
			tBlueBtn1Up = global.getBD(domain , "T_BLUE_BTN_M_UP");
			tBlueBtn1Over = global.getBD(domain , "T_BLUE_BTN_M_OVER");
			tBlueBtn1Down = global.getBD(domain , "T_BLUE_BTN_M_DOWN");
			
			//页签按钮
			blueButton2Up = global.getBD(domain , "BLUE_BTN_2_UP");
			blueButton2Down = global.getBD(domain , "BLUE_BTN_2_DOWN");
			blueButton2Over = global.getBD(domain , "BLUE_BTN_2_OVER");
			
			// 大蓝色按钮
			blueBigButton3Down = global.getBD(domain , "blueButton_l_down");
			blueBigButton3Over = global.getBD(domain , "blueButton_l_over");
			blueBigButton3Up = global.getBD(domain , "blueButton_l_up");
			blueBigButton3Disable = global.getBD(domain , "blueButton_l_disabled");
			
			// 2字小蓝色按钮
			blueButton3Up = global.getBD(domain , "BLUE_BTN_3_UP");
			blueButton3Down = global.getBD(domain , "BLUE_BTN_3_DOWN");
			blueButton3Over = global.getBD(domain , "BLUE_BTN_3_OVER");
			
			// 红色按钮
			tRedBtn1Up = global.getBD(domain , "T_RED_BTN_M_UP");
			tRedBtn1Over = global.getBD(domain , "T_RED_BTN_M_OVER");
			tRedBtn1Down = global.getBD(domain , "T_RED_BTN_M_DOWN");
			
			// X按钮
			windowCloseBtnUp = global.getBD(domain , "WINDOW_CLOSE_BTN_UP");
			windowCloseBtnDown = global.getBD(domain , "WINDOW_CLOSE_BTN_DOWN");
			windowCloseBtnOver = global.getBD(domain , "WINDOW_CLOSE_BTN_OVER");
			windowCloseBtnDisable = global.getBD(domain , "WINDOW_CLOSE_BTN_DISABLE");
			
			// 多选
			checkboxSelectUp = global.getBD(domain , "CHECKBOX_SELECT_UP");
			checkboxSelectOver = global.getBD(domain , "CHECKBOX_SELECT_OVER");
			checkboxUp = global.getBD(domain , "CHECKBOX_UP");
			checkboxOver = global.getBD(domain , "CHECKBOX_OVER");
			
			checkboxSelectUp1 = global.getBD(domain , "CHECKBOX_NEW_SELECT_UP");
			checkboxSelectOver1 = global.getBD(domain , "CHECKBOX_SELECT_OVER");
			checkboxUp1 = global.getBD(domain , "CHECKBOX_NEW_UP");
			checkboxOver1 = global.getBD(domain , "CHECKBOX_NEW_OVER");
			
			// 滚动条
			scbDownButtonDownSkin = global.getBD(domain , "SCB_DOWNBUTTON_DOWN_SKIN");
			scbDownButtonUpSkin = global.getBD(domain , "SCB_DOWNBUTTON_UP_SKIN");
			scbDownButtonOveSkin = global.getBD(domain , "SCB_DOWNBUTTON_OVER_SKIN");
			scbUpButtonDownSkin = global.getBD(domain , "SCB_UPBUTTON_DOWN_SKIN");
			scbUpButtonUpSkin = global.getBD(domain , "SCB_UPBUTTON_UP_SKIN");
			scbUpButtonOveSkin = global.getBD(domain , "SCB_UPBUTTON_OVER_SKIN");
			scbThumbDownSkin = global.getBD(domain , "SCB_THUMB_DOWN_SKIN");
			scbThumbUpSkin = global.getBD(domain , "SCB_THUMB_UP_SKIN");
			scbThumbOverSkin = global.getBD(domain , "SCB_THUMB_OVER_SKIN");
			scbTrackSkin = global.getBD(domain , "SCB_TRACK_SKIN");
			scbTrackIconSkin = global.getBD(domain , "SCB_THUMB_ICON_SKIN");
			
			scbDownButtonDownSkin1 = global.getBD(domain , "SCB_DOWNBUTTON_DOWN_SKIN1");
			scbDownButtonUpSkin1 = global.getBD(domain , "SCB_DOWNBUTTON_UP_SKIN1");
			scbDownButtonOveSkin1 = global.getBD(domain , "SCB_DOWNBUTTON_OVER_SKIN1");
			scbUpButtonDownSkin1 = global.getBD(domain , "SCB_UPBUTTON_DOWN_SKIN1");
			scbUpButtonUpSkin1 = global.getBD(domain , "SCB_UPBUTTON_UP_SKIN1");
			scbUpButtonOveSkin1 = global.getBD(domain , "SCB_UPBUTTON_OVER_SKIN1");
			scbThumbDownSkin1 = global.getBD(domain , "SCB_THUMB_DOWN_SKIN1");
			scbThumbUpSkin1 = global.getBD(domain , "SCB_THUMB_UP_SKIN1");
			scbThumbOverSkin1 = global.getBD(domain , "SCB_THUMB_OVER_SKIN1");
			scbTrackSkin1 = global.getBD(domain , "SCB_TRACK_SKIN1");
			scbTrackIconSkin1 = global.getBD(domain , "SCB_THUMB_ICON_SKIN1");

			MENU_SELECTED_BG = global.getBD(domain , "MENU_SELECTED_BG");
			MENU_BG = global.getBD(domain , "MENU_BG");
			
			NUMBER_INPUT_BG = global.getBD(domain , "NUMBER_INPUT_BG");
			LeftStepper_Down = global.getBD(domain , "LeftStepper_Down");
			LeftStepper_Over = global.getBD(domain , "LeftStepper_Over");
			LeftStepper_Up = global.getBD(domain , "LeftStepper_Up");
			MaxStepper_Down = global.getBD(domain , "MaxStepper_Down");
			MaxStepper_Over = global.getBD(domain , "MaxStepper_Over");
			MaxStepper_Up = global.getBD(domain , "MaxStepper_Up");
			MinStepper_Down = global.getBD(domain , "MinStepper_Down");
			MinStepper_Over = global.getBD(domain , "MinStepper_Over");
			MinStepper_Up = global.getBD(domain , "MinStepper_Up");
			RightStepper_Down = global.getBD(domain , "RightStepper_Down");
			RightStepper_Over = global.getBD(domain , "RightStepper_Over");
			RightStepper_Up = global.getBD(domain , "RightStepper_Up");
			
			ARROW = global.getBD(domain , "arrow");
			WINDOW_LINE = global.getBD(domain , "WINDOW_LINE");
			WINDOW_LINE2 = global.getBD(domain , "WINDOW_LINE2");
			
			Head_Up = global.getBD(domain,"Head_Up");
			Head_Over = global.getBD(domain,"Head_Over");
			
			panelBtnClass = global.getClass(domain , "panelBtn");
			spanelBtnClass = global.getClass(domain , "sPanelBtn");
			
			sPayBtnClass = global.getClass(domain , "sPayBtn");
			
			RADIO_UP = global.getBD(domain,"RADIO_UP");
			RADIO_DOT = global.getBD(domain,"RADIO_DOT");
			
			payBtnClass = global.getClass(domain , "payBtn");
			
			OVER_MC = global.getClass(domain,"Over_Mc");
			
			INTERROGATION_BTN = global.getClass(domain,"InterrogationBtn2");
			
			CLOSE_BTN = global.getClass(domain,"CloseBtn2");
			
			WOMAN_BD = global.getBD(domain,"WOMAN_BD");
			MAN_BD = global.getBD(domain,"MAN_BD");
			
			ACT_RED_POINT = global.getBD(domain,"ACT_RED_POINT");
			
			BANNER = global.getBD(domain,"BANNER");
			
			NONE_HAVE_RANK = global.getBD(domain,"NONE_HAVE_RANK");
			
			INPUT_BG = global.getBD(domain,"inputBg");
			RENAMEBTNUP = global.getBD(domain,"renameBtnUp");
			RENAMEBTNOVER = global.getBD(domain,"renameBtnOver");
			RENAMEBTNDOWN = global.getBD(domain,"renameBtnDown");
			
			//月卡小图标
			MONTH_CARD_S_BD = global.getBD(domain,"MONTH_CARD_S_BD");
			FOREVER_CARD_S_BD = global.getBD(domain,"FOREVER_CARD_S_BD");
			
			CHATBTN_UPICON = global.getBD(domain,"upIcon");
			CHATBTN_DOWNICON = global.getBD(domain,"downIcon");
			
			COMBOBOX_UP_BD = global.getBD(domain,"Combobox_up");
			COMBOBOX_DOWN_BD = global.getBD(domain,"Combobox_down");
			COMBOBOX_OVER_BD = global.getBD(domain,"Combobox_over");
			
			/** 活动窗口通用确认按钮 */
			ACTIVITY_OK_BUTTON_DOWN = global.getBD(domain,"ACTIVITY_OK_BUTTON_DOWN");
			ACTIVITY_OK_BUTTON_OVER = global.getBD(domain,"ACTIVITY_OK_BUTTON_OVER");
			ACTIVITY_OK_BUTTON_UP = global.getBD(domain,"ACTIVITY_OK_BUTTON_UP");
			
			SKILL_BG = global.getBD(domain,"SKILL_BG");
		}

		
		public static function getClass(name:String):Object
		{
			return Global.instance.getRes(null,name);
		}
	}
}