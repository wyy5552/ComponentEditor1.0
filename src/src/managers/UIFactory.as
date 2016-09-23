package src.managers
{
	import containers.SDBaseScrollPane;
	import containers.SDBasicsPane;
	import containers.SDHBox;
	import containers.SDPopupWin;
	import containers.SDScrollPane;
	import containers.SDUILoaderPanel;
	import containers.SDVBox;
	
	import controls.SDCheckBox;
	import controls.SDComboBox;
	import controls.SDCommonButton;
	import controls.SDDataGrid;
	import controls.SDLabel;
	import controls.SDList;
	import controls.SDRadioButton;
	import controls.SDTextArea;
	import controls.SDTextInput;
	
	import flash.display.Sprite;
	
	public class UIFactory
	{
		public static var PopupWin:String 			= "SDPopupWin";
		public static var CommonButton:String 		= "SDCommonButton";
		public static var CheckBox:String 			= "SDCheckBox";
		public static var RadioButton:String 		= "SDRadioButton";
		public static var Label:String 				= "SDLabel";
		public static var TextInput:String 			= "SDTextInput";
		public static var TextArea:String 			= "SDTextArea";
		public static var BasicsPane:String 		= "SDBasicsPane";
		public static var VBox:String 				= "SDVBox";
		public static var HBox:String 				= "SDHBox";
		public static var ComboBox:String		 	= "SDComboBox";
		public static var List:String 				= "SDList";
		public static var DataGrid:String 			= "SDDataGrid";
		public static var UILoaderPanel:String 		= "SDUILoaderPanel";
		public static var BaseScrollPane:String 	= "SDBaseScrollPane";
		
		
		private static var commonButton:Number = 0;
		private static var checkBox:Number = 0;
		private static var radioButton:Number = 0;
		private static var label:Number = 0;
		private static var textInput:Number = 0;
		private static var textArea:Number = 0;
		private static var canvas:Number = 0;
		private static var vbox:Number = 0;
		private static var hbox:Number = 0;
		private static var comboBox:Number = 0;
		private static var list:Number = 0;
		private static var colorPicker:Number = 0;
		private static var dataGrid:Number = 0;
		private static var uiLoaderPanel:Number = 0;
		private static var baseScrollPane:Number = 0;
		
		/**
		 * 创建UI 
		 */		
		public static function createUI(type:String,name:String = ""):Object
		{
			var uiObj:Object = new Object();
			switch(type)
			{
				case "SDPopupWin":
					uiObj.ui = new SDPopupWin();
					uiObj.name = "win";
					break;
				
				case "SDCommonButton":
					uiObj.ui = new SDCommonButton();
					uiObj.name = name==""?"commonButton"+commonButton:name;
					commonButton++;
					break;
				
				case "SDCheckBox":
					uiObj.ui = new SDCheckBox();
					uiObj.name = name==""?"checkBox_"+checkBox:name;
					checkBox++
					break;
				
				case "SDRadioButton":
					uiObj.ui = new SDRadioButton();
					uiObj.name = name==""?"radioButton_"+radioButton:name;
					radioButton++;
					break;
				
				case "SDLabel":
					uiObj.ui = new SDLabel();
					uiObj.name = name==""?"label_"+label:name;
					label++;
					break;
				
				case "SDTextInput":
					uiObj.ui = new SDTextInput();
					uiObj.name = name==""?"textInput_"+textInput:name;
					textInput++;
					break;
				
				case "SDTextArea":
					uiObj.ui = new SDTextArea();
					uiObj.name = name==""?"textArea_"+textArea:name;
					textArea++
					break;
				
				case "SDBasicsPane":
					uiObj.ui = new SDBasicsPane();
					uiObj.name = name==""?"canvas_"+canvas:name;
					canvas++
					break;
				
				case "SDVBox":
					uiObj.ui = new SDVBox();
					uiObj.name = name==""?"vbox_"+vbox:name;
					vbox++
					break;
				
				case "SDHBox":
					uiObj.ui = new SDHBox();
					uiObj.name = name==""?"hbox_"+hbox:name;
					hbox++
					break;
				
				case "SDComboBox":
					uiObj.ui = new SDComboBox();
					uiObj.name = name==""?"comboBox_"+comboBox:name;
					comboBox++
					break;
				
				case "SDList":
					uiObj.ui = new SDList();
					uiObj.name = name==""?"list_"+list:name;
					list++
					break;
				
				case "SDDataGrid":
					uiObj.ui = new SDDataGrid();
					uiObj.name = name==""?"dataGrid_"+dataGrid:name;
					dataGrid++
					break;
				
				case "SDUILoaderPanel":
					uiObj.ui = new SDUILoaderPanel();
					uiObj.name = name==""?"uiLoaderPanel"+uiLoaderPanel:name;
					uiLoaderPanel++
					break;
				
				case "SDBaseScrollPane":
					uiObj.ui = new SDBaseScrollPane();
					uiObj.name = name==""?"baseScrollPane"+baseScrollPane:name;
					baseScrollPane++
					break;
				
				default:
					return null;
			}
			return uiObj;
		}
	}
}