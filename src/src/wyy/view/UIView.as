package src.wyy.view
{
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.core.UIComponent;
	
	import src.wyy.event.WyyEvent;
	import src.wyy.util.BinderManager;
	import src.wyy.util.CodeParse;
	import src.wyy.vo.PropertyBaseVo;
	import src.wyy.vo.SpriteVoBinder;
	
	
	/**
	 * ui编辑部分
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午3:37:21
	 */
	public class UIView extends UIComponent
	{
		
		private var _curFocus:Sprite;
		
		private var binder:SpriteVoBinder;
		
		public var propertyView:PropertyView;
		
		private var model:BinderManager = BinderManager.inst;
		
		
		public function UIView()
		{
			super();
		}
		
		public function init():void
		{
			addEventListener(MouseEvent.ROLL_OVER,onUIOver);
			addEventListener(MouseEvent.ROLL_OUT,onUIOut);
			
			propertyView.addEventListener(WyyEvent.UI_NAME_CHANGE,onUINameChange);
		}
		
		protected function onUINameChange(event:WyyEvent):void
		{
			var uiName:String = event.data as String;
			binder.vo.uiName = uiName;
		}
		/**
		 * 编辑区添加组件 
		 * @param dis
		 * @param vo
		 * 
		 */		
		public function addItem(dis:DisplayObject,vo:PropertyBaseVo):void
		{
			if(model.addVec.indexOf(dis) == -1)
			{
				model.addVec.push(dis);
			}
			addChild(dis);
			dis.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
		}
		public function removeItem(dis:DisplayObject):void
		{
			removeChild(dis);
			model.delSp(dis);
			model.addVec.splice(model.addVec.indexOf(dis),1);
			dis.removeEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
		}
		/**
		 * 点击物品 
		 * @param event
		 * 
		 */		
		protected function onItemDown(event:Event):void
		{
			var sp:Sprite = event.target as Sprite;
			if(sp != curFocus)//当点击的是相同的，则不重新设置
			{
				propertyView.data = binder.vo;
				UIRect.inst.editUI = curFocus;
			}
			curFocus = event.target as Sprite;
			(curFocus).startDrag();
			addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			if(!curFocus.hasEventListener(WyyEvent.UI_RESIZE))
				curFocus.addEventListener(WyyEvent.UI_RESIZE,onResizeUI);
		}
		/**
		 * 重新设置大小 
		 * @param event
		 * 
		 */		
		protected function onResizeUI(event:Event):void
		{
			var binder:SpriteVoBinder = model.getBinder(curFocus);
			propertyView.data = binder.vo;
		}
		//如果在拖动组件,表示只是设置坐标
		protected function onMouseMove(event:MouseEvent):void
		{
			binder.setSingleProperty("x",curFocus.x.toString());
			binder.setSingleProperty("y",curFocus.y.toString());
			propertyView.data = binder.vo;
			UIRect.inst.editUI = curFocus;
		}
		/**
		 * 鼠标抬起 
		 */		
		public function onItemUp():void
		{
			if(curFocus)
			{
				Sprite(curFocus).stopDrag();
				removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				curFocus.removeEventListener(WyyEvent.UI_RESIZE,onResizeUI);
			}
		}
		
		/**
		 * 鼠标在ui编辑区，则监听按键动作 
		 * @param event
		 * 
		 */		
		protected function onUIOver(event:MouseEvent):void
		{
			addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		protected function onUIOut(event:MouseEvent):void
		{
			removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			if(curFocus != null)
			{
				if(event.keyCode == Keyboard.LEFT)
				{
					curFocus.x --;
				}
				else if(event.keyCode == Keyboard.RIGHT)
				{
					curFocus.x ++;
				}
				else if(event.keyCode == Keyboard.DOWN)
				{
					curFocus.y ++;	
				}
				else if(event.keyCode == Keyboard.UP)
				{
					curFocus.y --;	
				}
				
			}
		}

		/**
		 * 当前编辑的对象 
		 */
		public function get curFocus():Sprite
		{
			return _curFocus;
		}
		/**
		 * @private
		 */
		public function set curFocus(value:Sprite):void
		{
			_curFocus = value;
			binder = model.getBinder(value);
		}
		
		public function clear():void
		{
			removeChildren();
			model.addVec = new Vector.<DisplayObject>();
			_curFocus = null;
		}

	}
}