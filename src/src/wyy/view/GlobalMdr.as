package src.wyy.view
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.net.FileFilter;
	import flash.ui.Keyboard;
	
	import mx.controls.Button;
	
	import src.wyy.event.WyyEvent;
	import src.wyy.model.UIModel;
	import src.wyy.util.UISetMgr;
	import src.wyy.vo.DragObject;
	
	/**
	 * 最上层
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午4:05:19
	 */
	public class GlobalMdr implements IEventDispatcher
	{
		public var view:MyUI;
		
		public var cmp:ComponentView;
		
		public var ui:UIView;
		
		public var ppt:PropertyView;
		/**
		 * 当前拖动的 
		 */		
		public var curDrag:DragObject;
		/**
		 * 当前编辑的对象 
		 */		
		public var curFocus:DisplayObject;
		
		public var addVec:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
		public function GlobalMdr(ui:MyUI)
		{
			super();
			new UISetMgr();//实例化拖动点
			this.view = ui;
			
			this.cmp = ui.cmp;
			this.ui = ui.ui;
			this.ppt = ui.ppt;
			
			ui.addEventListener(Event.ADDED,onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			// TODO Auto-generated method stub
			cmp.addEventListener(WyyEvent.DRAG_COMPONENT,onStartDrag);
			view.stage.addEventListener(MouseEvent.MOUSE_UP,onStopDrag);
			//鼠标抬起
			ui.addEventListener(MouseEvent.MOUSE_UP,onUIUp);
			//鼠标点击ui编辑区域
			ui.addEventListener(MouseEvent.CLICK,onUIClick);
			
			ui.addEventListener(MouseEvent.ROLL_OVER,onUIOver);
			ui.addEventListener(MouseEvent.ROLL_OUT,onUIOut);
			
			
			view.saveBtn.addEventListener(MouseEvent.CLICK,onSaveCode);
			view.openBtn.addEventListener(MouseEvent.CLICK,onOpenCode);
		}
		
		private var _loadFile:File;
		
		protected function onOpenCode(event:MouseEvent):void
		{
			_loadFile = new File();
			_loadFile.addEventListener(Event.SELECT, selectFileHandler);
			var fileFilter:FileFilter = new FileFilter("游戏界面UI: (*.as)", "*.as");
			_loadFile.browseForOpen("游戏界面UI", [fileFilter]);
		}
		
		/**
		 * 选择地图配置文件 
		 * @param event
		 * 
		 */
		private function selectFileHandler(event:Event):void {
			_loadFile.removeEventListener(Event.SELECT, selectFileHandler);
			_loadFile.addEventListener(Event.COMPLETE, loadFileCompleteHandler);
			_loadFile.load();
		}
		/**
		 * 加载场景配置 
		 * @param event
		 * 
		 */
		private function loadFileCompleteHandler(event:Event):void 
		{
			_loadFile.removeEventListener(Event.COMPLETE, loadFileCompleteHandler);
			UIModel.inst.analyse(String(_loadFile.data));
		}	

		
		protected function onSaveCode(event:MouseEvent):void
		{
			UIModel.inst.sava(addVec);
		}
		
		protected function onUIOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			ui.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		protected function onUIOut(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			ui.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		/**
		 * ui编辑器里面的ui被点击 
		 * @param event
		 * 
		 */		
		protected function onUIClick(event:MouseEvent):void
		{
			
			if(event.target is DisplayObject)
			{
				if(event.target != ui)
				{
					trace(event.target);
					curFocus = event.target as DisplayObject;
					UISetMgr.editUI = curFocus;
					
					ppt.ui = curFocus;
				}
			}
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
		 * 鼠标在ui编辑部分抬起 
		 * @param event
		 * 
		 */		
		protected function onUIUp(event:MouseEvent):void
		{
			if(curDrag != null)
			{
				var btn:Button = new Button();
				ui.addElement(btn);
				var pt:Point = ui.globalToLocal(new Point(curDrag.x,curDrag.y));
				btn.x = pt.x;
				btn.y = pt.y;
				
				addVec.push(btn);
			}
		}
		
		protected function onStopDrag(event:MouseEvent):void
		{
			if(curDrag != null)
			{
				curDrag.stopDrag();
				view.removeElement(curDrag);
				curDrag = null;
			}
		}
		
		protected function onStartDrag(event:Event):void
		{
			curDrag = new DragObject();
			view.addElement(curDrag);
			curDrag.x = view.mouseX;
			curDrag.y = view.mouseY;
			curDrag.startDrag();
		}
		
		//
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function hasEventListener(type:String):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function willTrigger(type:String):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		
	}
}