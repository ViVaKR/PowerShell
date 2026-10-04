$Outlook = New-Object -ComObject Outlook.Application
$NameSpace = $Outlook.GetNamespace('mapi')
$MailBox = $NameSpace.Stores['email@email.co.kr'].GetRootFolder()
$Inbox = $Mailbox.Folders['받은 편지함']

#? (주석) 전체를 다 읽을 때는 -First 5 부분 지움, 정렬은 -> `| Sort-Order` 사용
$Inbox.Items | Select-Object -First 5 Subject, SenderEmailAddress, Body | Out-GridView -PassThru

#? (주석) 받은 편지함 서브 폴더를 읽을 때는 아래의 방법으로 (받은 편지함 아래 업무라는 폴더가 있을 때)
#  (주석) $SubFolder = $Inbox.Folders('업무')
#  (주석) $SubFolder.Items | Select-Object Subject, SenderEmailAddress, Body

#-> Select-Object 리스트 확인방법,  $Inbox.Items | Format-List
<# 
    [ Select-Object 가능 목록 ]
    * OriginatorDeliveryReportRequested 
    * ReadReceiptRequested              
    * ReceivedByEntryID                 
    * ReceivedByName                    
    * ReceivedOnBehalfOfEntryID         
    * ReceivedOnBehalfOfName            
    * ReceivedTime                      
    * RecipientReassignmentProhibited   
    * Recipients                        
    * ReminderOverrideDefault           
    * ReminderPlaySound                 
    * ReminderSet                       
    * ReminderSoundFile                 
    * ReminderTime                      
    * RemoteStatus                      
    * ReplyRecipientNames               
    * ReplyRecipients                   
    * SaveSentMessageFolder             
    * SenderName                        
    * Sent                              
    * SentOn                            
    * SentOnBehalfOfName                
    * Submitted                         
    * To                                
    * VotingOptions                     
    * VotingResponse                    
    * Links                             
    * ItemProperties                    
    * BodyFormat                        
    * DownloadState                     
    * InternetCodepage                  
    * MarkForDownload                   
    * IsConflict                        
    * IsIPFax                           
    * FlagIcon                          
    * HasCoverSheet                     
    * AutoResolvedWinner                
    * Conflicts                         
    * SenderEmailAddress                
    * SenderEmailType                   
    * EnableSharedAttachments           
    * Permission                        
    * PermissionService                 
    * PropertyAccessor                  
    * SendUsingAccount                  
    * TaskSubject                       
    * TaskDueDate                       
    * TaskStartDate                     
    * TaskCompletedDate                 
    * ToDoTaskOrdinal                   
    * IsMarkedAsTask                    
    * ConversationID                    
    * Sender                            
    * PermissionTemplateGuid            
    * RTFBody                           
    * RetentionPolicyName               
    * RetentionExpirationDate           
    * Application                       
    * Class                             
    * Session                           
    * Parent                            
    * Actions                           
    * Attachments                       
    * BillingInformation                
    * Body            
 #>
