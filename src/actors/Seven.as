package actors
{
	import starling.display.Image;
	import starling.events.Event;
	
	public class Seven extends Digit
	{
			
		
		public function Seven()
		{
			create();
		}
		
		private function create():void
		{
			digitColor = new Image(Root.assets.getTexture( "07_color@2x.png" ));
			digitMono = new Image(Root.assets.getTexture( "07_mono@2x.png" ));
			
			digitColor.name = Constants.SEVEN;
			digitMono.name = Constants.SEVEN;
			
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