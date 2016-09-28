package com.gamehero.sxd2.gui.core.tab
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ChatSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.GuideSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * 红点，"满"字tab 
	 * @author weiyanyu
	 */	
	public class ActTabBtn extends TabSbutton
	{
		/**
		 * 数值相关的容器
		 */
		private var _funcNumContaner:Sprite;
		
		/**
		 * “满”字提示 
		 */		
		protected var hintBG3:Bitmap;
		
		private var _num:int;
		
		public function ActTabBtn(stateUpSkin:BitmapData, stateDownSkin:BitmapData = null, stateOverSkin:BitmapData = null,disSkin:BitmapData = null,redType:String = ActTabBtnRedPointType.RED_CHAT_POINT)
		{
			super(stateUpSkin, stateDownSkin, stateOverSkin,disSkin);
			
			this.width = stateUpSkin.width;
			this.height = stateUpSkin.height;
			
			_funcNumContaner = new Sprite();
			_funcNumContaner.x = width - 5;
			_funcNumContaner.y = 5;
			_funcNumContaner.visible = false;
			this.addChild(_funcNumContaner);
		
			hintBG3 = new Bitmap(GuideSkin.FUNCTION_HINT_FULL);
			addChild(hintBG3);
			hintBG3.x = width - 5;
			hintBG3.y = 5;
			this.addChild(hintBG3);
			hintBG3.visible = false;
			
			var bitmap:Bitmap;
			switch(redType)
			{
				case ActTabBtnRedPointType.RED_CHAT_POINT:
				{
					bitmap = new Bitmap(ChatSkin.CHAT_REDPOINT);
					break;
				}
					
				case ActTabBtnRedPointType.RED_ACT_POINT:
				{
					bitmap = new Bitmap(CommonSkin.ACT_RED_POINT);
					break;
				}
				
				default:
				{
					break;
				}
			}
			_funcNumContaner.addChild(bitmap);
			
			/*_funcNumLabel = new Label;
			_funcNumLabel.width = 13
			_funcNumLabel.align = Align.CENTER;
			_funcNumLabel.color = GameDictionary.YELLOW;
			_funcNumLabel.y = 1;
			_funcNumContaner.addChild(_funcNumLabel);*/
		}
		
		/**
		 * 更新tab上面的数字
		 */
		override public function updateFuncNum(value:int):void
		{
			//_funcNumLabel.text = ""+value;
			if(_selected == false)
			{
				_funcNumContaner.visible = value>0;
			}
			_num = value;
		}
		
		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			if(_selected)
			{
				_funcNumContaner.visible = false;
			}
			else
			{
				_funcNumContaner.visible = _num > 0;
			}
		}
			
		
		override public function setFuncIconLoc(lx:int,ly:int):void
		{
			_funcNumContaner.x = lx;
			_funcNumContaner.y = ly;
		}
		
		
		override public function set full(value:Boolean):void
		{
			hintBG3.visible = value;
		}
	}
}