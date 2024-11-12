Lexer result:

Comment( This is an example of a very simple time tracking application.) | -- This is an example of a very simple time tracking application.
Whitespace(2) | 


Comment( TABLES) | -- TABLES
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Keyword(IF) | IF
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(EXISTS) | EXISTS
Whitespace(1) | 
    
Identifier(migration_script) | "migration_script"
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
        
Identifier(version) | "version"
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Special(,) | ,
Whitespace(1) | 
        
Identifier(identifier) | "identifier"
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(0) |    
Special(,) | ,
Whitespace(1) | 
        
Identifier(up) | "up"
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(0) |            
Special(,) | ,
Whitespace(1) | 
        
Identifier(down) | "down"
Whitespace(0) |  
Keyword(TEXT) | TEXT
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(1) | 
    
Special()) | )
Special(;) | ;
Whitespace(3) | 



Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(TABLE) | TABLE
Whitespace(0) |  
Keyword(IF) | IF
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(EXISTS) | EXISTS
Whitespace(1) | 
    
Identifier(activity_log) | "activity_log"
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
        
Identifier(timestamp) | "timestamp"
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Special(,) | ,
Whitespace(1) | 
        
Identifier(active) | "active"
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(0) |    
Special(,) | ,
Whitespace(1) | 
        
Keyword(PRIMARY) | PRIMARY
Whitespace(0) |  
Keyword(KEY) | KEY
Whitespace(0) |  
Special(() | (
Identifier(timestamp) | "timestamp"
Special()) | )
Whitespace(1) | 
    
Special()) | )
Special(;) | ;
Whitespace(3) | 



Comment( INDEXES) | -- INDEXES
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(INDEX) | INDEX
Whitespace(0) |  
Keyword(IF) | IF
Whitespace(0) |  
Keyword(NOT) | NOT
Whitespace(0) |  
Keyword(EXISTS) | EXISTS
Whitespace(0) |  
Identifier(activity_log_time) | "activity_log_time"
Whitespace(0) |  
Keyword(ON) | ON
Whitespace(0) |  
Identifier(activity_log) | "activity_log"
Whitespace(0) |  
Special(() | (
Identifier(timestamp) | "timestamp"
Whitespace(0) |  
Keyword(DESC) | DESC
Special()) | )
Special(;) | ;
Whitespace(3) | 



Comment( VIEWS) | -- VIEWS
Whitespace(1) | 

Keyword(CREATE) | CREATE
Whitespace(0) |  
Keyword(VIEW) | VIEW
Whitespace(1) | 
  
Identifier(activity_log_report) | "activity_log_report"
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(1) | 

Keyword(WITH) | WITH
Whitespace(1) | 
  
Identifier(activity_log_with_lead) | "activity_log_with_lead"
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(timestamp_seconds) | "timestamp_seconds"
Special(,) | ,
Whitespace(1) | 
    
Identifier(active) | "active"
Whitespace(0) |            
Special(,) | ,
Whitespace(1) | 
    
Identifier(automatic) | "automatic"
Whitespace(0) |         
Special(,) | ,
Whitespace(1) | 
    
Identifier(lead_active) | "lead_active"
Whitespace(0) |       
Special(,) | ,
Whitespace(1) | 
    
Identifier(lead_automatic) | "lead_automatic"
Whitespace(1) | 
  
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
      
Identifier(timestamp) | "timestamp"
Whitespace(0) |  
Operator(/) | /
Whitespace(0) |  
Numeric(1.0e9) | 1000000000.0
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(timestamp_seconds) | "timestamp_seconds"
Special(,) | ,
Whitespace(1) | 
      
Identifier(active) | "active"
Whitespace(0) |                                          
Special(,) | ,
Whitespace(1) | 
      
Identifier(automatic) | "automatic"
Whitespace(0) |                                       
Special(,) | ,
Whitespace(1) | 
      
