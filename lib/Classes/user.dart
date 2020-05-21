import 'package:Admin/Services/Authentication.dart';

class User{
   String _username;
   String _Email;
   String _Phone;
   String _Password;
   int _id;
   bool matched = false;
   Database db;
   User(){
     _username="";
     _Email="";
     _Phone="";
     _Password="";
     db = Database();
   }

   void setName(String name){
      _username = name;
   }
   void setEmail(String email){
     _Email = email;
   }

   void setPhone(String phone){
     _Phone = phone;
   }
   void ssetPassword(String password){
     _Password = password;
   }
  
   String getName(){
     return _username;
   }
   String getEmail(){
     return _Email;
   }
   String getPhone(){
     return _Phone;
   }
   String getPassword(){
     return _Password;
   }
   bool isNameValid(){
     if(_username==null)
       return false;
     for(int i=0;i<_username.length;++i){
          int a = _username[i].compareTo('0');
          int b = _username[i].compareTo('9');
          if(a<0){
            return false;
          }
          else if(b > 0){
              a = _username[i].compareTo('A');
              if(a<0){
                return false;
              }
              int b = _username[i].compareTo('Z');
              if(b>0){
                a = _username[i].compareTo('a');
                if(a<0){
                  return false;
                }
                int b = _username[i].compareTo('z');
                if(b>0){
                  return false;
                }
              }
          }
     }
     return true;
   }
   bool isPhoneValid(){
     for(int i=0;i<_Phone.length;++i){
       int a = _Phone[i].compareTo('0');
       int b = _Phone[i].compareTo('9');
       if(a<0){
         return false;
       }
       else if(b > 0){
        return false;
       }
     }
     return true;
   }
   bool isEmailValid() {
     int j= 0;
     for (int i = 0; i < _Email.length; ++i) {
        if(_Email[i]=='@'){
          j=i;
          break;
        }
        if(i==_Email.length-1){
          return false;
        }

     }
     while(j<_Email.length){
       if(_Email[j]=='.'){
         break;
       }
       else if(j==_Email.length-1){
         return false;
       }
       j++;
     }
     return true;

   }
   bool isPasswordValid(){
     if(_Password==null || _Password=="")
       return true;
     int count = 0;
     int count1 = 0;
     for (int i = 0; i < _Password.length; ++i) {
       int a = _Password[i].compareTo('0');
       int b = _Password[i].compareTo('9');
       if(a>=0 && b<=0)
         count++;
       else{
          a = _Password[i].compareTo('A');
          b = _Password[i].compareTo('Z');
         if(a>=0 && b<=0)
           count1++;
          a = _Password[i].compareTo('a');
          b = _Password[i].compareTo('z');
         if(a>=0 && b<=0)
           count1++;
       }

     }
     if(count>0 && count1>0 && _Password.length>5)
       return true;
     return false;
   }
   bool isUserValid(){
     return isNameValid() && isEmailValid() && isPhoneValid() && isPasswordValid();
   }
}