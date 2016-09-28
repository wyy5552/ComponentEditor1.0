package com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons
{
	import flash.display.BitmapData;

	/**
	 * @author Wbin
	 * 创建时间：2016-4-1 下午2:12:30
	 * 窗口通用问号按钮,tips显示用
	 */
	public class WindowHelpButton extends Button
	{
		private var tip:String = "";
		
		public function WindowHelpButton(UpSkin:BitmapData, downSkin:BitmapData = null, overSkin:BitmapData = null, disableSkin:BitmapData = null)
		{
			super(UpSkin,downSkin,overSkin,disableSkin);
			this.hint = " ";
		}
		
		public function get tips():String
		{
			return this.tip;
		}
		
		public function set tips(str:String):void
		{
			this.tip = str;
		}
		
	}
}