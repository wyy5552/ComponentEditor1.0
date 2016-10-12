package com.gamehero.sxd2.gui.core.components
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import alternativa.gui.base.ActiveObject;
	
	import bowser.utils.MovieClipPlayer;
	
	/**
	 * movieclip播放容器
	 * @author weiyanyu
	 * 创建时间：2016-10-12 下午4:57:24
	 */
	public class McPlayer extends ActiveObject
	{
		private var mc:MovieClip;
		
		private var mp:MovieClipPlayer;
		
		public function McPlayer()
		{
			super();
		}
		
		public function set source(value:Object):void
		{
			if(mc != null)
			{
				if(mc.parent)
					mc.parent.removeChild(mc);
				mc.stop();
			}
			mc = value as MovieClip; 
			if(mc == null)
				return;
			addChild(mc);
		}
	}
}