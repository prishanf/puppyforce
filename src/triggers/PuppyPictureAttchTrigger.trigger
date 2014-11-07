trigger PuppyPictureAttchTrigger on Attachment (after insert,after update) {
	
    Map<id,id> objectIdAttechmentIdMap = new Map<Id,Id>();
    List<Puppy__c> puppiesToUpdate = new List<Puppy__c>();
    for(Attachment attch : trigger.new){
        objectIdAttechmentIdMap.put(attch.ParentId,attch.id);
    }
    List<Puppy__c>  puppyRecords = [select id , Picture_Path__c from Puppy__c where id in : objectIdAttechmentIdMap.KeySet()]; 
    for(Puppy__c puppy : puppyRecords){
	    puppy.Picture_Path__c = '/servlet/servlet.FileDownload?file=' + objectIdAttechmentIdMap.get(puppy.id);
        puppiesToUpdate.add(puppy);
    }
	update puppiesToUpdate;
}