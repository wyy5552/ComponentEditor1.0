package com.gamehero.sxd2.common
{
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	
	import bowser.render.display.TextItem;
	
	/**
	 * 
	 * @author cuixu
	 * @create：2016-7-11
	 **/
	public class TextItem extends bowser.render.display.TextItem
	{
		public function TextItem(width:int=-1, height:int=-1)
		{
			super(width, height);
			_label = new Label(false);
			super.initUI();
		}
	}
}