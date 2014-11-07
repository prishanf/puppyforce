trigger PuppyReservarionTrigger on Puppy_Reservation__c (after insert) {

    List<AggregateResult> results = [Select Puppy_Location__c, Date__c, count(Puppy__c) Num from Puppy_Reservation__c group by Puppy_Location__c, Date__c];
    List<Puppy_Reservation__c> items = [select Puppy_Location__c, Date__c, Puppy_Location__r.capacity__c  from Puppy_Reservation__c where Id IN :Trigger.new];
    
    Map<String,Integer> LocaitonCountMap= new Map<String,Integer>();
    for( AggregateResult r : results){
        LocaitonCountMap.put((String)r.get('Puppy_Location__c')+String.valueof(r.get('Date__c')).substring(0,10),(Integer)r.get('Num'));
    }
  
    for(Puppy_Reservation__c reservation : items ){
        String key = reservation.Puppy_Location__c+ String.valueOf(reservation.Date__c);
        if(LocaitonCountMap.get(key) >= reservation.Puppy_Location__r.capacity__c){
            Trigger.new[0].Puppy_Location__c.addError('Maximum Capacity Exceeds');
        }
    }
  
}