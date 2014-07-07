package actors
{
	import starling.display.Image;
	import starling.events.Event;
	
	public class Four extends Digit
	{
			
		
		public function Four()
		{
			create();
		}
		
		private function create():void
		{
			digitColor = new Image(Root.assets.getTexture( "04_color@2x.png" ));
			digitMono = new Image(Root.assets.getTexture( "04_mono@2x.png" ));
			
			digitColor.name = Constants.FOUR;
			digitMono.name = Constants.FOUR;
			
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