package com.gamehero.sxd2.manager{
	
	import com.gamehero.sxd2.data.Browser;
	import com.gamehero.sxd2.data.OS;
	
	import flash.external.ExternalInterface;
	
	import bowser.logging.Logger;
	
	/**
	 * 调用JS Mananger
	 * 
	 * @author Trey
	 */
	public class JSManager {
		
		/**
		 * 获得Login服务器地址
		 * @return 数组包含：addr/p
		 * 
		 public static function getLoginURL():Array {
		 
		 return ExternalInterface.call('getLoginURL');
		 }
		 */
		
		/**
		 * 刷新游戏页面 
		 * 
		 */
		public static function refreshGame():void {
			
			try{
				
				ExternalInterface.call('refreshGame');
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
			}
		}
		
		
		/**
		 * 获得Client Session Id
		 * 
		 public static function getClientId():String {
		 
		 return ExternalInterface.call('getClientId');
		 }
		 */
		
		
		/**
		 * 获得Debug Switch
		 */
		public static var _isDebug:int = -1;
		public static function isDebug():Boolean {
			
			if(_isDebug == -1)
			{
				try{
					_isDebug = int(ExternalInterface.call('isDebug'));
				}
				catch(e:Error) {
					
					_isDebug = 0;
				}
			}
			return _isDebug;
		}
		
		
		
		/**
		 * 获得GC Debug Switch
		 */
		public static function isGCDebug():Boolean {
			
			try{
				
				return  ExternalInterface.call('isGCDebug');
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
				return false;
			}
			return false;
		}
		
		
		
		/**
		 * 获得是否允许gm控制台
		 */
		public static var _isGM:int = -1;
		public static function isGM():Boolean 
		{
			if(_isGM == -1)
			{
				try
				{	
					_isGM = ExternalInterface.call('isGM');
				}
				catch(e:Error) 
				{	
					_isGM = 0;
				}
			}
			return _isGM;
		}
		
		
		
		
		/**
		 * 是否本地测试环境
		 * */
		public static var _isLocal:int = -1;
		public static function isLocal():Boolean
		{
			if(_isLocal == -1)
			{
				try
				{	
					_isLocal = ExternalInterface.call('isLocal');
				}
				catch(e:Error) 
				{	
					_isLocal = 0;
				}
			}
			return _isLocal;
		}
		
		
		
		/**
		 * 设置js的cookie
		 * */
		public static function setCookie(name:String , value:Object):void
		{
			try{
				
				ExternalInterface.call('setCookie' , name , value);
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
			}
		}
		
		
		
		
		
		/**
		 * 获取js的cookie
		 * */
		public static function getCookie(name:String):Object
		{
			try{
				
				return ExternalInterface.call('getCookie' , name);
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
				return null;
			}
			return false;
		}
		
		
		
		
		
		/**
		 * 获取当前浏览器url
		 * */
		public static function getBrowserURL():String
		{
			try{
				
				return ExternalInterface.call('getBrowserURL');
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
				return "";
			}
			return "";
		}
		
		
		
		
		/**
		 * 获取浏览器类型
		 * */
		private static var browserName:String = "";
		public static function getBrowserName():String
		{
			if(browserName == "")
			{
				try
				{	
					browserName = ExternalInterface.call('getBrowserName');
				}
				catch(e:Error) 
				{	
					browserName = Browser.IE;
				}
			}
			return browserName;
		}
		
		
		
		
		/**
		 * 获取操作系统
		 * */
		private static var systemName:String = "";
		public static function getSystemName():String
		{
			if(systemName == "")
			{
				try
				{	
					systemName = ExternalInterface.call('getSystemName');
				}
				catch(e:Error) 
				{	
					systemName = OS.Win7;
				}
			}
			return systemName;
		}
		
		
		
		
		
		/**
		 * 判断是否需要使用嵌入字体
		 * */
		public static function needEmbedFont():Boolean
		{
			var browser:String = getBrowserName();
			if(browser == Browser.Chrome){
				var system:String = getSystemName();
				return (system == OS.Win10) || (system == OS.Win8);
			}
			return false;
		}
		
		
		
		
		
		/**
		 * 进入游戏，"游戏加载"文字清除
		 * */
		public static function clearText():void
		{
			try{
				
				ExternalInterface.call('resetTxt');
			}
			catch(e:Error) {
				
				Logger.error(JSManager, "JS ERROR");
			}
		}
		
		
	}
}