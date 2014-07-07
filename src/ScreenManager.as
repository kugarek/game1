package 
{
	

	public class ScreenManager //extends Sprite
	{
		private var _currentScreen:String;
		
		public function ScreenManager(value:String)
		{
			currentScreen = value;
		}
		
		

		[Bindable]
		public function get currentScreen():String
		{
			return _currentScreen;
		}

		public function set currentScreen(value:String):void
		{
			_currentScreen = value;
		}

	}
}