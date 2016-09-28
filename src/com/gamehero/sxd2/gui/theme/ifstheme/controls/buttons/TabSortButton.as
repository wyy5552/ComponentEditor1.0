package com.gamehero.sxd2.gui.theme.ifstheme.controls.buttons
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import alternativa.gui.base.ActiveObject;
	import alternativa.gui.data.DataProvider;
	
	/**
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-9-22 上午11:06:14
	 * 
	 */
	public class TabSortButton extends ActiveObject
	{
		private var _label:Label;
		
		private var _overBp:Bitmap;
		
		private var _downBp:Bitmap;
		
		private var _upBp:Bitmap;
		
		private var _select:Boolean;
		
		private var _selectColor:uint;
		private var _normalColor:uint;
		
		private var _sortType:String;
		private var _defauteSort:String;
		
		private var _callBack:Function;
		public function TabSortButton(
			label:String,
			callBack:Function,
			defSort:String,
			overBD:BitmapData,downBD:BitmapData,upBD:BitmapData,
			normalColor:uint = GameDictionary.GRAY_DEEP,selectColor:uint = GameDictionary.WHITE)
		{
			super();
			_callBack = callBack;
			_sortType = defSort;
			_selectColor = selectColor;
			_normalColor = normalColor;
			
			_defauteSort = _sortType;
			if(overBD)
			{
				_overBp = new Bitmap(overBD);
				addChild(_overBp);
				
				var offset:Number = 20;
				_label = new Label();
				_label.color = _normalColor;
				addChild(_label);
				_label.text = label;
				
				_overBp.width = _label.width + offset;
				_overBp.visible = false;
				
				_label.x = offset * 0.5 + 1;
				
				_upBp = new Bitmap(upBD);
				addChild(_upBp);
				
				_downBp = new Bitmap(downBD);
				addChild(_downBp);
				
				_overBp.visible = _upBp.visible = _downBp.visible = false;
				
				resize(_overBp.width,_overBp.height);
				
				//setposition
				_upBp.y = _downBp.y = 3;
				_upBp.x = width - upBD.width >> 1;
				_downBp.x = width - downBD.width >> 1;
				_label.y = 10;
				
				graphics.beginFill(0,0);
				graphics.drawRect(0,0,width,height);
				graphics.endFill();
			}
		}
		
		override public function get out():Boolean
		{
			// TODO Auto Generated method stub
			return super.out;
		}
		
		override public function set out(value:Boolean):void
		{
			// TODO Auto Generated method stub
			super.out = value;
			
			if(value)
			{
				_overBp.visible = false;
			}
		}
		
		override public function get over():Boolean
		{
			// TODO Auto Generated method stub
			return super.over;
		}
		
		override public function set over(value:Boolean):void
		{
			// TODO Auto Generated method stub
			super.over = value;
			
			if(value)
			{
				_overBp.visible = true;
			}
		}
		
		/**
		 *切换排序 
		 * 
		 */		
		private function switchSortType():void
		{
			switch(_sortType)
			{
				case DataProvider.ASC:
				{
					setSortDes();
					break;
				}
				case DataProvider.DESC:
				{
					setSortAsc();
					break;
				}
			}
			//
			_callBack && _callBack.call(null,this);
		}
		
		public function setSortAsc():void
		{
			_sortType = DataProvider.ASC;
			_upBp.visible = true;
			_downBp.visible = false;
			
			_label.color = _selectColor;
		}
		
		public function setSortDes():void
		{
			_sortType = DataProvider.DESC;
			_upBp.visible = false;
			_downBp.visible = true;
			
			_label.color = _selectColor;
		}
		
		override public function click():void
		{
			// TODO Auto Generated method stub
			super.click();
			
			//切换排序
			switchSortType();
		}
		
		
		public function set select(value:Boolean):void
		{
			_select = value;
			
			_downBp.visible = _upBp.visible = false;
			_label.color = _normalColor;
			
			_sortType = _defauteSort;
		}

		public function get sortType():String
		{
			return _sortType;
		}


	}
}