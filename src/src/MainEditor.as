package src
{
	import flash.events.Event;
	
	import mx.containers.Canvas;
	
	import src.controls.KeyControl;
	import src.controls.XMLControls;
	import src.utils.KeyStateUtil;

	public class MainEditor extends Canvas
	{
		/**
		 * 预览模式 
		 */		
		public static var isPreviewMode:Boolean = false;
		
		/**
		 * 编辑模式 
		 */		
		public static var isEditState:Boolean = false;
		
		/**
		 * 主编辑界面 
		 */		
		private var editPanel:EditPanel;
		
		/**
		 * 菜单栏 
		 */		
		private var menuPanel:MenuPanel;
		
		private var xmlControls:XMLControls;
		private var keyControl:KeyControl;
		private var isInto:Boolean = false;
		
		public function MainEditor()
		{
			xmlControls = new XMLControls();
			keyControl = new KeyControl();
			
			menuPanel = new MenuPanel();
			addChild(menuPanel);
			
			editPanel = new EditPanel();
			addChild(editPanel);
			editPanel.y = 50;
		}
	}
}