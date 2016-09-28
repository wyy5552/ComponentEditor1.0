package com.gamehero.sxd2.gui
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.util.FiltersUtil;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	/**
	 * @author Wbin
	 * 创建时间：2016-7-8 下午6:10:17
	 * 带有灰态的Sbtn
	 */
	public class SGrayButton extends SButton
	{
		public function SGrayButton(btn:SimpleButton, mc:MovieClip = null ,_lab:String="", _icon:DisplayObject=null, color:int=GameDictionary.WINDOW_BTN , lockCor:int = GameDictionary.WINDOW_BTN)
		{
			super(btn, _lab, _icon, color , lockCor);
			
			if(mc)
			{
				_btnMc = mc;
				_btnMc.mouseChildren = _btnMc.mouseEnabled = _btnMc.tabChildren = _btnMc.mouseEnabled = false;
				_btnMc.x = -4;
				_btnMc.y = -10;
				this.addChild(_btnMc);
			}
		}
		
		
		override public function abledUI(bool:Boolean):void
		{
			super.abledUI(bool);
		}
		
		/**
		 * mc播放
		 * */
		public function playEffect(bool:Boolean):void
		{
			if(_btnMc)
			{
				if(bool)
				{
					_btnMc.play();
				}
				else
				{
					_btnMc.stop();
				}
			}
		}
		
		/**
		 * @param bool 按钮灰态（true 灰态  false 去掉灰态）
		 * */
		public function set filte(bool:Boolean):void
		{
			if(bool)
			{
				this.filters = FiltersUtil.BW_Fiter;
				if(label)
				{
					label.alpha = 1.0;
				}
				if(icon)
				{
					icon.alpha = 1.0;
				}
			}
			else
			{
				this.filters = [];
			}
			
		}
	}
}