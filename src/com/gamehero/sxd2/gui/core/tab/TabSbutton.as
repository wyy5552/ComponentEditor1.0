package com.gamehero.sxd2.gui.core.tab
{
	import com.gamehero.sxd2.gui.core.IPanel;
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 页签按钮
	 * @author weiyanyu
	 * 创建时间：2015-12-9 上午11:40:21
	 * 
	 */
	public class TabSbutton extends ItemRender
	{
		protected var bmp:Bitmap;
		
		protected var upBd:BitmapData;
		
		protected var downBd:BitmapData;
		
		protected var overBd:BitmapData;
		
		
		protected var _panelClass:Class;
		protected var _panel:IPanel;
		protected var _panelParent:DisplayObjectContainer;
		protected var _px:int;
		protected var _py:int;
		
		
		public function TabSbutton(up:BitmapData,down:BitmapData = null,over:BitmapData = null,dis:BitmapData = null)
		{
			super();
			this.upBd = up;
			this.downBd = down;
			this.overBd = over;
			bmp = new Bitmap();
			addChild(bmp);
			bmp.bitmapData = upBd;
			if(up)
			{
				this.width = up.width;
				this.height = up.height;
			}
		}
		/**
		 * 绑定的面板 
		 * @return 
		 * 
		 */		
		public function get panel():IPanel
		{
			return _panel;
		}

		public function set panel(value:IPanel):void
		{
			_panel = value;
		}
		
		/**
		 * 添加页签绑定的类 
		 * @param pp 父容器
		 * @param pc 面板类
		 * @param px
		 * @param py
		 * 
		 */		
		public function addPanelClass(pp:DisplayObjectContainer,pc:Class,px:int = 0,py:int = 0):void
		{
			_panelParent = pp;
			_panelClass = pc;
			_px = px;
			_py = py;
		}

		override public function set selected(value:Boolean):void
		{
			super.selected = value;
			
			if(value)
			{
				if(_panel == null && _panelClass != null)
				{
					_panel = new _panelClass();
					_panelParent.addChild(_panel as DisplayObject);
					(_panel as DisplayObject).x = _px;
					(_panel as DisplayObject).y = _py;
				}
				if(_panel != null)//如果有绑定的界面
				{
					if(_panelParent)
					{
						_panelParent.addChild(DisplayObject(_panel));
					}
					DisplayObject(_panel).visible = true;
					_panel.init();
				}
				
				bmp.bitmapData = downBd == null ? upBd : downBd;
			}
			else
			{
				if(_panel != null)
				{
					if(_panelParent && DisplayObject(_panel).parent)
					{
						DisplayObject(_panel).parent.removeChild(DisplayObject(_panel));
					}
					DisplayObject(_panel).visible = false;
					_panel.clear();
				}
				bmp.bitmapData = upBd;
			}
		}
		
		
		override public function set over(value:Boolean):void
		{
			super.over = value;
			if(!selected)//如果被选中，则没有over什么的了
			{
				if(value)
				{
					bmp.bitmapData = overBd == null? upBd : overBd;
				}
				else
				{
					bmp.bitmapData = upBd;
				}
			}
		}
		
		override public function clear():void
		{
			super.clear();
		}
	}
}