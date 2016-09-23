package src.controls
{
	import flash.display.Sprite;
	
	import src.events.EditorEvents;
	import src.events.KeyEvent;

	/**
	 * 编辑控制器  
	 * @author yurs
	 * 
	 */	
	public class EditControls
	{
		private static var editRevokeArr:Array = [];
		private static var editRedoArr:Array = [];
		
		private static var revokeObj:Object;
		private static var redoObj:Object;
		private static var editObj:Object;
		
		public function EditControls()
		{
			EditorEvents.dispathcer.addEventListener(KeyEvent.REVOKE,revoke);
			EditorEvents.dispathcer.addEventListener(KeyEvent.REDO,redo);
		}
		
		private function revoke(e:KeyEvent):void
		{
			if(editRevokeArr.length == 0)return;
			var lastObj:Object = editRevokeArr.pop();
			editRedoArr.push(lastObj);
			
			if(lastObj.start.edit.hasOwnProperty("parent")){
				lastObj.end.edit.parent.removeChild(lastObj.end.ui);
			}else{
				if(lastObj.start.edit.hasOwnProperty("name"))
					lastObj.end.ui.name = lastObj.start.edit["name"];
				if(lastObj.start.edit.hasOwnProperty("x"))
					lastObj.end.ui.x = lastObj.start.edit["x"];
				if(lastObj.start.edit.hasOwnProperty("y"))
					lastObj.end.ui.y = lastObj.start.edit["y"];
				if(lastObj.start.edit.hasOwnProperty("width"))
					lastObj.end.ui.width = lastObj.start.edit["width"];
				if(lastObj.start.edit.hasOwnProperty("height"))
					lastObj.end.ui.height = lastObj.start.edit["height"];
				updata(lastObj.end.ui);
			}
		}
		
		private function redo(e:KeyEvent):void
		{
			if(editRedoArr.length == 0)return;
			var lastObj:Object = editRedoArr.pop();
			editRevokeArr.push(lastObj);
			
			if(lastObj.end.edit.hasOwnProperty("parent")){
				lastObj.start.edit.parent.addChild(lastObj.start.ui);
			}else{
				if(lastObj.end.edit.hasOwnProperty("name"))
					lastObj.start.ui.name = lastObj.end.edit["name"];
				if(lastObj.end.edit.hasOwnProperty("x"))
					lastObj.start.ui.x = lastObj.end.edit["x"];
				if(lastObj.end.edit.hasOwnProperty("y"))
					lastObj.start.ui.y = lastObj.end.edit["y"];
				if(lastObj.end.edit.hasOwnProperty("width"))
					lastObj.start.ui.width = lastObj.end.edit["width"];
				if(lastObj.end.edit.hasOwnProperty("height"))
					lastObj.start.ui.height = lastObj.end.edit["height"];
				updata(lastObj.start.ui);
			}
		}
		private function updata(ui:Sprite):void
		{
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_STAGE));
			EditorEvents.dispathcer.dispatchEvent(new EditorEvents(EditorEvents.UPDATE_SETTING,ui));
		}
		
		public static function addStartEdit(ui:Sprite,obj:Object):void
		{
			if(!ui)return;
			editObj = new Object();
			revokeObj = new Object();
			revokeObj.ui = ui;
			revokeObj.edit = obj;
			editObj.start = revokeObj
		}
		public static function addEndEdit(ui:Sprite,obj:Object):void
		{
			if(!ui)return;
			redoObj = new Object();
			redoObj.ui = ui;
			redoObj.edit = obj;
			editObj.end = redoObj;
			editRevokeArr.push(editObj);
			editRedoArr = [];
		}
	}
}