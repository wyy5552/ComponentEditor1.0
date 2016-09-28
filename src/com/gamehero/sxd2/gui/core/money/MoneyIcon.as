package com.gamehero.sxd2.gui.core.money
{
	
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.IconSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;

	/**
	 * 消耗类物品图标
	 * @author weiyanyu
	 * 创建时间：2015-9-17 下午4:53:04
	 * 
	 */
	public class MoneyIcon extends Bitmap
	{
		/**
		 * 图标大小一般都是一样大的，方便对位 
		 */		
		public static const SIZE:int = 24;
		
		protected var _iconId:int;
		
		public function MoneyIcon(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
		}
		
		public function get iconId():int
		{
			return _iconId;
		}
		
		
		/**
		 *资源路径，自动加载 
		 * @param value 货币id
		 * 
		 */		
		public function set iconId(value:int):void
		{
			_iconId = value;
			if(_iconId == MoneyDict.TONG_QIAN)
			{
				bitmapData = IconSkin.TONGQIAN;
			}
			else if(_iconId == MoneyDict.YUANBAO)
			{
				bitmapData = IconSkin.YUANBAO;
			}
			else if(_iconId == MoneyDict.YIN_PIAO)
			{
				bitmapData = IconSkin.YIN_PIAO;
			}
			else if(_iconId == MoneyDict.LING_YUN)
			{
				bitmapData = IconSkin.LINGYUN;
			}
			else if(_iconId == MoneyDict.JING_YAN)
			{
				bitmapData = IconSkin.JINGYAN;
			}
			else if(_iconId == MoneyDict.CAN_YE)
			{
				bitmapData = IconSkin.CANYE;
			}
			else if(_iconId == MoneyDict.MING_HUN)
			{
				bitmapData = IconSkin.MINGHUN;
			}
			else if(_iconId == MoneyDict.YUE_LI)
			{
				bitmapData = IconSkin.YUELI;
			}
			else if(_iconId == MoneyDict.BANG_GONG)
			{
				bitmapData = IconSkin.BANGGONG;
			}
			else if(_iconId == MoneyDict.PRESTIGE)
			{
				bitmapData = IconSkin.SHENGWANG;
			}
			else if(_iconId == MoneyDict.LING_SHI)
			{
				bitmapData = IconSkin.LINGSHI;
			}
			else if(_iconId == MoneyDict.LING_PO)
			{
				bitmapData = IconSkin.LINGPO;
			}
			else if(_iconId == MoneyDict.WU_XING)
			{
				bitmapData = IconSkin.WUXING;
			}
			else
			{
				bitmapData = null;
			}
			
		}
		
		override public function set bitmapData(value:BitmapData):void
		{
			super.bitmapData = value;
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}