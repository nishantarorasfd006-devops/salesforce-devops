public class genericRecordUploader {
    public static String insertRecord (List<Account> records, String resultFormat) {
        List<InsertResult> response = new List<InsertResult>();
        
        if (records == null || records.isEmpty()) {
            return JSON.serialize(response);
        }
        
        Database.SaveResult[] results = Database.insert(records, false);    
        for (Integer i = 0; i < results.size(); i++) {
            Database.SaveResult sr = results[i];
            InsertResult r = new InsertResult();
            r.rowNumber = i + 1;
            r.success = sr.isSuccess();
            r.recordId = sr.isSuccess() ? String.valueOf(sr.getId()) : null;
            if (!sr.isSuccess()) {
                List<String> errors = new List<String>();
                for (Database.Error e : sr.getErrors()) {
                    errors.add(e.getStatusCode() + ': ' + e.getMessage());
                }
                r.errorMessage = String.join(errors, ' | ');
            }
            response.add(r);
        }
        /*if(resultFormat == 'json') {
        	return JSON.serialize(response);
        } else {
            return response;
        }*/
        return JSON.serialize(response);
    }
    
    public class InsertResult {
        public Integer rowNumber;
        public Boolean success;
        public String recordId;
        public String errorMessage;
    }
}