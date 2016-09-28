package com.gamehero.sxd2.gui.core.tab
{
	import com.gamehero.sxd2.gui.core.group.ItemRender;
	import com.greensock.TweenMax;

	/**
	 * 只有两个页签，切换界面时候附带隐现的特效 （见布阵，命格等）
	 * @author weiyanyu
	 * 创建时间：2016-3-2 下午3:41:54
	 * 
	 */
	public class TabBarOnlyTwo extends TabBar
	{
		public function TabBarOnlyTwo()
		{
			super();
		}
		
		
		override public function set selectedIndex(value:int):void
		{
			super.selectedIndex = value;
			//可能只有一个页签功能开启,此时就不需要动画操作了。
			if(itemList.length > 1)
			{
				var btn:ItemRender = _curBtn;
				btn.mouseEnabled = false;//运动的过程中不要让btn接受鼠标点击，不然会有出现莫名其妙的错
				var btn0:ItemRender = itemList[0];
				//选中的按钮要放到第一个位置
				if(_type == HORIZEN)
				{
					TweenMax.to(btn,.2,{x:0,onComplete:endTween});
				}
				else if(_type == VERTICAL)
				{
					TweenMax.to(btn,.2,{y:0,onComplete:endTween});
				}
				function endTween():void
				{
					btn.mouseEnabled = true;
				}
				
				//未被选中的按钮放在第二个位置
				if(btn0 != btn)
				{
					if(_type == HORIZEN)
					{
						TweenMax.to(btn0,.2,{x:(btn.width + gap)});
					}
					else if(_type == VERTICAL)
					{
						TweenMax.to(btn0,.2,{y:(btn.height + gap)});
					}
					
				}
				var btn1:ItemRender = itemList[1];
				if(btn1 != btn)
				{
					if(_type == HORIZEN)
					{
						TweenMax.to(btn1,.2,{x:(btn.width + gap)});
					}
					else if(_type == VERTICAL)
					{
						TweenMax.to(btn1,.2,{y:(btn.height + gap)});
					}
				}
			}
			
		}
	}
}