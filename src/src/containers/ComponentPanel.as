package src.containers
{
	import controls.SDCommonButton;
	
	import core.SDSprite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.containers.Panel;
	import mx.containers.TitleWindow;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.TextArea;
	import mx.controls.TextInput;
	
	import spark.layouts.HorizontalAlign;
	
	import src.events.ComponentEvent;
	import src.events.EditorEvents;
	import src.managers.UIFactory;

	/**
	 * 组件列表 
	 * @author yurs
	 * 
	 */	
	public class ComponentPanel extends Canvas
	{
		private var uiName:String = "PopupWin,CommonButton,CheckBox,RadioButton,Label,TextInput,TextArea," +
									"BasicsPane,VBox,HBox,ComboBox,List,DataGrid,UILoaderPanel,BaseScrollPane";
		public var uiArr:Array = [];
		
		public var originalBox:Canvas = new Canvas();
		public var newMyBox:VBox = new VBox();
		
		public var newComponent:Label;
		public var panel:Panel;
		public var textArea:TextArea;
		public var enter:Button;
		public var cancel:Button;
		
		public function ComponentPanel()
		{
			uiArr = uiName.split(",");
			addChild(originalBox);
			addChild(newMyBox);
			
			newComponent = new Label();
			newComponent.text = "创建新组件";
			newMyBox.addChild(newComponent);
			newMyBox.x = 17;
			
			panel = new Panel();
			panel.width = 200;
			panel.height = 100;
			panel.x = 150;
			panel.y = 300;
			panel.visible = false;
			
			enter = new Button();
			panel.addChild(enter);
			cancel = new Button();
			panel.addChild(cancel);
			textArea = new TextArea();
			panel.addChild(textArea);
			
			textArea.width = 180;
			textArea.height = 22;
			textArea.text = "customComponent";
			panel.layout = "absolute";
			panel.title = "输入名称"
			enter.label = "确定";
			enter.width = 50;
			enter.height = 20;
			enter.x = 40;
			enter.y = panel.height-enter.height-40;
			cancel.label = "取消";
			cancel.width = 50;
			cancel.height = 20;
			cancel.x = (panel.width/2-enter.x-enter.width)*2+enter.x+enter.width;
			cancel.y = enter.y;
		} 
	}
}