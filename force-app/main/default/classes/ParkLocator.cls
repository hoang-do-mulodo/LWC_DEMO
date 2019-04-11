public with sharing class ParkLocator {


	public static String[] country(String ctry){
		//return  ['german', 'vn'];

		ParkService.ParksImplPort park = new ParkService.ParksImplPort();

		System.debug('ctry' + park.byCountry(ctry));
		String[] 	parksName = park.byCountry(ctry);
		return parksName; 
		//return park.byCountry(ctry);
	}
}