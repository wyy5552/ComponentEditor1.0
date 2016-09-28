package com.gamehero.sxd2.gui.theme.ifstheme.controls.tree
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.HtmlText;
	
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	
	
	/**
	 * 任务追踪栏上的文本
	 * @author xuwenyi
	 * @create 2015-11-12
	 **/
	public class TaskTreeLabel extends HtmlText
	{

		static private const WIDTH:int = 200;
		
		public function TaskTreeLabel()
		{
			super();
		}
		
		override public function set text(value:String):void
		{
			// TODO Auto Generated method stub
//			super.text = value;
			
			if(value == null)	return;

			textField.htmlText = value;
			
			var enabled:Boolean = value.indexOf("</a") >= 0;
			
			// TO DO：为了使链接文字也有手型，今后通过MouseManager修改
			if(enabled == true) {
				addChild(activeObject);
				activeObject.cursorActive = true;
				activeObject.graphics.clear();
				activeObject.graphics.beginFill(0x777777, 0);
				activeObject.graphics.drawRect(0, 0, WIDTH, textField.height);
			}
			if(isClickActive)
				activeObject.addEventListener(MouseEvent.CLICK,activeObjectClickHandle);
			
			this.height = textField.height;
		}
		
		
		
		private function activeObjectClickHandle(e:MouseEvent):void
		{
			var str:String = this.textField.htmlText;
			var strList:Array = str.split("event:");
			str = strList[1];
			strList = str.split('"');
			var textEvent:TextEvent = new TextEvent(TextEvent.LINK, true, false, strList[0]);
			dispatchEvent(textEvent);	
		}
		
		
	}
}