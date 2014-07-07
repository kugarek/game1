package actors
{
	import starling.display.Image;
	import starling.events.Event;
	
	public class Three extends Digit
	{
			
		
		public function Three()
		{
			create();
		}
		
		private function create():void
		{
			digitColor = new Image(Root.assets.getTexture( "03_color@2x.png" ));
			digitMono = new Image(Root.assets.getTexture( "03_mono@2x.png" ));
			
			digitColor.name = Constants.THREE;
			digitMono.name = Constants.THREE;
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.removeEventListeners();
			digitColor = null;
			digitMono = null;
		}

	}
}