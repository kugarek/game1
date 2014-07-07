package actors
{
	import starling.display.Image;
	import starling.events.Event;
	
	public class Eight extends Digit
	{
			
		
		public function Eight()
		{
			create();
		}
		
		private function create():void
		{
			digitColor = new Image(Root.assets.getTexture( "08_color@2x.png" ));
			digitMono = new Image(Root.assets.getTexture( "08_mono@2x.png" ));
			
			digitColor.name = Constants.EIGHT;
			digitMono.name = Constants.EIGHT;
			
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