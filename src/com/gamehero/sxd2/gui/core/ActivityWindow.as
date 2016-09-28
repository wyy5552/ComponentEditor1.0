package com.gamehero.sxd2.gui.core
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.SButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;

	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-8-25 下午5:14:58
	 * 
	 */
	public class ActivityWindow extends GameWindow
	{
		public var closeBtn:SButton;
		
		public var interrogationBtn:SButton;
		
		protected var title:Bitmap;
		
		public function ActivityWindow(position:int, resourceURL:String=null, width:Number=0, height:Number=0)
		{
			super(position, resourceURL, width, height);
		}
		
		
		override public function close():void
		{
			// TODO Auto Generated method stub
			super.close();
		}
		
		override protected function initWindow():void
		{
			//背景
			var bg:Bitmap = new Bitmap(getSwfBD("BG_BD"));
			add(bg);
			//标题
			title = new Bitmap(getSwfBD("TITLE_BD"));
			add(title,(width - title.width )>> 1,15);
			super.initWindow();
			
			closeBtn = new SButton(new CommonSkin.CLOSE_BTN);
			add(closeBtn,width - closeBtn.width - 10,10);
			closeBtn.addEventListener(MouseEvent.CLICK,onClickClose);
			
			interrogationBtn = new SButton(new CommonSkin.INTERROGATION_BTN);
			interrogationBtn.visible = false;
			add(interrogationBtn,closeBtn.x - interrogationBtn.width - 3,10);
		}
		
		/**
		 * 设置小问号hint
		 * 有hint 显示 
		 * */
		protected function set interrogation(value:String):void
		{
			this.interrogationBtn.visible = true;
			this.interrogationBtn.hint = GameDictionary.getGeneralTips(value);
		}
		
		protected function onClickClose(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			close();
		}
		
		override protected function onShow():void
		{
			// TODO Auto Generated method stub
			super.onShow();
		}
	}
}