<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_Approval_Email</fullName>
        <description>Send Approval Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Puppy_Registration_Approved</template>
    </alerts>
    <fieldUpdates>
        <fullName>Puppy_Registration_Status_Approved</fullName>
        <field>Registration_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Puppy Registration Status-Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Registration_Status_Pending</fullName>
        <field>Registration_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Update Registration Status-Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
