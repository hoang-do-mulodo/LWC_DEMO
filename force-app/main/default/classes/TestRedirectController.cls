public with sharing class TestRedirectController {

	public String inputValue{get; set;}
	public TestRedirectController() {

		inputValue = 'world';
		
	}

	public PageReference reloadPage(){
		PageReference pr = Page.DemoRedirect;
		pr.getParameters().put('id' ,  '11123434');
		pr.setRedirect(true);
		return pr;
	}
}