package com.gamehero.sxd2.gui
{
	import flash.display.Sprite;
	
	/**
	 * 全屏玩法基类
	 * @author cuixu
	 * @create：2016-4-11
	 **/
	public class FullScreenView extends Sprite
	{
		/**
		 * 窗口默认参数
		 * */
		public static var windowParam:Object;
		
		public function FullScreenView()
		{
			super();
		}
		
		/**
		 * 清理
		 * 
		 */
		public function clear():void{
			
		}
		
		public function close():void{
			windowParam = null;
		}
	}
}