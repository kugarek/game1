package actors
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Digit extends Sprite
	{
		
		private var _digitColor:Image;
		private var _digitMono:Image;
		
		public function Digit()
		{
			super();
			
		}
		
		
		
		public function get digitColor():Image
		{
			return _digitColor;
		}
		
		public function set digitColor(value:Image):void
		{
			_digitColor = value;
		}
		
		public function get digitMono():Image
		{
			return _digitMono;
		}
		
		public function set digitMono(value:Image):void
		{
			_digitMono = value;
		}

		
	}
}