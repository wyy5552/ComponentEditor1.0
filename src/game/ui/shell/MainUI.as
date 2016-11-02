/**Created by the Morn,do not modify.*/
package game.ui.shell {
	import morn.core.components.*;import moreui.view.*;
	public class MainUI extends View {
		public var viewStack:ViewStack = null;
		public var tab:Tab = null;
		protected static var uiXML:XML =
			<View width="1239" height="723">
			  <ViewStack x="222" y="146">
			    <ProgressBar skin="png.comp.progress"/>
			  </ViewStack>
			  <Tab labels="label1,label2" skin="png.comp.tab" x="380" y="507"/>
			  <List x="378" y="282" repeatX="2" repeatY="4" name="list">
			    <Box name="render">
			      <Clip skin="png.comp.clip_num" clipX="10" clipY="1" name="icon1"/>
			      <Label text="label" x="46" y="5" name="label1"/>
			    </Box>
			    <VScrollBar skin="png.comp.vscroll" x="157" y="4" name="scrollBar"/>
			  </List>
			  <Box x="376" y="154">
			    <Image skin="png.comp.blank" width="121" height="26"/>
			    <Clip skin="png.comp.clip_tree_arrow" x="5" y="6" clipX="1" clipY="2"/>
			  </Box>
			  <ViewStack x="646" y="211" var="viewStack">
			    <Box name="item0">
			      <Button label="label" skin="png.comp.button"/>
			      <Button label="label" skin="png.comp.button" x="90" y="2"/>
			    </Box>
			    <Box x="10" y="73" name="item1">
			      <CheckBox label="label" skin="png.comp.checkbox"/>
			      <CheckBox label="label" skin="png.comp.checkbox" x="87" y="2"/>
			    </Box>
			  </ViewStack>
			  <Tab labels="label1,label2" skin="png.comp.tab" x="653" y="337" var="tab"/>
			</View>;
		public function MainUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}