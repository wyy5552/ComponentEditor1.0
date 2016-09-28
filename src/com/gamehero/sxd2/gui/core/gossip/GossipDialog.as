package com.gamehero.sxd2.gui.core.gossip
{
	
	
	/**
	 * 弹出的对话框<br>
	 * <li>待机情况下播放一组语句
	 * <li>可以直接插入一句话，打断待机；说完后再继续播放正常的说话
	 * @author weiyanyu
	 * 创建时间：2016-9-5 下午4:04:22
	 */
	public class GossipDialog extends GossipBase
	{
		public function GossipDialog(direct:int = 1,delayTime:int = 20)
		{
			super(direct);
			this.delayTime = delayTime;
			
			_animate = new AnimateDialogue(this);
		}
		
		private var _animate:AnimateDialogue;
		
		/**
		 * 插入一句话 
		 * @param str
		 * 
		 */		
		public function insert(str:String):void
		{
			_animate.init();//先停止掉一切
			msgArr.unshift(str);
			start(0);
			msgArr.shift();
		}
		override public function start(index:int = -1):void
		{
			if(index == -1)
			{
				_bubbleArrIndex = Math.random() * msgArr.length;//从
			}
			else
			{
				_bubbleArrIndex = index;
			}
			showDialog(msgArr[_bubbleArrIndex]);
			_animate.start(intervalShow);
		}
		
		override public function clear():void
		{
			super.clear();
			_animate.clear();
		}
	}
}