import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/bottom_sheets/bottom_sheet.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';

class CustomerSupportPage2 extends StatefulWidget {
  const CustomerSupportPage2({Key? key}) : super(key: key);

  @override
  _CustomerSupportPageState createState() => _CustomerSupportPageState();
}

class _CustomerSupportPageState extends State<CustomerSupportPage2> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  List<String> supportList = ["How can i help you",];
  bool agree = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Card(
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 12.w,
                      )),
                )),
          ),
          title: Text('Customer Support',
              style: TextStyle(
                  fontSize: 16.0.w,
                  color: appBarTextColor,
                  fontWeight: FontWeight.w400)),
        ),
        body:Stack(
          children: [
            Form(
              key: globalFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  child: Center(
                      child:buildCustomerDataColumn(context)),
                ),
              ),
              ),
            Padding(
              padding:
              EdgeInsets.only(top: 0.w, bottom: 0.w, left: 0.w, right: 0.w),
              child:Align(
                alignment:Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*(1/3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: contact_color_customer,width: 0.5),
                        color: contact_color_customer,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           const Expanded(
                               flex: 1,
                               child: Icon(
                                   Icons.email_outlined,
                                   size: 25,
                                   color: Colors.white)),
                          Expanded(
                            flex: 2,
                            child: Text(
                              contact_us,
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),


                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*(1/3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 12.0,
                      ),
                      decoration: BoxDecoration(

                        border: Border.all(color: whatsapp_color_customer,width: 0.5),
                        color: whatsapp_color_customer,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.whatsapp_outlined,size: 25,color: Colors.white),
                        ],
                      ),


                    ),
                    InkWell(
                      onTap: () =>{
                        shareSheet(context)
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*(1/3),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: messanger_color_customer,width: 0.5),
                          color: messanger_color_customer,
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Image.asset(messenger,scale:2.5,),
                          ],
                        ),


                      ),
                    ),
                  ],),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildCustomerDataColumn(BuildContext context2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 20,),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Name', "Name")),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                                              return "Please enter phone";
                                            }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Phone', "Phone")),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  initialValue: '',
                  /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter email";
                                            }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Email', "Email")),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              DropdownButtonFormField<String>(

                decoration: dropDownProfile(
                    'How can i help you?', "Help") ,
                isDense: true,
                hint:Text("How can i help you?",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
                isExpanded: true,
                iconSize: 21,
                items:supportList.map((location) {
                  return DropdownMenuItem<String>(
                    child: Text(location),
                    value: location,

                  );
                }).toList(),

                onChanged: (newValue) {

                },

                validator: (value) => value == null ? '*' : null,

              ),

            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.multiline,
                  cursorColor: Colors.black,
                  maxLines: 5,

                  /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                  initialValue: '',
                  validator: (input) {
                    /*if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter address";
                                            }*/
                    return null;
                  },
                  decoration: textFieldProfile(
                      '', "Message")),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'You can add a GDPR checkbox if you want',
                      overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Colors.black87)
                    ),
                  )
                ],
              )
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.all(8.w),
          child: SizedBox(
              width: double.infinity,
              child: Builder(builder: (BuildContext context1) {
                return ElevatedButton(
                    child: Text("Submit",
                        style: TextStyle(
                            fontFamily: 'Metropolis', fontSize: 14.sp)),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(btnColorLogin),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                side: BorderSide(color: Colors.transparent)))),
                    onPressed: () {
                      if (validateAndSave()) {
                      }
                    });
              })),
        ),


      ],
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }


  shareSheet(BuildContext context) {
    bool _showAllDetails=false;
    showModalBottomSheet<int>(
      isScrollControlled: !_showAllDetails,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return  StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return CustomSheet(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      const SizedBox(height: 15,),
                      Text(share_tweet,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20.0.sp,
                          color: headingColor,
                          fontWeight: FontWeight.w700),),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Image.asset(profile),
                          const SizedBox(width: 15,),
                          Column(
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text:twitter_name,style: TextStyle(
                                        fontSize: 12.0.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                                    TextSpan(
                                      text: twitter_user_name,
                                      style: TextStyle(
                                            fontSize: 12.0.sp,
                                            color: sub_head_color_share,
                                            fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(via_direct_message,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 12.0.sp,
                                    color:sub_head_color_share,
                                    fontWeight: FontWeight.w500),),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined,size: 26,color:Colors.black54,),
                          const SizedBox(width: 15,),
                          Text(send_via_direct_message,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Divider(color:divider_color_share),
                      const SizedBox(height: 20,),
                      Wrap(
                        spacing: 15,
                        children: [
                          Column(
                            children: [
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child:const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.bookmark_add_outlined,color:Colors.black54,size: 30,),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(bookmark_text,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 12.0.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Column(
                            children: [
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child:const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.link,color:Colors.black54,size: 30,),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(copy_link_text,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 12.0.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),)
                            ],
                          ),
                          Column(
                            children: [
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child:const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(Icons.share_outlined,color:Colors.black54,size: 30,),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(share_via_text,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 12.0.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),)
                            ],
                          ),

                        ],
                      ),
                      const SizedBox(height: 20,),
                      Divider(color:divider_color_share),
                      const SizedBox(height: 20,),
                      SingleChildScrollView(

                        scrollDirection: Axis.horizontal,
                        child:    Wrap(
                          spacing: 15,
                          children: [
                            Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: whatsapp_color,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(Icons.whatsapp_outlined,color:Colors.white,size: 30,),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(whatsapp_text,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12.0.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),)
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: message_color_customer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(Icons.chat_rounded,color:Colors.white,size: 30,),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(message_text,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12.0.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),)
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: messanger_color_customer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:Image.asset(facebook,scale: 2,),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(news_feed_text,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12.0.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),)
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:Image.asset(gmail,scale: 2,),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(gmail_text,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12.0.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),)
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:Image.asset(telegram,scale: 2,),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(telegram_text,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12.0.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),)
                              ],
                            ),

                          ],
                        ),
                      )






                    ],
                  ),
                ),
              );}
        );
      },
    );
  }

}


