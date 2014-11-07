public class TodayReservationsController {

    private Map<String,List<Puppy__c>> locationPuppyMap = new  Map<String,List<Puppy__c>>();  
    
    public TodayReservationsController(){
        
    	List<Puppy_Reservation__c> resList = [Select Puppy_Location__r.Name, Puppy__r.Name ,Puppy__r.Puppy_Owner__c, Puppy__r.Picture_Path__c, Puppy__r.Date_of_Birth__c, Date__c  from Puppy_Reservation__c where Date__c = TODAY];  
        for(Puppy_Reservation__c r : resList){
            Puppy__c puppy = new Puppy__c(Name=r.Puppy__r.Name, Picture_Path__c =r.Puppy__r.Picture_Path__c);
            if(locationPuppyMap.containsKey(r.Puppy_Location__r.Name)){
                locationPuppyMap.get(r.Puppy_Location__r.Name).add(puppy);
            }else{
                List<Puppy__c> puppyList = new List<Puppy__c>();
                puppyList.add(puppy);
                locationPuppyMap.put(r.Puppy_Location__r.Name,puppyList);
            }
        }
    }
    
    public Map<String,List<Puppy__c>> getLocationPuppyMap(){
        return locationPuppyMap;
    }
        
}