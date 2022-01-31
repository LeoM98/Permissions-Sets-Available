public with sharing class PermissionAssigments_ctr {
    
    @AuraEnabled(cacheable = true)
    public static List<WrapperPermissions> getPermissionsByUsers(){

        List<WrapperPermissions> wrapperInstance = new List<WrapperPermissions>();
        Integer count = 0;

        List<PermissionSet> permissionSet = new List<permissionSet>();
        List<Id> idsPermissionsSetAssignment = new List<Id>();
        List<PermissionSetAssignment> lstPermissionsAssignment = [SELECT Id, PermissionSetId FROM PermissionSetAssignment WHERE AssigneeId = :Userinfo.getUserId() AND isActive = true WITH SECURITY_ENFORCED];
        if (!lstPermissionsAssignment.isEmpty()) {

            for (PermissionSetAssignment psa : lstPermissionsAssignment) {
                idsPermissionsSetAssignment.add(psa.PermissionSetId);
            } 
        }

        if (!idsPermissionsSetAssignment.isEmpty()) {
            permissionSet = [SELECT Id, Label
            FROM PermissionSet
            WHERE Id IN: idsPermissionsSetAssignment WITH SECURITY_ENFORCED];
        }
        
        if (!permissionSet.isEmpty()) {
            for(PermissionSet permission: permissionSet){
                if(count > 0){
                    WrapperPermissions wrapperInstanceObject = new WrapperPermissions();
                    wrapperInstanceObject.label = permission.Label;
                    wrapperInstanceObject.value = permission.Id;
                    wrapperInstance.add(wrapperInstanceObject);
                }
                count ++;
            }
        }

        if(!wrapperInstance.isEmpty()){
            return wrapperInstance;
        }

        return null;
    }
    
    public class WrapperPermissions{
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String value;
    }
}
