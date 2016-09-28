package com.gamehero.sxd2.gui.core.interFace
{
	import com.gamehero.sxd2.gui.bag.model.vo.ItemCellData;
	/**
	 * 包含item的组件，展示tips的时候需要知道一些属性
	 * @author weiyanyu
	 * 
	 */
	public interface ICellData
	{
		/**
		 * 包含数据：<br>
		 * 1.格子来源
		 * 2.pro_item  （可能没有）
		 * 3.propVo （肯定有，设置2的时候给赋值了） 
		 * @return 
		 * 
		 */		
		function get itemCellData():ItemCellData;
	}
}