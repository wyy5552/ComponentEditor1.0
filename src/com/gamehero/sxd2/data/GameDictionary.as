package com.gamehero.sxd2.data {
	
    import com.gamehero.sxd2.manager.JSManager;
    
    import flash.text.TextField;
    import flash.text.TextFormat;
	
	
	/**
	 * 游戏字典
	 * @author Trey
	 * @create-date 2013-8-26
	 */
	public class GameDictionary {
		
		// 游戏默认字体
		static public const FONT_NAME:String = "宋体";
		/**
		 * 波浪号 属性分隔符
		 */		
		public static var splitWave:String = "~";
		/**
		 * 帽子号 对象并列符
		 */		
		public static var splitHat:String = "^";
		/**
		 * 双帽子号 
		 */		
		public static var doubleSplitHat:String = "^^";
		
		
		
		/** 游戏颜色 */
		/**
		 * 白色 
		 */		
		static public const WHITE:uint = 0xd6e2ee;		// 白色
		static public const PINK:uint = 0xff5bf2;		// 粉色
		static public const BLUE:uint = 0x2795de;		// 蓝色
		static public const PURPLE:uint = 0xf601ff;	// 紫色
		static public const ORANGE:uint = 0xd5791f;	// 橙色
		static public const RED:uint = 0xad1818;		// 红色
		static public const YELLOW:uint = 0xf6e33f;	// 黄色
		static public const GREEN:uint = 0x41c61d;		// 绿色
		static public const GRAY:uint = 0x7690a4;		// 灰色
		static public const BLACK:uint = 0x151d25;		// 黑色
		/**
		 * 深灰 
		 */		
		static public const GRAY_DEEP:uint = 0x647b90;		// 深灰
		static public const WINDOW_BTN:uint = 0xb7dbdf;	//按钮字色
		static public const WINDOW_BTN_GRAY:uint = 0x397a93;	//按钮字色灰色
		static public const WINDOW_PAY_BTN:uint = 0xd1cba9;	//消费按钮字色
		static public const WINDOW_PAY_BTN_GRAY:uint = 0x90692d;//消费按钮字色灰色
		static public const ITEM_LABEL:uint = 0xffd40e;	//物品格子文本颜色
		
		
		static public const STROKE:uint = 0x191d20;		// 描边色
		static public const TASK_GREEN:uint = 0x2ce80e;	// 任务相关绿色
		
		
		
		/**面板颜色*/
		static public const WINDOW_GRAY:uint = 0xa5bed4;			//灰色
		static public const WINDOW_DEEP_GRAY:uint = 0x647b90;		//深灰色
		static public const WINDOW_WHITE:uint = 0xd6e2ee;			//白色
		static public const WINDOW_BLUE:uint = 0x7690a4;			//蓝色字
		static public const WINDOW_BLUE_GRAY:uint = 0x5e658b;		//蓝灰色字
		static public const WINDOW_UNSELECT_BTN:uint = 0x647b90;	//聊天未选择按钮字色
		static public const WINDOW_LINE:uint = 0x222e37;			//面板装饰线 颜色值
		
		//聊天颜色
		static public const CHAT_WORLD:uint = 0x568dfe;		// 世界
		static public const CHAT_FAMILY:uint = 0x6dfe56;		// 帮派
		static public const CHAT_PRIVATE:uint = 0xf6e33f;		// 私聊
		static public const CHAT_SYSTEM:uint = 0xf6e33f;		// 通告
		static public const CHAT_TIPS:uint = 0xa5bed4;			// 提示
		static public const CHAT_PLAYER:uint = 0x949ed3;		// 玩家
		static public const CHAT_DETAILS:uint = 0xd7deed;		// 内容
		static public const CHAT_BATTLELOG:uint = 0xc552f5;	// 战报
		
		
		// 颜色标签(Label)
		static public const WHITE_TAG:String = "|color=0x" + WHITE.toString(16) + "|";
		static public const ORANGE_TAG:String = "|color=0x" + ORANGE.toString(16) + "|";
		static public const YELLOW_TAG:String = "|color=0x" + YELLOW.toString(16) + "|";
		static public const RED_TAG:String = "|color=0x" + RED.toString(16) + "|";
		static public const GREEN_TAG:String = "|color=0x" + GREEN.toString(16) + "|";
		static public const BLUE_TAG:String = "|color=0x" + BLUE.toString(16) + "|";
		static public const PURPLE_TAG:String = "|color=0x" + PURPLE.toString(16) + "|";
		static public const GRAY_TAG:String = "|color=0x" + GRAY.toString(16) + "|";
		static public const GRAYDEEP_TAG:String = "|color=0x" + GRAY_DEEP.toString(16) + "|";
		static public const WINDOW_BTN_TAG:String = "|color=0x" + WINDOW_BTN.toString(16) + "|";
		
		//面板颜色标签
		static public const WINDOW_BLUE_TAG:String = "|color=0x" + WINDOW_BLUE.toString(16) + "|";
		static public const WINDOW_GRAY_TAG:String = "|color=0x" + WINDOW_GRAY.toString(16) + "|";
		static public const WINDOW_DEEP_GRAY_TAG:String = "|color=0x" + WINDOW_DEEP_GRAY.toString(16) + "|";
		static public const WINDOW_BLUE_GRAY_TAG:String = "|color=0x" + WINDOW_BLUE_GRAY.toString(16) + "|";
		
		static public const COLOR_TAG_END:String = "|/color|";
		
		
		// 颜色标签(HtmlText)
		static public const WHITE_TAG2:String = "<font color='#" + WHITE.toString(16) + "'>";
		static public const ORANGE_TAG2:String = "<font color='#" + ORANGE.toString(16) + "'>";
		static public const YELLOW_TAG2:String = "<font color='#" + YELLOW.toString(16) + "'>";
		static public const RED_TAG2:String = "<font color='#" + RED.toString(16) + "'>";
		static public const GREEN_TAG2:String = "<font color='#" + GREEN.toString(16) + "'>";
		static public const BLUE_TAG2:String = "<font color='#" + BLUE.toString(16) + "'>";
		static public const PURPLE_TAG2:String = "<font color='#" + PURPLE.toString(16) + "'>";
		static public const GRAY_TAG2:String = "<font color='#" + GRAY.toString(16) + "'>";
		/**
		 * 获取对应颜色的html文本 
		 * @param text
		 * @param color
		 * @return 
		 * 
		 */		
		public static function getTAG2Str(text:String,color:uint):String
		{
			return "<font color='#" + color.toString(16) + "'>" + text + "</font>";
		}
		
		static public const COLOR_TAG_END2:String = "</font>";
	
		// 一分钟、一小时、一天秒数	
		static public const MINUTE_SECONDS:uint = 60;
		static public const HOUR_SECONDS:uint = MINUTE_SECONDS * 60;
		static public const DAY_SECONDS:uint = HOUR_SECONDS * 24;
		static public const TEN_DAY_SECONDS:uint = DAY_SECONDS * 10;
		
		//命途
		static public const FATE_WHITE:uint = 0xd6e2ee;		// 未领取的资源显示颜色
		static public const FATE_YELLOW:uint = 0xd0b76d;		// 已领取的资源显示颜色
		static public const FATE_BLUE:uint = 0x50ffff;			// 未领取的属性显示颜色
		static public const FATE_BLUE_GRAY:uint = 0x3ca0a0 ;	// 已领取的属性显示颜色
		static public const FATA_STROKE:uint = 0x5f451b;		//命途描边色

		/**
		 *根据品质获取颜色值 
		 * @param quality
		 * @return 
		 * 
		 */		
		static public function getColorByQuality(quality:uint):uint
		{
			switch(quality)
			{
				case 0:
					return GameDictionary.WHITE;
				case 1:
					return GameDictionary.GREEN;
				case 2:
					return GameDictionary.BLUE;
				case 3:
					return GameDictionary.PURPLE;
				case 4:
					return GameDictionary.ORANGE;
				case 5:
					return GameDictionary.RED;
			}
			return GameDictionary.WHITE;
		}
		
		
		/**
		 *根据buffVo的colour属性获取颜色值 1是红   2是蓝
		 * @param colour 颜色 
		 * @return 
		 * 
		 */		
		static public function getBuffColor(colour:int):uint
		{
			switch(colour)
			{
				case 1:
					return GameDictionary.RED;
				case 2:
					return GameDictionary.BLUE;
				default:
					return GameDictionary.GRAY;
			}
		}
		
		
		
		
		/**
		 * 格式化秒为天数
		 * @param second
		 * @return 
		 * 
		 */
		public static function formatTime(seconds:int):String {
			
			var str:String = String(int(seconds / DAY_SECONDS));
			
			return str;// + Lang.instance.trans("AS_81");
		}
		
		
		
		
		/**
		 * 格式化金钱相关 
		 * @param value
		 * @return 
		 * 
		 */
		static public function formatMoney(value:Number):String {
			
			var str:String = "";
			
			// 当货币数量＜1000000时，用纯数字显示实际的数量
			if(value < 100000) {
				
				str = value.toString();
			}
			// 当1000000≤货币数量＜1亿时，用数字+“万”显示，显示整数万
			else if(value < 100000000) {
				
				str = int(value / 10000) + "万";//Lang.instance.trans("AS_85");
			}
			// 当货币数量≥1亿时，用数字+“亿”显示，显示整数亿
			else {
				
				str = int(value / 100000000) + "亿";//Lang.instance.trans("AS_86");
			}
			
			return str;
		}
		
		
		/**
		 * 生成支持alternativeGUI的html文本
		 * */
		public static function createCommonText(text:String , color:uint = WHITE , size:uint = 12 , bold:Boolean = false):String
		{
			if(text == "") return "";
			var colorStr:String = "0x" + color.toString(16);
			var colorStart:String = "|color=" + colorStr + "|";
			var colorEnd:String = "|/color|";
			
			var sizeStart:String = "|size=" + size + "|";
			var sizeEnd:String = "|/size|";
			
			var boldStart:String = "";
			var boldEnd:String = "";
			if(bold == true)
			{
				boldStart = "|b|";
				boldEnd = "|/b|";
			}
			
			var returnStr:String = colorStart + sizeStart + boldStart + text + boldEnd + sizeEnd + colorEnd;
			return returnStr;
		}
		
		/**
		 * 生成html文本
		 * */
		public static function createHtmlCommonText(text:String , color:uint = WHITE , size:uint = 12 ):String
		{
			if(text == "") return "";
			var colorStr:String = "#" + color.toString(16);
			var returnStr:String = "<font color='" + colorStr + "' size='" + size + "'>" + text + "</font>";
			return returnStr;
		}
		
		/**
		 * 将字符串处理成整形数组
		 * @param str 要处理的字符串
		 * @param cla 数组项的类型
		 * @param delim 分隔符
		 */
		static public function stringToArray(str:String, cla:Class, delim:String = "^"):Array
		{
			var arr:Array = [];
			if(str.length>0){
				arr = str.split(delim);
				var len:int = arr.length;
				for(var i:int=0; i<len; i++)
				{
					arr[i] = cla(arr[i]);
				}
			}
			return arr;
		}
		
		
		private static var fontName:String = "";
		static public function getFontName():String
		{
			if(fontName == "")
			{
				var browser:String = JSManager.getBrowserName();
				var system:String = JSManager.getSystemName();
				switch(browser)
				{
					case Browser.Chrome:
						fontName = ((system == OS.Win10) || (system == OS.Win8)) ? App.embedFontName : "微软雅黑";
						break;
					
					default:
						fontName = "宋体";
						break;
				}
			}
			return fontName;
		}
		
		static public function needEmbedFont():Boolean{
			var browser:String = JSManager.getBrowserName();
			if(browser == Browser.Chrome){
				var system:String = JSManager.getSystemName();
				return (system == OS.Win10) || (system == OS.Win8);
			}
			return false;
		}
		
		/**
		 * 设置MovieClip中的textfield默认字体 根据浏览器判定用宋体还是黑体
		 * @param tf
		 * @param format
		 * 
		 */
		static public function setTfDefaultFontName(tf:TextField,format:TextFormat = null):void{
			if(format == null){
				format = new TextFormat();
			}
			format.font = getFontName();
			tf.defaultTextFormat = format;
		}
	}
}