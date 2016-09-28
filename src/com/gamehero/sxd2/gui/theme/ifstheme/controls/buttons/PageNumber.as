package com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MainSkin;
	
	import alternativa.gui.base.GUIobject;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-9-14 下午4:36:24
	 * 
	 */
	public class PageNumber extends GUIobject
	{
		private var buttonList:Vector.<Button> = new Vector.<Button>();
		
		private var _maxPage:int;
		private const offsetX:Number = 4;
		public function PageNumber(maxPage:int = 4)
		{
			super();
			
			_maxPage = maxPage;
		}
		/**
		 *初始化 
		 * 
		 */		
		public function initButton():void
		{
			// TODO Auto Generated method stub
			for (var i:int = 0; i < _maxPage; i++) 
			{
				var btn:Button = new Button(
					MainSkin.getSwfBD("Page_Number_Up"),
					MainSkin.getSwfBD("Page_Number_Down"),
					MainSkin.getSwfBD("Page_Number_Over"),
					MainSkin.getSwfBD("Page_Number_Disable")
				);
				btn.x = (offsetX + btn.width) * i;
				btn.label = String(i + 1);
				
				addChild(btn);
				
				buttonList.push(btn);
			}
		}
		
		/**
		 * 
		 * 
		 */		
		public function initPage():void
		{
			
		}
		
		public function clear():void
		{
			for (var i:int = 0; i < buttonList.length; i++) 
			{
				var btn:Button = buttonList[i];
			}
		}

		public function set maxPage(value:int):void
		{
			_maxPage = value;
		}

	}
}