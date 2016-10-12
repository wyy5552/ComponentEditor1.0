package src.wyy.util
{
	import com.gamehero.sxd2.gui.core.GeneralWindow;
	import com.gamehero.sxd2.gui.core.button.YY_SkinSetBtn;
	import com.gamehero.sxd2.gui.core.components.McPlayer;
	import com.gamehero.sxd2.gui.core.components.SpBitmap;
	import com.gamehero.sxd2.gui.core.group.DataGroup;
	import com.gamehero.sxd2.gui.core.label.ActiveLabel;
	import com.gamehero.sxd2.gui.core.util.SpAddUtil;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import src.wyy.model.CompDict;
	import src.wyy.model.ResourceModel;
	import src.wyy.vo.KeyValueVo;
	
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
				case CompDict.YY_McPlayer:
					dis = new McPlayer();
					break;
				case CompDict.YY_SpBitmap:
					dis = new SpBitmap();
					break;
				case CompDict.YY_DataGroup:
					dis = new DataGroup();
					break;
				default:
					dis = new Sprite;
			}
			dis.mouseEnabled = true;
			dis.mouseChildren = false;
			return dis;
		}
		
		public static function setSingleProperty(dis:Sprite,kv:KeyValueVo):void
		{
			switch(kv.type)
			{
				case KeyValueVo.int_type:
				{
					dis[kv.key] = int(kv.value);
					break;
				}
				case KeyValueVo.bd_type:
					var url:Array = kv.value.split("~");
					var bd:BitmapData = SpAddUtil.getBD(ResourceModel.inst.getDomain(url[0]),url[1]);
					dis[kv.key] = bd;
					break;
				case KeyValueVo.mc_type:
					var url:Array = kv.value.split("~");
					var obj:Object = SpAddUtil.getRes(ResourceModel.inst.getDomain(url[0]),url[1]);
					dis[kv.key] = obj;
					break;
				default:
				{
					dis[kv.key] = String(kv.value);
					break;
				}
			}
		}
	}
}