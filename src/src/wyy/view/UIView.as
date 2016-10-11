package src.wyy.view
{
	
	import flash.display.Sprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.core.UIComponent;
	
	import src.wyy.event.WyyEvent;
	import src.wyy.util.BinderManager;
	import src.wyy.vo.PropertyBaseVo;
	import src.wyy.vo.SpriteVoBinder;
	
	
	/**
	 * ui编辑部分
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午3:37:21
	 */
	public class UIView extends UIComponent
	{
		
		private var binder:SpriteVoBinder;
		
		public var propertyView:PropertyView;
		
		private var binderMgr:BinderManager = BinderManager.inst;
		
		
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
		public function addItem(dis:Sprite,vo:PropertyBaseVo):void
		{
			if(binderMgr.addVec.indexOf(dis) == -1)
			{
				binderMgr.addVec.push(dis);
			}
			addChild(dis);
			dis.addEventListener(MouseEvent.MOUSE_DOWN,onItemDown);
		}
		public function removeItem(dis:Sprite):void
		{
			removeChild(dis);
			binderMgr.delSp(dis);
			binderMgr.addVec.splice(binderMgr.addVec.indexOf(dis),1);
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
			curFocus = event.target as Sprite;
			propertyView.data = binder.vo;
			FoucusUIMgr.inst.editUI = curFocus;
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
			var binder:SpriteVoBinder = binderMgr.getBinder(curFocus);
			propertyView.data = binder.vo;
		}
		//如果在拖动组件,表示只是设置坐标
		protected function onMouseMove(event:MouseEvent):void
		{
			binder.setSingleProperty("x",curFocus.x.toString());
			binder.setSingleProperty("y",curFocus.y.toString());
			propertyView.data = binder.vo;
			FoucusUIMgr.inst.editUI = curFocus;
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
		public function get curFocus():Sprite
		{
			return FoucusUIMgr.inst.editUI;
		}
		/**
		 * @private
		 */
		public function set curFocus(value:Sprite):void
		{
			FoucusUIMgr.inst.editUI = value;
			binder = binderMgr.getBinder(value);
		}
		
		public function clear():void
		{
			removeChildren();
			binderMgr.addVec = new Vector.<Sprite>();
		}

	}
}