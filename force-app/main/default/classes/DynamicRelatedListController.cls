public with sharing class DynamicRelatedListController {
    @AuraEnabled(cacheable=true)
    public static List<SObject> getRelatedRecords(Id recordId, String relatedObject, String fields) {
        if (String.isBlank(recordId) || String.isBlank(relatedObject) || String.isBlank(fields)) {
            return new List<SObject>();
        }

        String parentField = '';
        Map<String, Schema.SObjectField> childFields = Schema.getGlobalDescribe().get(relatedObject).getDescribe().fields.getMap();

        // Find lookup field referencing parent
        for (Schema.SObjectField f : childFields.values()) {
            Schema.DescribeFieldResult dfr = f.getDescribe();
            if (dfr.getReferenceTo().size() > 0 && dfr.getReferenceTo()[0].getDescribe().getName() == 'Account') {
                parentField = dfr.getName();
                break;
            }
        }

        if (String.isBlank(parentField)) {
            throw new AuraHandledException('No relationship field found for Account on ' + relatedObject);
        }

        String query = 'SELECT ' + fields + ' FROM ' + relatedObject + ' WHERE ' + parentField + ' = :recordId LIMIT 50';
        return Database.query(query);
    }
}