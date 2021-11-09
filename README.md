# ICU-Diaries

-open project in Xcode


-press play within ICU_DiariesApp.swift

*don't forget to change device to ipad air when previewing


## **ICU_Diary_RESTful_API**  
web_host: 68.58.243.157  
database_endpoint: icudiary.c43yxbbxirw2.us-east-2.rds.amazonaws.com  
[Github_repo](https://github.com/slingjun/ICU_Diary_REST_Services)  

Method ---------------------------------------------------URL  
1: POST                  "http://68.58.243.157:8000/api/diary/new/"  [Link](http://68.58.243.157:8000/api/diary/new/)  
### Requires: sender_id, receiver_id, created_time(optional), title, content  
### Goal: create a diary entry  
### Returns HTTP_201 if success, HTTP_400 if failed.
  
2: GET                   ""http://68.58.243.157:8000/api/diary/testing/" [Link](http://68.58.243.157:8000/api/diary/testing/)"  
### Requires: None  
### Goal: get every diary entry in the database in **JSON Format**  
### Returns:   
{  
    "contents": [  
        {  
            "diary_id": 2,  
            "sender_id": 2,  
            "receiver_id": 3,  
            "created_time": "2021-11-09T04:52:32.105308Z",  
            "modified_time": null,  
            "title": "Message From .",  
            "content": "Hello ICU Diary"  
        },  
        {  
            "diary_id": 3,  
            "sender_id": 3,  
            "receiver_id": 4,  
            "created_time": "2021-11-09T04:52:32.105308Z",  
            "modified_time": null,  
            "title": "Message From .",  
            "content": "Hello ICU Diary"  
        },  
        **......**  
    ]  
}  