Identifier(LEAD) | LEAD
Special(() | (
Identifier(active) | "active"
Special()) | )
Whitespace(0) |  
Keyword(OVER) | OVER
Whitespace(0) |         
Special(() | (
Whitespace(1) | 
        
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
          
Identifier(timestamp) | "timestamp"
Whitespace(0) |  
Keyword(ASC) | ASC
Special(,) | ,
Whitespace(1) | 
          
Identifier(active) | "active"
Whitespace(0) |  
Keyword(DESC) | DESC
Whitespace(1) | 
      
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(lead_active) | "lead_active"
Whitespace(0) |      
Special(,) | ,
Whitespace(1) | 
      
Identifier(LEAD) | LEAD
Special(() | (
Identifier(automatic) | "automatic"
Special()) | )
Whitespace(0) |  
Keyword(OVER) | OVER
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
        
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
          
Identifier(timestamp) | "timestamp"
Whitespace(0) |  
Keyword(ASC) | ASC
Special(,) | ,
Whitespace(1) | 
          
Identifier(active) | "active"
Whitespace(0) |  
Keyword(DESC) | DESC
Whitespace(1) | 
      
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(lead_automatic) | "lead_automatic"
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
      
Identifier(activity_log) | "activity_log"
Whitespace(1) | 
    
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
      
Identifier(timestamp_seconds) | "timestamp_seconds"
Whitespace(0) |  
Keyword(ASC) | ASC
Special(,) | ,
Whitespace(1) | 
      
Identifier(active) | "active"
Whitespace(0) |  
Keyword(DESC) | DESC
Whitespace(1) | 
  
Special()) | )
Whitespace(0) |                                                                         
Special(,) | ,
Whitespace(1) | 
  
Identifier(extended_activity_log) | "extended_activity_log"
Whitespace(0) |  
Special(() | (
Identifier(timestamp_seconds) | "timestamp_seconds"
Special(,) | ,
Whitespace(0) |  
Identifier(active) | "active"
Special(,) | ,
Whitespace(0) |  
Identifier(is_unknown) | "is_unknown"
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
      
Identifier(timestamp_seconds) | "timestamp_seconds"
Whitespace(0) |                
Special(,) | ,
Whitespace(1) | 
      
Identifier(active) | "active"
Whitespace(0) |                           
Special(,) | ,
Whitespace(1) | 
      
Numeric(0) | 0
Whitespace(0) |                    
Keyword(AS) | AS
Whitespace(0) |  
Identifier(is_unknown) | "is_unknown"
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
      
Identifier(activity_log_with_lead) | "activity_log_with_lead"
Whitespace(1) | 
    
Keyword(UNION) | UNION
Whitespace(0) |  
Keyword(ALL) | ALL
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
      
Identifier(timestamp_seconds) | "timestamp_seconds"
Whitespace(0) |                
Special(,) | ,
Whitespace(1) | 
      
Numeric(0) | 0
Whitespace(0) |                    
Keyword(AS) | AS
Whitespace(0) |  
Identifier(active) | "active"
Whitespace(0) |    
Special(,) | ,
Whitespace(1) | 
      
Numeric(1) | 1
Whitespace(0) |                    
Keyword(AS) | AS
Whitespace(0) |  
Identifier(is_unknown) | "is_unknown"
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
      
Identifier(activity_log_with_lead) | "activity_log_with_lead"
Whitespace(1) | 
    
Keyword(WHERE) | WHERE
Whitespace(1) | 
      
Special(() | (
Whitespace(1) | 
        
Identifier(lead_automatic) | "lead_automatic"
Whitespace(0) |  
Operator(==) | ==
Whitespace(0) |  
Numeric(1) | 1
Whitespace(1) | 
        
Keyword(AND) | AND
Whitespace(0) |  
Identifier(lead_active) | "lead_active"
Whitespace(0) |  
Operator(==) | ==
Whitespace(0) |  
Numeric(1) | 1
Whitespace(1) | 
        
Keyword(AND) | AND
Whitespace(0) |  
Identifier(active) | "active"
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(1) | 1
Whitespace(1) | 
      
Special()) | )
Whitespace(1) | 
      
Keyword(OR) | OR
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
        
Identifier(lead_active) | "lead_active"
Whitespace(0) |  
Keyword(IS) | IS
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(1) | 
        
Keyword(AND) | AND
Whitespace(0) |  
Identifier(active) | "active"
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(1) | 1
Whitespace(1) | 
        
Keyword(AND) | AND
Whitespace(0) |  
Identifier(STRFTIME) | STRFTIME
Special(() | (
StringLiteral(%Y-%m-%d) | '%Y-%m-%d'
Special(,) | ,
Whitespace(0) |  
Identifier(DATETIME) | DATETIME
Special(() | (
Identifier(DATETIME) | DATETIME
Special(() | (
Special()) | )
Special(,) | ,
Whitespace(0) |  
StringLiteral(localtime) | 'localtime'
Special()) | )
Special()) | )
Whitespace(0) |  
Operator(!=) | !=
Whitespace(0) |  
Identifier(STRFTIME) | STRFTIME
Special(() | (
Whitespace(1) | 
          
StringLiteral(%Y-%m-%d) | '%Y-%m-%d'
Whitespace(0) |                                                       
Special(,) | ,
Whitespace(1) | 
          
Identifier(DATETIME) | DATETIME
Special(() | (
Identifier(DATETIME) | DATETIME
Special(() | (
Identifier(timestamp_seconds) | "timestamp_seconds"
Special(,) | ,
Whitespace(0) |  
StringLiteral(unixepoch) | 'unixepoch'
Special()) | )
Special(,) | ,
Whitespace(0) |  
StringLiteral(localtime) | 'localtime'
Special()) | )
Whitespace(1) | 
        
Special()) | )
Whitespace(1) | 
      
Special()) | )
Whitespace(1) | 
    
