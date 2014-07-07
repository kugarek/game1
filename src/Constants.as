package
{
    import flash.geom.Point;
    
    import starling.errors.AbstractClassError;

    public class Constants
    {
        public function Constants() { throw new AbstractClassError(); }
        
        // We chose this stage size because it is used by many mobile devices; 
        // it's e.g. the resolution of the iPhone (non-retina), which means that your game
        // will be displayed without any black bars on all iPhone models up to 4S.
        // 
        // To use landscape mode, exchange the values of width and height, and 
        // set the "aspectRatio" element in the config XML to "landscape". (You'll also have to
        // update the background, startup- and "Default" graphics accordingly.)
        
        /*public static const STAGE_WIDTH:int  = 320;
        public static const STAGE_HEIGHT:int = 480;*/
		
		public static const PL:String = "Pl";
		public static const ENG:String = "Eng";
		public static const BUNDLE_NAME: String = "localisation";
		
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const SIDEBAR:String = "sidebar";
		
		public static const SCALE_NORMAL_VALUE:Number = 1;
		public static const SCALE_SIDEBAR_VALUE:Number = 0.8;
		
		public static const MINUS_ONE_VALUE:int = -1;
		
		
		//digits names
		
		public static const ZERO:String = "Zero";
		public static const ONE:String = "One";
		public static const TWO:String = "Two";
		public static const THREE:String = "Three";
		public static const FOUR:String = "Four";
		public static const FIVE:String = "Five";
		public static const SIX:String = "Six";
		public static const SEVEN:String = "Seven";
		public static const EIGHT:String = "Eight";
		public static const NINE:String = "Nine";
	
		public static const ZERO_CORDS:Point = new Point(561, 310);
		public static const ONE_CORDS:Point = new Point(956, 248);
		public static const TWO_CORDS:Point = new Point(1501, 260);
		public static const THREE_CORDS:Point = new Point(276, 778);
		public static const FOUR_CORDS:Point = new Point(662, 884);
		public static const FIVE_CORDS:Point = new Point(1082, 778);
		public static const SIX_CORDS:Point = new Point(1483, 766);
		public static const SEVEN_CORDS:Point = new Point(309, 1296);
		public static const EIGHT_CORDS:Point = new Point(1089, 1308);
		public static const NINE_CORDS:Point = new Point(1488, 1244);
		
		
		//private var cords:Array = [new Point(361, 110), new Point(856, 48), new Point(1301, 60), 
			//new Point(76, 578), new Point(462, 684), new Point(882, 578), new Point(1283, 566), new Point(109, 1096), 
			//new Point(889, 1108), new Point(1288, 1044)] /* of Points which are cords for the digits */;
    }
}