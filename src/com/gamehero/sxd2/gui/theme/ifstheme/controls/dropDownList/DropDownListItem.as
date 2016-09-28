package com.gamehero.sxd2.gui.theme.ifstheme.controls.dropDownList
{
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	
	import flash.events.MouseEvent;
	
	import alternativa.gui.enum.Align;
	
	import org.bytearray.display.ScaleBitmap;

	public class DropDownListItem extends ItemRender
	{
		/** 文本 **/
		private var label:Label;
		/** 选中的效果图片 **/
		private var scaleBitmap:ScaleBitmap;
		
		public function DropDownListItem()
		{
			super();
			scaleBitmap = new ScaleBitmap(CommonSkin.MENU_SELECTED_BG);
			scaleBitmap.scale9Grid = CommonSkin.MENU_SELECTED_BG_GRID;
			scaleBitmap.visible = false;
			addChild(scaleBitmap);
			
			label = new Label();
			label.align = Align.CENTER;
			addChild(label);
			this.mouseChildren = false ;
			this.mouseEnabled = true;
		}
		override public function set width(value:Number):void
		{
			super.width = value;
			draw();
		}
		override public function set height(value:Number):void
		{
			super.height = value;
			draw();
		}
		
		override protected function draw():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x000000, 0);
			this.graphics.drawRect(0,0,width,height);
			this.graphics.endFill();
			
			scaleBitmap.x = 3;
			scaleBitmap.y = 0;
			scaleBitmap.setSize(width - 6,height);
			label.width = width - 2;
			label.x = 1;
			label.y = height - label.height >> 1;
		}
		
		override public function onOver(event:MouseEvent = null):void
		{
			scaleBitmap.visible = true;
		}
		override public function onOut(event:MouseEvent = null):void
		{
			scaleBitmap.visible = false;
		}
		
		public function set text(value:String):void
		{
			label.text = value;
			draw();
		}
		public function get text():String
		{
			return label.text;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!(value is DropDownListVO))
			{
				return;
			}
			label.text = ""+value.title;
			draw();
		}
		
		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			scaleBitmap.visible = value;
		}
		
	}
}