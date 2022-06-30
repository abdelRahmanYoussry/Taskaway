import 'package:algorizainternship/Componets/ElevatedButton.dart';
import 'package:algorizainternship/Componets/TextFormField.dart';
import 'package:algorizainternship/Style/Colors.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
   var emailController= TextEditingController();
    var formKey=GlobalKey<FormState>();
    return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: false,
       toolbarHeight: mediaQuery.height/4,
       flexibleSpace: Container(
         decoration: const BoxDecoration(
             image: DecorationImage(
                 image: AssetImage('assets/image/background.jpg'),
                 fit: BoxFit.fitWidth
             )
         ),
       ),
     ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
               Text('Welcome to Fashion Daily ',
                 style: Theme.of(context).textTheme.caption!.copyWith(fontSize:14 ),),
               const SizedBox(height: 20,),
               Text('Sign in ',
                 style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.black),),
              const SizedBox(height: 20,),
               Text('Phone Number ',
                 style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
              Row(
                children: [
                  Expanded(
                    child: MyTextFormField(
                      textInputFormat: '[0-9]',
                      backgroundColor: Colors.white,
                      borderColor: const Color(0xffebedee),
                      control:emailController ,
                      isPassword: false,
                      hint: 'Eg 035338114',
                      validator: (value)
                      {
                        if(value.isEmpty)
                          return 'Phone Can not be Empty';
                        else
                          return null;
                      },
                      readOnly: false,
                      prefix: CountryPickerDropdown(
                        initialValue: 'EG',
                        itemBuilder: _buildDropdownItem,
                        // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                        priorityList:[
                          CountryPickerUtils.getCountryByIsoCode('GB'),
                          CountryPickerUtils.getCountryByIsoCode('CN'),
                        ],
                        sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                        onValuePicked: (Country country) {
                          print(country.name);
                        },
                      ),
                      labelColor: Colors.black,
                      type: TextInputType.emailAddress,
                      onTap: (){},
                      textColor: Colors.black,
                      onChanged: (value){},
                    ),
                  ),

                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MyElevatedButton(
                borderColor:Colors.blue ,borderWidth: 0,
                  height: 50, width: double.infinity,
                  onTap: (){
                  if(formKey.currentState!.validate()){
                    print('All is ok');
                  }
                  }, buttonName: 'Sign in',
                  buttonColor: Colors.blue,radius: 5,),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,height: 0.5,
                      decoration: const BoxDecoration(
                        color: Colors.grey,

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('Or',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,height: 0.5,
                      decoration: const BoxDecoration(
                        color: Colors.grey,

                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MyElevatedButton(
                borderWidth: 2,
                borderColor: Colors.blue,
                height: 50, width:double.infinity,
                textColor: Colors.blue,
                onTap: (){}, buttonName: 'Sign With Google',
                image:  const AssetImage(
                  'assets/image/googleLogo.png',
                ),
                buttonColor: Colors.white,radius: 5,),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont Have any account?',style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                  ),),
                  TextButton(onPressed: (){}, child: const Text(
                    'Sign Up',style: TextStyle(
                      color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold
                  ),
                  ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Text('Use the application according to polivy rules ,Any kinds of violations will be subject to sanctions',
                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16,),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
Widget _buildDropdownItem(Country country) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0),
  child:   SizedBox(
    width: 100,
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(
          width: 5.0,
        ),
        Flexible(
          child: Text("+${country.phoneCode}(${country.isoCode})",style: const TextStyle(
            fontSize: 12,fontWeight: FontWeight.bold,
          ),),
        ),
      ],
    ),
  ),
);