package actors
{
	import starling.display.Image;
	import starling.events.Event;
	
	public class Five extends Digit
	{
			
		
		public function Five()
		{
			create();
		}
		
		private function create():void
		{
			digitColor = new Image(Root.assets.getTexture( "05_color@2x.png" ));
			digitMono = new Image(Root.assets.getTexture( "05_mono@2x.png" ));
			
			digitColor.name = Constants.FIVE;
			digitMono.name = Constants.FIVE;
			
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