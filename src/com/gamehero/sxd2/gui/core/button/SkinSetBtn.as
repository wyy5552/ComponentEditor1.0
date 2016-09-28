package com.gamehero.sxd2.gui.core.button
{
	
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons.Button;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import alternativa.gui.alternativagui;

	use namespace alternativagui;
	/**
	 * 可以更换皮肤的button
	 * @author weiyanyu
	 * 创建时间：2016-9-19 下午4:23:30
	 */
	public class SkinSetBtn extends Button
	{
		public function SkinSetBtn()
		{
			super(null,null,null,null);
		}
		
		public function setSkin(UpSkin:BitmapData, downSkin:BitmapData = null, overSkin:BitmapData = null, disableSkin:BitmapData = null):void
		{
			stateUP = new Bitmap(UpSkin);
			if(downSkin) {
				if(_stateDOWN is Bitmap)
				{
					Bitmap(_stateDOWN).bitmapData = downSkin;
				}
				else
				{
					stateDOWN = new Bitmap(downSkin);
				}
			}
			if(overSkin) {
				if(_stateOVER is Bitmap)
				{
					Bitmap(_stateOVER).bitmapData = overSkin;
				}
				else
				{
					stateOVER = new Bitmap(overSkin);
				}
			}
			if(disableSkin) {
				if(_stateOFF is Bitmap)
				{
					Bitmap(_stateOFF).bitmapData = disableSkin;
				}
				else
				{
					stateOFF = new Bitmap(disableSkin);
				}
			}
			// TRICKY: 根据UP_SKIN确定按钮大小，无需再设置按钮大小
			this._width = _stateUP.width;
			this._height = _stateUP.height;
		}
	}
}