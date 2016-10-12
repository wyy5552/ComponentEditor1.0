package src.wyy.util
{
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.button.YY_SkinSetBtn;
	import com.gamehero.sxd2.gui.core.group.DataGroup;
	import com.gamehero.sxd2.gui.core.label.ActiveLabel;
	
	import flash.display.Sprite;
	
	import src.wyy.model.CompDict;
	
	/**
	 * ui创建器
	 * @author weiyanyu
	 * 创建时间：2016-10-12 下午2:09:25
	 */
	public class UICreater
	{
		public function UICreater()
		{
		}
		
		/**
		 *  
		 * @param value
		 * @return 
		 * 
		 */		
		public static function getUIbyName(value:String):Sprite
		{
			var dis:Sprite;
			switch(value)
			{
				case CompDict.YY_SkinSetBtn:
					dis = new YY_SkinSetBtn;	
					break;
				case CompDict.YY_Label:
					dis = new ActiveLabel;
					break;
				case CompDict.YY_Window:
					dis = new GeneralWindow(1);
					break;
				case CompDict.YY_DataGroup:
					dis = new DataGroup();
					break;
				case CompDict.YY_DataGroup:
					dis = new DataGroup();
					break;
				default:
					dis = new Sprite;
			}
			dis.mouseEnabled = true;
			dis.mouseChildren = false;
			return BinderManager.setGraphics(dis);
		}
	}
}