Keyword(UNION) | UNION
Whitespace(0) |  
Keyword(ALL) | ALL
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
      
Keyword(CAST) | CAST
Special(() | (
Identifier(STRFTIME) | STRFTIME
Special(() | (
StringLiteral(%s) | '%s'
Special(,) | ,
Whitespace(0) |  
StringLiteral(now) | 'now'
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Keyword(REAL) | REAL
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(timestamp_seconds) | "timestamp_seconds"
Special(,) | ,
Whitespace(1) | 
      
Numeric(0) | 0
Whitespace(0) |                                    
Keyword(AS) | AS
Whitespace(0) |  
Identifier(active) | "active"
Whitespace(0) |            
Special(,) | ,
Whitespace(1) | 
      
Numeric(0) | 0
Whitespace(0) |                                    
Keyword(AS) | AS
Whitespace(0) |  
Identifier(is_unknown) | "is_unknown"
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
      
Identifier(activity_log_with_lead) | "activity_log_with_lead"
Whitespace(1) | 
    
Keyword(WHERE) | WHERE
Whitespace(1) | 
      
Identifier(lead_active) | "lead_active"
Whitespace(0) |  
Keyword(IS) | IS
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(1) | 
      
Keyword(AND) | AND
Whitespace(0) |  
Identifier(active) | "active"
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(1) | 1
Whitespace(1) | 
      
Keyword(AND) | AND
Whitespace(0) |  
Identifier(STRFTIME) | STRFTIME
Special(() | (
StringLiteral(%Y-%m-%d) | '%Y-%m-%d'
Special(,) | ,
Whitespace(0) |  
Identifier(DATETIME) | DATETIME
Special(() | (
Identifier(DATETIME) | DATETIME
Special(() | (
Special()) | )
Special(,) | ,
Whitespace(0) |  
StringLiteral(localtime) | 'localtime'
Special()) | )
Special()) | )
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Identifier(STRFTIME) | STRFTIME
Special(() | (
Whitespace(1) | 
        
StringLiteral(%Y-%m-%d) | '%Y-%m-%d'
Whitespace(0) |                                                       
Special(,) | ,
Whitespace(1) | 
        
Identifier(DATETIME) | DATETIME
Special(() | (
Identifier(DATETIME) | DATETIME
Special(() | (
Identifier(timestamp_seconds) | "timestamp_seconds"
Special(,) | ,
Whitespace(0) |  
StringLiteral(unixepoch) | 'unixepoch'
Special()) | )
Special(,) | ,
Whitespace(0) |  
StringLiteral(localtime) | 'localtime'
Special()) | )
Whitespace(1) | 
      
Special()) | )
Whitespace(1) | 
    
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
      
Identifier(timestamp_seconds) | "timestamp_seconds"
Whitespace(0) |  
Keyword(ASC) | ASC
Special(,) | ,
Whitespace(1) | 
      
Identifier(active) | "active"
Whitespace(0) |  
Keyword(DESC) | DESC
Whitespace(1) | 
  
Special()) | )
Whitespace(0) |                                                                       
Special(,) | ,
Whitespace(1) | 
  
Identifier(tidied_activity_log) | "tidied_activity_log"
Whitespace(0) |  
Special(() | (
Identifier(timestamp_seconds) | "timestamp_seconds"
Special(,) | ,
Whitespace(0) |  
Identifier(active) | "active"
Special(,) | ,
Whitespace(0) |  
Identifier(is_unknown) | "is_unknown"
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
      
Identifier(timestamp_seconds) | "timestamp_seconds"
Special(,) | ,
Whitespace(1) | 
      
Identifier(active) | "active"
Whitespace(0) |            
Special(,) | ,
Whitespace(1) | 
      
Identifier(is_unknown) | "is_unknown"
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
      
Special(() | (
Whitespace(1) | 
        
Keyword(SELECT) | SELECT
Whitespace(1) | 
          
Identifier(timestamp_seconds) | "timestamp_seconds"
Whitespace(0) |  
Special(,) | ,
Whitespace(1) | 
          
Identifier(active) | "active"
Whitespace(0) |             
Special(,) | ,
Whitespace(1) | 
          
Identifier(is_unknown) | "is_unknown"
Whitespace(0) |         
Special(,) | ,
Whitespace(1) | 
          
Identifier(LAG) | LAG
Special(() | (
Identifier(active) | "active"
Special()) | )
Whitespace(0) |  
Keyword(OVER) | OVER
Whitespace(0) |   
Special(() | (
Whitespace(1) | 
            
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
              
Identifier(timestamp_seconds) | "timestamp_seconds"
Whitespace(0) |  
Keyword(ASC) | ASC
Special(,) | ,
Whitespace(1) | 
              
Identifier(active) | "active"
Whitespace(0) |  
Keyword(DESC) | DESC
Whitespace(1) | 
          
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(lag_active) | "lag_active"
Whitespace(1) | 
        
Keyword(FROM) | FROM
Whitespace(1) | 
          
Identifier(extended_activity_log) | "extended_activity_log"
Whitespace(1) | 
      
Special()) | )
Whitespace(1) | 
    
Keyword(WHERE) | WHERE
Whitespace(1) | 
      
Identifier(lag_active) | "lag_active"
Whitespace(0) |  
Keyword(IS) | IS
Whitespace(0) |  
Keyword(NULL) | NULL
Whitespace(1) | 
      
Keyword(OR) | OR
Whitespace(0) |  
Identifier(lag_active) | "lag_active"
Whitespace(0) |  
Operator(!=) | !=
Whitespace(0) |  
Identifier(active) | "active"
Whitespace(1) | 
    
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
      
Identifier(timestamp_seconds) | "timestamp_seconds"
Whitespace(0) |  
Keyword(ASC) | ASC
Special(,) | ,
Whitespace(1) | 
      
Identifier(active) | "active"
Whitespace(0) |  
Keyword(DESC) | DESC
Whitespace(1) | 
  
Special()) | )
Whitespace(0) |                     
Special(,) | ,
Whitespace(1) | 
  
Identifier(activity_log_pairs) | "activity_log_pairs"
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Special(,) | ,
Whitespace(1) | 
    
Identifier(start_date_time) | "start_date_time"
Whitespace(0) |         
Special(,) | ,
Whitespace(1) | 
    
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |   
Special(,) | ,
Whitespace(1) | 
    
Identifier(end_date_time) | "end_date_time"
Whitespace(0) |           
Special(,) | ,
Whitespace(1) | 
    
Identifier(end_is_unknown) | "end_is_unknown"
Whitespace(0) |          
Special(,) | ,
Whitespace(1) | 
    
Identifier(duration_seconds) | "duration_seconds"
Whitespace(1) | 
  
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
      
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Whitespace(0) |                                                                    
Special(,) | ,
Whitespace(1) | 
      
Identifier(DATETIME) | DATETIME
Special(() | (
Identifier(DATETIME) | DATETIME
Special(() | (
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Special(,) | ,
Whitespace(0) |  
StringLiteral(unixepoch) | 'unixepoch'
Special()) | )
Special(,) | ,
Whitespace(0) |  
StringLiteral(localtime) | 'localtime'
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(start_date_time) | "start_date_time"
Special(,) | ,
Whitespace(1) | 
      
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |                                                                      
Special(,) | ,
Whitespace(1) | 
      
Identifier(DATETIME) | DATETIME
Special(() | (
Identifier(DATETIME) | DATETIME
Special(() | (
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Special(,) | ,
Whitespace(0) |  
StringLiteral(unixepoch) | 'unixepoch'
Special()) | )
Special(,) | ,
Whitespace(0) |  
StringLiteral(localtime) | 'localtime'
Special()) | )
Whitespace(0) |    
Keyword(AS) | AS
Whitespace(0) |  
Identifier(end_date_time) | "end_date_time"
Whitespace(0) |   
Special(,) | ,
Whitespace(1) | 
      
Identifier(end_is_unknown) | "end_is_unknown"
Whitespace(0) |                                                                             
Special(,) | ,
Whitespace(1) | 
      
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |  
Operator(-) | -
Whitespace(0) |  
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Whitespace(0) |                      
Keyword(AS) | AS
Whitespace(0) |  
Identifier(duration_seconds) | "duration_seconds"
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
      
Special(() | (
Whitespace(1) | 
        
Keyword(SELECT) | SELECT
Whitespace(1) | 
          
Identifier(active) | "active"
Whitespace(0) |                                                    
Special(,) | ,
Whitespace(1) | 
          
Identifier(timestamp_seconds) | "timestamp_seconds"
Whitespace(0) |             
Keyword(AS) | AS
Whitespace(0) |  
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Special(,) | ,
Whitespace(1) | 
          
Identifier(LEAD) | LEAD
Special(() | (
Identifier(timestamp_seconds) | "timestamp_seconds"
Special()) | )
Whitespace(0) |  
Keyword(OVER) | OVER
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
            
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
              
Identifier(timestamp_seconds) | "timestamp_seconds"
Whitespace(0) |  
Keyword(ASC) | ASC
Special(,) | ,
Whitespace(1) | 
              
Identifier(active) | "active"
Whitespace(0) |  
Keyword(DESC) | DESC
Whitespace(1) | 
          
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Special(,) | ,
Whitespace(1) | 
          
Identifier(LEAD) | LEAD
Special(() | (
Identifier(is_unknown) | "is_unknown"
Special()) | )
Whitespace(0) |  
Keyword(OVER) | OVER
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
            
Keyword(ORDER) | ORDER
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
              
Identifier(timestamp_seconds) | "timestamp_seconds"
Whitespace(0) |  
Keyword(ASC) | ASC
Special(,) | ,
Whitespace(1) | 
              
Identifier(active) | "active"
Whitespace(0) |  
Keyword(DESC) | DESC
Whitespace(1) | 
          
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(end_is_unknown) | "end_is_unknown"
Whitespace(1) | 
        
Keyword(FROM) | FROM
Whitespace(1) | 
          
Identifier(tidied_activity_log) | "tidied_activity_log"
Whitespace(1) | 
      
Special()) | )
Whitespace(1) | 
    
Keyword(WHERE) | WHERE
Whitespace(1) | 
      
Identifier(active) | "active"
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(1) | 1
Whitespace(1) | 
  
Special()) | )
Whitespace(0) |                         
Special(,) | ,
Whitespace(1) | 
  
Identifier(activity_history_pairs) | "activity_history_pairs"
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Identifier(start_date_time) | "start_date_time"
Whitespace(0) |         
Special(,) | ,
Whitespace(1) | 
    
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Special(,) | ,
Whitespace(1) | 
    
Identifier(start_date) | "start_date"
Whitespace(0) |              
Special(,) | ,
Whitespace(1) | 
    
Identifier(end_date_time) | "end_date_time"
Whitespace(0) |           
Special(,) | ,
Whitespace(1) | 
    
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |   
Special(,) | ,
Whitespace(1) | 
    
Identifier(duration_seconds) | "duration_seconds"
Whitespace(0) |        
Special(,) | ,
Whitespace(1) | 
    
Identifier(end_is_unknown) | "end_is_unknown"
Whitespace(1) | 
  
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
      
Identifier(start_date_time) | "start_date_time"
Whitespace(0) |                                       
Special(,) | ,
Whitespace(1) | 
      
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Whitespace(0) |                               
Special(,) | ,
Whitespace(1) | 
      
Identifier(STRFTIME) | STRFTIME
Special(() | (
StringLiteral(%Y-%m-%d) | '%Y-%m-%d'
Special(,) | ,
Whitespace(0) |  
Identifier(start_date_time) | "start_date_time"
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(start_date) | "start_date"
Special(,) | ,
Whitespace(1) | 
      
Identifier(end_date_time) | "end_date_time"
Whitespace(0) |                                         
Special(,) | ,
Whitespace(1) | 
      
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |                                 
Special(,) | ,
Whitespace(1) | 
      
Identifier(duration_seconds) | "duration_seconds"
Whitespace(0) |                                      
Special(,) | ,
Whitespace(1) | 
      
Identifier(end_is_unknown) | "end_is_unknown"
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
      
Identifier(activity_log_pairs) | "activity_log_pairs"
Whitespace(1) | 
    
Keyword(WHERE) | WHERE
Whitespace(1) | 
      
Identifier(duration_seconds) | "duration_seconds"
Whitespace(0) |  
Operator(>) | >
Whitespace(0) |  
Numeric(0) | 0
Whitespace(1) | 
      
Keyword(OR) | OR
Whitespace(0) |  
Identifier(end_is_unknown) | "end_is_unknown"
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(1) | 1
Whitespace(1) | 
  
Special()) | )
Whitespace(1) | 

Keyword(SELECT) | SELECT
Whitespace(1) | 
  
Identifier(start_date_time) | "start_date_time"
Whitespace(0) |                                                                                              
Special(,) | ,
Whitespace(1) | 
  
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Whitespace(0) |                                                                                      
Special(,) | ,
Whitespace(1) | 
  
Identifier(end_date_time) | "end_date_time"
Whitespace(0) |                                                                                                
Special(,) | ,
Whitespace(1) | 
  
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |                                                                                        
Special(,) | ,
Whitespace(1) | 
  
Identifier(active_duration_seconds) | "active_duration_seconds"
Whitespace(0) |                                                                                      
Special(,) | ,
Whitespace(1) | 
  
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |  
Operator(-) | -
Whitespace(0) |  
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Whitespace(0) |                              
Keyword(AS) | AS
Whitespace(0) |  
Identifier(total_duration_seconds) | "total_duration_seconds"
Whitespace(0) |    
Special(,) | ,
Whitespace(1) | 
  
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |  
Operator(-) | -
Whitespace(0) |  
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Whitespace(0) |  
Operator(-) | -
Whitespace(0) |  
Identifier(active_duration_seconds) | "active_duration_seconds"
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(inactive_duration_seconds) | "inactive_duration_seconds"
Special(,) | ,
Whitespace(1) | 
  
Identifier(interval_json_array) | "interval_json_array"
Whitespace(1) | 

Keyword(FROM) | FROM
Whitespace(1) | 
  
Special(() | (
Whitespace(1) | 
    
Keyword(SELECT) | SELECT
Whitespace(1) | 
      
Identifier(start_date) | "start_date"
Whitespace(0) |                                                                     
Special(,) | ,
Whitespace(1) | 
      
Identifier(MIN) | MIN
Special(() | (
Identifier(start_date_time) | "start_date_time"
Special()) | )
Whitespace(0) |                               
Keyword(AS) | AS
Whitespace(0) |  
Identifier(start_date_time) | "start_date_time"
Whitespace(0) |         
Special(,) | ,
Whitespace(1) | 
      
Identifier(MIN) | MIN
Special(() | (
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Special()) | )
Whitespace(0) |                       
Keyword(AS) | AS
Whitespace(0) |  
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Special(,) | ,
Whitespace(1) | 
      
Identifier(MAX) | MAX
Special(() | (
Identifier(end_date_time) | "end_date_time"
Special()) | )
Whitespace(0) |                                 
Keyword(AS) | AS
Whitespace(0) |  
Identifier(end_date_time) | "end_date_time"
Whitespace(0) |           
Special(,) | ,
Whitespace(1) | 
      
Identifier(MAX) | MAX
Special(() | (
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Special()) | )
Whitespace(0) |                         
Keyword(AS) | AS
Whitespace(0) |  
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |   
Special(,) | ,
Whitespace(1) | 
      
Identifier(SUM) | SUM
Special(() | (
Identifier(duration_seconds) | "duration_seconds"
Special()) | )
Whitespace(0) |                              
Keyword(AS) | AS
Whitespace(0) |  
Identifier(active_duration_seconds) | "active_duration_seconds"
Special(,) | ,
Whitespace(1) | 
      
StringLiteral([) | '['
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
Identifier(GROUP_CONCAT) | GROUP_CONCAT
Special(() | (
Identifier(active_pair_json) | "active_pair_json"
Special(,) | ,
Whitespace(0) |  
StringLiteral(,) | ','
Special()) | )
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
StringLiteral(]) | ']'
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(interval_json_array) | "interval_json_array"
Whitespace(1) | 
    
Keyword(FROM) | FROM
Whitespace(1) | 
      
Special(() | (
Whitespace(1) | 
        
Keyword(SELECT) | SELECT
Whitespace(1) | 
          
Identifier(start_date_time) | "start_date_time"
Whitespace(0) |                                                                                                                                                
Special(,) | ,
Whitespace(1) | 
          
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Whitespace(0) |                                                                                                                                        
Special(,) | ,
Whitespace(1) | 
          
Identifier(end_date_time) | "end_date_time"
Whitespace(0) |                                                                                                                                                  
Special(,) | ,
Whitespace(1) | 
          
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |                                                                                                                                          
Special(,) | ,
Whitespace(1) | 
          
Identifier(start_date) | "start_date"
Whitespace(0) |                                                                                                                                                     
Special(,) | ,
Whitespace(1) | 
          
Identifier(duration_seconds) | "duration_seconds"
Whitespace(0) |                                                                                                                                               
Special(,) | ,
Whitespace(1) | 
          
StringLiteral({"start":) | '{"start":'
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
Keyword(CAST) | CAST
Special(() | (
Special(() | (
Identifier(start_timestamp_seconds) | "start_timestamp_seconds"
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Numeric(1.0e3) | 1000.0
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special()) | )
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
StringLiteral(,"end":) | ',"end":'
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
Keyword(CAST) | CAST
Special(() | (
Special(() | (
Identifier(end_timestamp_seconds) | "end_timestamp_seconds"
Whitespace(0) |  
Operator(*) | *
Whitespace(0) |  
Numeric(1.0e3) | 1000.0
Special()) | )
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Keyword(INTEGER) | INTEGER
Special()) | )
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
StringLiteral(,"incomplete":) | ',"incomplete":'
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
Special(() | (
Whitespace(1) | 
            
Keyword(CASE) | CASE
Whitespace(1) | 
              
Keyword(WHEN) | WHEN
Whitespace(0) |  
Identifier(end_is_unknown) | "end_is_unknown"
Whitespace(0) |  
Operator(=) | =
Whitespace(0) |  
Numeric(1) | 1
Whitespace(0) |  
Keyword(THEN) | THEN
Whitespace(0) |  
StringLiteral(true) | 'true'
Whitespace(1) | 
              
Keyword(ELSE) | ELSE
Whitespace(0) |  
StringLiteral(false) | 'false'
Whitespace(1) | 
            
Keyword(END) | END
Whitespace(1) | 
          
Special()) | )
Whitespace(0) |  
Operator(||) | ||
Whitespace(0) |  
StringLiteral(}) | '}'
Whitespace(0) |  
Keyword(AS) | AS
Whitespace(0) |  
Identifier(active_pair_json) | "active_pair_json"
Whitespace(1) | 
        
Keyword(FROM) | FROM
Whitespace(1) | 
          
Identifier(activity_history_pairs) | "activity_history_pairs"
Whitespace(1) | 
      
Special()) | )
Whitespace(1) | 
    
Keyword(GROUP) | GROUP
Whitespace(0) |  
Keyword(BY) | BY
Whitespace(1) | 
      
Identifier(start_date) | "start_date"
Whitespace(1) | 
  
Special()) | )
Special(;) | ;
