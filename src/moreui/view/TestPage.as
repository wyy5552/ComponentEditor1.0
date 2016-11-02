package moreui.view
{
	import game.ui.shell.MainUI;
	
	import morn.core.components.Clip;
	import morn.core.components.Component;
	import morn.core.components.Label;
	import morn.core.components.List;
	import morn.core.components.Tree;
	import morn.core.handlers.Handler;
	
	public class TestPage extends MainUI
	{
		private var list:List;
		public function TestPage()
		{
			super();
			var tree:Tree = new Tree();
			tree.width = 120;
			tree.height = 150;
			tree.spaceBottom = 10;
			tree.spaceLeft = 10;
			tree.itemRender =
				new XML("<Box>" +
					"<Clip url='png.comp.clip_selectBox' x='15' alpha='0.5' clipY='3' width='80' name='selectBox'/>" +
					"<Clip name='arrow' y='2' clipY='2' url='png.comp.clip_tree_arrow'/>" +
					"<Clip x='16' clipY='3' name='folder' url='png.comp.clip_tree_folder'/>" +
					"<Label x='36' name='label' width='100' color='0xefefef' height='20'/>" +
					"</Box>");
			tree.scrollBarSkin = "png.comp.vscroll";
			tree.xml =  <root>
			<item label="1">
			<item label="1_1" >
			<item label="1_1_1" />
			<item label="1_1_2" />
			<item label="1_1_3" />
			</item>
			<item label="1_2" />
			<item label="1_3" />					
			</item>
			<item label="2">
			<item label="2_1" />
			<item label="2_2" />
			<item label="2_3" />
			<item label="2_4" />
			</item>
			<item label="3"/>
			</root>;			
			addChild(tree);
//			list = getChildByName("list") as List;
//			list.renderHandler = new Handler(listRender);//自定义渲染方式
////			list.array = [{icon1:1,label1:"label1"},{icon1:2,label1:"label2"},{icon1:3,label1:"label3"},{icon1:4,label1:"label4"},{icon1:5,label1:"label5"},{icon1:6,label1:"label6"}];
//			list.array = ["label1", "label2", "label3", "label4", "label5", "label6", "label6", "label6", "label6", "label6", "label6"];//赋值
			
			tab.selectHandler = viewStack.setIndexHandler;
		}
		private function listRender(item:Component, index:int):void {
			if (index < list.length) {
				var icon:Clip = item.getChildByName("icon1") as Clip;
				icon.frame = index + 1;
				var label:Label = item.getChildByName("label1") as Label;
				label.text = list.array[index];
			}
		}
	}
}