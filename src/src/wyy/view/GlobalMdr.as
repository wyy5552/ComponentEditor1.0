package src.wyy.view
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	import src.wyy.event.WyyEvent;
	import src.wyy.model.UIModel;
	import src.wyy.util.UICreater;
	import src.wyy.util.UIRect;
	import src.wyy.vo.DragObject;
	import src.wyy.vo.PropertyBaseVo;
	
	/**
	 * 最上层
	 * @author weiyanyu
	 * 创建时间：2016-9-22 下午4:05:19
	 */
	public class GlobalMdr
	{
		public var view:MyUI;
		
		public var cmp:ComponentView;
		
		public var ui:UIView;
		
		public var ppt:PropertyView;
		/**
		 * 当前拖动的 
		 */		
		public var curDrag:DragObject;
		
		private var uiRect:UIRect;
	
		
		public function GlobalMdr(ui:MyUI)
		{
			super();
			uiRect = UIRect.inst;
			
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
		 * @param event
		 */
		private function selectFileHandler(event:Event):void {
			_loadFile.removeEventListener(Event.SELECT, selectFileHandler);
			_loadFile.addEventListener(Event.COMPLETE, loadFileCompleteHandler);
			_loadFile.load();
		}
		/**
		 * @param event
		 */
		private function loadFileCompleteHandler(event:Event):void 
		{
			ui.clear();
			_loadFile.removeEventListener(Event.COMPLETE, loadFileCompleteHandler);
			var addVec:Vector.<DisplayObject> = UIModel.inst.analyse(String(_loadFile.data));
			for(var i:int = 0; i < addVec.length; i++)
			{
				ui.addItem(addVec[i]);
			}
		}	

		/**
		 * 生成代码 
		 * @param event
		 * 
		 */		
		protected function onSaveCode(event:MouseEvent):void
		{
			UIModel.inst.sava(ui.addVec);
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
				var vo:PropertyBaseVo = curDrag.data as PropertyBaseVo;
				var dis:DisplayObject = UICreater.getUIbyName(vo.type)
				ui.addItem(dis);
				dis.x = ui.mouseX;
				dis.y = ui.mouseY;
				for(var i:int = 0; i < vo.deProperty.length; i++)
				{
					dis[vo.deProperty[i]] = vo.deValue[i];
				}
				ui.addVec.push(dis);
			}
		}
		/**
		 * 舞台鼠标抬起
		 * @param event
		 * 
		 */		
		protected function onStopDrag(event:MouseEvent):void
		{
			uiRect.onMouseUp();
			
			if(curDrag != null)
			{
				curDrag.stopDrag();
				view.removeElement(curDrag);
				curDrag = null;
			}
		}
		
		protected function onStartDrag(event:WyyEvent):void
		{
			curDrag = new DragObject();
			view.addElement(curDrag);
			curDrag.data = event.data;
			curDrag.x = view.mouseX;//设置到鼠标位置
			curDrag.y = view.mouseY;
			curDrag.width = event.data["width"];
			curDrag.height = event.data["height"];
			curDrag.startDrag();
		}
		
	}
}