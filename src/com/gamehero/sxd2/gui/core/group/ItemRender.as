package com.gamehero.sxd2.gui.core.group
{
	
	import com.gamehero.sxd2.gui.theme.ifstheme.container.list.ListItemObject;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	
	/**
	 * 呈现项
	 * @author weiyanyu
	 * 创建时间：2015-9-10 下午4:02:49
	 * 
	 */
	public class ItemRender extends ListItemObject
	{
		
		
		public function ItemRender()
		{
			super();
		}
		
		protected var _ent:Object;
		/**
		 * 添加一个透明遮挡 
		 * @param w
		 * @param h
		 * 
		 */		
		public function addMaskShape(w:int,h:int):void
		{
			var shap:Shape = new Shape();
			shap.graphics.beginFill(0xff0000,0);
			shap.graphics.drawRect(0,0,w,h);
			shap.graphics.endFill();
			addChild(shap);
		}
		
		public function updateFuncNum(value:int):void
		{
			
		}
		
		public function set full(isFull:Boolean):void 
		{
			
		}
		
		public function setFuncIconLoc(lx:int,ly:int):void
		{
			
		}
		

		public function onClick(e:MouseEvent = null):void
		{
			
		}
		
		public function onDoubleClick(e:MouseEvent = null):void
		{
			
		}
		
		public function set ent(value:Object):void
		{
			_ent  = value;
		}
		
		public function get ent():Object
		{
			return _ent;
		}
		
		/**
		 *  鼠标划入<br>
		 * 之所以不用activeObject的over事件，是因为Gui的事件不受局部组件的控制<br>
		 */		
		public function onOver(e:MouseEvent = null):void
		{
		}
		
		public function onOut(e:MouseEvent = null):void
		{
		}
		
		
		override public function clear():void
		{
			_data = null;
		}
	}
}