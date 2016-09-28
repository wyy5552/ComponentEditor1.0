package com.gamehero.sxd2.gui.core.monthCard
{
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.BuffSkin;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
	import com.gamehero.sxd2.local.Lang;
	
	import flash.display.Bitmap;
	
	import alternativa.gui.base.ActiveObject;
	
	/**
	 * 月卡类型
	 * @author shenliangliang
	 * @E-mail: 971935832@qq.com
	 * 创建时间：2016-8-16 下午5:36:16
	 * 
	 */
	public class CardIcon extends ActiveObject
	{
		/**
		 * 小图标
		 * */
		public static const SMALL:String = "SMALL";
		/**
		 * 大图标
		 * */
		public static const BIG:String = "BIG";
		//图标
		private var icon:Bitmap;
		//类型
		private var type:int;
		public function CardIcon(type:int,size:String = SMALL)	
		{
			super();
			
			this.type = type;
			
			switch(type)
			{
				case CardIconType.TYPE_FOREVER_CARD:
				{
					icon = (size == SMALL)?new Bitmap(CommonSkin.FOREVER_CARD_S_BD):new Bitmap(BuffSkin.FOREVER_CARD_B_BD);
					addChild(icon);
					
					hint = Lang.instance.trans("vipcard_text_8");
					break;
				}
				case CardIconType.TYPE_MONTH_CARD:
				{
					icon = (size == SMALL)?new Bitmap(CommonSkin.MONTH_CARD_S_BD):new Bitmap(BuffSkin.MONTH_CARD_B_BD);
					addChild(icon);
					
					hint = Lang.instance.trans("vipcard_text_7");
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			if(icon)
				width = icon.width;
		}
	}
}